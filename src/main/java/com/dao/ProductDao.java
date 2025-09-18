package com.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.model.Product;

@Service
public class ProductDao {

	@Autowired		//Dependency Injection
	ProductRepository prodRepo;
	
	public List<Product> getProducts() {
		return prodRepo.findAll();
	}
}