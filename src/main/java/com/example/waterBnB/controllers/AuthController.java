package com.example.waterBnB.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.waterBnB.models.User;
import com.example.waterBnB.requests.UserLoginRequest;
import com.example.waterBnB.service.UserService;


@Controller
@RequestMapping("/guest/signin")
public class AuthController {
	private final UserService userService;
	public AuthController(UserService userService) {
		this.userService = userService;
	}
	
	@GetMapping("")
	public String ShowRegisterLogin(Model model) {
		if(!model.containsAttribute("newUser")) {
			model.addAttribute("newUser",new User());
		}
		if(!model.containsAttribute("loginUser")) {
			model.addAttribute("loginUser", new UserLoginRequest());
		}
		return "/register-login.jsp";
		
	}
	
	@PostMapping("/register")
	public String createUser(
			@Valid @ModelAttribute("newUser") User newUser,
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		if(result.hasErrors()) {
			redirectAttributes.addFlashAttribute("newUser", newUser);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newUser", result);
			return "redirect:./";
		}
		User user = userService.createUser(newUser, result);
//		if (user== null) {
//			redirectAttributes.addFlashAttribute("newUser", newUser);
//			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newUser", result);
//			return "redirect:/guest/signin/register";
//		}
//		else {
		session.setAttribute("role", user.getRole());
		session.setAttribute("user_id", user.getId());
			
		// Host redirect to dashboard page
		if (user.getRole().equals("Host"))
			return "redirect:/host/dashboard";
			
		// guest redirect to search page
		return "redirect:/";
		//}
		
	}
	@PostMapping("/login")
	public String userLogin(
			@Valid @ModelAttribute("loginUser") UserLoginRequest user,
			BindingResult result,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
//		if(result.hasErrors()) {
//			redirectAttributes.addFlashAttribute("loginUser", user);
//			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.loginUser", result);
//			return "redirect:./";
//		}

		User userLogged = userService.loginUser(user, result);
		if (userLogged== null) {
			redirectAttributes.addFlashAttribute("loginUser", user);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.loginUser", result);
			return "redirect:./";
		}
		else {
			session.setAttribute("role", userLogged.getRole());
			session.setAttribute("user_id", userLogged.getId());
			
			// Host redirect to dashboard page
			if (userLogged.getRole().equals("Host"))
				return "redirect:/host/dashboard";
			
			// guest redirect to search page
			return "redirect:/";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user_id");
		session.removeAttribute("role");
		return "redirect:/";
	}
}