<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<title>portfolio</title>
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
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/script3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/qna.js"></script>

<style>
#buttoncss {padding: 15px 28px;	margin: -40px 30px 10px;}
.active .anum {color: #4982cf; font-weight: bold; font-size: 15px;}
.btn_wrap2 {display: flex; justify-content: flex-end;}
#allqna {background: #4982cf; border: 1px solid #4982cf; color: #fff; padding: 15px 50px; font-weight: 600; text-align: right; margin-right: 20px;}
#myqna {background: #4982cf; border: 1px solid #4982cf; color: #fff; padding: 15px 50px; font-weight: 600; text-align: right}
</style>

</head>

<body>

	<!-- 헤더 -->
	<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
	<!-- //헤더 -->

	
	<main id="inquiry">
		<section class="inquiry_">
			<h3>문의하기</h3>
			<div class="btn_wrap2">
				<a href="${pageContext.request.contextPath }/QnA/QnAList"
					id="allqna">전체 문의보기</a>
				<c:if test="${authCustomer.customerRole != 99}">
					<a href="#none" id="myqna">나의 문의보기</a>
				</c:if>
			</div>
			<br>
			<div class="mo_scroll">
				<p class="scroll_x">↔ 좌우로 스크롤하세요</p>
				<div class="inquiry_wrap">
					<ul class="th_line">
						<li class="no">No.</li>
						<li class="tit">제목</li>
						<li class="date">작성날짜</li>
					</ul>
					<div class="qna_wrap">
						<c:forEach items="${qnaList}" var="QnA">
							<div class="qna">
								<ul class="list">
									<li class="no">${QnA.qnaNo}</li>
									<c:if
										test="${QnA.boardType == 0 
									|| (QnA.boardType == 1 && QnA.customerNo == authCustomer.customerNo)
									|| authCustomer.customerRole == 99}">
										<li class="tit">${QnA.title}</li>
									</c:if>
									<c:if
										test="${QnA.boardType == 1 && QnA.customerNo != authCustomer.customerNo && authCustomer.customerRole != 99}">
										<li class="tit secret">비밀글 입니다</li>
									</c:if>
									<li class="date">${QnA.regDate}</li>
								</ul>
								<ul class="text_wrap">
									<li class="q_area"><c:if
											test="${QnA.boardType == 0 || (QnA.boardType == 1 && QnA.customerNo == authCustomer.customerNo)
											|| authCustomer.customerRole == 99}">
											<p class="no">Q</p>
											<p class="question tit">${QnA.content}</p>
										</c:if></li>
									<c:if
										test="${!empty QnA.adminContent && QnA.boardType == 0
									 || !empty QnA.adminContent && QnA.boardType == 1 && QnA.customerNo == authCustomer.customerNo
									 || !empty QnA.adminContent && authCustomer.customerRole == 99}">
										<li class="a_area">
											<p class="no">A</p>
											<p class="answer tit">${QnA.adminContent}</p>
											<p class="answer_date date">${QnA.adminRegDate}</p>
										</li>
									</c:if>
								</ul>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
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
				action="${pageContext.request.contextPath}/QnA/QnAList" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<input type="hidden" id="keyword" name="keyword"
					value="${pageMaker.cri.keyword}"> <input type="hidden"
					name="type" value="${pageMaker.cri.type}">

			</form>
			<c:if test="${authCustomer.customerRole != 99}">
				<div class="btn_wrap">
					<a href="#none" class="order_btn">문의하기</a>
				</div>
			</c:if>
		</section>

		<!-- 고객 문의 창 -->
		<section id="inquiry_popup" class="inquiry_popup"
			style="display: none;">
			<a href="#none" class="inquiry_close"><img
				src="images/ver02/close.png" alt=""></a>
			<div class="inquiry_write">
				<h3>문의</h3>
				<form id="moveForm1"
					action="${pageContext.request.contextPath}/QnA/insertQnA"
					method="get">
					<table>
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tr>
							<th>비밀글 여부</th>
							<td><input type="checkbox" id="secret_write_Y"
								name="boardType" value="1"> <label for="secret_write_Y">YES</label>
								<input type="hidden" name="customerNo"
								value="${authCustomer.customerNo}"></td>
						</tr>
						<tr>
							<th><label for="inquiry_tit">제목</label></th>
							<td><input type="text" id="inquiry_tit" name="title"
								placeholder="제목을 입력해 주세요" required></td>
						</tr>
						<tr>
							<th><label for="inquiry_cont">문의 내용</label></th>
							<td><textarea name="content" id="inquiry_cont"
									placeholder="700자 이하 입력가능" required></textarea>
								<div class="textLengthWrap">
									<span class="textCount">0자</span> <span class="textTotal">/
										700자</span>
								</div></td>
						</tr>
					</table>
					<div class="btn_wrap">
						<a id="submitqna" href="#none" class="order_btn">문의</a> <a
							href="#none" class="shopping_btn">취소</a>
					</div>
				</form>
			</div>
		</section>
		
		<!-- 탑버튼 -->
		<a href="#none" class="top_btn"><img
			src="images/ver02/top_btn.png" alt=""></a>
		<!-- /탑버튼 -->

	</main>

	<!-- Footer -->
	<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	<!-- //Footer -->

</body>

<script>
	//나의 문의 보기
	$("#myqna").on("click", function() {

		let keyword = $("#keyword");
		let customerNo = '${authCustomer.customerNo}';
		keyword.val(customerNo);
		$("#moveForm").submit();

	});
</script>

</html>
