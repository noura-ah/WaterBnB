package com.example.waterBnB.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.waterBnB.models.Pool;
import com.example.waterBnB.models.Review;
import com.example.waterBnB.models.User;
import com.example.waterBnB.service.PoolService;
import com.example.waterBnB.service.ReviewService;
import com.example.waterBnB.service.UserService;



@Controller
public class PoolController {
	private final PoolService poolService;
	private final UserService userService;
	private final ReviewService reviewService;

	public PoolController(PoolService poolService,  UserService userService, ReviewService reviewService) {
		this.poolService = poolService;
		this.userService = userService;
		this.reviewService = reviewService;
	}


	//home page 
	@GetMapping("/")
	public String home(Model model,HttpSession session, RedirectAttributes redirectAttributes) { 
		return "/index.jsp";
	}
	
	// search by artist name
	@GetMapping(value="/search")
	public String search(
		@RequestParam(value = "search") String search ,
		Model model,
		RedirectAttributes redirectAttributes) {	
		if (search.isEmpty()) {
			return "redirect:./";
		}
		List<Pool> pools = poolService.findByAddress(search);
		if (pools.isEmpty()) {
			redirectAttributes.addFlashAttribute("error", "Location "+search+" is not found");
			return "redirect:./";
		}
        return "redirect:/search/"+search;
	}
	
	// show the results of the search 
	@GetMapping(value="/search/{search}")
	public String dsplaySearch(@PathVariable(value = "search") String search , Model model ) {
		List<Pool> pools = poolService.findByAddress(search);
		model.addAttribute("pools",pools);
		model.addAttribute("location",search);
        return "/search-result.jsp";
    }
	
	
	
	
	@GetMapping(value="/host/dashboard")
	public String add(Model model,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		if (! session.getAttribute("role").equals("Host")) {
			redirectAttributes.addFlashAttribute("error", "only Host can access this page");
			return "redirect:/";
		}
		if (!model.containsAttribute("pool")) {
			model.addAttribute("pool",new Pool());
		}
		User user = userService.findUser((long) session.getAttribute("user_id"));
		List<Pool> pools = poolService.findPoolByUser(user);
		model.addAttribute("pools",pools);
		return "/dashboard.jsp";
	}
		
	// add new pool
	@PostMapping(value="/host/dashboard")
	public String add(Model model, @Valid @ModelAttribute("pool") Pool pool, 
			BindingResult result, 
			RedirectAttributes redirectAttributes,
			HttpSession session
			) {
		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("pool",pool);
			redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.pool",result);
			return "redirect:/host/dashboard";
        } 
		
		Long id= (Long) session.getAttribute("user_id");
		User user = userService.findUser(id);
		pool.setUser(user);
		poolService.createPool(pool);
    	redirectAttributes.addFlashAttribute("success", "Pool was created successfully");
        return "redirect:/host/dashboard";
	        
		}

	
	
	
		// show the edit form page 
		@GetMapping("/pools/{id}")
		public String edit(@PathVariable("id") Long id, Model model,RedirectAttributes redirectAttributes
				,HttpSession session) {
			if (session.getAttribute("user_id")== null) {
				redirectAttributes.addFlashAttribute("error", "register/login to access this page");
				return "redirect:/";
			}
			if (!model.containsAttribute("pool")) {
				Pool pool = poolService.findPool(id);
				model.addAttribute("pool", pool);
			}
			
			model.addAttribute("poolid", id);
		    return "/show_pool.jsp";
		}
		    
		// edit 
		@PutMapping(value="/pools/{id}/edit")
		public String update(@PathVariable("id") Long id,@Valid @ModelAttribute("pool") Pool pool ,
				BindingResult result, 
				RedirectAttributes redirectAttributes, 
				HttpSession session) {
			if (result.hasErrors()) {
				redirectAttributes.addFlashAttribute("pool",pool);
				redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.pool",result);
				return "redirect:/pools/"+id;
			}

			Long user_id= (Long) session.getAttribute("user_id");
			User user = userService.findUser(user_id);
			pool.setUser(user);
			poolService.updatePool(id,pool);
			redirectAttributes.addFlashAttribute("success", "Pool was edited successfully");
			return "redirect:/host/dashboard";
			}
		
		// show review form page
		@GetMapping("/pools/{id}/review")
		public String showReview(@PathVariable("id") Long id, Model model,
				RedirectAttributes redirectAttributes,
				HttpSession session) {
			if (session.getAttribute("user_id")== null) {
				redirectAttributes.addFlashAttribute("error", "register/login to access this page");
				return "redirect:/";
			}
			if (!model.containsAttribute("review")) {
				Review review = new Review();
				model.addAttribute("review", review);
			}
			Pool pool = poolService.findPool(id);
			model.addAttribute("pool", pool);
			model.addAttribute("poolid", id);
		    return "/add_review.jsp";
		}
		
		// add a new review to pool 
		@PostMapping("/pools/{id}/review/add")
		public String addReview (@PathVariable("id") Long id,@Valid @ModelAttribute("review") Review review ,
				BindingResult result, 
				RedirectAttributes redirectAttributes, 
				HttpSession session) {
			if (result.hasErrors()) {
				redirectAttributes.addFlashAttribute("review",review);
				redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.review",result);
				return "redirect:/pools/"+id+"/review";
			}
			
			Long user_id= (Long) session.getAttribute("user_id");
			User user = userService.findUser(user_id);
			
			Pool pool = poolService.findPool(id);
			
			// create review after assigning user and pool
			review.setUser(user);
			review.setPool(pool);
			reviewService.createReview(review);
			
			// update pool rating 
			poolService.updateRating(pool);
			redirectAttributes.addFlashAttribute("success", "Review was edited successfully");
			return "redirect:/pools/"+id;
		}
	
}
