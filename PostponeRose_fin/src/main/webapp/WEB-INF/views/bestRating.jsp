<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>


<style>
.best-experts {
	display: flex;
	justify-content: space-around;
	padding: 20px;
}

.expert {
	border: 1px solid #ddd;
	padding: 20px;
	border-radius: 8px;
	width: 30%;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	font-weight: bold;
}

.form-group input {
	width: 100%;
	padding: 8px;
	margin-top: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

h3{
	color: #333;
}
</style>

<h1>실시간 전문가 BEST 3</h1>
<div class="best-experts">
	
	<div class="expert">	
		<c:choose>
			<c:when test="${empty ratingTwoName.memberName}">
				<img src="../resources/img/bestexpert2.png">
			</c:when>
			<c:otherwise>
				<h3>실시간 전문가 2등</h3>
				<div class="form-group">
					<label>이름</label><br> <input readonly="readonly"
						value='<c:out value="${ratingTwoName.memberName}"/>'>
				</div>
				<div class="form-group">
					<label>평균 평점</label><br> <input readonly="readonly"
						value='<c:out value="${ratingTwo.rate }"/>'>
				</div>
				<div class="form-group">
					<label>병원 이름</label><br> <input readonly="readonly"
						value='<c:out value="${memberInfoTwo.institutionName }"/>'>
				</div>
				<div class="form-group">
					<label>병원 주소</label><br> <input readonly="readonly"
						value='<c:out value="${memberInfoTwo.institutionAddress }"/>'>
				</div>
				<div class="form-group">
					<label>병원 번호</label><br> <input readonly="readonly"
						value='<c:out value="${memberInfoTwo.institutionTel }"/>'>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="expert">
		<c:choose>
			<c:when test="${empty ratingName.memberName}">
				<img src="../resources/img/bestexpert1.png">
			</c:when>
			<c:otherwise>
			<h3>실시간 전문가 1등</h3>
				<div class="form-group">
					<label>이름</label><br> <input readonly="readonly" name="name"
						value='<c:out value="${ratingName.memberName}"/>'>
				</div>
				<div class="form-group">
					<label>평균 평점</label><br> <input readonly="readonly"
						name="rating" value='<c:out value="${rating.rate }"/>'>
				</div>
				<div class="form-group">
					<label>병원 이름</label><br> <input readonly="readonly"
						name="institutionName"
						value='<c:out value="${memberInfo.institutionName }"/>'>
				</div>
				<div class="form-group">
					<label>병원 주소</label><br> <input readonly="readonly"
						name="institutionAddress"
						value='<c:out value="${memberInfo.institutionAddress }"/>'>
				</div>
				<div class="form-group">
					<label>병원 번호</label><br> <input readonly="readonly"
						name="institutionTel"
						value='<c:out value="${memberInfo.institutionTel }"/>'>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="expert">
		<c:choose>
			<c:when test="${empty ratingThreeName.memberName}">
				<img src="../resources/img/bestexpert3.png">
			</c:when>
			<c:otherwise>
			<h3>실시간 전문가 3등</h3>
				<div class="form-group">
					<label>이름</label><br> <input readonly="readonly"
						value='<c:out value="${ratingThreeName.memberName}"/>'>
				</div>
				<div class="form-group">
					<label>평균 평점</label><br> <input readonly="readonly"
						value='<c:out value="${ratingThree.rate }"/>'>
				</div>
				<div class="form-group">
					<label>병원 이름</label><br> <input readonly="readonly"
						value='<c:out value="${memberInfoThree.institutionName }"/>'>
				</div>
				<div class="form-group">
					<label>병원 주소</label><br> <input readonly="readonly"
						value='<c:out value="${memberInfoThree.institutionAddress }"/>'>
				</div>
				<div class="form-group">
					<label>병원 번호</label><br> <input readonly="readonly"
						value='<c:out value="${memberInfoThree.institutionTel }"/>'>
				</div>
			</c:otherwise>
		</c:choose>

	</div>
</div>



<%@include file="include/footer.jsp"%>