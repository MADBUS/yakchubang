<%@ page import="com.medicalInfo.project.model.MemberType" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="include/header.jsp" %>
<!-- End Header Area -->
<%
Boolean isLogin = (Boolean) session.getAttribute("isLogin");
if (isLogin == null || isLogin == false) {
%>
<script>
    alert("로그인 후 이용해주세요");
    window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
    return;
}
%>
<!-- Check if the user is an ADMIN -->
<%
    MemberType memberType = (MemberType) session.getAttribute("membertype");
    if (memberType == null || memberType != MemberType.ADMIN) {
%>
<script>
    alert("접근권한이 없습니다");
    window.location.href = "login"; // Redirect to login page
</script>
<%
    return;
}
%>

<!-- Start Features -->
<section class="Feautes section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>전문가회원 신청리스트</h2>
                    <img src="resources/img/section-img.png" alt="#">
                    <p>최소 3일에서 7일정도 걸릴 수 있습니다.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <form id="expertForm" method="post">
                <table class="tableForm" border="1" width="350">
                    <tbody>
                        <tr>
                            <td>No</td>
                            <td>첨부파일</td>
                            <td>증명사진</td>
                            <td>신청인</td>
                            <td>등록일</td>
                            <td>미리보기</td>
                            <td>연락 이메일</td>
                            <td>거절사유</td>
                            <td>수락상태</td>
                        </tr>
                        <c:forEach items="${waitforexpertlist}" var="waitforexpert">
						    <tr>
						        <td><c:out value="${waitforexpert.waitforexpertId}" /></td>
						        <td>첨부파일: <c:out value="${waitforexpert.fileName}" />
						            <a href="http://localhost:8090/download?fileName=<c:out value='${waitforexpert.uniqueName}' />&originalFileName=<c:out value='${waitforexpert.fileName}' />&fileType=<c:out value='${waitforexpert.fileType}' />">다운로드</a>
						        </td>
						        <td>첨부파일: <c:out value="${waitforexpert.pictureName}" />
						            <a href="http://localhost:8090/download2?fileName=<c:out value='${waitforexpert.picuniName}' />&originalFileName=<c:out value='${waitforexpert.pictureName}' />&fileType=<c:out value='${waitforexpert.picType}' />">다운로드</a>
						        </td>
						        <td><c:out value="${waitforexpert.memberName}" /></td>
						        <td>
						            <fmt:formatDate value="${waitforexpert.created_at}" pattern="yyyy.MM.dd" />
						        </td>
						        <td>
						            <img src="http://localhost:8090/download2?fileName=<c:out value='${waitforexpert.picuniName}' />&originalFileName=<c:out value='${waitforexpert.pictureName}' />&fileType=<c:out value='${waitforexpert.picType}' />" width="200px" />
						        </td>
						        <td><c:out value="${waitforexpert.email}" /></td>
						        <td>
						            <select name="rejectReason_${waitforexpert.waitforexpertId}">
						                <option value="">거절 사유를 선택해주세요</option>
						                <option value="해당기관과 연락이 되질 않습니다">해당기관과 연락이 되질 않습니다</option>
						                <option value="파일이 부적절하지 않습니다">파일이 부적절하지 않습니다</option>
						                <option value="해당 기관에서 본인을 인증 할 수 없습니다">해당 기관에서 본인을 인증 할 수 없습니다</option>
						            </select>
						        </td>
						        <td>
						            <a href="modwaitforexpert?memberNum=${waitforexpert.memberNum}&waitforexpertId=${waitforexpert.waitforexpertId}&email=${waitforexpert.email}">승인</a>
						            <a href="#" onclick="reject(${waitforexpert.waitforexpertId}, '${waitforexpert.email}')">거절</a>
						        </td>
						    </tr>
						</c:forEach>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</section>

<div class="pageBtn">
	 <ul class="pagination-centered">
		<c:if test="${pageMaker.prev }">
			<li class="paginate_button previous">
				<a href="${pageMaker.startPage - 1 }">Previous</a>
			</li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			<li class="paginate_button ${pageMaker.cri.pageNum == num? 'active':'' }">
				<a href="${num}">${num}</a>
			</li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="paginate_button next">
				<a href="${pageMaker.endPage + 1 }">Next</a>
			</li>
		</c:if>
	</ul>
</div>

<form id="pageForm" action="/waitforexpert" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>

<script type="text/javascript">
    function reject(waitforexpertId, email) {
        var rejectReason = document.querySelector('select[name="rejectReason_' + waitforexpertId + '"]').value;
        if (rejectReason === "") {
            alert("거절 사유를 선택해주세요");
            return;
        }
        
        var form = document.createElement("form");
        form.method = "post";
        form.action = "delwaitforexpert"; // Controller action for rejection

        var idInput = document.createElement("input");
        idInput.type = "hidden";
        idInput.name = "waitforexpertId";
        idInput.value = waitforexpertId;
        form.appendChild(idInput);

        var emailInput = document.createElement("input");
        emailInput.type = "hidden";
        emailInput.name = "email";
        emailInput.value = email;
        form.appendChild(emailInput);

        var reasonInput = document.createElement("input");
        reasonInput.type = "hidden";
        reasonInput.name = "rejectReason";
        reasonInput.value = rejectReason;
        form.appendChild(reasonInput);

        document.body.appendChild(form);
        form.submit();
    }
    
	let pageForm = $("#pageForm");

	$(".paginate_button a").on("click", function(e) {
		// a태그의 기본 기능인 링크를 삭제 
		e.preventDefault();
		// pageNum 값을 사용자가 클릭한 a 태그의 href 속성값으로 변경
		pageForm.find("input[name='pageNum']").val($(this).attr("href"));
		pageForm.submit();
	});
</script>

<%@ include file="include/footer.jsp" %>