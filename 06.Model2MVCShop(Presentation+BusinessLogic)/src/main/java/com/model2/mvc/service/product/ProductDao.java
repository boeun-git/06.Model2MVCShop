package com.model2.mvc.service.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

public interface ProductDao {
	
	public int insertProduct(Product product) throws Exception ;
	
	//��ǰ ���� ��ȸ�� ���� DBMS�� ����
	public Product findProduct(int productNo ) throws Exception ;
	
	//��ǰ�����ȸ�� ���� DBMS�� ����
	public List<Product> getProductList(Search search) throws Exception;	
	
	//��ǰ ���� ������ ���� DBMS�� ����
	public void updateProduct(Product product) throws Exception ;
	
	//�Խ��� Page ó���� ���� ��ü Row(totalCount) return
	public int getTotalCount(Search search)  throws Exception ;
	
	public List<String> getAutocomplete(String prodName) throws Exception;
	
}
