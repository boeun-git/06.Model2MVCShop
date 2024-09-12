package com.model2.mvc.web.Purchase;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;


//==> 판매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;	
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")		//pageUnit 이 null 인 경우 3  null 이 아닌 경우 pageUnit 값을 사용 
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")		//pageSize 가 null 인 경우 2  null 이 아닌 경우 pageSize 값을 사용
	int pageSize;
	
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.GET)
	public String addPurchase(@RequestParam("prod_no") int prodNo, 
											Model model) throws Exception{
		
		System.out.println("/purchase/addPurchase : GET");

		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, 
											@RequestParam("prodNo") int prodNo,
											HttpSession session,
												Model model) throws Exception{
		System.out.println("/purchase/addPurchase : POST");
		
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setBuyer((User)session.getAttribute("user"));
		
		purchaseService.addPurchase(purchase);
		
		model.addAttribute("purchase", purchase);

		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping("listPurchase")
	public String listPurchase(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception {

		System.out.println("/purchase/listPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> mapSearch = new HashMap<String, Object>() ;
		mapSearch.put("search", search);
		mapSearch.put("userId", ((User)session.getAttribute("user")).getUserId());
		
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(mapSearch);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.GET)
	public String updatePurchase(@RequestParam("tranNo") int tranNo, Model model, HttpSession session) throws Exception {

		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setBuyer((User)session.getAttribute("user"));
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
		
	}
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST)
	public String updatePurchase(@RequestParam("prodNo") int prodNo, 
												@ModelAttribute("purchase") Purchase purchase,
												Model model,
												HttpSession session) throws Exception {

		System.out.println("/purchase/updatePurchase : POST");
		
		purchase.setBuyer((User)session.getAttribute("user"));
		
		purchaseService.updatePurchase(purchase);
		
		model.addAttribute("purchase", purchase);
		
		
		return "forward:/purchase/getPurchase?tranNo=" + purchase.getTranNo();

	}
	
	@RequestMapping("updateTranCodeByProd")
	public String updateTranCodeByProd(@RequestParam("tranNo") int tranNo,
																@RequestParam("tranCode") String tranCode) throws Exception {

		System.out.println("/purchase/updateTranCodeByProd");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase, tranCode);
		
		return "forward:/product/listProduct?menu=manage";
	}
	
	@RequestMapping("updateTranCode")
	public String updateTranCode(@RequestParam("tranNo") int tranNo,
													@RequestParam("tranCode") String tranCode) throws Exception {
		
		System.out.println("/purchase/updateTranCode");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase, tranCode);
		
		return "forward:/purchase/listPurchase";
			
	}

	@RequestMapping("getPurchase")
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		model.addAttribute("purchase", purchaseService.getPurchase(tranNo));
		
		return "forward:/purchase/getPurchase.jsp";
			
	}
	
}