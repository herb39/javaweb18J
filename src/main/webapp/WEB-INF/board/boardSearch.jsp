<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardList.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
  	body {
		height: 100%;
		min-height: 600px;
		background: url(./images/sea-4768869_1920.jpg) no-repeat center center fixed;
		background-size: cover;
	}
  </style>
  <script>
    'use strict';
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/BoardList.bo?pag=${pag}&pageSize="+pageSize;
    }
    
    function searchCheck() {
    	let searchString = $("#searchString").val();
    	
    	if (searchString.trim() == "") {
    		alert("검색어를 입력하세요.");
    		searchForm.searchString.focus();
    	} else {
    		searchForm.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">게 시 판</h2>
  <div class="text-canter">
  	${searchTitle}(으)로 ${searchString}(을)를 검색한 결과 <b>${searchCount}</b>건이 검색되었습니다.
  </div>
  <table class="table table-borderless m-0 p-0">
  	<tr>
  		<td><a href="${ctp}/BoardList.bo?pag=${pag}&pageSize=${pageSize}" class="btn btn-info btn-sm">돌아가기</a></td>
  	</tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성시간</th>
      <th>조회수</th>
      <th>좋아요</th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
    <c:if test="${vo.day_diff == 0}">
      <tr>
        <td>${searchCount}</td>
        <td>
        	<a href="${ctp}/BoardContent.bo?flag=search&search=${search}&searchString=${searchString}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
          <%-- <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if> --%>
        </td>
        <td>${vo.nickName}</td>
        <td>
          <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.wDate,0,10)}</c:if>
          <c:if test="${vo.hour_diff <= 24}">
            ${vo.day_diff == 0 ? fn:substring(vo.wDate,11,16) : fn:substring(vo.wDate,0,16)}
          </c:if>
        </td>
        <td>${vo.readNum}</td>
        <td>${vo.good}</td>
      </tr>
      <c:set var="searchCount" value="${searchCount - 1}" />
      </c:if>
    </c:forEach>
    <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>