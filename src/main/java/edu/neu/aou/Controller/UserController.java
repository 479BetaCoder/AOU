package edu.neu.aou.Controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.annotation.PostConstruct;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.Item;
import edu.neu.aou.Entity.Order;
import edu.neu.aou.Entity.User;
import edu.neu.aou.Service.UserService;
import edu.neu.aou.Service.VendorService;

@Controller
@RequestMapping("/User")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private VendorService vendorService;
	
	private Map<String, String> categories;

	private Logger logger = Logger.getLogger(getClass().getName());
	
	@PostConstruct
	protected void loadCategory() {
		// using hashmap, could also read this info from a database
		categories = new LinkedHashMap<String, String>();
		// key=the role, value=display to user
		categories.put("Restaurant", "Restaurant");
		categories.put("Grocery", "Grocery");

	}
	
	
	// User Views

	@GetMapping("/showFilteredBulkOrder")
	public String showFilteredBulkOrderForm(@RequestParam("selCategory") String category, @RequestParam("aouFilter") String theAouFilter , Model theModel, HttpServletRequest request) {

		List<Item> items;
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(theAouFilter.equals("ALL")) {
			items = userService.getByCategory(category);
			System.out.println("Items Size from ALL:::" + items.size());
		}else {
			items = userService.getByAouCat(category,user.getZipCode());
			System.out.println("Items Size from AOU:::" + items.size());
		}
		

		// theModel.addAttribute("bulkOrder", new BulkOrder());

		// model for form display
		theModel.addAttribute("items", items);
		return "bulkOrder-Form";

	}

	@GetMapping("/showBulkOrderForm")
	public String showBulkOrderForm(Model theModel) {
		
		return "bulkOrder-Form";

	}

	// User actions

	@PostMapping("/addOrder")
	public @ResponseBody String addOrder(@RequestParam("selItemId") int theItemId,
			@RequestParam("selQuantity") int theQuantity, Model theModel, HttpServletRequest request) {

		try {
			
			Item orderItem = vendorService.getItem(theItemId);

			Order newOrder = new Order();
			newOrder.setOrderQuantity(theQuantity);
			newOrder.setOrderItem(orderItem);
			newOrder.setOrderCost(theQuantity * orderItem.getItemPrice());

			HttpSession session = request.getSession();

			if (session.getAttribute("bulkOrder") == null) {
				session.setAttribute("bulkOrder", new BulkOrder());
			}

			BulkOrder bOrder = (BulkOrder) session.getAttribute("bulkOrder");
			bOrder.addOrders(newOrder);
			BulkOrder.bulkOrderCost = bOrder.getBulkOrderCost() + newOrder.getOrderCost();
			// System.out.println("Session Value :: " + session.getAttribute("bulkOrder"));
			session.setAttribute("bulkOrder", bOrder);
		

			return "1";
		} catch (Exception e) {
			logger.severe("Some exception :: " + e.toString());
			return "-1";
		}

	}

	@PostMapping("/deleteOrder")
	public @ResponseBody String deleteOrder(@RequestParam("orderIndex") int theOrderIndex, Model theModel,
			HttpServletRequest request) {

		try {

		HttpSession session = request.getSession();

		if (session.getAttribute("bulkOrder") == null) {
			System.out.println("Initially empty!!");
			return "0"; // defensive programming
		}

		BulkOrder bOrder = (BulkOrder) session.getAttribute("bulkOrder");
		double removedOrderCost = bOrder.getOrderList().get(theOrderIndex).getOrderCost();
		BulkOrder.bulkOrderCost = bOrder.getBulkOrderCost() - removedOrderCost;

		bOrder.deleteOrder(theOrderIndex);
		session.setAttribute("bulkOrder", bOrder);
		

		return "1";
		}catch(Exception e) {
			logger.info("Some exception while deleting cart item : " + e.toString());
			return "-1";
		}
	}

	@GetMapping("/showMyCart")
	public String showMyCart(Model theModel, HttpServletRequest request) {

		HttpSession session = request.getSession();

		if (session.getAttribute("bulkOrder") != null) {
			theModel.addAttribute(session.getAttribute("bulkOrder"));
		}

		return "cart-summary";
	}

	@GetMapping("/placeOrder")
	public String placeMyCart(Model theModel, HttpServletRequest request) {
		theModel.addAttribute("myBulkOrder", new BulkOrder());
		return "confirm-Order";
	}

	@PostMapping("/confirmBulkOrder")
	public @ResponseBody String confirmBulkOrder(@Valid @ModelAttribute("myBulkOrder") BulkOrder theBulkOrder,
			BindingResult theBindingResult, Model theModel, HttpServletRequest request, HttpServletResponse response) {

		try {

			HttpSession session = request.getSession();
			logger.info(theBulkOrder.toString());

			// form validation

			if (theBindingResult.hasErrors()) {
				return "0";
			}

			if (session.getAttribute("user") == null) {
				try {
					response.sendRedirect("/Login");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				User user = (User) session.getAttribute("user");
				BulkOrder finalOrder = (BulkOrder) session.getAttribute("bulkOrder");

				theBulkOrder.setUser(user);
				theBulkOrder.setBulkOrderStatus("Processing");
				theBulkOrder.setOrderList(finalOrder.getOrderList());
				theBulkOrder.setCartValue(BulkOrder.bulkOrderCost);
				userService.save(theBulkOrder);

			}
			
			// cleaning activities
			session.removeAttribute("bulkOrder");
			BulkOrder.bulkOrderCost = 0;
			
			return "1";

		} catch (Exception e) {
			logger.info("Some exception occured : " + e.toString());
			return "-1";
		}
	}

	@GetMapping("/showOrderHist")
	public String showMyOrderHist(Model theModel, HttpServletRequest request) {

		HttpSession session = request.getSession();

		if (session.getAttribute("user") != null) {

			User user = (User) session.getAttribute("user");
			List<BulkOrder> bulkOrderList = userService.getMyOrderHist(user.getId());
			theModel.addAttribute("orderHistList", bulkOrderList);

			return "order-History";
		} else {
			return "redirect:/Login";
		}

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
