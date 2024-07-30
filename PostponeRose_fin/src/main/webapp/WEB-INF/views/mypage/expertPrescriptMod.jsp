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
								<table>
									<tr>
									    <td>약품 코드</td>
									    <td><input type="text" readonly="readonly" name="itemSeq" id="itemSeq"></td>
									    <td>약 이름</td>
									    <td><input type="text" readonly="readonly" name="itemName" id="itemName"></td>
									    <td>투약량</td>
									    <td><input type="text" name="dosage" id="dosage"></td>
									    <td>투약일</td>
									    <td><input type="text" name="dosageDate" id="dosageDate"></td>
									    <td>추가/삭제</td>
									    <td> <input type="checkbox" name="addordrop" id="addordrop" value="Y" checked> </td>
									    <td>comment</td>
									    <td><input type="text" name="detail_comment" id="detail_comment"></td>
									    <td><button type="button" id="addMedicineBtn">등록</button></td>
									</tr>
								</table>					
							<p/>
							<div>
							<form action="modMed" method="post">
								<input type='hidden' name='prescript_no' value='${dto.prescript_no }'>
								<table border="solid 1px black" width="100%" id="medicineTable">
									<c:if test="${not empty detaillist }" >
										<thead>
											<tr>
												<th>고유번호</th>
												<th>약품명</th>
												<th>1일 투약횟수</th>
												<th>총 투약일수</th>
												<th>변동사항</th>
												<th>설명</th>
												<th>수정</th>
											</tr>
										</thead>
										<c:forEach var="detaildto" items="${detaillist }">
												<tbody >
													<tr>
														<td><c:out value="${detaildto.medicine_no}"/><input type='hidden' name='mediID[]' value='${detaildto.medicine_no}'></td>
														<td><c:out value="${detaildto.medicine_name }"/><input type='hidden' name='itemName[]' value='${detaildto.medicine_name }'></td>
														<td><c:out value="${detaildto.per_day }"/><input type='hidden' name='pd[]' value='${detaildto.per_day }'></td>
														<td><c:out value="${detaildto.total_day }"/><input type='hidden' name='td[]' value='${detaildto.total_day }'></td>
														<td><c:out value="${detaildto.addordrop }"/><input type='hidden' name='addordrop[]' value='${detaildto.addordrop }'></td>
														<td><c:out value="${detaildto.detail_comment }"/><input type='hidden' name='d_comment[]' value='${detaildto.detail_comment }'></td>
														<td><button type='button' class='deleteBtn'>삭제</button></td>
													</tr>
												</tbody>
										</c:forEach>
									</c:if>
								</table>
								<input type="submit" value="수정완료">
								</form>
								<a href="/mypage/deleteprescript?prescript_no=${dto.prescript_no }">처방전 삭제</a> 
							</div>
							<!-- 처방전 작성 시 화면으로 돌아가서 (read only 해제된 화면) 수정(query문 updte) 처리?? -->
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End PrescriptView -->
		<h1>약 검색</h1>
			<input type="text" id="searchInput" placeholder="약이름">
			<button onclick="ajaxTest()">검색</button>
			<table id="datatablesSimple" class ="resultTestApi">
			<thead>
				<tr>
					<th>회사명</th>
					<th>약품코드</th>
					<th>약품명</th>
					<th>약품 이미지</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mediApi}" var="medis">
					<c:forEach items="${medis.body.items}" var="medi">
						<tr>
							<td>${medi.entpName}</td>
							<td>${medi.itemSeq}</td>
							<td><a href="javascript:void(0);" class="medLink" data-itemseq="${medi.itemSeq}" data-itemname="${medi.itemName}">${medi.itemName}</a></td>
							<td><img src="${medi.itemImage}" alt="${medi.itemName} 이미지"></td>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>

		</table>
<script>
// Event delegation to handle dynamically created links
    $(document).on("click", ".medLink", function() {
        var itemSeq = $(this).data("itemseq");
        var itemName = $(this).data("itemname");
        $("#itemSeq").val(itemSeq);
        $("#itemName").val(itemName);
    });

    $(document).on("click", ".deleteBtn", function() {
        $(this).closest("tr").remove();
    });
    // Add new row to #medicineTable
    $("#addMedicineBtn").click(function() {
        var itemSeq = $("#itemSeq").val();
        var itemName = $("#itemName").val();
        var dosage = $("#dosage").val();
        var addordrop = $("#addordrop").prop("checked") ? "ADD" : "DROP";
        var dosageDate = $("#dosageDate").val();
        var detailComment = $("#detail_comment").val();

        // Create a new row
        var newRow = "<tr>" +
					    "<td>" + itemSeq + "<input type='hidden' name='mediID[]' value='" + itemSeq + "'></td>" +
					    "<td>" + itemName + "<input type='hidden' name='itemName[]' value='" + itemName + "'></td>" +
					    "<td>" + dosage + "<input type='hidden' name='pd[]' value='" + dosage + "'></td>" +
					    "<td>" + dosageDate + "<input type='hidden' name='td[]' value='" + dosageDate + "'></td>" +
					    "<td>" + addordrop + "<input type='hidden' name='addordrop[]' value='" + addordrop +"'></td>" +
					    "<td>" + detailComment + "<input type='hidden' name='d_comment[]' value='" + detailComment + "'></td>" +
					    "<td><button type='button' class='deleteBtn'>삭제</button></td>" +
    				 "</tr>";

        // Append the new row to the table
        $("#medicineTable tbody").append(newRow);

        // Clear the input fields
        $("#itemSeq").val("");
        $("#itemName").val("");
        $("#dosage").val("");
        $("#dosageDate").val("");
        $("#addordrop").val("");
        $("#detail_comment").val("");
    });
		<!--/ End Comment -->
		function ajaxTest() {
		    let find = $("#searchInput").val();
		    console.log("검색어: " + find);

		    $.ajax({
		        url: "ajaxTest",
		        type: "post",
		        dataType: "json",
		        data: { "search": find },
		        success: function(data) {
		            // 결과 테이블을 비웁니다.
		            $('.resultTestApi tbody').empty();
		            
		            // 데이터 구조에 따라 처리합니다.
		            $.each(data, function(index, response) {
		                $.each(response.body.items, function(idx, item) {
		                    // 새로운 행 생성
		                    var tr = $("<tr>");

		                    // 각 항목을 셀로 추가
		                    tr.append($("<td>").text(item.entpName));
		                    tr.append($("<td>").text(item.itemSeq));
		                    tr.append($("<td>").html("<a href='javascript:void(0);' class='medLink' data-itemseq='" + item.itemSeq + "' data-itemname='" + item.itemName + "'>" + item.itemName + "</a>"));
		                    tr.append($("<td>").html("<img src='" + item.itemImage + "' alt='약품 이미지' style='width: 100px; height: auto;'>"));

		                    // 행을 테이블에 추가
		                    $('.resultTestApi tbody').append(tr);
		                });
		            });
		        },
		        error: function(xhr, status, error) {
		            console.error("AJAX 요청 실패:", status, error);
		        }
		    });
		}
</script>		
<%@include file="../include/footer.jsp"%>