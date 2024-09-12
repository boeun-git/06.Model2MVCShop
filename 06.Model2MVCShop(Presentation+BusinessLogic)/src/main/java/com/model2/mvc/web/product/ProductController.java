package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;


//==> ȸ������ Controller
@Controller
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")		//pageUnit �� null �� ��� 3  null �� �ƴ� ��� pageUnit ���� ��� 
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")		//pageSize �� null �� ��� 2  null �� �ƴ� ��� pageSize ���� ���
	int pageSize;
	
	
	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/addProduct.do");
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping("/getProduct.do")
	public String addUser( @RequestParam("prodNo") int prodNo, HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/getProduct.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		////////////////// �ֱ� �� ��ǰ///////////////////////
	   	Cookie[] cookies = request.getCookies();
	   	String history = "";
	   	
	   	if (cookies!=null && cookies.length > 0) {
	   		for (int i = 0; i < cookies.length; i++) {
	   			Cookie cookie = cookies[i];
	   			if (cookie.getName().equals("history")) {
	   				history = cookie.getValue();
	   			}
	   		}
	   		
	   		history += "/" + String.valueOf(product.getProdNo());
	   		Cookie cookie = new Cookie("history", history);	
	   		response.addCookie(cookie);
	   		
	   	}else{
	   		
	   		Cookie cookie = new Cookie("history", String.valueOf(product.getProdNo()));	
	   		
	       	response.addCookie(cookie);
	   	}
		
	   	/////////////////////////////////////////////////		
		
		return "redirect:/user/loginView.jsp";
	}

}