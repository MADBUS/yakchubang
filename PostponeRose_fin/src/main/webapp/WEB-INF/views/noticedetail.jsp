<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>


<div>
	<h2>공지사항</h2>

	<table>
		<tbody>
			<tr>
				<th>No</th>
				<td>${notice.id_announcement}</td>
				<th>제목</th>
				<td>${notice.title}</td>
				<th>게시자</th>
				<td>${notice.writerName}</td>
				<th>게시일</th>
				<td>${notice.created_at}</td>
			</tr>
			<tr>
				<td colspan="8">${notice.content}</td>
			</tr>
		</tbody>
	</table>
	<div class="btn_right mt15">
		<button type="button">
			<a href="/notice">목록으로</a>
		</button>
		<button type="button">
			<a href="/modnotice?id_announcement=${notice.id_announcement}">수정하기</a>
		</button>
		<input type="button" value="삭제하기" id="delete">
		<%-- <button type="button"><a href="/deletenotice?id_announcement=${notice.id_announcement}">삭제하기</a></button> --%>
	</div>

	<script>
document.getElementById('delete').addEventListener('click',function() {
	let result = confirm("게시글을 삭제하시겠습니까?");
	if (result) {
					window.location.href = "/deletenotice?id_announcement=${notice.id_announcement}";
				}
		});
	</script>

</div>


<%@include file="include/footer.jsp"%>