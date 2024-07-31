<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.medicalInfo.project.model.MemberInfoDTO"%>
<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!doctype html>
<html class="no-js" lang="zxx">
    <head>

        <!-- Meta Tags -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="keywords" content="Site keywords here">
		<meta name="description" content="">
		<meta name='copyright' content=''>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- Title -->
        <title>Mediplus - Free Medical and Doctor Directory HTML Template.</title>
        
        <style type="text/css">
        	.pageBtn {width: 100%; margin:0 auto; box-sizing: border-box;}
        	.pagination {text-align: center; vertical-align: middle; }
			.paginate_button {display: inline-block; list-style: none; padding: 6px; text-align: center;}
			
			#rateform fieldset{
			    display: inline-block;
			    direction: rtl;
			    border:0;
			}
			#rateform fieldset legend{
			    text-align: right;
			}
			#rateform input[type=radio]{
			    display: none;
			}
			#rateform label{
			    font-size: 3em;
			    color: transparent;
			    text-shadow: 0 0 0 #f0f0f0;
			}
			#rateform label:hover{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#rateform label:hover ~ label{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#rateform input[type=radio]:checked ~ label{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#reviewContents {
			    width: 100%;
			    height: 150px;
			    padding: 10px;
			    box-sizing: border-box;
			    border: solid 1.5px #D3D3D3;
			    border-radius: 5px;
			    font-size: 16px;
			    resize: none;
			}
		</style>
		
		<!-- Favicon -->
        <link rel="icon" href="../resources/img/favicon.png">
		
		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
		<!-- Nice Select CSS -->
		<link rel="stylesheet" href="../resources/css/nice-select.css">
		<!-- Font Awesome CSS -->
        <link rel="stylesheet" href="../resources/css/font-awesome.min.css">
		<!-- icofont CSS -->
        <link rel="stylesheet" href="../resources/css/icofont.css">
		<!-- Slicknav -->
		<link rel="stylesheet" href="../resources/css/slicknav.min.css">
		<!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="../resources/css/owl-carousel.css">
		<!-- Datepicker CSS -->
		<link rel="stylesheet" href="../resources/css/datepicker.css">
		<!-- Animate CSS -->
        <link rel="stylesheet" href="../resources/css/animate.min.css">
		<!-- Magnific Popup CSS -->
        <link rel="stylesheet" href="../resources/css/magnific-popup.css">
		
		<!-- Medipro CSS -->
        <link rel="stylesheet" href="../resources/css/normalize.css">
        <link rel="stylesheet" href="../resources/style.css">
        <link rel="stylesheet" href="../resources/css/responsive.css">
        
      
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
    </head>
    <body>
	
		<!-- Preloader -->
        <div class="preloader">
            <div class="loader">
                <div class="loader-outter"></div>
                <div class="loader-inner"></div>

                <div class="indicator"> 
                    <svg width="16px" height="12px">
                        <polyline id="back" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                        <polyline id="front" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                    </svg>
                </div>
            </div>
        </div>
        <!-- End Preloader -->
		
		<!-- Get Pro Button -->
		<ul class="pro-features">
			<a class="get-pro" href="#">Get Pro</a>
			<li class="big-title">Pro Version Available on Themeforest</li>
			<li class="title">Pro Version Features</li>
			<li>2+ premade home pages</li>
			<li>20+ html pages</li>
			<li>Color Plate With 12+ Colors</li>
			<li>Sticky Header / Sticky Filters</li>
			<li>Working Contact Form With Google Map</li>
			<div class="button">
				<a href="http://preview.themeforest.net/item/mediplus-medical-and-doctor-html-template/full_screen_preview/26665910?_ga=2.145092285.888558928.1591971968-344530658.1588061879" target="_blank" class="btn">Pro Version Demo</a>
				<a href="https://themeforest.net/item/mediplus-medical-and-doctor-html-template/26665910" target="_blank" class="btn">Buy Pro Version</a>
			</div>
		</ul>
	
		<!-- Header Area -->
		<header class="header" >
			<!-- Topbar -->
			<div class="topbar">
				<div class="container">
					<div class="row">
						<div class="col-lg-6 col-md-5 col-12">
							<!-- Contact -->
							<ul class="top-link">
								<li><a href="#">About</a></li>
								<li><a href="#">Doctors</a></li>
								<li><a href="#">Contact</a></li>
								<li><a href="#">FAQ</a></li>
							</ul>
							<!-- End Contact -->
						</div>
						<div class="col-lg-6 col-md-7 col-12">
							<!-- Top Contact -->
							<ul class="top-contact">
								<li><i class="fa fa-phone"></i>+880 1234 56789</li>
								<li><i class="fa fa-envelope"></i><a href="mailto:support@yourmail.com">support@yourmail.com</a></li>
							</ul>
							<!-- End Top Contact -->
						</div>
					</div>
				</div>
			</div>
			<!-- End Topbar -->
			<!-- Header Inner -->
			<div class="header-inner">
				<div class="container">
					<div class="inner">
						<div class="row">
							<div class="col-lg-3 col-md-3 col-12">
								<!-- Start Logo -->
								<div class="logo">
									<a href="../index"><img src="../resources/img/logo.png" alt="#"></a>
								</div>
								<!-- End Logo -->
								<!-- Mobile Nav -->
								<div class="mobile-nav"></div>
								<!-- End Mobile Nav -->
							</div>
							<div class="col-lg-7 col-md-9 col-12">
								<!-- Main Menu -->
								<div class="main-menu">
									<nav class="navigation">
										<ul class="nav menu">
											<li class="active"><a href="#">약 검색 </a></li>
											<li><a href="#">QA 게시판 </a></li> <!-- 태기님 파트 -->
											<li><a href="#">공지사항 </a></li> <!-- 수연이 파트 -->
											<li><a href="../mypage/patientMypage">마이페이지 <i class="icofont-rounded-down"></i></a>
												<ul class="dropdown">
													<li><a href="../mypage/prescript">마이처방전</a></li>
													<li><a href="../qa">QA문의 내역</a></li>
													<li><a href="../mypage/memberEdit">회원정보 수정</a></li> <!-- PATIENT 정보 수정 -->
												</ul>
											</li>
											<%
												// Get the session attribute "membertype"
											    MemberType membertype = (MemberType) session.getAttribute("membertype");
												MemberDTO memberDTO = (MemberDTO) session.getAttribute("member_info");
												MemberInfoDTO memberInfoDTO = (MemberInfoDTO) session.getAttribute("member");
												PrescriptDTO prescriptDTO = (PrescriptDTO) session.getAttribute("prescript");

											    if (membertype == MemberType.EXPERT) {
											%>
											<li><a href="../mypage/expertMypage">전문가 마이페이지<i class="icofont-rounded-down"></i></a>
												<ul class="dropdown">
													<li><a href="../mypage/#">처방전 작성</a></li> <!-- 장열님 파트 -->
													<li><a href="../mypage/expertMypage">처방전 확인</a></li> <!-- 작성된 처방전 모두 확인하는 페이지 -->
												</ul>
											</li>
											<%
											    }
											%>
										</ul>
									</nav>
								</div>
								<!--/ End Main Menu -->
							</div>
							<div class="col-lg-2 col-12">
								<div class="get-quote">
									<%
									   if (membertype == null) {
									%>
									<a href="../login" class="btn">로그인</a>
									<%
									    } else if (membertype != null) {
									%>
									<a href="/logout" class="btn">로그아웃</a>
									<%
									    }
									%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--/ End Header Inner -->
		</header>
