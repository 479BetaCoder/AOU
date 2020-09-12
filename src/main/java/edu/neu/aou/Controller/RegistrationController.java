package edu.neu.aou.Controller;

import java.io.IOException;
import java.util.Arrays;
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
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.neu.aou.Entity.User;
import edu.neu.aou.Service.UserService;

@Controller
@RequestMapping("/register")
public class RegistrationController {

	@Autowired
	private UserService userService;

	private Map<String, String> categories;

	private static final List<String> contentTypes = Arrays.asList("image/png", "image/jpeg", "image/gif");

	private Logger logger = Logger.getLogger(getClass().getName());

	@PostConstruct
	protected void loadCategory() {
		// using hashmap, could also read this info from a database
		categories = new LinkedHashMap<String, String>();
		// key=the role, value=display to user
		categories.put("Restaurant", "Restaurant");
		categories.put("Grocery", "Grocery");

	}

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {

		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}

	@GetMapping("/userRegistrationForm")
	public String showUserRegistrationPage(@RequestParam("role") int role, Model theModel, HttpServletRequest request) {

		
		HttpSession session = request.getSession();
		if(session!=null) {
		session.invalidate();
		}
		
		session = request.getSession();
		session.setAttribute("role", role);

		theModel.addAttribute("aouUser", new User());
		// model for form display
		theModel.addAttribute("categories", categories);

		return "user-Form";
	}

	@PostMapping("/ProcessingUser")
	public String processUserRegistrationForm(@Valid @ModelAttribute("aouUser") User theUser,
			BindingResult theBindingResult, Model theModel, HttpServletRequest request) {

		HttpSession session = request.getSession();
		String userName = theUser.getUserName();
		User existing = null;

		ObjectError error = new ObjectError("general", "Some binding errors");
		
		try {
			if (theUser.getPhoto().getBytes().length != 0) {

				String fileContentType = theUser.getPhoto().getContentType();
				logger.info("Content::" + fileContentType);
				if ((!contentTypes.contains(fileContentType))) {
					error = new ObjectError("photo", "Expecting an image type");
					theBindingResult.addError(error);
				}

			}

		} catch (IOException e) {
			logger.info("Some issue in processing . " + e.toString());
			return "user-Form";

		}

		logger.info("Processing registration form for: " + userName);

		// form validation
		if (theBindingResult.hasErrors()) {
			theBindingResult.addError(error);
			theModel.addAttribute("registrationError", error.getDefaultMessage());
			theModel.addAttribute("categories", categories);
			return "user-Form";
		}

		if (session.getAttribute("existingUser") != null) {
			if (session.getAttribute("user") != null) {
				User loggedInUser = (User) session.getAttribute("user");
				theUser.setRole(loggedInUser.getRole());
				existing = userService.findValidUserName(userName, theUser.getId());
			} else {
				theModel.addAttribute("registrationError","You have not logged out properly. We are clearing your session to continue a new registration." );
				session.invalidate();
				return "user-Form";
			}
		} else {
			// check the database if user already exists
			existing = userService.findByUserName(userName);
		}

		if (existing != null) {
			theModel.addAttribute("registrationError", "User name already exists.");
			theModel.addAttribute("categories", categories);
			logger.warning("User name already exists.");
			return "user-Form";
		}

		// create user account

		userService.save(theUser, session.getAttribute("existingUser"));

		logger.info("Successfully created user: " + userName);
		if (session.getAttribute("existingUser") != null) {
			session.setAttribute("user", theUser);
			session.removeAttribute("existingUser");
			return "redirect:/dashboard";
		} else {
			return "redirect:/register/registrationConfirmation";
		}

	}

	@GetMapping("/registrationConfirmation")
	public String registrationConf() {
		return "registration-Confirmation";
	}

	@GetMapping("/updateMyInfo")
	public String updateUser(Model theModel, HttpServletRequest request) {
		try {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		session.setAttribute("existingUser", true);

		if (session.getAttribute("role") != null) {
			session.removeAttribute("role");
		}

		if (user.getVendorCategory() != null) {
			session.setAttribute("role", 3);
		}

		theModel.addAttribute("aouUser", user);
		theModel.addAttribute("categories", categories);
		return "user-Form";
		}catch(Exception e) {
			return "exception";
		}
	}

	// Used by image in dashboard used by href
	@RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
	public void showImage(HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		// User user = userService.getUser(itemId);
		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
		response.getOutputStream().write(user.getUserDp());
		response.getOutputStream().close();
	}

}
