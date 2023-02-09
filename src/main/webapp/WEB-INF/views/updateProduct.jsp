<%@page import="com.ojo.vo.AddressVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 업로드</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" 	src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="./js/productUpload.js" defer="defer"></script>
<link rel="stylesheet" href="./css/productUpload.css">
</head>

<body >
<div id="wrap">
	<section>
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
	
		<div>
			<%=request.getAttribute("images") %>
			<!-- <form action="prodcutUploadOk" method="post" enctype="multipart/form-data" name="upload" onSubmit="return checkForm()"> -->
			<form action="updateProductOk" id="update" method="post" class="row g-3 needs-validation" novalidate enctype="multipart/form-data" name="upload" >
			
				<table class="table border-3 border-secondary rounded-3" border="1" cellpadding="3" cellspacing="0" width="500px">
					<tr>
						<td align="center" width="80px">제목</td>
						<td colspan="3">
								<input type="text" class="form-control form-control-sm"  name="title" style="width: 98%" required value="${vo.title}" />
						
						
						</td>
					</tr>
					<tr>
						<td align="center">주소</td>
						<td align="center" width="250px">
							<div style="display: inline-block;">
								<select id="postgu" class="form-select form-select-sm" name="postgu" style="width: 110px; height: 30px;" required>
									<option value="">선택</option>
		
								<c:forEach var="gu" items="${guList}">
									<option value="${gu.gu}" <c:if test ="${vo.postgu eq gu.gu}">selected="selected"</c:if>>${gu.gu}</option>
								</c:forEach>
		
								</select> 
							</div>
							<div style="display: inline-block;">
								<select id="postdong" class="form-select form-select-sm" name="postdong" style="width: 110px; height: 30px;" required="required">
									<option value="">선택</option>
									<option selected="selected">${vo.postdong}</option>
								</select>
							</div>
						</td>
						<td align="center"  width="80px" >카테고리</td>
						<td align="center" width="120">
							<select name="category" class="form-select form-select-sm" style="width: 95%"  required>
									<option selected disabled value="">선택</option>
									<option value="가전제품" <c:if test ="${vo.category eq '가전제품' }"> selected </c:if>>가전제품</option>
									<option value="생활용품" <c:if test ="${vo.category eq '생활용품' }">selected="selected"</c:if>>생활용품</option>
									<option value="식품" <c:if test ="${vo.category eq '식품' }">selected</c:if>>식품</option>
									<option value="의류" <c:if test ="${vo.category eq '의류' }">selected</c:if>>의류</option>
									<option value="기타" <c:if test ="${vo.category eq '기타' }">selected</c:if>>기타</option>
		
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">가격</td>
						<td align="center">
							<input class="form-control form-control-sm" type="text" name="price"  required value="${vo.price}"/>
							
						</td>
						<td align="center">거래완료</td>
						<td>
							<c:choose>
								<c:when test="${vo.istrade == 1}">
									<input class="form-check-input" type="checkbox" value="1" name="is_trade" checked="checked">
								</c:when>
								<c:when test="${vo.istrade == 0}">
									<input class="form-check-input" type="checkbox" value="1" name="is_trade">
								</c:when>
							
							</c:choose>
						</td>
					</tr>
					<tr>
						<td colspan="4">상세설명</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
						<p>
							<textarea id="content" class="form-control form-control-sm" rows="10" name="postcontent" 
										style="width: 98%; resize: none;" required >${vo.postcontent}</textarea>
						</p>
						<div style="text-align: left; padding-left: 5px;">
							<input type="text" id="place" class="form-control form-control-sm" 
								name="subway" value="${vo.subway}" style="width: 50%; ">
						</div>
						</td>
					</tr>
					<tr>
						<td align="center" valign="middle">첨부파일</td>
						<td colspan="3" valign="middle" >
							<div style="width: 500px; vertical-align: middle; position: relative;">
								<input type="file" id="fileSelect" class="btn btn-sm" name="uploadFile" multiple="multiple" accept="image/*" style="visibility: hidden;" required/>
								<label for="fileSelect" >
									<div style="position: absolute; top:0; left: 0;">
											<div class="btn text-white btn-sm" style="background-color: #B88FCC;">파일선택</div>
									</div>
										<div id="filedrag"  contenteditable="true" placeholder="버튼을 클릭하거나 파일을 드래그앤드롭 하세요" >
											<c:forEach var="realname" items="${io}">
												<div id="thumb" style="display: inline-block; width: 100px; margin: 5px; z-index:1;">
													<img src="${pageContext.request.contextPath}/uploadImages/${realname.filename}" 
													style="width: 100%; height: 50px; object-fit: scale-down; z-index:none; border: 1px solid #A4A4A4;"><br/> 
													<input type="button" id="del" class="btn btn-light" value="x" name="delete"
															style="width:18px;height:18px; 
																	font-weight:bold;
															 		--bs-btn-padding-y: 
															 		.0; --bs-btn-padding-x: 
															 		.0; --bs-btn-font-size: 
															 		.3rem;&quot;">
													<input type="hidden" name="image${realname.imageNum}" value="${realname.imageNum }">
												</div>
											</c:forEach>
									</div>
								</label>
							</div>
						</td>
					</tr>
						<td colspan="4" align="center">
							<input type="button" class="btn text-white btn-sm" value="수정하기" 
								style="background-color: #B88FCC;" onclick="document.getElementById('update').submit();"  /> 
							<input type="reset" class="btn text-white btn-sm" value="다시쓰기" style="background-color: #B88FCC;"/> 
							<input type="button" class="btn text-white btn-sm" value="돌아가기" onclick="history.back()" style="background-color: #B88FCC;"/></td>
					</tr>
	
				</table>
				
				<input type="hidden" name="userid" value="${userid}"></br>
				<input type="hidden" name="postnum" value="${vo.postnum}"></br>
				
			</form>
			
		</div>
	</section>