<!-- End Header Area -->
<%
	// Check if the membertype is null
	if (membertype == null) {
	    // Redirect to login.jsp
	    response.sendRedirect("/login");
	    return;
	} else if (membertype.equals("EXPERT") || membertype.equals("PATIENT") && memberDTO.getMemberNum() == prescriptDTO.getMemberNum()) {
		// Redirect to login.jsp
		response.sendRedirect("/mypage/memberEdit");
	 return;
	}
%>

		<section class="Feautes section"></section>
		<section class="Feautes section">
			<div class="section-title">
				<h2>회원 마이페이지</h2>
			</div>
		</section>
		
		<!-- Start ExpertEdit -->
		<section class="Feautes section">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-title">
							<h2>회원 정보 수정</h2>
							<img src="../resources/img/section-img.png" alt="#">
							<p/>
							<div>
								<form name="editForm" action="/mypage/edit" method="post" onsubmit="return validateForms()">
									<%
										String memberID = memberDTO.getMemberId();
										String memberName = memberDTO.getMemberName();
										String memberAddress = memberDTO.getMemberAddress();
										String memberEmail = memberDTO.getMemberEmail();
										String memberPhone = memberDTO.getMemberPhone();
										int memberNum = memberDTO.getMemberNum();
									%>
									<div>
										<label>회원 ID</label>
							            <input type="text" readonly="readonly" name="memberId" value="${memberDto.memberId }">
							        </div>
									<div>
										<label>회원 이름</label>
							            <input type="text" readonly="readonly" name="memberName" value="<%=memberName%>">
							        </div>
							        <div>
										<label>회원 주소</label>
							            <input type="text" name="memberAddress" value="${memberDto.memberAddress }">
							        </div>
							       	<div>
										<label>회원 이메일 주소</label>
							            <input type="text" readonly="readonly" name="memberEmail" value="<%=memberEmail%>">
							        </div>
							        <div>
							        	<label>회원 연락처</label>
							            <input type="text" name="memberPhone" value="${memberDto.memberPhone }">
							        </div>
							        <br/>
							        <%
										if (membertype == MemberType.EXPERT) {
											String institutionName = memberInfoDTO.getInstitutionName();
											String institutionAddress = memberInfoDTO.getInstitutionAddress();
											String license = memberInfoDTO.getLicense();
											String institytionTel = memberInfoDTO.getInstitutionTel();
											System.out.println("이거 찍히냐?"+memberInfoDTO.toString());
									%>
						        	<p><strong>전문기관 등록 정보 변경 필요 시 재등록 요청 부탁드립니다.</strong></p>
							        <br/>
							        <div>
							        	<img src="http://localhost:8090/download2?fileName=<%=memberInfoDTO.getPicuniName() %>&originalFileName=<%=memberInfoDTO.getPictureName() %>&fileType=<%=memberInfoDTO.getPicType() %>" width="200px" />
							        </div>
							       	<div>
							        	<img src="http://localhost:8090/download?fileName=<%=memberInfoDTO.getUniqueName() %>&originalFileName=<%=memberInfoDTO.getFileName() %>&fileType=<%=memberInfoDTO.getFileType() %>" width="200px" />
							        </div>
							        <div>
										<label>전문기관 이름</label>
							            <input type="text" readonly="readonly" name="institutionName" value="<%=institutionName%>">
							        </div>
							        <div>
							            <label>전문기관 주소</label>
							            <input type="text" readonly="readonly" name="institutionAddress" value="<%=institutionAddress%>">
							        </div>
							        <div>
										<label>전문기관 사업자 등록번호</label>
							            <input type="text" readonly="readonly" name="license" value="<%=license%>">
							        </div>
							        <div>
							            <label>전문기관 연락처</label>
							            <input type="text" readonly="readonly" name="institytionTel" value="<%=institytionTel%>">
							        </div>
							        <%
									    }
									%>
									<button type="submit" class="btn">수정 완료</button>
							
								</form>
									</div>									
									
							<form action="/mypage/withdraw" method="post">
								<input type="hidden" name="memberNum"  value="<%=memberNum%>" >
								<button type="submit" class="btn" id="Withdrawal">회원 탈퇴</button>
							</form>		
								<%
									if (membertype == MemberType.EXPERT) {
								%>
								<p/>
								<button type="button" class="btn">전문기관 재등록 요청</a></button>
								<%
								    }
								%>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End ExpertEdit -->

