package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {

	//�������� ����ȸ�� ���� ����Ͻ��� ����
	public Purchase getPurchase(int prodNO) throws Exception;
	
	//���ظ�� ���⸦ ���� ����Ͻ��� ����
	public Map<String, Object> getPurchaseList(Map map) throws Exception;
	
	//�ǸŸ���� ���� ���� ����Ͻ��� ����
	public Map<String, Object> getSaleList(Search searchVO) throws Exception;
	
	//���Ÿ� ���� ����Ͻ��� ����
	public Purchase addPurchase(Purchase purchaseVO) throws Exception;
	
	//�������������� ���� ����Ͻ��� ����
	//public PurchaseVO updatePurchase(PurchaseVO purchaseVO);
	public void updatePurchase(Purchase purchaseVO) throws Exception;
	
	//���Ż����ڵ������ ���� ����Ͻ��� ����
	public void updateTranCode(Purchase purchaseVO, String tranCode) throws Exception;

}
