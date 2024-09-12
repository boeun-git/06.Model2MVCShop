package com.model2.mvc.service.purchase;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	//�������� ����ȸ�� ���� DBMS�� ����
	public Purchase findPurchase(int tranNo) throws Exception ;
	
	//���Ÿ�Ϻ��⸦ ���� DBMS�� ����
	//public List<Purchase> getPurchaseList(Search search, String userId) throws Exception;
	public List<Purchase> getPurchaseList(Map map) throws Exception;
	
	//�ǸŸ�Ϻ��⸦ ���� DBMS�� ����
	public HashMap<String, Object> getSaleList(Search searchVO);

	//���Ÿ� ���� DBMS�� ����
	public Purchase insertPurchase(Purchase purchase) throws Exception ;
	
	//�������� ������ ���� DBMS�� ����
	public void updatePurchase(Purchase purchase) throws Exception ;
	
	//���Ż����ڵ������ ���� DBMS�� ����
	public void updateTranCode(Purchase purchase, String tranCode) throws Exception ;


	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
	//public int getTotalCount(Search search) throws Exception ;
	public int getTotalCount(Map map) throws Exception ;

	// �Խ��� currentPage Row ��  return 
	public String makeCurrentPageSql(String sql , Search search);

}
