<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%
Boolean isLogin = (Boolean) session.getAttribute("isLogin");
if (isLogin == null || isLogin == false) {
    // Redirect to login.jsp if the user is not logged in
%>
<script>
	alert("로그인 후 이용해주세요");
	window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
} 

%>
<%
	// Check if the membertype is null
	if (membertype == null) {
	    // Redirect to login.jsp
	    response.sendRedirect("/login");
	    return;
	} else if (membertype.equals("EXPERT") && memberDTO.getMemberNum() == prescriptDTO.getMemberNum()) {
		// Redirect to login.jsp
	    response.sendRedirect("/mypage/expertMypage");
	 return;
	}
%>

		<!-- End Header Area -->
		
		<section class="Feautes section"></section>
		<section class="Feautes section">
			<div class="section-title">
				<h2>전문가 마이페이지</h2>
			</div>
		</section>
		
		<!-- Start PrescriptView -->
		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<h2>환자 처방전 목록</h2>
							<img src="../resources/img/section-img.png" alt="#">
							<p></p>
							
							<form id="searchForm" action="/mypage/expertMypage" method="get">
								<div class="col-lg-6">
									<div class="form-group">
									    <select id="searchType" class="form-control" name="type">
									   		<option value="all" ${expertPageMaker.cri.type == "all"? "selected":"" }>ALL</option>
									    </select>
									</div>
								</div>
							</form>
							
							<div>
								<table id="boardTable" border="solid 1px black" width="100%">
									<thead>
										<tr>
											<th>NO.</th>
											<th>처방일자</th>
											<th>환자명</th>
											<th>환자 ID</th>
											<th>처방기관</th>
											<th>전문가명</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
								
								<div class="pageBtn">
									<ul class="pagination">
										<c:if test="${expertPageMaker.prev}">
											<li class="paginate_button previous">
												<a href="${expertPageMaker.startPage - 1 }">Previous</a>
											</li>
										</c:if>
										<c:forEach var="num" begin="${expertPageMaker.startPage }" end="${expertPageMaker.endPage }">
											<li class="paginate_button ${expertPageMaker.cri.pageNum == num? 'active':'' }"><a href="${num }">${num }</a></li>
										</c:forEach>
										<c:if test="${expertPageMaker.next }">
											<li class="paginate_button next">
												<a href="${expertPageMaker.endPage + 1 }">Next</a>
											</li>
										</c:if>
									</ul>
								</div>
								<form id="pageForm" action="/mypage/expertMypage" method="get">
									<input type="hidden" name="pageNum" value="${expertPageMaker.cri.pageNum }">
									<input type="hidden" name="amount" value="${expertPageMaker.cri.amount }">
									<input type="hidden" name="type" value="${expertPageMaker.cri.type }">
									<input type="hidden" name="type" value="${expertPageMaker.cri.memberNum }">
								</form>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End PrescriptView -->
		
<!--/ End QaView -->
<section class="Feautes section">
			<div class="section-title">
				<h2>나의 평균평점</h2>
				 <input readonly="readonly" value='<c:out value="${myAvgRating.rate}"/>'>
			</div>
		</section>
		
		<section class="Feautes section">
			<div class="section-title">
				 <h2>나의 QA게시판 Rating List</h2>
			</div>
		</section>
<section class="Feautes section">
	<div class="section-title">
		<table>
			<thead>
				<tr>
					<th>QA게시글 번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>이름</th>
					<th>날짜</th>
					<th>평점</th>
				</tr>
			</thead>
				<tbody>
				   <c:choose> 
		  				<c:when test="${empty myQaMixList }">
							<tr>
		   						<th>-----</th>
		   						<th>-----</th>
		   						<th>-----</th>
		   						<th>-----</th>
		   						<th>-----</th>
		   						<th>-----</th>
		   					<tr>
		   				</c:when>
		   				<c:otherwise>
						<c:forEach items="${myQaMixList}" var="qaRating">
		   					<tr>
		   						<th><c:out value="${qaRating.qadto.qa_id}"/></th>
		   						<th><c:out value="${qaRating.qadto.title}"/></th>
		   						<th><c:out value="${qaRating.qadto.writer}"/></th>
		   						<th><c:out value="${qaRating.qadto.context}"/></th>
		   						<th><c:out value="${qaRating.qadto.created_at}"/></th>
		   						<th><c:out value="${qaRating.ratingdto.rate}"/></th>
		   					<tr> 
		   				</c:forEach>	
		   				</c:otherwise>
		  				</c:choose>	  
					</tbody>  	
				</table>
			</div>
		</section>
<section class="Feautes section">
	<div class="section-title">
		 <h2>나의 Prescript게시판 Rating List</h2>
	</div>
