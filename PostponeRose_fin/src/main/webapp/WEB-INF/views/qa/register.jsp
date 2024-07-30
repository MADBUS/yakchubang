<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<!-- End Header Area -->
<style type="text/css">
th,td{
      align-content: center;
      border: 1px solid black;
    }
</style>
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
MemberType memberType =(MemberType)session.getAttribute("membertype");
 memberDTO = (MemberDTO)session.getAttribute("member_info");
%>
<%
if (memberDTO == null || memberType == null) {
    System.out.println("MemberDTO is nullHBYGBYBYG: " + memberDTO);
    System.out.println("MemberType is null: " + memberType);
%>
	 <script type="text/javascript">
        alert("로그인 해주세요");
        window.location.href = "http://localhost:8090/login";
    </script>
<% 
}  
%>
<div class="col-lg-6 col-md-12 col-12">
	<h2>글 쓰기</h2>
	<br>
	<form class="form" action="http://localhost:8090/qa/register" method="post">
		<table id="Qatable">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="form-group">
						<label>제목</label>
						<input name="title" type="text" placeholder="필수입력" required="required">
					</div>
				</div>
				<br>
				<div class="col-lg-6 col-md-6 col-12">
					<div class="form-group">
						<label>작성자</label>
						<input name="writer" type="text" value="<%=memberDTO.getMemberName() %>" readonly="readonly">
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<div class="form-group">
						<label>처방전 번호 입력</label>
						<input name="prescript_no" type="text" placeholder="prescript_no">
					</div>
				</div>
				<div class="col-lg-12 col-md-12 col-12">
					<div class="form-group">
						<label>내용</label>
						<textarea name="context"
							placeholder="필수입력" required="required"></textarea>
					</div>
				</div>
				<div>
					<input type="hidden" name="memberType" value="<%=memberType %>" >
					<input type="hidden" name="memberNum" value="<%=memberDTO.getMemberNum() %>" >
				</div>
			</div>
			<br><br><br>
		<h3>나의 처방전</h3>
		<table>
		    <thead>	
			 <tr>
				<th>처방한 날짜</th>
				<th>처방전 번호</th>
				<th>환자 이름</th>
				<th>전화 번호</th>
				<th>처방 기관</th>
				<th>전문가 명</th>
			 </tr>
		   </thead>
		   <tbody>
		   	  <c:choose> 
		  	<c:when test="${empty myPrescript}">
			<tr>
		   		<th>첨부 x</th>
		   		<th>첨부 x</th>
		   		<th>첨부 x</th>
		   		<th>첨부 x</th>
		   		<th>첨부 x</th>
		   		<th>첨부 x</th>
		   	<tr>
		   	</c:when>
		   	<c:otherwise>
		   	<c:forEach items="${myPrescript}" var="my">
		   	<tr>
		   		<th><c:out value="${my.prescribed_date}"/></th>
		   		<th><c:out value="${my.prescript_no}"/></th>
		   		<th><c:out value="${my.patient_name}"/></th>
		   		<th><c:out value="${my.patient_phone}"/></th>
		   		<th><c:out value="${my.institution_address}"/></th>
		   		<th><c:out value="${my.expert_name}"/></th>
		   	<tr> 
		   	</c:forEach>	
		   	</c:otherwise>
		  </c:choose>
		   </tbody>
		</table>
		<br><br><br>
			<div class="row">
				<div class="col-lg-5 col-md-4 col-12">
					<div class="form-group">
						<div class="button">
							<button type="submit" class="btn">글작성 완료</button>	
							<br><br><br>
							<button type="button" class="btn"><a href="/qa/list">돌아가기</a></button>
							<button type="reset" class="btn">다시 작성</button>
						</div>
					</div>
				</div>
			</div>
		</table>
	</form>
</div>


<%@include file="../include/footer.jsp"%>