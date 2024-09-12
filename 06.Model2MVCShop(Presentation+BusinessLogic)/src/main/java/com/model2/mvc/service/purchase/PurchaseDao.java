package com.model2.mvc.service.purchase;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	//구매정보 상세조회를 위한 DBMS를 수행
	public Purchase findPurchase(int tranNo) throws Exception ;
	
	//구매목록보기를 위한 DBMS를 수행
	//public List<Purchase> getPurchaseList(Search search, String userId) throws Exception;
	public List<Purchase> getPurchaseList(Map map) throws Exception;
	
	//판매목록보기를 위한 DBMS를 수행
	public HashMap<String, Object> getSaleList(Search searchVO);

	//구매를 위한 DBMS를 수행
	public Purchase insertPurchase(Purchase purchase) throws Exception ;
	
	//구매정보 수정을 위한 DBMS를 수행
	public void updatePurchase(Purchase purchase) throws Exception ;
	
	//구매상태코드수정을 위한 DBMS를 수행
	public void updateTranCode(Purchase purchase, String tranCode) throws Exception ;


	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	//public int getTotalCount(Search search) throws Exception ;
	public int getTotalCount(Map map) throws Exception ;

	// 게시판 currentPage Row 만  return 
	public String makeCurrentPageSql(String sql , Search search);

}
