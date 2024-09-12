package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {

	//구매정보 상세조회를 위한 비즈니스를 수행
	public Purchase getPurchase(int prodNO) throws Exception;
	
	//구해목록 보기를 위한 비즈니스를 수행
	public Map<String, Object> getPurchaseList(Map map) throws Exception;
	
	//판매목록을 보기 위한 비즈니스를 수행
	public Map<String, Object> getSaleList(Search searchVO) throws Exception;
	
	//구매를 위한 비즈니스를 수행
	public Purchase addPurchase(Purchase purchaseVO) throws Exception;
	
	//구매정보수정을 위한 비즈니스를 수행
	//public PurchaseVO updatePurchase(PurchaseVO purchaseVO);
	public void updatePurchase(Purchase purchaseVO) throws Exception;
	
	//구매상태코드수정을 위한 비즈니스를 수행
	public void updateTranCode(Purchase purchaseVO, String tranCode) throws Exception;

}
