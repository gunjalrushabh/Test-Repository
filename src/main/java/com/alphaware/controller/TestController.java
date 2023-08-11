package com.alphaware.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

	@GetMapping("/")
	public String testApi() {
		return "Hello guys your application up n running";
	}
}
