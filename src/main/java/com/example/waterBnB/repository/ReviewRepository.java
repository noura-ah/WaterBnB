package com.example.waterBnB.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.waterBnB.models.Pool;
import com.example.waterBnB.models.Review;


@Repository
public interface ReviewRepository extends CrudRepository<Review, Long>{
	List<Review> findByPool(Pool pool);

}
