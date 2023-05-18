<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hello, World!</title>
	<jsp:include page="/include/bs4.jsp" />
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <style>
  	body {
	  height: 100%;
	  min-height: 600px;
	  background: url(./images/sea-4768869_1920.jpg) no-repeat center center fixed;
	  background-size: cover;
	}
	
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  </style>
  <script>
  Kakao.init('9b690017665b392a082df157ff58c871'); //발급받은 키 중 javascript키를 사용해준다.
  console.log(Kakao.isInitialized()); // sdk초기화여부판단
  //카카오로그인
  function kakaoLogin() {
      Kakao.Auth.login({
        success: function (response) {
          Kakao.API.request({
            url: '/v2/user/me',
            success: function (response) {
          	  console.log(response)
            },
            fail: function (error) {
              console.log(error)
            },
          })
        },
        fail: function (error) {
          console.log(error)
        },
      })
    }
  //카카오로그아웃  
  function kakaoLogout() {
      if (Kakao.Auth.getAccessToken()) {
        Kakao.API.request({
          url: '/v1/user/unlink',
          success: function (response) {
          	console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
        Kakao.Auth.setAccessToken(undefined)
      }
    }  
  </script>
</head>
<body>
	<jsp:include page="/include/header.jsp"/>
		<div class="container" style="margin-top:0px">
		  <div class="row">
		    <div class="col-sm-4">
		      <h2>About Me</h2>
		      <h5>Photo of me:</h5>
		      <div class="fakeimg">Fake Image</div>
		      <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
      
      
      <ul>
	<li onclick="kakaoLogin();">
      <a href="javascript:void(0)">
          <span>카카오 로그인</span>
      </a>
	</li>
	<li onclick="kakaoLogout();">
      <a href="javascript:void(0)">
          <span>카카오 로그아웃</span>
      </a>
	</li>
</ul>


		      <hr class="d-sm-none">
		    </div>
		    <div class="col-sm-8">
		      <h2>TITLE HEADING</h2>
		      <h5>Title description, Dec 7, 2017</h5>
		      <div class="fakeimg">Fake Image</div>
		      <p>Some text..</p>
		      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
		      <br>
		      <h2>TITLE HEADING</h2>
		      <h5>Title description, Sep 2, 2017</h5>
		      <div class="fakeimg">Fake Image</div>
		      <p>Some text..</p>
		      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
		    </div>
		  </div>
		</div>
	<jsp:include page="/include/footer.jsp" />		
	  <!-- </div> -->
</body>
</html>