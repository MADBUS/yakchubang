<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
</head>
<body>


		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-10" id="mediSerchSection">
						<div class="table-container">
							<form id="modForm" action="">
								<h3>QA 게시판</h3>
								<h5 id="qaPrescriptTitle">수정 및 삭제</h5>
								<div id="qaListBtn">
									<button type="button" class="btn" data-oper ="list">게시판으로 돌아가기</button>
								</div>
								<br/>
								<div class="card mb-4">
									<div class="qa-title">
										<span id="span1"><b>제목 </b><input name="title" value='<c:out value="${q_ID.title }"/>'></span>
										<span id="span2" class="span3-writer"><b>작성자 </b><input readonly="readonly" name="writer" value='<c:out value="${q_ID.writer }"/>'></span>
										<span id="span3"><b>작성일 </b><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${q_ID.created_at }"/></span>
										
										<span id="span4"><b>조회 </b>${q_ID.viewcnt }</span>
									</div>
									<div class="qa-content">
										<p><textarea rows="5" cols="50" name="context"><c:out value="${q_ID.context }"/></textarea></p>
									</div>
								</div>
								<div id="qaPreNum">
									<span id="span1"><b>현재 게시글 처방전 번호 </b><input name="prescript_no" value='<c:out value="${q_ID.prescript_no }"/>'></span>
								</div>
								<br/>
								<c:choose> 
								  	<c:when test="${q_ID.prescript_no ==0 }">
								   	</c:when>
								   	<c:otherwise>
								   		<h5 id="qaPrescriptTitle">게시글 처방전</h5>
								   		<br/>
										<div class="card mb-4" id="qaPrescript">
											<div id="qaPrescriptContent1">
												<span id="qaPreSpan1"><b>처방전 No. </b>${prescriptDTO.prescript_no}</span>
												<span id="qaPreSpan2"><b>환자명 </b>${prescriptDTO.patient_name}</span>
												
												<span id="qaPreSpan3"><b>전문가명 </b>${prescriptDTO.expert_name}</span>
												<span id="qaPreSpan4"><b>처방기관 </b>${prescriptDTO.institution_address}</span>
												<span id="qaPreSpan5"><b>처방일자 </b><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${prescriptDTO.prescribed_date}"/></span>
											</div>
										</div>	
								   	</c:otherwise>
								</c:choose>
								<br/>
								<c:choose> 
								  	<c:when test="${empty myPrescript}">
								   	</c:when>
								   	<c:otherwise>
								   	<h5 id="qaPrescriptTitle">마이처방전</h5>
									<br/>
									<div class="card mb-4">
										<table class="medicine-table">
										    <thead>	
											 <tr>
											 	<th>처방전 No.</th>
												<th>환자명</th>
												<th>전문가명</th>
												<th>처방기관</th>
												<th>처방일자</th>
											 </tr>
										   </thead>
										   <tbody>
										   	  <c:forEach items="${myPrescript}" var="my">
												   	<tr>
												   		<td data-th='처방전 No.'><c:out value="${my.prescript_no}"/></td>
												   		<td data-th='환자명'><c:out value="${my.patient_name}"/></td>
												   		<td data-th='전문가명'><c:out value="${my.expert_name}"/></td>
												   		<td data-th='처방기관'><c:out value="${my.institution_address}"/></td>
												   		<td data-th='처방일자'><fmt:formatDate pattern = "yyyy-MM-dd hh:mm" value="${my.prescribed_date}"/></td>
												   	 <tr> 
										   		</c:forEach>	
										    </tbody>
										  </table>
										</div>
								   	 </c:otherwise>
								   </c:choose>
								   <button type="button" class="btn" data-oper ="modify">수정</button>
								   <button type="button" class="btn" data-oper ="delete">삭제</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
							
							
							
							
	
<script type="text/javascript">
	$(document).ready(function() {
		const formObj = $("#modForm");
		
		$(".btn").on("click", function(e) {
			e.preventDefault(); 
			const operation = $(this).data("oper");
			let url = "";
			let method = "";
			
			switch(operation){
			case "list":
				url = "/qa/list";
				method = "get";
				break;
			case "modify":
				url = "/qa/modify?qa_id=${q_ID.qa_id}";
				method = "post";
				alert("게시글이 수정되었습니다");
				break;
			case "delete":
				if (!confirm("정말 삭제하시겠습니까?")) {
					 event.preventDefault();
					return;
				}else{
					url = "/qa/remove?qa_id=${q_ID.qa_id}";
					method = "post";
					alert("게시글이 삭제되었습니다");
					break;
				}
				
			default:
				return;
			}
			
			formObj.attr("action",url).attr("method",method).submit();
		});
	});

</script>
<%@include file="../include/footer.jsp"%>