</div>
<footer
	style=" border:1px solid black; display: flex; flex-direction: row; justify-content: flex-start; left: 10%; width: 80%;">
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


</body>

<script>
	$(document).ready(function() {
	    $('input[name="delete"]').on("click", function(e) {
	        e.preventDefault();
	        e.stopPropagation();
	        deleteFile($(this));
	    });
	})
	
	 function deleteFile(obj) {
        obj.parent().remove();
    }
	
	
	/* 부트스트랩 유효성 검사 */
	(() => {
		  'use strict'
	
		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  let forms = document.querySelectorAll('.needs-validation')
	
		  // Loop over them and prevent submission
		  Array.from(forms).forEach(form => {
		    form.addEventListener('submit', event => {
		      if (!form.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		      }
	
		      form.classList.add('was-validated')
		    }, false)
		  })
		})()
	
		
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
	
	$('.profile').click(function() {
		location.href = "MYpage";
	});
	
	/* 이미지 업로드 */
	
	(
		imageView = function imageView(filedrag, fileSelect){
			let file_drag = document.getElementById(filedrag);
			let file_select = document.getElementById(fileSelect);
			let selFiles = [];
			
			let divStyle = 'display: inline-block; width: 100px; margin: 5px; z-index:1;';
			let imgStyle = 'width: 100%; height: 50px; object-fit: scale-down; z-index:none; border: 1px solid #A4A4A4;';
			let chkStyle = 'width:18px;height:18px; font-weight:bold; --bs-btn-padding-y: .0; --bs-btn-padding-x: .0; --bs-btn-font-size: .3rem;"';
			
			/* 폼에서 전달된 이미지 추가 */
			file_select.onchange = function(e){
				let files = e.target.files;
				let fileArr = Array.prototype.slice.call(files);
				console.log(fileArr);
				for(let f of fileArr){
					imageLoader(f);
				}
			}
	
		/* 드래그 & 드랍으로 전달된 이미지 추가 */
		file_drag.addEventListener('dragenter', function(e){
			e.preventDefault();
			e.stopPropagation();
		}, false)
		
		file_drag.addEventListener('dragover', function(e){
			e.preventDefault();
			e.stopPropagation();
		}, false)
		
		file_drag.addEventListener('drop', function(e){
			let files = {};
			e.preventDefault();
			e.stopPropagation();
			let dt = e.dataTransfer;
			files = dt.files;
			$("input[type='file']").prop("files", e.dataTransfer.files)
			// console.log(files);
			for(let f of files){
				imageLoader(f);
				console.log(f);
			}
		}, false)
		
		/* 이미지 썸네일 보기 */
		imageLoader = function(file) {
			selFiles.push(file);
			console.log(file);
			let reader = new FileReader();
			reader.onload = function(ee){
				let img = document.createElement('img')
				img.setAttribute('style', imgStyle);
				img.src = ee.target.result;
				file_drag.appendChild(makeDiv(img, file));
			}
			reader.readAsDataURL(file);
		}
		
		
		makeDiv = function (img, file) {
			let div = document.createElement('div');
			div.setAttribute('style', divStyle);
			let btn = document.createElement('input');
			btn.setAttribute('type', 'button');
			btn.setAttribute('class', 'btn btn-light')
			btn.setAttribute('value', 'x');
			btn.setAttribute('delFile', file.name);
			btn.setAttribute('style', chkStyle);
			
			/* 이미지 삭제 */
			btn.onclick = function (ev) {
				let ele = ev.srcElement;
				let delFile = ele.getAttribute('delFile');
				for(let i = 0; i<selFiles.length; i++){
					if(delFile == selFiles[i].name){
						selFiles.splice(i, 1);
					}
				}
				
				
				dt = new DataTransfer();
				for(f in selFiles){
					let file = selFiles[f];
					dt.items.add(file);
				}
				file_select.files = dt.files;
				let p = ele.parentNode;
				file_drag.removeChild(p);
			}
			div.appendChild(img);
			div.appendChild(btn);
			return div;
		}
		
	}
			
	)('filedrag', 'fileSelect')

	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){
	
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;		
	}
	
	/* function checkForm() {
		let form = document.upload;
		if (form.title.value == "") {
			form.title.focus();
			alert('제목을 입력해주세요.');
			return false;
			
		}else if (form.postgu.value == "" || form.postdong.value == "선택"){ 
			form.postgu.select();
			alert('주소를 선택하세요.')
			return false;
		}
		
	} */

		
</script>
</html>