package edu.neu.aou.Controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.Order;
import edu.neu.aou.Entity.User;
import edu.neu.aou.Service.VendorService;

@Controller
@RequestMapping("/Vendor")
public class VendorController {

	@Autowired
	private VendorService vendorService;
	
	private static final List<String> contentTypes = Arrays.asList("image/png", "image/jpeg", "image/gif");

	private Logger logger = Logger.getLogger(getClass().getName());

	// Vendor views

	@GetMapping("/showProductForm")
	public String showProductsForm(Model theModel) {

		theModel.addAttribute("vendorItem", new Item());
		return "product-Form";

	}

	@GetMapping("/showMyProducts")
	public String showMyProducts(Model theModel, HttpServletRequest request) {

		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		List<Item> theItems = vendorService.getItems(currentUser.getId());
		theModel.addAttribute("items", theItems);

		return "show-items";

	}
	
	@GetMapping("/showMyOrders")
	public String showMyOrders(Model theModel, HttpServletRequest request) {

		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		List<Order> theOrders = vendorService.getOrders(currentUser.getId());
		theModel.addAttribute("orders", theOrders);
		
		return "show-VendorOrders";

	}
	
	

	// Vendor actions...

	@PostMapping("/saveItem")
	public String saveVendorItem(@Valid @ModelAttribute("vendorItem") Item theItem,
			BindingResult theBindingResult, Model theModel, HttpServletRequest request) {

		HttpSession session = request.getSession();
		logger.info(theItem.toString());
		
		ObjectError error = new ObjectError("general", "Some binding errors");
		
		try {
			if (theItem.getItemPhoto().getBytes().length != 0) {

				String fileContentType = theItem.getItemPhoto().getContentType();
				logger.info("Content::" + fileContentType);
				if ((!contentTypes.contains(fileContentType))) {
					error = new ObjectError("photo", "Expecting an image type");
					theBindingResult.addError(error);
				}

			}

		} catch (IOException e) {
			logger.info("Some issue in processing . " + e.toString());
			return "product-Form";

		}

		// form validation

		if (theBindingResult.hasErrors()) {
			theBindingResult.addError(error);
			theModel.addAttribute("registrationError", error.getDefaultMessage());
		
			return "product-Form";
		}

		if (session.getAttribute("user") == null) {
			return "redirect:/Login";
		} else {
			User user = (User) session.getAttribute("user");
			theItem.setVendor(user);
			vendorService.save(theItem);
		}
		return "redirect:/Vendor/productConfirmation";
	}
	
	@GetMapping("/productConfirmation")
	public String registrationConf() {
		return "product-Confirmation";
	}

	@PostMapping("/deleteItem")
	public @ResponseBody String deleteItem(@RequestParam("itemId") int theItemId, Model theModel, HttpServletResponse response) {

		try {
			int result = vendorService.deleteItem(theItemId);
			if (result == 1) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			logger.info("Some issue while processing : " + e.toString());
			return "-1";
		}

	}

	@GetMapping("/showItemForUpdate")
	public String updateItem(@RequestParam("itemId") int theId, Model theModel) {

		Item theItem = vendorService.getItem(theId);
		theModel.addAttribute("vendorItem", theItem);

		return "product-Form";
	}
	
	// Used by image in dashboard used by href
		@RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
		public void showImage(@RequestParam("itemId") int theItemId, HttpServletResponse response, HttpServletRequest request)
				throws ServletException, IOException {

			
			Item theItem = vendorService.getItem(theItemId);
			response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
			response.getOutputStream().write(theItem.getItemPic());
			response.getOutputStream().close();
		}

}
