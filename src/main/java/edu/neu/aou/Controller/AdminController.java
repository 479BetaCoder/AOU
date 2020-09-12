package edu.neu.aou.Controller;

import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import edu.neu.aou.Entity.BulkOrder;
import edu.neu.aou.Entity.User;
import edu.neu.aou.Service.AdminService;

@Controller
@RequestMapping("/Admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	private Logger logger = Logger.getLogger(getClass().getName());

	@GetMapping("/getVendors")
	public String getVendors(Model theModel) {
		
		try {
		List<User> theVendors = adminService.getVendors();
		theModel.addAttribute("vendors", theVendors);

		return "show-Vendors";
		}catch(Exception e) {
			return "exception";
		}

	}

	@GetMapping("/showActiveBulkOrders")
	public String showActiveBulkOrders(Model theModel) {
		
		try {
		List<BulkOrder> theActiveBulkOrders = adminService.getActiveBulkOrders();
		System.out.println("Active Orders size : " + theActiveBulkOrders.size());
		theModel.addAttribute("activeOrders", theActiveBulkOrders);

		return "active-Orders";
		}catch(Exception e) {
			return "exception";
		}

	}

	@GetMapping("/showOfferForm")
	public String showOfferForm(@RequestParam("bulkOrderId") int bulkOrderId, Model theModel) {
		
		try {
		BulkOrder theBulkOrder = adminService.getBulkOrderById(bulkOrderId);
		theModel.addAttribute("theBulkOrder", theBulkOrder);

		return "offer-Form";
		}catch(Exception e) {
			return "exception";
		}

	}

	@GetMapping("/showExpiredBulkOrders")
	public String showExpiredBulkOrders(Model theModel) {

		try {
		List<BulkOrder> theExpiredOrders = adminService.getExpiredBulkOrder();
		theModel.addAttribute("theExpiredBulkOrders", theExpiredOrders);
		
		return "expired-Orders";
		}catch(Exception e){
			return "exception";
		}
	}

	@GetMapping("/deleteExpiredOrders")
	public @ResponseBody String deleteExpiredBulkOrders(Model theModel) {

		try {
			adminService.deleteExpiredOrders();
			return "1";
		} catch (Exception e) {
			 e.printStackTrace();
			return "-1";
		}
	}

	@PostMapping("/saveOffer")
	public @ResponseBody String saveOffer(@ModelAttribute("theBulkOrder") BulkOrder theBulkOrder, Model theModel,
			HttpServletRequest request) {

		try {
		HttpSession session = request.getSession();
		logger.info(theBulkOrder.toString());

		if (session.getAttribute("user") == null) {
			return "-1";
		} else {
			adminService.saveOffer(theBulkOrder);
			return "1";
		}
		}catch(Exception e) {
			logger.info("Some exception occurred :" + e.toString());
			return "0";
		}
		
	}

	@PostMapping("/deleteVendor")
	public @ResponseBody String deleteUser(@RequestParam("vendorId") int theVendorId, Model theModel) {

		try {

			int result = adminService.deleteVendor(theVendorId);
			if (result == 1) {
				return "1";
			} else {
				return "0";
			}

		} catch (Exception e) {
			logger.info("Exception in deleting vendor..." + e.toString());
			return "-1";

		}

	}
	
	
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleResourceNotFoundException() {
        return "exception";
    }


}
