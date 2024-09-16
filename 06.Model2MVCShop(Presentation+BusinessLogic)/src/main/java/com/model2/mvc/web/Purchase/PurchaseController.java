package com.model2.mvc.web.Purchase;

import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


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
	public ModelAndView addPurchase(@RequestParam("prod_no") int prodNo) throws Exception{
		
		System.out.println("/purchase/addPurchase : GET");

		Product product = productService.getProduct(prodNo);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "/purchase/addPurchaseView.jsp");
		modelAndView.addObject("product", product);
		
		return modelAndView;
		//return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase, 
											@RequestParam("prodNo") int prodNo,
											HttpSession session) throws Exception{
		
		System.out.println("/purchase/addPurchase : POST");
		
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setBuyer((User)session.getAttribute("user"));
		
		purchaseService.addPurchase(purchase);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "/purchase/addPurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		//return "forward:/purchase/addPurchase.jsp";
		return modelAndView;
	}
	
	@RequestMapping("listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, HttpSession session) throws Exception {

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
//		model.addAttribute("list", map.get("list"));
//		model.addAttribute("resultPage", resultPage);
//		model.addAttribute("search", search);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(  "/purchase/listPurchase.jsp");
		modelAndView.addObject("search", search);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		
		
	//	return "forward:/purchase/listPurchase.jsp";
		return modelAndView;
	}
	
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.GET)
	public ModelAndView updatePurchase(@RequestParam("tranNo") int tranNo, HttpSession session) throws Exception {

		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setBuyer((User)session.getAttribute("user"));
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(  "/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
		//return "forward:/purchase/updatePurchaseView.jsp";
		
	}
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST)
	public ModelAndView updatePurchase(@RequestParam("prodNo") int prodNo, 
												@ModelAttribute("purchase") Purchase purchase,
												HttpSession session) throws Exception {

		System.out.println("/purchase/updatePurchase : POST");
		
		purchase.setBuyer((User)session.getAttribute("user"));
		
		purchaseService.updatePurchase(purchase);


		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "/purchase/getPurchase?tranNo=" + purchase.getTranNo());
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;	
	}
	
	@RequestMapping("updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(@RequestParam("tranNo") int tranNo,
																@RequestParam("tranCode") String tranCode) throws Exception {

		System.out.println("/purchase/updateTranCodeByProd");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase, tranCode);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProduct?menu=manage");
	
		return modelAndView;
	}
	
	@RequestMapping("updateTranCode")
	public ModelAndView updateTranCode(@RequestParam("tranNo") int tranNo,
													@RequestParam("tranCode") String tranCode) throws Exception {
		
		System.out.println("/purchase/updateTranCode");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase, tranCode);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase");
	
		return modelAndView;
		
		//return "forward:/purchase/listPurchase";
			
	}

	@RequestMapping("getPurchase")
	public ModelAndView getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchaseService.getPurchase(tranNo));
	
		return modelAndView;	
		
		//return "forward:/purchase/getPurchase.jsp";
			
	}
	
}