</section>
<section class="Feautes section">
	<div class="section-title">
		<table>
		<thead>
			<tr>
				<th>처방전 번호</th>
				<th>환자 이름</th>
				<th>환자 번호</th>
				<th>병원 주소</th>
				<th>날짜</th>
				<th>평점</th>
			</tr>
		</thead>
		<tbody>
		   <c:choose> 
		  	<c:when test="${empty myPrescriptList }">
				<tr>
		   			<th>-----</th>
		   			<th>-----</th>
		   			<th>-----</th>
		   			<th>-----</th>
		   			<th>-----</th>
		   			<th>-----</th>
		   		<tr>
		   	</c:when>
		   	<c:otherwise>
			<c:forEach items="${myPrescriptList}" var="PrescriptRating">
		   				<tr>
		   					<th><c:out value="${PrescriptRating.prescriptdto.prescript_no}"/></th>
		   					<th><c:out value="${PrescriptRating.prescriptdto.patient_name}"/></th>
		   					<th><c:out value="${PrescriptRating.prescriptdto.patient_phone}"/></th>
		   					<th><c:out value="${PrescriptRating.prescriptdto.institution_address}"/></th>
		   					<th><c:out value="${PrescriptRating.prescriptdto.prescribed_date}"/></th>
		   					<th><c:out value="${PrescriptRating.ratingdto.rate}"/></th>
		   				<tr> 
		   			</c:forEach>	
		   		</c:otherwise>
		  		</c:choose>  
			</tbody>  	
		</table>	
	</div>
</section>
<script type="text/javascript">
	$(document).ready(
			function() {
				loadTable();

				console.log("전체게시글 화면 이동");

				// loadTable() 시작
				function loadTable() {
					$.ajax({
						url : "/mypage/getExpertMypage",
						type : "post",
						data : {pageNum : $("#pageForm").find("input[name='pageNum']").val(),
								amount : $("#pageForm").find("input[name='amount']").val(),
								type : $("#searchType").val()},
						dataType : "json",
						success : function(data) {
							// data의 타입 Array
							var boardTbody = $("#boardTable tbody"); // 테이블 본문(tbody) 요소 저장
							boardTbody.empty(); // 테이블 본문을 비워서 기존 데이터 삭제

							// 서버에서 전달받은 Array를 반복적으로 화면에 출력
							$.each(data, function(index, prescript) {
								console.log("prescipttest:::::"+index);
								var row = $("<tr>"); // 새로운 테이블의 행 요소 생성
								row.append($("<td>").text(prescript.prescript_no)); // 생성한 tr요소에 게시글 번호가 담긴 td요소 추가
								
								
								var parseDate = new Date(prescript.prescribed_date); // DB에 저장된 등록 날짜를 Date객체로 변환
								// numeric : (2024, 7), 2-digit: (24, 07)
								var options = {
									year : "numeric",
									month : "2-digit",
									day : "2-digit",
									hour : "2-digit",
									minute : "2-digit"
								};
								var formattedDate = parseDate.toLocaleString(
										"ko-KR", options); // 날짜 형식을 한국 시간 형식과 지정 옵션으로 반환
								
								var prescribedDateLink = $("<a>").attr("href",
										"/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(formattedDate);
								var prescribedDateTd = $("<td>").append(prescribedDateLink);
								row.append(prescribedDateTd);
										
								// 게시글 제목을 누르면 상세보기로 이동해야하므로 링크(a태그)를 만들어서 url등록
								var patientNameLink = $("<a>").attr("href",
										"/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(prescript.patient_name);
								var patientNameTd = $("<td>").append(patientNameLink); // a태그를 td태그에 추가
								row.append(patientNameTd);
								
								var memberIdLink = $("<a>").attr("href",
										"/mypage/expertPrescriptDetail?prescript_no=" + prescript.prescript_no + "&memberNum=" + prescript.memberNum).text(prescript.memberId);
								var memberIdTd = $("<td>").append(memberIdLink);
								row.append(memberIdTd);
								
								row.append($("<td>").text(prescript.institution_address));
								row.append($("<td>").text(prescript.expert_name));
										
								boardTbody.append(row); // 생성한 tr요소를 테이블 본문에 추가 
							});
						},
						error : function(e) {
							console.log("실패");
							console.log(e);
						}
					});
					
					let pageForm = $("#pageForm");
					
					$(".paginate_button a").on("click", function(e) {
						// a태그의 기본 기능인 링크를 삭제
						e.preventDefault();
						// pageNum값을 사용자가 클릭한 a태그의 href의 속성값으로 변경
						pageForm.find("input[name='pageNum']").val($(this).attr("href"));
						pageForm.submit();
					});
				}
			});
</script>
<%@include file="../include/footer.jsp"%>