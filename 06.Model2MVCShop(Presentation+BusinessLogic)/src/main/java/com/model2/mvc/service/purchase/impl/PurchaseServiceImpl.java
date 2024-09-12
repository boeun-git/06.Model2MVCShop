package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	@Qualifier("purchaseDaoImpl")	
	private PurchaseDao purchaseDao;
	@Autowired
	@Qualifier("productDaoImpl")	
	private ProductDao productDao;

	public PurchaseServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public void setPurchaseDao(PurchaseDao puchaseDao) {
		this.purchaseDao = puchaseDao;
	}
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	//구매목록보기를 위한 비즈니스를 수행, searchkeyword가 필요없고 구매아이디 필요
    //public Map<String , Object > getPurchaseList(Search search, String userId) throws Exception  { 
	public Map<String , Object > getPurchaseList(Map purchaseMap) throws Exception  { 
        // TODO Auto-generated method stub
		System.out.println(purchaseMap);

		int totalCount = purchaseDao.getTotalCount(purchaseMap);
		
		List<Purchase> list= purchaseDao.getPurchaseList(purchaseMap);
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
    }

	//구매상태코드 수정을 위한 비즈니스를 수행
    public void updateTranCode(Purchase purchase,  String tranCode)  throws Exception { 
        // TODO Auto-generated method stub
    	purchaseDao.updateTranCode(purchase, tranCode);
    }

//	//판매목록 보기를 위한비즈니스를 수행 
    public Map<String,Object> getSaleList(Search search)  { 
        // TODO Auto-generated method stub
    	
		return purchaseDao.getSaleList(search);
    }

	//구매를 위한 비즈니스를 수행
    public Purchase addPurchase(Purchase purchase) throws Exception  { 
        // TODO Auto-generated method stub
    	System.out.println("service : " + purchase);
		return purchaseDao.insertPurchase(purchase);
    }

	//구매정보 수정을 위한 비즈니스를 수행
    //public PurchaseVO updatePurchase(PurchaseVO purchaseVO)  { 
    public void updatePurchase(Purchase purchase) throws Exception  {
        // TODO Auto-generated method stub
    	purchaseDao.updatePurchase(purchase);
    }

	//구매정보 상세보기를 위한 비즈니스를 수행
    public Purchase getPurchase(int proNO) throws Exception{ 
		return purchaseDao.findPurchase(proNO);
    }

}
