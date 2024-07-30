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
							<h2>마이처방전 기록 상세보기</h2>
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
							
							<button type="button" class="btn"><a href="/mypage/patientMypage">처방전 목록</a></button>
							
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End PrescriptView -->
		
		<!-- Start Rating -->
		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<h2>별점 남기기</h2>
							<img src="../resources/img/section-img.png" alt="#">
							<p/>
							<div>
								<fieldset>
									<span class="text-bold">별점을 선택해주세요</span>
									<br/>
									<input type="radio" name="rate" value="5" id="rate1"><label for="rate1">★</label>
									<input type="radio" name="rate" value="4" id="rate2"><label for="rate2">★</label>
									<input type="radio" name="rate" value="3" id="rate3"><label for="rate3">★</label>
									<input type="radio" name="rate" value="2" id="rate4"><label for="rate4">★</label>
									<input type="radio" name="rate" value="1" id="rate5"><label for="rate5">★</label>
								</fieldset>
									<br/>
									<div id="subRating">
										<button type="button" id="submitRating" class="btn">별점 제출</button>
									</div>
								</form>		
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End Rating -->
		
		
		
		<!-- Start Comment -->
		<section class="Feautes section"  id="modifyContent">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<c:if test="${empty commentlist}">
								<h2>처방전 Comment 남기기</h2>
								<img src="../resources/img/section-img.png" alt="#">
								<p/>
								<div style="width: 100px, text-align:center">
									<form method="post" action="/mypage/write">
										<input type="hidden" name="writer"  value="${dto.memberNum }" >
								        <input type="hidden" name="table_type" value="PRESCRIPT" >
								        <input type="hidden" name="prescript_no" value="${dto.prescript_no }" >
								        <input type="hidden" name="writerName" value="${dto.patient_name }" >
								        
								        <textarea class="col-auto form-control" name="content" id="reviewContents" placeholder="처방전에 대한 평가를 남겨주세요!" required="required"></textarea>
								        </p>
								        <button type="submit" id="btnCommentWrite" class="btn">댓글 작성</button>
								    </form>
								</div>
							</c:if>
							
							<p/>
							<!-- Start Commente댓글 출력 -->
							<form method="post" action="/mypage/remove">
								<c:if test="${not empty commentlist}">
									<h2>처방전 Comment</h2>
									<img src="../resources/img/section-img.png" alt="#">
									<p/>
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
													
													<p>
													<c:if test="${commentsdto.writer eq dto.memberNum }">
														<button type="button" class="btn" id="btnCommentModify">
															<a href='/mypage/prescriptDetailModify?prescript_no=<c:out value="${commentsdto.prescript_no }"/>&comment_id=<c:out value="${commentsdto.comment_id }"/>#modifyContent'>수정</a>
														</button>
														<input type="hidden" name="comment_id" value="${commentsdto.comment_id }" >
														<input type="hidden" name="writer" value="${dto.memberNum }" >
												        <input type="hidden" name="table_type" value="PRESCRIPT" >
												        <input type="hidden" name="prescript_no" value="${dto.prescript_no }" >
												        <input type="hidden" name="writerName" value="${dto.patient_name }" >
														<button type="submit" class="btn" id="btnCommentDelete">삭제</button>
													</c:if>
													</p>
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

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#btnCommentWrite').on('click', function(){
			alert("댓글이 작성되었습니다.");
		});
	
		
		$('#btnCommentDelete').on('click', function(){
			alert("댓글이 삭제되었습니다.");
		});
		
		
	    $('#submitRating').click(function() {
	        var selectedStar = $('input[name="rate"]:checked').val();
	        const membernum ="<%= memberDTO2.getMemberNum() %>";
	        const memberType = "<%= memberType2 %>";
	        const prescript_no = ${dto.prescript_no};
	        const expertnum = ${dto.memberNum_expert};
	        
	        console.log("selectedStar :"+selectedStar);
	        console.log("membernum :"+membernum);
	        console.log("memberType :"+memberType);
	        console.log("prescript_no :"+prescript_no);
	        console.log("expertnum :"+expertnum);
 
	        if (selectedStar) {
	            $.ajax({
	                type: 'post',
	                url: '/mypage/addRate',
	                data: { rate: selectedStar,
	                		memberNum: membernum,
	                		ratedtable_type:'PRESCIRPT',
	                		membertype: memberType,
	                		ratedtprescript_no:prescript_no,
	                		expertNum: expertnum,
	                		expertype:"EXPERT"
	                },
	                dataType : "json",
	                success : function(response) {
	                	if(response == true){
	                		 alert('평점이 제출되었습니다.');
	    
		    	            location.href = "/mypage/prescriptDetail?prescript_no="+prescript_no+"&memberNum="+membernum;
	                	}else if(response == false){
	                		 alert('이미 한번 평점줬음.');
	                	}
	           
	                	
	                },
					error : function(e) {
						console.log("실패");
						console.log(e);
					}
	            });
	          
	            
	            
	            
	        } else {
	            alert('별점을 선택해주세요.');
	        }
	    });
	});
</script>
		
<%@include file="../include/footer.jsp"%>