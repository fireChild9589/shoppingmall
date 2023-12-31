<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


 
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<title>product</title>
<!-- 초기화 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/reset.css" type="text/css">
<!-- 스와이퍼 css -->
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" type="text/css">
<!-- 슬릭슬라이더 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<!-- 슬릭슬라이더 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/sub.css" type="text/css">

<!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@300;400;500;600;700&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<!-- 제이쿼리 최신버전 js -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 스와이퍼 js -->
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<!-- 슬릭슬라이더 js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<!-- js -->
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/script3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/product.js"></script>

<style>
.active .anum {color: #4982cf; font-weight: bold; font-size: 15px;}
#product #kv {margin: auto; text-align: center;}
#soldout{text-align: center; font-size: 15px; color: white; background-color: #e60a2f; width:100px; margin:0 auto;}
</style>

</head>

<body>
	<div class="wrapper">
	
		<!-- 헤더 -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //헤더 -->
		
		<main id="product">
			<section id="kv">
				<img
					src="${pageContext.request.contextPath}/assets/images/ver02/${view}${subCategory}.png">
			</section>
			<c:if test="${empty Search}">
				<ul class="category">
					<li><a
						href="${pageContext.request.contextPath}/main/${view}/${subCategory}">전체</a></li>
					<li><a
						href="${pageContext.request.contextPath}/main/${view}/${subCategory}?category=강아지&subCategory=${subCategory}">강아지</a></li>
					<li><a
						href="${pageContext.request.contextPath}/main/${view}/${subCategory}?category=고양이&subCategory=${subCategory}">고양이</a></li>
				</ul>
			</c:if>
			<section>
				<ul>
					<c:forEach items="${productList}" var="product">
						<li><a
							href="${pageContext.request.contextPath}/main/productDetal/${product.productNo}">
								<img
								src="${pageContext.request.contextPath}/upload/${product.saveName}">
								<c:if test="${product.productEa > 0}">
								<span class="tit">${product.productName}</span> 
								<span class="price jb"> 
								<fmt:formatNumber type="number"	maxFractionDigits="3" value="${product.price}" />원
								</span>
								</c:if>
								<c:if test="${product.productEa <= 0}">
								<span class="tit"><del>${product.productName}</del>></span> 
								<span class="price jb"><del> 
								<fmt:formatNumber type="number"	maxFractionDigits="3" value="${product.price}" />원</del></span>
								<p id="soldout"><b>품절</b></p>
								</c:if>
						</a></li>
					</c:forEach>
				</ul>
			</section>
			
			<!-- 페이징 -->
			<c:if test="${empty keyword}">
				<ul class="paging pageInfo">
					<c:if test="${pageMaker.prev}">
						<li class="pageInfo_btn previous"><a
							href="${pageMaker.startPage - 1}">◀</a></li>
					</c:if>

					<!-- 각 번호 페이지 버튼 -->
					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }">
							<a class="anum" href="${num}">${num}</a>
						</li>
					</c:forEach>

					<!-- 다음페이지 버튼 -->
					<c:if test="${pageMaker.next}">
						<li class="pageInfo_btn next"><a
							href="${pageMaker.endPage + 1}">▶</a></li>
					</c:if>
				</ul>
			</c:if>
			<form id="moveForm"
				action="${pageContext.request.contextPath}/main/${view}/${subCategory}"
				method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="type" value="${pageMaker.cri.type}">
				<input type="hidden" id="category" name="category"
					value="${category}"> <input type="hidden"
					id="CriteriaSubCategory" name="subCategory"
					value="${CriteriaSubCategory}">
			</form>
			<!-- 탑버튼 -->
			<a href="#none" class="top_btn"><img
				src="${pageContext.request.contextPath }/assets/images/ver02/top_btn.png"
				alt=""></a>
			<!-- /탑버튼 -->
		</main>
		
		<!-- Footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		<!-- //Footer -->
		
	</div>
</body>
</html>
