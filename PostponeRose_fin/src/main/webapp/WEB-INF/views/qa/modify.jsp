<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style type="text/css">
	table{
	  width: 100%;
      border: 2px solid black;
	}
	th,td{
      align-content: center;
      border: 1px solid black;
    }
     #d1{
    	 width: 100%;
    	 height: 100px;
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
</head>
<body>
	<h1>수정 및 삭제</h1>
	<form id="modForm" action="">
		<div id="d1">
        <label>제목</label><br>    
    	<input  name="title" value='<c:out value="${q_ID.title }"/>'>
    </div>
    <div id="d1">
        <label>작성자</label><br>
    	<input  readonly="readonly"   name="writer" value='<c:out value="${q_ID.writer }"/>'>
    </div>
    <div id="d1">
        <label>내용</label><br>
    	 <textarea rows="5" cols="50"   name="context">
	       <c:out value="${q_ID.context }"/>
	   </textarea>
	</div>
	<br><br><br>
	<div id="d1">
		<label>처방전 번호</label><br>
    	<input name="prescript_no" value='<c:out value="${q_ID.prescript_no }"/>'>
	</div>
	<br>
	<div id="prescript">
		<h3>게시글 처방전</h3>
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
		  	<c:when test="${q_ID.prescript_no ==0 }">
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
		   	<tr>
		   		<th><c:out value="${prescriptDTO.prescribed_date}"/></th>
		   		<th><c:out value="${prescriptDTO.prescript_no}"/></th>
		   		<th><c:out value="${prescriptDTO.patient_name}"/></th>
		   		<th><c:out value="${prescriptDTO.patient_phone}"/></th>
		   		<th><c:out value="${prescriptDTO.institution_address}"/></th>
		   		<th><c:out value="${prescriptDTO.expert_name}"/></th>
		   	<tr> 	
		   	</c:otherwise>
		  </c:choose>
		</tbody>  	
	</table>
	</div>
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
		<button type="button" class="btn" data-oper ="list">게시판 돌아가기</button>
		<button type="button" class="btn" data-oper ="modify">수정</button>
		<button type="button" class="btn" data-oper ="delete">삭제</button>
	</form>
	<br><br><br>	
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