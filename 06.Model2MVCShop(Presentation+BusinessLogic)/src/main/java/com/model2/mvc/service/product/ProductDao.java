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
	
	//상품 정보 조회를 위한 DBMS를 수행
	public Product findProduct(int productNo ) throws Exception ;
	
	//상품목록조회를 위한 DBMS를 수행
	public List<Product> getProductList(Search search) throws Exception;	
	
	//상품 정보 수정을 위한 DBMS를 수행
	public void updateProduct(Product product) throws Exception ;
	
	//게시판 Page 처리를 위한 전체 Row(totalCount) return
	public int getTotalCount(Search search)  throws Exception ;
	
	public List<String> getAutocomplete(String prodName) throws Exception;
	
}
