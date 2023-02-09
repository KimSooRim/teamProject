<%@page import="com.ojo.vo.PosttblVO"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script> -->
<script type="text/javascript" src="./js/detailPage.js" defer="defer"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=36a0fe67ad31dba87c833fa34314e92c&libraries=services"></script>
<!-- 카카오톡 공유하기 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>

<link rel="stylesheet" href="./css/detail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,1,200"
	rel="stylesheet" />
<style>
	.color .red    {background: #fa5a5a;}
	.color .yellow {background: #f0d264;}
	.color .green  {background: #82c8a0;}
	.color .cyan   {background: #7fccde;}
	.color .blue   {background: #6698cb;}
	.color .purple {background: #B88FCC;}

 	.btn-container{
		background-color: white;
  		border-radius: 4px;
  	 	text-align: center;
	  	/* margin-bottom: 40px;
   		padding-top: 30px; */
	  	font-weight: 300;
	  	/* border: 1px solid black; */
	  	position: absolute;
	}
	.btn, .btn-two {
	  margin: 9px;
	}
	
	.btn-two.small {
	  padding: 8px 18px;  
	  font-size: 14px;
	}
	
	a[class*="btn"] {text-decoration: none;}
	input[class*="btn"], 
	button[class*="btn"] {border: 0;}

	/* Colors for .btn and .btn-two */
	.btn.blue, .btn-two.blue     {background-color: #7fb1bf;}
	.btn.green, .btn-two.green   {background-color: #9abf7f;}
	.btn.red, .btn-two.red       {background-color: #fa5a5a;}
	.btn.purple, .btn-two.purple {background-color: #cb99c5;}
	.btn.cyan, .btn-two.cyan     {background-color: #7fccde;}
	.btn.yellow, .btn-two.yellow {background-color: #f0d264;}
	
	.rounded {
	 	border-radius: 5px;
	}

	/* default button style */
	.btn {
		position: relative;
		border: 0;
		padding: 15px 25px;
		display: inline-block;
		text-align: center;
		color: white;
	}
	.btn:active {
	  	top: 4px; 
	}

	/* color classes for .btn */
	.btn.blue {box-shadow: 0px 4px #74a3b0;}
	.btn.blue:active {box-shadow: 0 0 #74a3b0; background-color: #709CA8;}
	
	.btn.green {box-shadow: 0px 4px 0px #87a86f;}
	.btn.green:active {box-shadow: 0 0 #87a86f; background-color: #87a86f;}
	
	.btn.red {box-shadow:0px 4px 0px #E04342;}
	.btn.red:active {box-shadow: 0 0 #ff4c4b; background-color: #ff4c4b;}
	
	.btn.purple {box-shadow:0px 4px 0px #AD83A8;}
	.btn.purple:active {box-shadow: 0 0 #BA8CB5; background-color: #BA8CB5;}
	
	.btn.cyan {box-shadow:0px 4px 0px #73B9C9;}
	.btn.cyan:active {box-shadow: 0 0 #73B9C9; background-color: #70B4C4;}
	
	.btn.yellow {box-shadow:0px 4px 0px #D1B757;}
	.btn.yellow:active {box-shadow: 0 0 #ff4c4b; background-color: #D6BB59;}

	/* Button two - I have no creativity for names */
	.btn-two {
	  color: white; 
	  padding: 15px 25px;
	  display: inline-block;
	  border: 1px solid rgba(0,0,0,0.21);
	  border-bottom-color: rgba(0,0,0,0.34);
	  text-shadow:0 1px 0 rgba(0,0,0,0.15);
	  box-shadow: 0 1px 0 rgba(255,255,255,0.34) inset, 
	              0 2px 0 -1px rgba(0,0,0,0.13), 
	              0 3px 0 -1px rgba(0,0,0,0.08), 
	              0 3px 13px -1px rgba(0,0,0,0.21);
	}
	
	.btn-two:active {
	  top: 1px;
	  border-color: rgba(0,0,0,0.34) rgba(0,0,0,0.21) rgba(0,0,0,0.21);
	  box-shadow: 0 1px 0 rgba(255,255,255,0.89),0 1px rgba(0,0,0,0.05) inset;
	  position: relative;
	}

</style>


</head>
<body>
	
	<div id="wrap">
	<section>
	<!-- 상단 메뉴 -->
	<!-- <div class="menu">
		
	</div> -->
	<nav class="nav_navbar">

		<!-- 로고 -->
		<div>
			<img id="logo" alt="no image" src="./images/logo.png">
		</div>

		<!-- 검색창 -->
		<div></div>

		<!-- 아이콘 -->
		<div class="div_nav_icons">
		
			<%
			if (session.getAttribute("userid") != null) {
			%>
			<div>
				<span id="logout"><b>로그아웃</b></span> <span
					class="material-symbols-outlined">logout</span>
			</div>
			<div class="box" style="background: #BDBDBD; ">
				<%-- <img class="profile" src="./profileimage/<%=profileimg.trim()%>"> --%>
				<img class="profile" src="./profileimage/defaultprofile.jpg">	
			</div>
			<%
			} else {
			%>
			<div>
				<span id="login"><b>로그인/회원가입</b></span> 
				<span class="material-symbols-outlined">login</span>
			</div>
			<%
			}
			%>
		</div>
	</nav>
	
	<!-- <h2 style="text-align: center">상품 상세 이미지</h2> -->
	
	<!-- 상품 이미지 슬라이더 -->
	
	<div style="display: flex; justify-content: center; padding-top:150px;">
		<div class="container">
			<c:forEach var="images" items="${images}">
					<div class="mySlides">
						<%-- <div class="numbertext">/${images.size()}</div> --%>
						<img src="${pageContext.request.contextPath}/uploadImages/${images.filename}" style="width: 100%; height: 400px; object-fit: scale-down;">
						<%-- <img src="uploadImages/${image.filename}" style="width: 100%; height: 400px; "/> --%>
						<%-- <img src="<spring:url value='/uploadImage/${images.filename}'/>" style="width: 100%; height: 400px; "/> --%>
						<%-- <img src="<spring:url value='/uploadImage/${images.filename}'/>" style="width: 100%; height: 400px; object-fit: scale-down;"/> --%>
					</div>
			</c:forEach>
		<%-- </c:if> --%>

			<a class="prev" onclick="plusSlides(-1)" style=""><img alt="" src="./images/l_arrow.png" width="20"></a>
			<a class="next" onclick="plusSlides(1)" ><img alt="" src="./images/r_arrow.png" width="20"></a>
			
				<div class="caption-container">
					<p id="caption"></p>
				</div>
				<div class="row">
					<c:forEach var="image" items="${images}">
						<div class="column">
							<img class="demo cursor" 
								src="${pageContext.request.contextPath}/uploadImages/${image.filename}" 
								style="width: 100%; height: 66px;" onclick="currentSlide(1)">
							<%-- <img class="demo cursor" src="<spring:url value='/uploadImage/${image.filename}'/>" 
							style="width: 100%; height: 66px;" onclick="currentSlide(1)"> --%>
								
						</div>
					</c:forEach>
				</div>
		</div>

			<!-- 상품 상세 설명 -->
			<div class="product" style="position: relative;">
				<!-- <div class="caption-container">
					<p id="caption"></p>
				</div> -->
				<div style="font-size: 25px; font-weight: 600; margin-bottom:25px;">
					<c:choose>
						<c:when test="${vo.istrade == 1 }">
							<img src="./images/sold-out.png" width="40px"/>
						</c:when>
						<c:when test="${vo.istrade == 0 }">
							<img src="./images/deal.png" width="40px"/>
						</c:when>
					</c:choose>
					${vo.title}
					
				</div>
				<div style="font-size: 40px; font-weight: 500;">
					${vo.price} 원
				</div>
				<hr style="border: 1px solid lightgray;">
				<div style="font-size: 18px;margin-bottom:25px;font-weight: 500;">상품정보</div>
				<div style="display: flex; ">
					<div style="flex: 1; width: 40%;">
						<c:set var="postcontent" value="${fn:replace(vo.postcontent, '<', '&lt;')}"/>
						<c:set var="postcontent" value="${fn:replace(postcontent, '>', '&gt;')}"/>
						<c:set var="postcontent" value="${fn:replace(postcontent, enter, '<br/>')}"/>
						<p style="white-space: pre-line;">${postcontent}</p>
					</div>
					<div id="map" style="width:400px;height:200px; flex: 1;"></div>
				</div>
				
		<!-- 		<div style="background: #ffc107; width:180px;height: 50px; border: 1px solid #ffc107; border-radius: 7px; 
				display: flex; justify-content: center; align-items: center; position: absolute; bottom:20px;
				color:white; font-size:18px; font-weight: 600;
				">
				<span class="material-symbols-outlined" style="font-size:18px; margin-right: 10px;">mode_comment</span>
					채팅하기
				</div>
				<div style="background: #B88FCC; width:160px;height: 50px; border: 1px solid #B88FCC; border-radius: 7px; 
				display: flex; justify-content: center; align-items: center; position: absolute; bottom:20px; left:230px;
				color:white; font-size:18px; font-weight: 600;
				">
				<span class="material-symbols-outlined" style="font-size:18px; margin-right: 10px;">heart_plus</span>
				
					찜 하기
					
				</div> -->
				
					
			
				<div style="display: inline-block; width: 500px; height: 75px; position: absolute; left: 8%; bottom: 0px ">
					<%-- <c:if test="${not empty userid}">
						<div style= "align-items: center;  bottom:20px; position: absolute;">
							<input type="button" class="button" name="update" value="수정하기" onclick="location.href='updateProduct?postnum=${postnum}'">
						</div>				
					</c:if> --%>
				
				
					<div class="btn-container" style="  left: 0%; font-weight: bold;">
		    			<a href="#" class="btn-two small purple rounded">채팅하기</a>
		    		</div>
		    		
		    		<div class="btn-container" style=" left: 42%; font-weight: bold;">
		    			<a href="#" class="btn-two small purple rounded">찜하기</a>
		    		</div>
		    		<c:if test="${userid eq vo.userid}">
			    		<div class="btn-container" style=" right: 0%; font-weight: bold;">
			    			<a href="#" class="btn-two small purple rounded" onclick="location.href='updateProduct?postnum=${postnum}'">수정하기</a>
			    		</div>
			    	</c:if>
	    		</div>
	    	
			<%-- <c:choose>
				<c:when test="${not empty userid}">
					<div style= "display: flex; justify-content: center; 
						align-items: center; position: absolute; bottom:20px; left:400px;">
						<input type="button" name="update" value="수정하기" onclick="location.href='updateProduct?postnum=${postnum}'">
					</div>				
				</c:when>
			</c:choose>  --%>
				
			</div>
		</div>
		<br/>
		<div style="display: block; width: 1200px; margin-left: auto; margin-right: auto;">
			<a id="kakaotalk-sharing-btn" href="javascript:;">
			<img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
			    alt="카카오톡 공유 보내기 버튼" width="50px" align="right" />
			</a>
		</div>
	</section>
	<footer
			style="display: flex; flex-direction: row; justify-content: flex-start; left: 10%; width: 80%;">
			<nav>
				<a>팀원소개</a>
			</nav>
			<p>
				<span>김준형</span><br> <span>이진호</span><br> <span>박주희</span><br>
				<span>김수림</span><br>
			</p>
			<nav>
				<a>중고거래 주의사항</a>
			</nav>
			<p style="text-align: left;">
				<span>1. 메신저 대화 중 외부링크를 받으면 대화를 즉시 중단하라</span><br> <span>2.
					판매자가 메신저에서 수수료를 핑계로 재송금 요구하면 거래 중단 후 즉시 신고하라</span><br> <span>3.
					오픈 메신저로 하는 무료 나눔상품과 시세보다 현저히 저렴한 상품은 주의하라</span>
			</p>
		</footer>
	</div>
	
</body>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
	    level: 4, // 지도의 확대 레벨
	    mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
	}; 
	
	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 장소 검색 객체를 생성합니다
	
	var inputData = ['${vo.subway}']
	console.log(inputData);
	var ps = new kakao.maps.services.Places(); 
	
	// 키워드로 장소를 검색합니다
	if(inputData == null){
		inputData ==['서울시청'];
	}	
	ps.keywordSearch(inputData, placesSearchCB); 

	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();
	        
	            displayMarker(data[0]);
	        	console.log(data[0]);
	            bounds.extend(new kakao.maps.LatLng(data[0].y, data[0].x));

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}
	

	let url = 'https://ifh.cc/g/3A6hZ9.png';
	let price = ${vo.price};
	
	Kakao.init('8b88d8b1eb5ba4fdbf11c745db25ac71'); // 사용하려는 앱의 JavaScript 키 입력
	Kakao.isInitialized();
	
	Kakao.Share.createDefaultButton({
		container: '#kakaotalk-sharing-btn',
		  objectType: 'commerce',
		  content: {
		    title: '세상 모든 것들이 새롭게 만나는 곳.',
		    imageUrl: url,
		    link: {
		      mobileWebUrl: 'http://localhost:9000',
		      webUrl: 'http://localhost:9000',
		    },
		  },
		  commerce: {
		    productName: '${vo.title}',
			regularPrice: price,
		    /*discountRate: 10,
		    discountPrice: 90000,  */
		  },
		  buttons: [
		    {
		      title: '자세히보기',
		      link: {
		        mobileWebUrl: 'http://localhost:9000',
		        webUrl: 'http://localhost:9000',
		      },
		    },
		    {
		      title: '공유하기',
		      link: {
		        mobileWebUrl: 'https://developers.kakao.com',
		        webUrl: 'https://developers.kakao.com',
		      },
		    },
		  ],
		});

	
	
	function displayMarker(place) {
		// 지도에 마커를 생성하고 표시한다
		var marker = new kakao.maps.Marker({
			map: map, // 마커를 표시할 지도 객체
			position: new kakao.maps.LatLng(place.y, place.x) // 마커의 좌표
		});
		
	}
	

	$('#logo').click(function() {
		//console.log("콘솔");
		var form = $('<form></form>');
		form.attr("method", "post");
		form.attr("action", "main");
		form.appendTo('body');
		form.append($('<input type="hidden" value="clear" name=clear>'));
		form.submit();
	});
	$('.profile').click(function() {
		location.href = "MYpage";
	});
	
	$('#logout').click(function() {
		//console.log("콘솔");
		var form = $('<form></form>');
		form.attr("method", "post");
		form.attr("action", "main");
		form.appendTo('body');
		form.append($('<input type="hidden" value="remove" name=remove>'));
		form.submit();
	});
	
	$('#login').click(function() {
		location.href = "loginPage";
	});
</script>
</html>