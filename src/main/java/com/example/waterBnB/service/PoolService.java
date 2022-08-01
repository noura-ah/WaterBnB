package com.example.waterBnB.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.waterBnB.models.Pool;
import com.example.waterBnB.models.Review;
import com.example.waterBnB.models.User;
import com.example.waterBnB.repository.PoolRepository;

@Service
public class PoolService {
	private final PoolRepository poolRepository;

	public PoolService(PoolRepository poolRepository) {
		this.poolRepository = poolRepository;
	}
	
	public List<Pool> findAllPools() {
    	return poolRepository.findAll();
	}
	
	public List<Pool> findPoolByUser(User user){
		return poolRepository.findByUser(user);
	}
	
	public List<Pool> findByAddress(String search) {
       	return  poolRepository.findByAddressContaining(search);
    }
	
	public Pool createPool(Pool b) {
		return  poolRepository.save(b);
	    }
	
	public Pool findPool(Long id) {
	    Optional<Pool> optionalPool =  poolRepository.findById(id);
	    return optionalPool.isPresent()?  optionalPool.get() : null;
	}
	
	public Pool updatePool(Long id, Pool pool) {
		Pool current_pool = findPool(id);
		current_pool.setAddress(pool.getAddress());
		current_pool.setDescription(pool.getDescription());
		current_pool.setCost(pool.getCost());
		current_pool.setPoolSize(pool.getPoolSize());
		return  poolRepository.save(current_pool);
	    }
	
	public Pool updateRating (Pool pool) {
		Double rating = 0.0;
		for (Review review :pool.getReviews()) {
			rating+=review.getRating();
		}
		rating=rating/pool.getReviews().size();
		pool.setRating(rating);
		return poolRepository.save(pool);
	}

}
