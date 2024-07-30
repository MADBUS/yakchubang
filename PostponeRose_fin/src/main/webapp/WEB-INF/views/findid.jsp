<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


  <form class = "content" action="id_auth.me" method="post">
    <div class="textbox">
        <h3>아이디를 전달받을 이메일을 입력해주세요</h3>
        <br><br>
          <label for="email">이메일</label>
          <input id="email" name=email required="/^([\w-]+(?:.[\w-]+))@((?:[\w-]+.)\w[\w-]{0,66}).([a-z]{2,6}(?:.[a-z]{2})?)?$/i" type="email" />
    </div>
       <input type="submit" id="check" value="아이디찾기">
</form>

<script type="text/javascript">
 $(document).ready(function() {
    $('#check').on('click', function(){
        alert("이메일로 아이디가 전송되었습니다.");
    });
 });
</script>

<%@include file="include/footer.jsp"%>