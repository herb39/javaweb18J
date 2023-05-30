<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#demo {
		font-size: 30px;
	}
</style>
<!-- 특정 요소에 카운트다운 타이머 표시 -->
<p id="demo"></p>

<script>
  // 00:00:00의 현재 시간을 가져오는 함수
  function getResetTime() {
    var now = new Date(); // 현재 날짜와 시간
    var resetTime = new Date(); // 카운트다운을 초기화할 날짜와 시간

    // 카운트다운을 다음 날 00:00:00으로 설정
    resetTime.setDate(now.getDate() + 1);
    resetTime.setHours(0, 0, 0, 0);

    return resetTime;
  }

  // 카운트다운을 업데이트하는 함수
  function updateCountdown() {
    // 현재 시간 가져오기
    var now = new Date().getTime();

    // 다음 날을 위한 카운트다운 초기화 시간 가져오기
    var resetTime = getResetTime().getTime();

    // 현재 시간과 초기화 시간 사이의 차이 계산
    var distance = resetTime - now;

    // 시간, 분, 초 계산
    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

    // "demo" 요소에 결과 표시
    document.getElementById("demo").innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초 후에 다음 주제가 정해집니다!";
  }

  // 초기 카운트다운 업데이트
  updateCountdown();

  // 1초마다 카운트다운 업데이트
  setInterval(updateCountdown, 1000);
</script>
