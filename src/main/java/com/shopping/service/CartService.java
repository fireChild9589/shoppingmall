package com.shopping.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.dao.AddressDAO;
import com.shopping.dao.CartDAO;
import com.shopping.dao.OrderDAO;
import com.shopping.vo.AddressVO;
import com.shopping.vo.CartVO;
import com.shopping.vo.OrderVO;
import com.shopping.vo.ProductVO;

@Service
public class CartService {
	
	@Autowired	
	private CartDAO cartDAO;
	@Autowired
	private AddressDAO addressDAO;
	@Autowired
	private OrderDAO orderDAO;
	
	/*장바구니 보기*/
	public List<ProductVO> viewCart(int customerNo) { 
		System.out.println("viewCart Service()");
		
		List<ProductVO> cartList = cartDAO.getCartList(customerNo);
		
		return cartList;
	}
	
	/*장바구니 추가*/
	public int addCart(CartVO cartVO) { 
		System.out.println("addCart Service()");
		
		CartVO returnVO = cartDAO.checkCart(cartVO);

		if(returnVO == null) { 
			cartDAO.insertCart(cartVO);
			cartDAO.insertCartDetail(cartVO);
			
		}else { /*아이디 체크해서 갖고 있는 카트 넘버를 매개변수로 넘어온 cartVO에 넣어서 카트 디테일에 인서트함*/
			cartVO.setCartNo(returnVO.getCartNo()); 
			//체크해서 해당 상품 있으면 update 없으면 insert로 넘어가게 해야함
			cartDAO.insertCartDetail(cartVO);
		}
		
		return cartVO.getProductCnt();
	}
	
	/* 장바구니 리스트 삭제. 고객의 카트 넘버 찾아서 삭제함*/
	public boolean deleteList(CartVO cartVO) { 
		System.out.println("deleteList Service()");
		
		boolean result = false;
		
		CartVO checkCartNo = cartDAO.checkCart(cartVO);
		cartVO.setCartNo(checkCartNo.getCartNo());
		
		int row = cartDAO.deleteList(cartVO);
		
		if(row>0) {
			result = true;
		}
		
		return result;
	}
	
	

	
	
	/* 주문상태 완료(2)인 주문 테이블만 있으면 주문하나 만듬.*/
	/* 주문상태인(1) 주문 테이블 있으면 해당 테이블에 추가 */
	public boolean addOrder(OrderVO orderVO) {
		System.out.println("addOrder Service()");
		boolean result = false;
		
		OrderVO ordersCheck = orderDAO.checkOrder(orderVO.getCustomerNo());
		
		/*결제 진행 중 상태인 주문건(상태 1)이 있으면~해당 주문 삭제함*/
		if(ordersCheck != null) {
			int orderNo = ordersCheck.getOrderNo();
			orderDAO.deleteOrderDetail(orderNo);
			orderDAO.deleteOrder(orderNo);
		}
			int row = orderDAO.insertOrder(orderVO); //order 만들기 + orderNo 값 받아오기
			
			List<ProductVO> productList = orderVO.getProductList();
			Map<String, Object> map = new HashMap<>();
			map.put("orderNo", orderVO.getOrderNo());
			
			for(int i =0; i<productList.size(); i ++) {
				map.put("orderProduct", productList.get(i));
				
				orderDAO.insertOrderDetail(map);	//디테일 테이블에도 물건 추가함
				
			}
			orderDAO.checkOrderDetailList(orderVO); //오더 테이블 제품 확인하고 재고보다 주문하는 수량이 많을 경우 최대 재고로  업데이트 
			
			if(row>0) {result = true;} //order 추가 성공하면 true 리턴함
			
			return result;
			
	}//addOrder end
	
	

	/*고객의 주문 페이지 정보를 불러옴*/
	/*주문 디테일 제품 리스트와 주문 정보가 들어가 있는 orderVO + 고객의 주소 정보*/
	public Map<String, Object> getOrderInfo(String customerNo){
		System.out.println("getOrderInfo Service()");
		Map<String,Object> orderInfo = new HashMap<>();
		
		OrderVO orderVO = orderDAO.checkOrder(customerNo);
		List<ProductVO> orderList =  orderDAO.getOrderList(orderVO);
		orderVO.setProductList(orderList);
		
		List<AddressVO> addressList = addressDAO.getCustomerAddress(customerNo);
		
		orderInfo.put("orderInfo", orderVO);
		orderInfo.put("addressList", addressList);
		
		return orderInfo;
	}
	
	/*주소 추가*/
	public boolean addAddress(AddressVO addressVO) {
		System.out.println("addAdress Service()");
		boolean result = false;
		
		int cnt = addressDAO.addressCount(addressVO);
		if(cnt>2) {addressDAO.deleteOldAddress(addressVO);}
		int insertRows  = addressDAO.insertAddress(addressVO);
		
		if(insertRows>0) {result = true;}
		
		return result;	
		}
	
}