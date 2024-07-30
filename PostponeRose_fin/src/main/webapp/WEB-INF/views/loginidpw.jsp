<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
<!-- End Header Area -->
      
      <!-- 기존 회원 Login Start -->
      <div class="login">
         <div class="login-box" style="background-image:url('resources/img/login.png')">
            <div class="login-container">
               <div class="container">
                  <div class="row"  id="loginContainer">
                     <div class="login-text">
                        <p class="text1">당신의 모든 약 정보,</p>
                        <br/>
                        <p class="text1">약 쳐봥</p>
                        <br/>
                        <p class="text2">문구를 넣어주세요</p>
                        <br/>
                     </div>
                     <div id="loginBox">
                        <table id="loginForm">
                           <tr>
                              <td><input name="id" id="id" placeholder="아이디"></td>
                           </tr>
                           <tr>
                              <td><input name="pw" id="pw" type="password" placeholder="비밀번호"></td>
                           </tr>                        
                        </table>
                        <p id="error-message" style="color:red; display:none;">아이디 또는 비밀번호가 잘못되었습니다.</p>
                        <div>
                           
                           <input class="login-btn" type="submit" value="로그인" onclick="login()">
                        
                           <span>아이디를 잊으셨나요? <a href="/findid"><strong>아이디 찾기</strong></a></span>
                           <br/>
                           <span>비밀번호를 잊으셨나요? <a href="/findpw"><strong>비밀번호 찾기</strong></a></span>
                        </div>
                     </div>
                  </div>
               </div>
               
            </div>
         </div>
      </div>
      
      
      <section class="services section">
         <div class="container">
            <div class="row">
               <div class="col-lg-12">
                  <div class="section-title">
                     <h2>웹사이트 설명#</h2>
                     <p>마지막에 채울 예정</p>
                  </div>
               </div>
            </div>
         </div>
      </section>
      
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
            dataType: 'json',  // Expect JSON response
            success: function(response) {
                console.log(response);  // Log the response to check its content
                if (response) {
                    console.log("로그인 성공");
                    window.location.href = '/login';  // Redirect on success
                } else {
                    console.log("로그인 실패");
                    $('#error-message').show();
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