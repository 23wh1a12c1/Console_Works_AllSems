package com.bvrith;

//import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import com.model.Product;
import com.dao.ProductDao;

@RestController
public class ProductController {

	/*@GetMapping("getProduct")
	public Product getProduct() {
		Product product = new Product(101,"Laptop",45000.00);
		return product;
	}
	*/
	
	@Autowired
	ProductDao prodDao;
	
	@GetMapping("getProducts")
	public List<Product> getProducts() {
		return prodDao.getProducts();
	}
	
	/*@GetMapping("getProducts")
	public List<Product> getProducts(){
		
		Product product1 = new Product(101,"Laptop",45000.00);
		Product product2 = new Product(102,"Mobie",85000.00);
		Product product3 = new Product(103,"Pendive",1000.00);
		
		List<Product> productList = new ArrayList<Product>();
		
		productList.add(product1);
		productList.add(product2);
		productList.add(product3);
		
		return productList;
		
	}
	
	
	@GetMapping("getProductById/{id}")
	public Product getProductById(@PathVariable("id") int pid){
		
		Product product1 = new Product(101,"Laptop",45000.00);
		Product product2 = new Product(102,"Mobie",85000.00);
		Product product3 = new Product(103,"Pendrive",1000.00);
		
		List<Product> productList = new ArrayList<Product>();
		
		productList.add(product1);
		productList.add(product2);
		productList.add(product3);
		
		for(Product product : productList) {
			if (product.getProdId() == pid) {
				return product;
			}
		}
		
		return null;
		
	}
	*/
}