<script type="text/javascript">
$(document).ready(function() {
	$('#Withdrawal').on('click', function(){
		if (!confirm("정말 탈퇴하시겠습니까?")) {
			 event.preventDefault();
		}
	});
 });
	
	function validateForms() {
	    // 정규식 패턴
	    var usernamePattern = /^[a-zA-Z][a-zA-Z0-9_]{4,14}$/;
	
	    // 입력 필드 값
	    var memberId = document.forms["editForm"]["memberId"].value;
	    var membersId = document.forms["editForm"]["memberId"].placeholder;
	    var memberAddress = document.forms["editForm"]["memberAddress"].value; 
	    var membersAddress = document.forms["editForm"]["memberAddress"].placeholder; 
	    var memberPhone = document.forms["editForm"]["memberPhone"].value; 
	    var membersPhone = document.forms["editForm"]["memberPhone"].placeholder;
		
	 	// 유효성 검사
	    if (memberId == null) {
	    	memberId = membersId;
	    } 
	 	if (!usernamePattern.test(memberId)) {
	        alert("아이디는 알파벳으로 시작하고 5자 이상 15자 이하이어야 하며, 알파벳, 숫자, 언더스코어(_)만 포함할 수 있습니다.");
	        return false;
	    }
	    
	    if (memberAddress == null) {
	    	memberAddress = membersAddress;
	    }
	    
	    if (memberPhone == null) {
	    	memberPhone = membersPhone;
	    }
	
	    return true; // 유효성 검사를 통과한 경우 폼을 제출합니다.
	}
	
</script>
<%@include file="../include/footer.jsp"%>
