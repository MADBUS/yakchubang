<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>

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
    MemberType memberType = (MemberType) session.getAttribute("membertype");
    if (memberType != MemberType.ADMIN) {
%>
    <script>
        alert("작성권한이 없습니다");
        window.location.href = "notice"; // 로그인 페이지로 리디렉션
    </script>
<%
        return;
    }
%>	
	<div>
		<h2>공지사항 작성</h2>
		<form method="post" action="/insertnotice">
			<table>
				<caption>
					<strong><span>*</span> 표시는 필수입력 항목입니다.</strong>
				</caption>
				<tbody>
					<tr>
						<th>제목<span>*</span></th>
						<td><input  name="noticetitle" value=""  required/></td>
					</tr>
					<tr>
						<th>작성자<span>*</span></th>
						<td><input name="writerName" value="" required/></td>
					</tr>
					<tr>
						<th>내용<span>*</span></th>
						<td><textarea  name="noticecontent"
								cols="30" rows="10" class="textarea01" required></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_right mt15">
				<button type="button"><a href="/notice">목록으로</a></button>
				<button type="submit">등록하기</button>			
			</div>

		</form>

	</div>


<%@include file="include/footer.jsp"%>