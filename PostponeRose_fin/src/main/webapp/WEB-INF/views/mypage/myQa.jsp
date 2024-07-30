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
											<li><a href="#">약 검색 </a></li>
											<li><a href="../qa/list">QA 게시판 </a></li> <!-- 태기님 파트 -->
											<li><a href="#">공지사항 </a></li> <!-- 수연이 파트 -->
											<li class="active"><a href="../mypage/patientMypage">마이페이지 <i class="icofont-rounded-down"></i></a>
												<ul class="dropdown">
													<li><a href="../mypage/prescript">마이처방전</a></li>
													<li><a href="../mypage/myQa">QA문의 내역</a></li>
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
		response.sendRedirect("/mypage/myQa");
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
							<h2>MyQa 문의 내역 확인</h2>
							<img src="../resources/img/section-img.png" alt="#">
							<p/>
							
							<form id="searchForm" action="/mypage/myQa" method="get">
								<div class="col-lg-6">
									<div class="form-group">
									    <select id="searchType" class="form-control" name="type">
									   		<option value="all" ${qaPageMaker.cri.type == "all"? "selected":"" }>ALL</option>
									    </select>
									</div>
								</div>
							</form>
							<div>
								<table id="boardTable" border="1">
							        <thead>
							            <tr>
							                <th>No.</th>
							                <th>작성자</th>
							                <th>제목</th>
							                <th>내용</th>
							                <th>작성일</th>
							            </tr>
							        </thead>
									<tbody></tbody>
								</table>
								
								<div class="pageBtn">
									<ul class="pagination">
										<c:if test="${qaPageMaker.prev}">
											<li class="paginate_button previous">
												<a href="${qaPageMaker.startPage - 1 }">Previous</a>
											</li>
										</c:if>
										<c:forEach var="num" begin="${qaPageMaker.startPage }" end="${qaPageMaker.endPage }">
											<li class="paginate_button ${qaPageMaker.cri.pageNum == num? 'active':'' }">
												<a href="${num}">${num }</a>
											</li>
										</c:forEach>
										<c:if test="${qaPageMaker.next }">
											<li class="paginate_button next">
												<a href="${qaPageMaker.endPage + 1 }">Next</a>
											</li>
										</c:if>
									</ul>
								</div>
								<form id="pageForm" action="/mypage/myQa" method="get">
									<input type="hidden" name="pageNum" value="${qaPageMaker.cri.pageNum }">
									<input type="hidden" name="amount" value="${qaPageMaker.cri.amount }">
									<input type="hidden" name="type" value="${qaPageMaker.cri.type }">
									<input type="hidden" name="type" value="${qaPageMaker.cri.memberNum }">
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End ExpertEdit -->
		
<script type="text/javascript">
	$(document).ready(
			function() {
				loadTable();

				console.log("전체게시글 화면 이동");

				// loadTable() 시작
				function loadTable() {
					$.ajax({
						url : "/mypage/getMyQa",
						type : "post",
						data : {pageNum : $("#pageForm").find("input[name='pageNum']").val(),
								amount : $("#pageForm").find("input[name='amount']").val(),
								type : $("#searchType").val()},
						dataType : "json",
						success : function(data) {
							// data의 타입 Array
							var boardTbody = $("#boardTable tbody"); // 테이블 본문(tbody) 요소 저장
							boardTbody.empty(); // 테이블 본문을 비워서 기존 데이터 삭제

							// 서버에서 전달받은 Array를 반복적으로 화면에 출력
							$.each(data, function(index, qa) {
								console.log("qatest:::::"+index);
								var row = $("<tr>"); // 새로운 테이블의 행 요소 생성
								row.append($("<td>").text(qa.qa_id)); // 생성한 tr요소에 게시글 번호가 담긴 td요소 추가
								
								row.append($("<td>").text(qa.writer)); 
								
								// 게시글 제목을 누르면 상세보기로 이동해야하므로 링크(a태그)를 만들어서 url등록
								var qaTitleLink = $("<a>").attr("href",
										"/qa/get?qa_id=" + qa.qa_id +"&prescript_no="+qa.prescript_no+"&memberNum="+ qa.member_num).text(qa.title);
								var qaTitleTd = $("<td>").append(qaTitleLink); // a태그를 td태그에 추가
								row.append(qaTitleTd);
								
								var qaContextLink = $("<a>").attr("href",
										"/qa/get?qa_id=" + qa.qa_id +"&prescript_no="+qa.prescript_no+"&memberNum="+ qa.member_num).text(qa.context);
								var qaContextTd = $("<td>").append(qaContextLink); // a태그를 td태그에 추가
								row.append(qaContextTd);
								
								var parseDate = new Date(qa.created_at); // DB에 저장된 등록 날짜를 Date객체로 변환
								// numeric : (2024, 7), 2-digit: (24, 07)
								var options = {
									year : "numeric",
									month : "2-digit",
									day : "2-digit",
									hour : "2-digit",
									minute : "2-digit"
								};
								var formattedDate = parseDate.toLocaleString(
										"ko-KR", options); // 날짜 형식을 한국 시간 형식과 지정 옵션으로 반환
								
								var createdLink = $("<a>").attr("href",
										"/mypage/myqa?qa_id=" + qa.qa_id + "&memberNum=" + qa.member_num).text(formattedDate);
								var createdTd = $("<td>").append(createdLink);
								row.append(createdTd);
								
								boardTbody.append(row); // 생성한 tr요소를 테이블 본문에 추가 
							});
						},
						error : function(e) {
							console.log("실패");
							console.log(e);
						}
					});
					
					let pageForm = $("#pageForm");
					
					$(".paginate_button a").on("click", function(e) {
						// a태그의 기본 기능인 링크를 삭제
						e.preventDefault();
						// pageNum값을 사용자가 클릭한 a태그의 href의 속성값으로 변경
						pageForm.find("input[name='pageNum']").val($(this).attr("href"));
						pageForm.submit();
					});
				}
			});
</script>

<%@include file="../include/footer.jsp"%>