<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->
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
<!-- Slider Area -->
<%
    MemberType memberType = (MemberType) session.getAttribute("membertype");
    if (memberType == null) {
%>
    <script>
        alert("로그인 후 이용해주세요");
        window.location.href = "login"; // 로그인 페이지로 리디렉션
    </script>
<%
        return;
    }
%>
<!-- Start Feautes -->
<section class="Feautes section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2>전문가회원 신청</h2>
                    <img src="resources/img/section-img.png" alt="#">
                    <p>최소 3일에서 7일정도 걸릴 수 있습니다.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <form id="expertForm" action="upload_ok" method="post" enctype="multipart/form-data">
                <table class="tableForm">
                    <tbody>
                        <tr>
                            <td>이름 : </td>
                            <td><input type="text" name="memberName" id="memberName"></td>
                        </tr>
                        <tr> 
                            <td>의료 면허: </td>
                            <td><input type="text" name="medicalLicense" id="medicalLicense"></td>
                        </tr>
                        <tr> 
                            <td>의료 기관: </td>
                            <td><input type="text" name="medicalInstitution" id="medicalInstitution"></td> 
                        </tr>
                        <tr> 
                            <td>의료 기관주소: </td>
                            <td><input type="text" name="InstitutionAddress" id="InstitutionAddress"></td> 
                        </tr>
                        <tr>
                            <td>의료 기관 전화번호: </td>   
                            <td><input type="text" name="institutionTel" id="institutionTel"></td> 
                        </tr>
                        <tr>
                            <td>연락 받을 이메일: </td>
                            <td><input type="text" name="email" id="email"></td> 
                        </tr>
                        <tr>
                            <td>증명사진 파일 선택: </td>
                            <td><input type="file" name="picture" id="picture"></td>
                        </tr>
                        <tr>
                            <td>전문가 면허증 파일 선택: </td>
                            <td><input type="file" name="file" id="file"></td>
                        </tr>
                        
                        <tr>
                            <td colspan="2"><input type="submit" value="제출하기"></td>
                        </tr>
                    </tbody>
                </table>
                
            </form>
        </div>
    </div>
</section>
<!--/ End Feautes -->

<!-- Start Fun-facts -->

<%@include file="include/footer.jsp"%>

<script>
    document.getElementById('expertForm').onsubmit = function(e) {
        var missingFields = [];

        var fields = [
            {id: 'memberName', name: '이름'},
            {id: 'medicalLicense', name: '의료 면허'},
            {id: 'medicalInstitution', name: '의료 기관'},
            {id: 'InstitutionAddress', name: '의료 기관주소'},
            {id: 'institutionTel', name: '의료 기관 전화번호'},
            {id: 'email', name: '연락 받을 이메일'},
            {id: 'picture', name: '증명사진 파일 선택'},
            {id: 'file', name: '전문가 면허증 파일 선택'}
        ];

        fields.forEach(function(field) {
            var value = document.getElementById(field.id).value;
            if (!value) {
                missingFields.push(field.name);
            }
        });

        if (missingFields.length > 0) {
            alert(missingFields.join(', ') + '이(가) 필요합니다.');
            e.preventDefault();
        }
    };
</script>