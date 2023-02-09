<%@page import="com.ojo.vo.UsertblVO"%>
<%@page import="com.ojo.vo.ChattblVO"%>
<%@page import="com.ojo.vo.PosttblVO"%>
<%@page import="com.ojo.vo.RoomtblVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main Page</title>

<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- BootStrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Google Icon -->
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,1,200"
	rel="stylesheet" />
<!-- SockJS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>

<link href="./css/mainPage.css" rel="stylesheet">

</head>

<%
	ArrayList<String> categorylist = (ArrayList<String>) request.getAttribute("categorylist");
	ArrayList<String> gulist = (ArrayList<String>) request.getAttribute("gulist");
	ArrayList<PosttblVO> postlist = (ArrayList<PosttblVO>) request.getAttribute("postlist");
	ArrayList<String> postimages = (ArrayList<String>) request.getAttribute("postimages");
	ArrayList<RoomtblVO> sell_room_list = (ArrayList<RoomtblVO>) request.getAttribute("sell_room_list");
	ArrayList<RoomtblVO> purchase_room_list = (ArrayList<RoomtblVO>) request.getAttribute("purchase_room_list");
	UsertblVO user = (UsertblVO) request.getAttribute("user");
	//out.print(user);
	//out.print(sell_room_list);
	//out.print("<br>");
	//out.print(purchase_room_list);
	// out.print(postlist);
	// out.print("<br>");
	// out.print(postimages);

	String search = (String) session.getAttribute("session_search");
	if (session.getAttribute("session_search") == null) {
		search = "";
	}

	response.setContentType("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<body>
	<!-- 네비바 -->

	<%
		String gu_name = (String) session.getAttribute("session_gu");
	%>
	<nav class="nav_navbar"">

		<!-- 로고 -->
		<div
			style="display: flex; justify-content: center; align-items: center;">
			<img id="logo" alt="no image" src="./images/logo.png">
			<div class="dropdown" style="margin-left: 15px;">
				<%
					if (session.getAttribute("session_gu") != null) {
				%>
				<button class="btn btn-secondary dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false"
					style="width: 130px; font-size: 20px;">
					<%=gu_name%>
				</button>
				<%
					} else {
				%>
				<button class="btn btn-secondary dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">구 선택</button>
				<%
					}
				%>
				<ul class="dropdown-menu">
					<%
						for (String gu : gulist) {
					%>
					<li class="div_gu_item dropdown-item"
						style="width: 100%; font-size: 18px;"><%=gu%></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>

		<!-- 검색창 -->
		<div>
			<form action="main" method="post">
				<input id="input_search_post" type="text" name="search"
					value="<%=search%>" />
			</form>
		</div>

		<!-- 아이콘 -->
		<div class="div_nav_icons">

			<%
				if (session.getAttribute("userid") != null) {
					/* String profileimg = request.getParameter("userprofile"); */
			%>
			<div>
				<span id="logout"><b>로그아웃</b></span> <span
					class="material-symbols-outlined">logout</span>
			</div>
			<div class="box" style="background: #BDBDBD;">
				<img class="profile" src="profileimage/${userprofile}">
				<!-- <img class="profile"
					src="./profileimage/defaultprofile.jpg"> -->
			</div>
			<%
				} else {
			%>
			<div>
				<span class="login"><b>로그인/회원가입</b></span> <span
					class="material-symbols-outlined">login</span>
			</div>
			<%
				}
			%>
		</div>


	</nav>

	<!-- body -->
	<div class="div_body">
		<!-- 뒷 배경 -->
		<div class="div_bg">
			<img class="" alt="no image"
				src="https://static.wixstatic.com/media/fc7570_cfaf1cf72d3948d0b8c28290ba288269~mv2_d_3521_1344_s_2.jpg/v1/fill/w_1241,h_474,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/fc7570_cfaf1cf72d3948d0b8c28290ba288269~mv2_d_3521_1344_s_2.jpg">
		</div>

		<div class="div_name">세상의 사람과 물건이 새롭게 만나는 곳</div>

		<div class="div_main">
			<!-- 카테고리 -->
			<div class="div_category">
				<!-- 상품 카테고리 -->

				<%
					for (String category : categorylist) {
				%>
				<div class="div_category_item"><%=category%></div>
				<%
					}
				%>

			</div>
			<div class="div_items">
				<!-- 상품 -->

				<%
					//for (PosttblVO vo : postlist) {
					for (int index = 0; index < postlist.size(); index++) {
						PosttblVO vo = postlist.get(index);
				%>
				<div class="item" postnum="<%=vo.getPostnum()%>">
					<!-- 상품 이미지 -->

					<img alt="no_image" src="uploadImages/<%=postimages.get(index)%>">
					
					<div style="width: 90%">
						<div style="font-size: 18px;"><%=vo.getTitle()%></div>
						<div style="color: gray; font-size: 13px;">
							<span><%=vo.getPostgu()%></span> <span><%=vo.getPostdong()%></span>
						</div>
						<div style="font-size: 18px;">
							<%=vo.getPrice()%>
						</div>
					</div>
				</div>
				<%
					}
				%>

			</div>
		</div>
	</div>
	<%
		if (session.getAttribute("userid") != null) {
	%>
	<div id="productupload"
		style="cursor: pointer; width: 70px; height: 70px; display: flex; justify-content: center; align-items: center; position: fixed; right: 10%; bottom: 5%; font-size: 30px; font-weight: 1000; color: white; background: orange; border-radius: 50%;">
		<span class="material-symbols-outlined" style="font-size: 50px;">add_box</span>
	</div>
	<div id="chat"
		style="cursor: pointer; width: 70px; height: 70px; display: flex; justify-content: center; align-items: center; position: fixed; right: 5%; bottom: 5%; font-size: 30px; font-weight: 1000; color: white; background: green; border-radius: 50%;">
		<span class="material-symbols-outlined" style="font-size: 50px;">sms</span>
	</div>
	<!-- 채팅 -->
	<div id="chatlist"
		style="width: 13%; height: 700px; display: none; flex-direction: column; position: fixed; right: 2%; top: 20%;; color: white; border-radius: 15px; background: skyblue; z-index: 2; overflow: auto; padding: 10px 0px;">

		<div
			style="display: flex; justify-content: center; height: 30px; border-bottom: 1px solid white;">
			<div id="sell"
				style="border-right: 1px solid white; width: 40%; text-align: center;">판매</div>
			<div id="purchase" style="width: 40%; text-align: center;">구매</div>
		</div>

		<div id="sell_chat"
			style="height: 80%; display: flex; flex-direction: column; padding: 10px;">
			<%
				for (RoomtblVO vo : sell_room_list) {
			%>
			<div class="btn-modal" room=<%=vo.getRoom()%>
				style="height: 60px; border-bottom: 1px solid white; display: flex; align-items: center;">
				<%=vo.getPurchaser_nick()%>
			</div>
			<%
				}
			%>
		</div>
		<div id="purchase_chat"
			style="height: 80%; display: none; flex-direction: column; padding: 10px;">
			<%
				for (RoomtblVO vo : purchase_room_list) {
			%>
			<div class="btn-modal" room=<%=vo.getRoom()%>
				style="height: 60px; border-bottom: 1px solid white; display: flex; align-items: center;">
				<%=vo.getPurchaser_nick()%>
			</div>
			<%
				}
			%>
		</div>

	</div>
	<%
		} else {
	%>
	<div class="login"
		style="cursor: pointer; width: 70px; height: 70px; display: flex; justify-content: center; align-items: center; position: fixed; right: 10%; bottom: 10%; font-size: 30px; font-weight: 1000; color: white; background: orange; border-radius: 50%;">
		<span class="material-symbols-outlined" style="font-size: 50px;">login</span>
	</div>
	<%
		}
	%>
	<!-- 채팅 모달창 -->
	<div id="modal" style="display: none;">
		<div class="modal-window" style="background: floralwhite;">
			<div class="title" style="display: flex; justify-content: space-between;">
				<div style="display: flex; align-items: center;">
					<span id="user_state" class="material-symbols-outlined" style="color:orange;">fiber_manual_record</span>
					<div id="conn_info"></div>
				</div>
				<div id="room_name"></div>
				<div class="close-area">X</div>
			</div>
			<div id="divChatData" style="height: 60%; overflow: auto;">
				<ul id="chatting_room">
         		  
       			</ul>
			</div>
			<div>
				<textarea id="message"
					style="width: 100%; height: 100px; resize: none; border-radius: 5px; margin: 10px 0px;"></textarea>
			</div>
			<div id='send'
				style="background: yellow; cursor:pointer; float: right; padding: 6px 10px; border-radius: 10px; font-weight: bold;">전송</div>
		</div>
	</div>
</body>
<script type="text/javascript">


/* websocket */
// 현재 사용자 닉네임 가져오기
<%String nick = "";
if (user != null) {
	nick = user.getNickname();%>
	let nick="<%=nick%>"
<%}%>
var webSocket = {
		init: function(param) {
			//console.log*(param.url);
			this._url = param.url;
			this._initSocket();
		},
		sendChat: function(room, nickname) {
			this._sendMessage(room, 'CMD_MSG_SEND', $('#message').val(), nickname);
		},
		sendEnter: function(room, nickname) {
			this._sendMessage(room, 'CMD_ENTER', "입장", nickname);
		},
		sendEnterResponse: function(room, nickname) {
			this._sendMessage(room, 'CMD_ENTER_RESPONSE', "입장", nickname);
		},
		sendOut: function(room, nickname) {
			this._sendMessage(room, 'CMD_OUT', "입장", nickname);
		},
		receiveMessage: function(msgData) {
			// 정의된 CMD 코드에 따라서 분기 처리
			if(msgData.cmd == 'CMD_MSG_SEND') {		
				//$('#divChatData').append('<div>' + msgData.msg + '</div>');
				var li_tag = document.createElement("li");
				if(msgData.nickname == nick){
					li_tag.setAttribute("class", "right");
				} else {
					li_tag.setAttribute("class", "left");
				}
				var div_sender = document.createElement("div");
				div_sender.setAttribute("class", "sender");
				div_sender.innerHTML = "<span>"+msgData.nickname+"</span>";
				li_tag.appendChild(div_sender);
				
				var div_message = document.createElement("div");
				div_message.setAttribute("class", "message");
				div_message.innerHTML = "<span>"+msgData.msg+"</span>";
				li_tag.appendChild(div_message);
						
				chatting_room.appendChild(li_tag);
				/* scroll bar */
				var scroll_div = document.getElementById("divChatData");
			    scroll_div.scrollTop = scroll_div.scrollHeight;
			}
			// 입장
			else if(msgData.cmd == 'CMD_ENTER') {
				if(msgData.nickname != nick){
					//console.log("온라인");
					this.sendEnterResponse($('#message').attr('room'),"");
					$('#user_state').css('color','lime');
					$('#conn_info').text("두 분 다 채팅에 참여중입니다");
				}
				//$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
			else if(msgData.cmd == 'CMD_ENTER_RESPONSE') {
				if(msgData.nickname != nick){
					//console.log("온라인");
					$('#user_state').css('color','lime');
					$('#conn_info').text("두 분 다 채팅에 참여중입니다");
				}
				//$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
			else if(msgData.cmd == 'CMD_OUT') {
				//console.log(msgData);
				$('#user_state').css('color','orange');
				$('#conn_info').text("오프라인");
			}
			// 퇴장
			else if(msgData.cmd == 'CMD_EXIT') {		
				if(($('#message').attr('room')==msgData.bang_id)){
					$('#user_state').css('color','orange');
					$('#conn_info').text("오프라인");
				}
				//$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
		},
		closeMessage: function(str) {
			$('#divChatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
		},
		disconnect: function() {
			this._socket.close();
		},
		_initSocket: function() {
			this._socket = new SockJS(this._url);
			this._socket.onopen = function(evt) {
				//console.log(evt.data);				
				//webSocket.receiveMessage(JSON.parse(evt.data));
			};
			this._socket.onmessage = function(evt) {
				webSocket.receiveMessage(JSON.parse(evt.data));
			};
			this._socket.onclose = function(evt) {
				//console.log(evt.data);
				//webSocket.closeMessage(JSON.parse(evt.data));
			}
		},
		_sendMessage: function(bang_id, cmd, msg, nickname) {
			var msgData = {
					bang_id : bang_id,
					cmd : cmd,
					msg : msg,
					nickname : nickname
			};
			
			var jsonData = JSON.stringify(msgData);
			this._socket.send(jsonData);
		}
	};
	
	$(window).on('load', function () {
		webSocket.init({ url: '<c:url value="/chat" />' });
	});
	
	$('#send').click(function() {
		webSocket.sendChat($("#message").attr('room'),nick);
		let data = {
	    		'room' : $("#message").attr('room'),
	    		'nickname' : nick,
	    		'msg' : $("#message").val()
	    	}
		$.ajax({
	    	type: "POST", //요청 메소드 방식
	    	url:"insert_chat",
	    	data: JSON.stringify(data),
	    	contentType : 'application/json; charset=UTF-8',
	      	dataType : 'json',
	    	success : function(){
			},
	    	error : function(){
	    	}
	    });
		$("#message").val("");
	});

	$('#message').keydown(function(e) {
		if(e.keyCode == 13){
			e.preventDefault();
			webSocket.sendChat($(this).attr('room'),nick);
			let data = {
		    		'room' : $(this).attr('room'),
		    		'nickname' : nick,
		    		'msg' : $(this).val()
		    	}
			$.ajax({
		    	type: "POST", //요청 메소드 방식
		    	url:"insert_chat",
		    	data: JSON.stringify(data),
		    	contentType : 'application/json; charset=UTF-8',
		      	dataType : 'json',
		    	success : function(){
				},
		    	error : function(){
		    	}
		    });
			$(this).val("");
			console.log($(this).val());
		  }
		});
	
	$('.btn-modal').click(function(){
		$('#user_state').css('color','orange');
		$('#conn_info').text("오프라인");
		webSocket.sendOut($('#message').attr('room'),"");
		$('#modal').css('display','block')
		let room = $(this).attr('room')
		$.ajax({
	    	type: "POST",
	    	url:"loadChatting",
	    	data: {'room':room},
	    	
	    	success : function(result){
	    		let chatlist = JSON.parse(result);
	    		/* 이전 대화기록 가져오기 */
	    		let chatting_room = document.getElementById("chatting_room");
				for(chat of chatlist){
					var li_tag = document.createElement("li");
					if(chat.send_nick == nick){
						li_tag.setAttribute("class", "right");
					} else {
						li_tag.setAttribute("class", "left");
					}
					var div_sender = document.createElement("div");
					div_sender.setAttribute("class", "sender");
					div_sender.innerHTML = "<span>"+chat.send_nick+"</span>";
					li_tag.appendChild(div_sender);
					
					var div_message = document.createElement("div");
					div_message.setAttribute("class", "message");
					div_message.innerHTML = "<span>"+chat.content+"</span>";
					li_tag.appendChild(div_message);
					
					chatting_room.appendChild(li_tag);
					//$('#divChatData').append('<div>' + chat.send_nick + " : " + chat.content + '</div>');	
				}
				
				
	    		/* scroll bar 갱신 */
	    		var scroll_div = document.getElementById("divChatData");
	    		scroll_div.scrollTop = scroll_div.scrollHeight;
			},
	    	error : function(a, b, c){
	    		console.log('에러');
	    	}
	    });
		
		/* 채팅방 이름설정 */
		//$('#room_name').text($(this).text().trim());
		$('#message').attr("room",room);
	
		webSocket.sendEnter(room, nick);
	});
		
	const closeBtn = modal.querySelector(".close-area")
		closeBtn.addEventListener("click", e => {
			webSocket.sendOut($('#message').attr('room'),"");$
			modal.style.display = "none"
		})

	
	$('#sell').click(function() {
		$('#purchase_chat').css('display', 'none');
		$('#sell_chat').css('display', 'flex');
	});
	$('#purchase').click(function() {
		$('#sell_chat').css('display', 'none');
		$('#purchase_chat').css('display', 'flex');
	});

	$('#chat').click(function() {
		if ($('#chatlist').css('display') == 'flex') {
			$('#chatlist').css('display', 'none');
		} else if ($('#chatlist').css('display') == 'none') {
			$('#chatlist').css('display', 'flex');
		}
		
		webSocket.init({ url: '<c:url value="/chat" />' });

	});
	/* 메인페이지 */
	$('.item').click(function() {
			let postnum = $(this).attr('postnum');
			//console.log(postnum)
			var form = $('<form></form>');
			form.attr("method", "post");
			form.attr("action", "detailPageOk");
			form.appendTo('body');
			form.append($('<input type="hidden" value="' + postnum + '" name=postnum>'));
			form.submit();
		});
	$('#productupload').click(function() {
		location.href = "productUpload";
	});
	$('.profile').click(function() {
		location.href = "MYpage";
	});
	$('.div_category_item').click(function(e) {
		let category = $(this).text();
		//console.log(category);
		$(this).css("color", "gray");
		console.log(category);
		var form = $('<form></form>');
		form.attr("method", "post");
		form.attr("action", "main");
		form.appendTo('body');
		form.append($('<input type="hidden" value="' + category + '" name=category>'));
		form.submit();
			});
	//let subToggle=true;
	$('.div_gu_item').click(function(e) {
		let gu = $(this).text();
		$(this).css("color", "white");
		console.log(gu);
		var form = $('<form></form>');

		form.attr("method", "post");
		form.attr("action", "main");
		form.appendTo('body');
		form.append($('<input type="hidden" value="' + gu + '" name=gu>'));
		form.submit();
	});
	//$('#input_search_post')
	$('#logo').click(function() {
		//console.log("콘솔");
		var form = $('<form></form>');
		form.attr("method", "post");
		form.attr("action", "main");
		form.appendTo('body');
		
		form.append($('<input type="hidden" value="clear" name=clear>'));
		form.submit();
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

	$('.login').click(function() {
		location.href = "loginPage";
	});
</script>
</html>