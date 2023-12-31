<!-- 카트 jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">
 
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<title>portfolio</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/reset.css" type="text/css"> <!-- 초기화 css -->
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" type="text/css"> <!-- 스와이퍼 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css"> <!-- 슬릭슬라이더 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css"> <!-- 슬릭슬라이더 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/sub.css" type="text/css"> <!-- 서브 css -->
<link href="${pageContext.request.contextPath}/assets/css/customer.css" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com"> <!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com"> <!-- 구글폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet"> <!-- 구글폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@300;400;500;600;700&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.min.js"></script> <!-- 제이쿼리 최신버전 js -->
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script> <!-- 스와이퍼 js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script> <!-- 슬릭슬라이더 js -->
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/script3.js"></script> <!-- js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/myPage.js"></script>
</head>
<style>
</style>
<body>

	<!-- 헤더 -->
	<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
	<!-- //헤더 -->



	<div id="wrap">



		<!-- aside-bar -->
		<c:import url="/WEB-INF/views/includes/myPage-aside.jsp"></c:import>


		<!-- 고객 정보 -->
		<div class=customer_info>
			<div class="customer_profile">
				<img
					src="https://static-00.iconduck.com/assets.00/person-circle-icon-512x512-zwz8ctki.png"
					id="customer_img"> <br>
				<br>${customerInfo.customerName} (${customerInfo.customerId})님
				안녕하세요-! <br>고객 등급 :
				<c:if test="${customerInfo.customerRole == 1}">
								일반 고객
							</c:if>
				<c:if test="${customerInfo.customerRole == 2}">
								Admin
							</c:if>
				<br>누적 금액 :
				<fmt:formatNumber type="number" maxFractionDigits="3"
					value="${customerInfo.totalPayment}" />
				원
			</div>
		</div>
		<!-- 고객 정보 -->

		<div id="board">
			<div id="list">


			<div class="paging-area">
				<table class="table-hover table order-list-table">
					<thead>
						<tr class="category">
							<th colspan="2">제품명</th>
							<th>수량</th>
							<th>금액</th>
							<th>구매일</th>
							<th>관리</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList}" var="product">
							<tr class="product_list">
								<td><a
									href="${pageContext.request.contextPath}/main/productDetal/${product.productNo}"><img
										src="${pageContext.request.contextPath}/upload/${product.saveName}"
										class="product-img"></a></td>
								<td>${product.productName}</td>
								<td>${product.productEa}개</td>
								<td><fmt:formatNumber type="number" maxFractionDigits="3"
										value="${product.price}" />원</td>
								<td>${product.regDate}</td>
								<td><a
									href="${pageContext.request.contextPath}/myPage/writeReview/${product.productNo}"
									class="review-btn">리뷰쓰기</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="clear"></div>
				<!-- 페이징 -->
				<c:if test="${paging.selectPage >10}">
					<a class="paging_" style ="margin: 14px"
						href="${pageContext.request.contextPath}/myPage/${authCustomer.customerNo}?selectPage=${paging.startPageNum - 1}">
						◀ </a>
				</c:if>

				<c:forEach begin="${paging.startPageNum}" end="${paging.endPageNum}"
					var="page">
					<c:if test="${page <= paging.finalPage}">
						<a class="paging_" style ="margin: 14px"
							href="${pageContext.request.contextPath}/myPage/${authCustomer.customerNo}?selectPage=${page}"
							id="P${page}">${page}</a>
					</c:if>
				</c:forEach>
				<c:if test="${paging.next == true}">
					<a class="paging_" style ="margin: 14px"
						href="${pageContext.request.contextPath}/myPage/${authCustomer.customerNo}?selectPage=${paging.endPageNum + 1}">
						▶ </a>
				</c:if>
				<input type="hidden" value="${paging.selectPage}" id="select_Page">
				</div>
			</div>
		</div>
	</div>


	<!-- 탑버튼 -->
	<a href="#none" class="top_btn"><img
		src="${pageContext.request.contextPath }/assets/images/ver02/top_btn.png"
		alt=""></a>
	<!-- /탑버튼 -->

</body>

<script>
	
</script>

</html>