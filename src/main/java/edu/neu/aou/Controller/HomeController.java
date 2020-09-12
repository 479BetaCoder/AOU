package edu.neu.aou.Controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import edu.neu.aou.Entity.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome to AOU! The client locale is {}.", locale);
		return "home";
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Model theModel, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User loggedInuser = (User)session.getAttribute("user");
		if(loggedInuser==null) {
			return "redirect:/Login";
		}
		theModel.addAttribute("loggedInUser", loggedInuser);
		return "dashboard";
	}
	
	@GetMapping("/Login")
	public String showMyLoginPage(HttpServletRequest request) {
		
			//request.getSession().invalidate();
			return "login";

	}
	
	

	// add request mapping for /access-denied

	@GetMapping("/UnAuthorized")
	public String showAccessDenied() {
		return "access-Denied";

	}
	
	
}
