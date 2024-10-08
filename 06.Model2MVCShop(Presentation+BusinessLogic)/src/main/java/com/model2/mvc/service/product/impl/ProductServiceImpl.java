package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}
	

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}


	@Override
	public Product getProduct(int prodNo) throws Exception {
		//상품 정보 조회를 위한 비즈니스 로직을 실행
		// TODO Auto-generated method stub
		return productDao.findProduct(prodNo);
	}

	@Override
	public Map<String , Object > getProductList(Search search) throws Exception {
		//상품목록조회를 위한 비즈니스 로직을 실행
		// TODO Auto-generated method stub
		List<Product> list= productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public int addProduct(Product product) throws Exception {
		//상품등록을 위한 비즈니스 로직을 실행
		// TODO Auto-generated method stub
		return productDao.insertProduct(product);
	
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		//상품정보수정을 위한 비즈니스 로직을 실행
		// TODO Auto-generated method stub
		productDao.updateProduct(product);
		
	}
	
	public List<String> getAutocomplete(String prodName) throws Exception{
		List<String> list = productDao.getAutocomplete("%"+prodName+"%");
		
		return list;
	}

}
