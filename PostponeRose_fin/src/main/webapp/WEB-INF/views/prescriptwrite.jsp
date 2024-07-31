<%@page import="com.medicalInfo.project.model.MemberInfoDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->
<style>
body {
	font-size: 140%;
}

h2 {
	text-align: center;
	padding: 20px 0;
}

table caption {
	padding: .5em 0;
}

table.dataTable th, table.dataTable td {
	white-space: nowrap;
}

.p {
	text-align: center;
	padding-top: 140px;
	font-size: 14px;
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
MemberInfoDTO memberInfo = (MemberInfoDTO)session.getAttribute("memInfo");
MemberType memberType = (MemberType) session.getAttribute("membertype");
if (memberType != MemberType.EXPERT) {
%>
<script>
	alert("접근 권한이 없습니다");
	window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
return;
}else if (memberType==null){
%>	
<script>
	alert("접근 권한이 없습니다");
	window.location.href = "login"; // 로그인 페이지로 리디렉션
</script>
<%
return;
}
%>
<!-- Slider Area -->
<h2>처방전 리스트</h2>
		<form id="prescriptionForm" action="insertprescript" method="post">  	
			<table>
				<tbody>
					<tr>
						<td>환자 성명</td>
						<td><input type="text" name="patientName" id="patientName"></td>
						<td>환자 이메일</td>
						<td><input type="text" name="memberId" id="memberId">
							<button type="button" id="lookupBtn">조회</button></td>
						<td>전화 번호</td>
						<td><input type="text" name="phoneNum" id="phoneNum"></td>
						<td><button type="button" id="registerPatient">신규 등록</button></td>
					</tr>
					<tr>
						<td>발행기관</td>
						<td><input type="text" name="prescribingInstitution" value="<%=memberInfo.getInstitutionName() %>"></td>	
						<td>전문가 이름</td>
						<td><input type="text" name="prescribingDoctor" value="<%=memberDTO.getMemberName() %>"></td>
					</tr>
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
				</tbody>
			</table>
			<table class="datatable-table" id="medicineTable">
				<thead>
					<tr>
						<th>고유번호</th>
						<th>약품명</th>
						<th>투약량</th>
						<th>투약일</th>
						<th>추가/제거</th>
						<th>코멘트</th>
						<th>작업</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
			<input type="submit" value="처방전 작성">
			</form>
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
$(document).ready(function(){
    $("#lookupBtn").click(function(){
        var memberId = $("#memberId").val();
        $.ajax({
            url: "lookupPatient", // URL of the controller
            type: "post",
            data: { memberId:memberId },
            dataType : "json",
            success: function(response) {
                console.log("response체크"+response.memberName);
                if (response.success) {
                    $("#patientName").val(response.memberName);
                    $("#phoneNum").val(response.phoneNum);
                } else {
                    alert("환자 정보를 찾을 수 없습니다.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    });
    
    $("#registerPatient").click(function(){
        var patientEmail = $("#memberId").val();
        var patientName = $("#patientName").val();
        var patientTel = $("#phoneNum").val();
        $.ajax({
            url: "registerpatient", // URL of the controller
            type: "post",
            data: {patientName:patientName,
                patientEmail: patientEmail,
                patientTel:patientTel},
            dataType : "json",
            success: function(response) {
                console.log("response체크"+response);
                if (response) {
                    alert("환자 정보를 추가등록 했습니다.");
                } else {
                    alert("환자 정보를 찾을 수 없습니다.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    });

    // Event delegation to handle dynamically created links
    $(document).on("click", ".medLink", function() {
        var itemSeq = $(this).data("itemseq");
        var itemName = $(this).data("itemname");
        $("#itemSeq").val(itemSeq);
        $("#itemName").val(itemName);
    });

    // Add new row to #medicineTable
    $("#addMedicineBtn").click(function() {
        var itemSeq = $("#itemSeq").val();
        var itemName = $("#itemName").val();
        var dosage = $("#dosage").val();
        var dosageDate = $("#dosageDate").val();
        var detailComment = $("#detail_comment").val();
        var addordrop = $("#addordrop").prop("checked") ? "ADD" : "DROP";
        // Create a new row
        var newRow = "<tr>" +
            "<td>" + itemSeq + "<input type='hidden' name='mediID[]' value='" + itemSeq + "'></td>" +
            "<td>" + itemName + "<input type='hidden' name='itemName[]' value='" + itemName + "'></td>" +
            "<td>" + dosage + "<input type='hidden' name='pd[]' value='" + dosage + "'></td>" +
            "<td>" + dosageDate + "<input type='hidden' name='td[]' value='" + dosageDate + "'></td>" +
            "<td>"+ addordrop + "<input type='hidden' name='addordrop[]' value='"+ addordrop  +"'></td>" +
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
        $("#detail_comment").val("");
    });

    // Event delegation to handle delete button
    $(document).on("click", ".deleteBtn", function() {
        $(this).closest("tr").remove();
    });

    // Prevent form submission on button click
    $("button").not("[type='submit']").click(function(event){
        event.preventDefault();
    });

    // Prevent form submission if no medicine is added
    $("#prescriptionForm").submit(function(event) {
        if ($("#medicineTable tbody tr").length === 0) {
            alert("처방전에 약품을 추가하세요.");
            event.preventDefault();
        }
    });
});

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
<%@include file="include/footer.jsp"%>