package com.shopping.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shopping.vo.Criteria;
import com.shopping.vo.ProductVO;

@Repository
public class ProductDAO {

	@Autowired
	private SqlSession sqlSession;

	// -------------- 상품 등록
	public int insertProduct(ProductVO vo) {
		System.out.println("insertProduct DAO()");

		return sqlSession.insert("product.insertProduct", vo);
	}

	// --------------- 상품 이미지 등록
	public int insertProductImg(Map<String, Object> prdouctImgMap) {
		System.out.println("insertProductImg DAO()");

		return sqlSession.insert("image.insertProductImage", prdouctImgMap);
	}

	// -------------- 상품 수정
	public int modifyProduct(ProductVO vo) {
		System.out.println("modifyProduct DAO()");

		return sqlSession.update("product.modifyProduct", vo);
	}

	// --------------- 상품 이미지 수정
	public int modifyProductImg(Map<String, Object> prdouctImgMap) {
		System.out.println("modifyProductImg DAO()");

		return sqlSession.update("image.modifyProductImg", prdouctImgMap);
	}

	// --------------- 상품 삭제
	public int deleteProduct(int productNo) {
		System.out.println("deleteProduct DAO()");

		return sqlSession.delete("product.deleteProduct", productNo);
	}

	// --------------- 상품 이미지 삭제
	public int deleteProductImg(int productNo) {
		System.out.println("deleteProductImg DAO()");

		return sqlSession.delete("image.deleteProductImg", productNo);
	}

	// ---------------- 메인 롤링 리스트 가져오기
	public List<ProductVO> mainProductList() {
		System.out.println("mainProductList DAO()");

		return sqlSession.selectList("product.mainProductList");
	}

	// ---------------- 관리자 페이지 상품 리스트 가져오기
	public List<ProductVO> getAllProductList2(Criteria cri) {
		System.out.println("getAllProductList DAO()");

		return sqlSession.selectList("product.getAllProductList2", cri);
	}

	// ---------------- 전체 상품 리스트 가져오기 ----------------------------
	public List<ProductVO> getAllProductList(Criteria cri) {
		System.out.println("getAllProductList DAO()");

		return sqlSession.selectList("product.getAllProductList", cri);
	}

	// ---------------- 카테고리 상품 리스트 가져오기
	public List<ProductVO> getCategoryProductList(Criteria cri) {
		System.out.println("getCategoryProductList DAO()");

		return sqlSession.selectList("product.getCategoryProductList", cri);
	}

	// ----------------- 상품 검색
	public List<ProductVO> productSearch(String keyword) {
		System.out.println("productSearch DAO()");

		return sqlSession.selectList("product.productSearch", keyword);
	}

	// ---------------- 상품 정보 가져오기
	public ProductVO getProduct(ProductVO vo) {
		System.out.println("getProduct DAO()");

		return sqlSession.selectOne("product.getProduct", vo);
	}

	// ----------------- 상품 수 가져오기
	public int getTotal(Criteria cri) {
		System.out.println("getTotal DAO()");

		return sqlSession.selectOne("product.getTotal", cri);

	}

	// ----------------- 서브카테고리 상품 수 가져오기
	public int getTotalSubCategory(Criteria cri) {
		System.out.println("getTotalSubCategory DAO()");

		return sqlSession.selectOne("product.getTotalSubCategory", cri);

	}

	
	/*주문한 제품 정보 받아오기*/
	public ProductVO getProductInfo(int productNo) {
		System.out.println("getProductInfo DAO()");
		ProductVO returnVO = sqlSession.selectOne("product.getProductInfo", productNo);

		return returnVO;
	}
	
	
}
