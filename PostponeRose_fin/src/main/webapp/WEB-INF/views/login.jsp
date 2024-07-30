<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="include/header.jsp"%>
<!-- End Header Area -->


		<div class="login">
			<div class="login-box" style="background-image:url('resources/img/login.png')">
				<div class="login-container">
					<div class="container">
						<div class="row"  id="kakaoLoginContainer">
							<div class="login-text">
								<p class="text1">당신의 모든 약 정보,</p>
								<br/>
								<p class="text1">약 쳐봥</p>
								<br/>
								<p class="text2">문구를 넣어주세요</p>
								<br/>
							</div>
							<div class="login-kakao">
								<c:choose>
									<c:when test="${empty isLogin || isLogin==false}">
										<div id="kakaoLoginBox">
											<h3>Kakao로</h3>
											<br>
											<h1>약쳐봥 시작하기</h1>
											<a
												href="https://kauth.kakao.com/oauth/authorize?client_id=bc19ac7c0d184c8fbf994a386db912f2&redirect_uri=http://localhost:8090/oauth&response_type=code">
												<img src="/resources/loginbtn.png">
											</a>
											<form action="medisearch" method="get" class="medisearch">
												<p>내가 복용하는 약의 정보가 궁금하다면?</p>
												<input type="text" id="medisearchForm" name="searchMed" placeholder="검색할 약의 이름을 입력해 주세요.">
												<input type="submit" class="medisearch-btn" value ="검색">
											</form>
										</div>
									</c:when>
									<c:otherwise>
										<div id="kakaoLogoutBox">
											<br/>
											<h3>${member_info.memberName}님 환영합니다!</h3>
											<div id="memberGrade">
												<p>멤버 등급: ${membertype}</p>
											</div>
											<br/>	
											<form action="medisearch" method="get" class="medisearch">
												<p>내가 복용하는 약의 정보가 궁금하다면?</p>
												<input type="text" id="medisearchForm" name="searchMed" placeholder="검색할 약의 이름을 입력해 주세요.">
												<input type="submit" class="medisearch-btn" value ="검색">
											</form>
											<div id="applyExpert">
												<p>나의 처방전 기록이 궁금하다면? <a href="/mypage/prescript"><strong>마이처방전 가기</strong></a></p>
											</div>
											<br/>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<c:if test="${not empty isLogin || isLogin == true}">
			<section class="expert-container" >
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="section-title">
								<h2><a href="../bestRating">실시간 전문의 BEST 3</a></h2>
								<p>전문의에게 문의사항이 있다면 지금 바로 문의해보세요!</p>
							</div>
							<div class="wrap" > <!-- 배너표시영역 -->
								<a href="../bestRating">
							        <div class="rolling-list"> <!-- 원본배너 -->
							            <ul>
							                <li>
							                    <div class="expert">
											        <h4>실시간 전문가 1등</h4>
											        <br>
											        <div class="form-group">
											            <label>이름</label><br>
											            <input readonly="readonly" name="name" value='<c:out value="${ratingName.memberName}"/>'>
											        </div>
											        <div class="form-group">
											            <label>평균 평점</label><br>
											            <input readonly="readonly" name="rating" value='<c:out value="${rating.rate }"/>'>
											        </div>
											        <div class="form-group">
											            <label>병원 이름</label><br>
											            <input readonly="readonly" name="institutionName" value='<c:out value="${memberInfo.institutionName }"/>'>
											        </div>
											    </div>
							                </li>
							                <li>
							                	<div class="expert">
								                    <h4>실시간 전문가 2등</h4>
								                    <br>
											        <div class="form-group">
											            <label>이름</label><br>
											            <input readonly="readonly" value='<c:out value="${ratingTwoName.memberName}"/>'>
											        </div>
											        <div class="form-group">
											            <label>평균 평점</label><br>
											            <input readonly="readonly" value='<c:out value="${ratingTwo.rate }"/>'>
											        </div>
											        <div class="form-group">
											            <label>병원 이름</label><br>
											            <input readonly="readonly" value='<c:out value="${memberInfoTwo.institutionName }"/>'>
											        </div>
										        </div>
							                </li>
							                <li>
							                	<div class="expert">
								                    <h4>실시간 전문가 3등</h4>
								                    <br>
											        <div class="form-group">
											            <label>이름</label><br>
											            <input readonly="readonly" value='<c:out value="${ratingThreeName.memberName}"/>'>
											        </div>
											        <div class="form-group">
											            <label>평균 평점</label><br>
											            <input readonly="readonly" value='<c:out value="${ratingThree.rate }"/>'>
											        </div>
											        <div class="form-group">
											            <label>병원 이름</label><br>
											            <input readonly="readonly" value='<c:out value="${memberInfoThree.institutionName }"/>'>
											        </div>
										        </div>
							                </li>
							            </ul>
							        </div>
							     </a>
		    				</div>
						</div>
					</div>
				</div>
			</section>
		</c:if>
		
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
	window.onload = function() {
		var message = "${message}";
		var error = "${error}";
		if (message) {
			alert(message);
		}
		if (error) {
			alert(error);
		}
	}
</script>
<!--Start of Tawk.to Script-->
<script type="text/javascript">
	var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
	(function() {
		var s1 = document.createElement("script"), s0 = document
				.getElementsByTagName("script")[0];
		s1.async = true;
		s1.src = 'https://embed.tawk.to/6695c28b32dca6db2cafecc3/1i2sfvs8d';
		s1.charset = 'UTF-8';
		s1.setAttribute('crossorigin', '*');
		s0.parentNode.insertBefore(s1, s0);
	})();
	
	
	
	// 롤링 배너 복제본 생성
    let roller = document.querySelector('.rolling-list');
    roller.id = 'roller1'; // 아이디 부여

    let clone = roller.cloneNode(true)
    // cloneNode : 노드 복제. 기본값은 false. 자식 노드까지 복제를 원하면 true 사용
    clone.id = 'roller2';
    document.querySelector('.wrap').appendChild(clone); // wrap 하위 자식으로 부착

    document.querySelector('#roller1').style.left = '0px';
    document.querySelector('#roller2').style.left = document.querySelector('.rolling-list ul').offsetWidth + 'px';
    // offsetWidth : 요소의 크기 확인(margin을 제외한 padding값, border값까지 계산한 값)

    roller.classList.add('original');
    clone.classList.add('clone');
</script>
<!--End of Tawk.to Script-->
<!-- End Appointment -->



<%@include file="include/footer.jsp"%>