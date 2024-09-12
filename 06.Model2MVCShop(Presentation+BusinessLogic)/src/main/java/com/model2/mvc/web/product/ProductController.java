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
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping("/getProduct.do")
	public String getProduct( @RequestParam("prodNo") int prodNo,
											@RequestParam("menu") String menu,
											Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

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
	   	model.addAttribute("product", product);
	   	model.addAttribute("menu", menu);
	   	
		if (menu != null && menu !="") {
			if(menu.equals("manage"))
				return "redirect:/updateProductView.do?prodNo="+product.getProdNo()+"&menu=menage";
		}
		
		return "forward:/product/getProduct.jsp";	
		
	}
	
	@RequestMapping("/listProduct.do")
	public String listProduct(@ModelAttribute("search") Search search, @RequestParam("menu") String menu,Model model, HttpServletRequest request) throws Exception {
		System.out.println("/listProduct.do");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping("/updateProduct.do")
	public String updateProduct(@ModelAttribute("product") Product product, Model model) throws Exception {
		
		System.out.println("/updateProduct.do");
		
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		return "redirect:/getProduct.do?prodNo="+product.getProdNo()+"&menu=ok";
	}
	
	@RequestMapping("/updateProductView.do")
	public String updateProductView(	@RequestParam("prodNo") int prodNo, Model model) throws Exception {
	
		System.out.println("/updateProductView.do");
		
		Product product =productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	

}