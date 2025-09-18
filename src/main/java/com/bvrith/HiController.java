package com.bvrith;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HiController {
	
	@RequestMapping("hi")
	public String hi(){
		return "Hi from HiController";
	}
	
	@RequestMapping("welcome")
	public String welcome(){
		return "Welcome from HiController";
	}
}

