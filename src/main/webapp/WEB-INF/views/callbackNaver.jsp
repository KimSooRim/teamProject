<%@page import="java.awt.geom.RectangularShape"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>naver</title>
</head>
<body>


	<script type="text/javascript"
		src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">
	</script>
	
	

	<section class="bg-light">
		<div class="container py-4">
			<div class="row align-items-center justify-content-between">
				<a class="navbar-brand h1 text-center" href="index.do"> </a>
			</div>
			<div>
				<h1 class="text-dark text-center">환영합니다</h1>
				<div class="form-floating mb-3">
				<input type="hidden" class="form-control" id="input_email"
					placeholder="name@example.com" value="${naver_id}"><label for="input_email">
					</label>
			</div>
			<div class="form-floating mb-3">
				<input type="hidden" class="form-control" id="input_password"
					placeholder="name@example.com" value="${naver_pw}"> <label for="input_password"></label>
			</div>
				<p class="text-center">
					<span id="name"></span>${name} 님의 회원가입 성공<br>이메일 주소는 ${email}<strong
						id="email"></strong>입니다.
				</p>
			</div>
			<div class="d-grid gap-2">
				<button id="naver_in" type="button" class="btn btn-primary" style="background: #B88FCC; border:1px solid #B88FCC"><b>시작</b></button>
			</div>
		</div>
	</section>
	
	<script>
	$('#naver_in').click(function(){

		let id = $('#input_email').val();
		let password = $('#input_password').val();

		$.ajax({
			url : "start",
			data : {
				id : id,
				password : password
			},
			method : "POST",
			success : function(data) {
				//console.log("성공");
				if(data=="로그인실패"){
					alert("아이디 또는 비밀번호를 확인하세요.");
				} else {
					location.replace("main");
				}
				
			},
			error : function(request, status, error) {
				alert("아이디 또는 비밀번호를 확인하세요.")
				console.log("에러");
			},
			complete : function() {
				console.log("완료");
			}
		});
	});
	</script>
</body>
</html>