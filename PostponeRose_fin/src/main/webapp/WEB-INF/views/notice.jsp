<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<style>
.hidden{
	display: none;
}

nav{
	background-color: #FFF;
	padding: 10px;
}

nav ul{
	list-style: none;
	padding: 0;
}

nav ul li{
	margin: 10px 0;
}

nav ul li a{
	color: black;
	text-decoration: none;
}

</style>


<button id="menuButton">전체메뉴</button>
<nav id="menuBar" class="hidden">
	<ul>
		<li><a href="/notice">공지사항</a></li>
		<!-- <li><a href="#">홈페이지 설명</a></li> -->
		<li><a href="/agreement">개인정보방침</a></li>
		<li><a href="/waitforexpert">전문가 등록</a></li>
	</ul>
</nav>

<script>
	document.getElementById('menuButton').addEventListener('click', function() {
		var menuBar = document.getElementById('menuBar');
		if (menuBar.classList.contains('hidden')) {
			menuBar.classList.remove('hidden');
		} else {
			menuBar.classList.add('hidden');
		}
	});
</script>
<div>
	<h2>공지사항 목록</h2>
	<table>
		<thead>
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>게시자</th>
				<th>게시일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${allnotice}" var="notice">
				<tr>
					<td>${notice.id_announcement}</td>
					<td><a
						href="/noticedetail?id_announcement=${notice.id_announcement}">${notice.title}</a></td>
					<td>${notice.writerName}</td>
					<td><fmt:formatDate value="${notice.created_at}"
							pattern="yyyy.MM.dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

	<div class="pageBtn">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage - 1 }">Previous</a>
					</li>
					</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }">
								<a href="${num }">${num }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage + 1 }">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
				
				<form id="pageForm" action="/notice" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<input type="hidden" name="type" value="${pageMaker.cri.type }">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
				</form>


<div>
	<button type="button">
		<a href="/noticewrite">작성</a>
	</button>
</div>
<script>
let pageForm = $("#pageForm");

$(".paginate_button a").on("click", function(e) {
	// a태그의 기본 기능인 링크를 삭제 
	e.preventDefault();
	// pageNum 값을 사용자가 클릭한 a 태그의 href 속성값으로 변경
	pageForm.find("input[name='pageNum']").val($(this).attr("href"));
	pageForm.submit();
});
</script>


<%@include file="include/footer.jsp"%>