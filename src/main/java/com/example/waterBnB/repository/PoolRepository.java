package com.example.waterBnB.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.waterBnB.models.Pool;
import com.example.waterBnB.models.User;

@Repository
public interface PoolRepository extends CrudRepository<Pool, Long>{
	List<Pool> findByAddressContaining(String search);
	
	List<Pool> findAll();
	
	List<Pool> findByUser(User user);
}
