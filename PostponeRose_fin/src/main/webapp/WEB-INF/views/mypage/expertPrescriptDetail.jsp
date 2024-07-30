<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	//Get the session attribute "membertype"
	MemberType memberType2 = (MemberType) session.getAttribute("membertype");
	MemberDTO memberDTO2 = (MemberDTO) session.getAttribute("member_info");
	PrescriptDTO prescriptDTO2 = (PrescriptDTO) session.getAttribute("prescript");
	
	// Check if the membertype is null
	if (memberType2 == null) {
	    // Redirect to login.jsp
	    response.sendRedirect("/login");
	    return;
	} else if (memberType2.equals("EXPERT") || memberType2.equals("PATIENT") && memberDTO2.getMemberNum() == prescriptDTO2.getMemberNum()) {
		// Redirect to login.jsp
	    response.sendRedirect("/index");
	 return;
	}
%>


		<!-- End Header Area -->
		
		<section class="Feautes section">
		</section>
		
		<!-- Start PrescriptView -->
		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<h2>환자 처방전 기록 상세보기</h2>
							<img src="../resources/img/section-img.png" alt="#">
							<p/>
							<div>
								<div>
									<label>NO.</label>
						            <input readonly="readonly" name="prescript-no" value='<c:out value="${dto.prescript_no }"/>'>
						        </div>
						        <div>
									<label>처방일자</label>
						            <input readonly="readonly" name="prescripted-date" value='<c:out value="${dto.prescribed_date }"/>'>
						        </div>
						        <div>
						        	<label>환자명</label>
						            <input readonly="readonly" name="patient-name" value='<c:out value="${dto.patient_name }"/>'>
						            
						            <label>처방기관</label>
						            <input readonly="readonly" name="institution-address" value='<c:out value="${dto.institution_address }"/>'>
						        </div>
						        <div>
						            <label>환자ID</label>
						            <input readonly="readonly" name="ssn" value='<c:out value="${dto.memberId }"/>'>
						            
						            <label>전문가명</label>
						            <input readonly="readonly" name="expert-name" value='<c:out value="${dto.expert_name }"/>'>
						        </div>
							</div>
							
							<p/>
							<div>
								<table border="solid 1px black" width="100%">
									<c:if test="${not empty detaillist }">
										<thead>
											<tr>
												<th>No.</th>
												<th>약품명</th>
												<th>1일 투약횟수</th>
												<th>총 투약일수</th>
												<th>변동사항</th>
												<th>설명</th>
											</tr>
										</thead>
										<c:forEach var="detaildto" items="${detaillist }" varStatus="status">
												<tbody>
													<tr>
														<td><c:out value="${status.count }"/></td>
														<td><c:out value="${detaildto.medicine_name }"/></td>
														<td><c:out value="${detaildto.per_day }"/></td>
														<td><c:out value="${detaildto.total_day }"/></td>
														<td><c:out value="${detaildto.addordrop }"/></td>
														<td><c:out value="${detaildto.detail_comment }"/></td>
	
													</tr>
												</tbody>
										</c:forEach>
									</c:if>
								</table>
							</div>
							<!-- 처방전 작성 시 화면으로 돌아가서 (read only 해제된 화면) 수정(query문 updte) 처리?? -->
							<button type="button" class="btn"><a href="/mypage/expertPrescriptMod?prescript_no=${dto.prescript_no }">처방전 수정</a></button> 
							<button type="button" class="btn"><a href="/mypage/expertMypage">처방전 목록</a></button>
							
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End PrescriptView -->
		
		<!-- Start Comment -->
		<section class="Feautes section"  id="modifyContent">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<!-- Start Commente댓글 출력 -->
							<form method="post" action="/mypage/remove">
								<c:if test="${not empty commentlist}">
									<div>
										<c:forEach var="commentsdto" items="${commentlist }">
											<li>
												<div>
													<c:choose>
														<c:when test="${commentsdto.writer eq dto.memberNum }">
															<h2>환자 Comment</h2>
															<p>작성자: ${commentsdto.writerName }</p>
														</c:when>
														<c:otherwise>
															<h2>의사 Comment</h2>
															<p>작성자: ${commentsdto.writerName }</p>
														</c:otherwise>
													</c:choose>
													<p> -> ${commentsdto.content }</p>
													<p>[<fmt:formatDate pattern="yyyy-MM-dd-HH:mm:ss" value="${commentsdto.created_at }"/>]</p>
													
													<hr/>
												</div>
											</li>
										</c:forEach>
									</div>
								</c:if>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End Comment -->
		
<%@include file="../include/footer.jsp"%>