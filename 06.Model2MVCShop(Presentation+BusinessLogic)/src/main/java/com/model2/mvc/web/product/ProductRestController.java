package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
		

	//@RequestMapping("getProduct")
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo) throws Exception {

		System.out.println("RestController : /product/getProduct : GET");
		return productService.getProduct(prodNo);	
		
	}
	

	//@RequestMapping("listProduct")
	@RequestMapping( value="json/listProduct", method=RequestMethod.POST )
	public Map<String, Object> listProduct(@RequestBody  Search search) throws Exception {
		System.out.println("RestController : /product/listProduct");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		return productService.getProductList(search);
	}
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct(@RequestBody  Product product) throws Exception{
		
		System.out.println("RestController : /product/addProduct : POST");
		
		return productService.getProduct(productService.addProduct(product));
	}
	
	@RequestMapping(value="json/updateProduct", method = RequestMethod.POST)
	public Product updateProduct(@RequestBody Product product) throws Exception{

		System.out.println("RestController : /product/updateProduct : POST");
		
		productService.updateProduct(product);
		
		return productService.getProduct(product.getProdNo());
	}
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping(value="json/getProductAutocomplete/{prodName}", method = RequestMethod.GET)
	public List<String> getProductAutocomplete(@PathVariable String prodName) throws Exception{

		System.out.println("RestController : /product/getProductAutocomplete : GET");
		
		return productService.getAutocomplete(prodName);
	}

}