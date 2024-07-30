<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->

<!-- 기존 회원 Login Start -->
<div class="login">
    <div class="login-box" style="background-image:url('resources/img/login.png')">
        <div class="login-container">
            <div class="container">
                <div class="row"  id="loginContainer">
                    <div class="col-lg-12">
                        <div class="login-text">
                            <p class="text1">약쳐봥 ~~~</p>
                            <br/>
                            <p class="text2">문구를 넣어주세요.</p>
                        </div>
                        <!-- 오류 메시지를 표시할 공간 추가 -->
                        <form id="loginBox">
                            <table id="loginForm">
                                <tr>
                                    <td><input name="id" id="id" placeholder="아이디"></td>
                                </tr>
                                <tr>
                                    <td><input name="pw" id="pw" placeholder="비밀번호" type="password"></td>
                                </tr>
                            </table>
                            <div>
								<div id="error-message" style="color:red; display:none;">아이디 또는 비밀번호가 잘못되었습니다.</div>                            
                                <input class="login-btn" type="button" value="로그인" onclick="login()">
                                
                                <span>아이디를 잊으셨나요? <a href="/findid"><strong>아이디 찾기</strong></a></span>
                                <br/>
                                <span>비밀번호를 잊으셨나요? <a href="/findpw"><strong>비밀번호 찾기</strong></a></span>
                            </div>    
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function login() {
        const id = $('#id').val();
        const pw = $('#pw').val();
        
        $.ajax({
            url: '/loginidpw',
            type: 'POST',
            data: {
                id: id,
                pw: pw
            },
            dataType: 'json',  // JSON 형식으로 응답을 받기 위한 설정
            success: function(response) {
                console.log(response);  // 응답 확인용 로그
                if (response.success) {
                    console.log("로그인 성공");
                    window.location.href = '/login';  // 로그인 성공 시 페이지 이동
                } else {
                    console.log("로그인 실패: " + response.message);
                    $('#error-message').text(response.message).show();
                }
            },
            error: function() {
                console.log("서버 오류 발생");
                $('#error-message').text('서버 오류가 발생했습니다. 나중에 다시 시도해주세요.').show();
            }
        });
    }
</script>

<%@include file="include/footer.jsp"%>
