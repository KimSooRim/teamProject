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
<title>로그인 페이지</title>
</head>
<body>
	
	<%
		request.setCharacterEncoding("UTF-8");
		ArrayList<String> gulist = (ArrayList<String>) request.getAttribute("gulist");
	%>
	<div
		style="display: flex; justify-content: center; align-items: center; background: #FAFAFA;">
		<div
			style="background-color: white; border: 1px solid lightgray; border-radius: 10px; width: 30%; height: auto; margin: 10%; padding: 3%; text-align: center">
			<!-- 로고 -->
			<img id="logo" alt="no image" src="./images/logo.png" style="width: 100px; cursor: pointer;">
			<div style="color: gray; font-family: sans-serif; font-weight: bold;">신규
				회원가입하세요</div>
			<hr>

			<!-- 회원가입 정보 -->
			<div class="form-floating mb-3">
				<input type="id" class="form-control" id="input_id"
					placeholder="name@example.com"> <label for="input_id">아이디</label>
			</div>
			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="input_password"
					placeholder="name@example.com"> <label for="input_password">비밀번호</label>
			</div>
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="input_nickname"
					placeholder="name@example.com"> <label for="input_nickname">닉네임</label>
			</div>
			<div style="color: gray; font-family: sans-serif; font-weight: bold;">
				지역 설정</div>

			<div style="display: flex; justify-content: space-around;  margin: 10px 20px;">
				<div>
					<select id="gu_select" class="form-select"
						aria-label="Default select example">
						<!-- <option selected>구</option> -->
						<%
						for (String gu : gulist) {
						%>
						<option class="gu"><%=gu%></option>
						<%
						}
						%>
					</select>
				</div>
				<div>
					<select id="dong_select" class="form-select"
						aria-label="Default select example">
						<option selected>동</option>
					</select>
				</div>
			</div>

			<hr>
			<div id="caution"
				style="display: none; color: red; margin-bottom: 10px;"></div>
			<button id="sign_up" type="button" class="btn btn-primary" style="background: #B88FCC; border:1px solid #B88FCC">가입하기</button>

			<div style="margin-top: 10px;">
				계정이 있으신가요? <a href="loginPage" style="text-decoration: none; color:#73536F">로그인</a>
			</div>
		</div>

	</div>

	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
-->
</body>
<script>  
	$('#logo').click(function() {
		//console.log("콘솔");
		var form = $('<form></form>');
		form.attr("method", "post");
		form.attr("action", "main");
		form.appendTo('body');
		form.append($('<input type="hidden" value="clear" name=clear>'));
		form.submit();
	});
	$('#gu_select').change(function() {
		let gu = $(this).val();
		$('#dong_select').empty();
		/* console.log(gu); */
	$.ajax({
			url : "dongselect",
			data : {
				gu : gu
			},
			method : "POST",
			success : function(data) {
				//console.log("성공");
				let donglist = data.split(" ");
				donglist.pop();
				//console.log(donglist);
				for(dong of donglist){
					//console.log(dong);
					$('#dong_select').append(
						        $('<option>').prop({
						            innerHTML: dong
						        })
					    );
				}
			},
			error : function(data, status, error) {

				console.log("에러");
			},
			complete : function(data) {
				console.log("완료");
			}
		});
	});
	
	$('#sign_up').click(function() {

		let id = $('#input_id').val();
		let nickname = $('#input_nickname').val();
		let name = $('#input_name').val();
		let password = $('#input_password').val();
		let gu = $('#gu_select').val();
		let dong = $('#dong_select').val();
		let profile_image = "defaultprofile.jpg";

		$.ajax({
			url : "user_signup",
			data : {
				id : id,
				nickname : nickname,
				name : name,
				password : password,
				gu : gu,
				dong : dong,
				userprofile :profile_image
			},
			method : "POST",
			success : function(data) {
				console.log(data);
				if(data=="아이디중복"){
					$('#caution').html("아이디 중복입니다.")
					$('#caution').css("display", "block")
				}
				if(data=="닉네임중복"){
					$('#caution').html("닉네임 중복입니다.")
					$('#caution').css("display", "block")
				}
				if(data=="아이디중복닉네임중복"){
					$('#caution').html("아이디와 닉네임 중복입니다.")
					$('#caution').css("display", "block")
				}
				if(data=="회원가입완료"){
					alert("회원가입이 완료되었습니다.");
					location.replace("loginPage")
				}
				
			},
			error : function(data, status, error) {
				/* console.log(data.responseJSON.message);
				$('#caution').html(data.responseJSON.message)
				$('#caution').css("display", "block")
				console.log("에러"); */
			},
			complete : function(data) {
				console.log("완료");
			}
		});
	});
</script>
</html>