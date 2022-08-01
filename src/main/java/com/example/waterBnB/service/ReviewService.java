package com.example.waterBnB.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.waterBnB.models.Review;
import com.example.waterBnB.models.User;
import com.example.waterBnB.repository.ReviewRepository;

@Service
public class ReviewService {
	private final ReviewRepository reviewRepository;

	public ReviewService(ReviewRepository reviewRepository) {
		this.reviewRepository = reviewRepository;
	}
	
	
	public Review createReview(Review b) {
		return  reviewRepository.save(b);
	    }
	
	public Review findReview(Long id) {
	    Optional<Review> optionalReview =  reviewRepository.findById(id);
	    return optionalReview.isPresent()?  optionalReview.get() : null;
	}
	

}
