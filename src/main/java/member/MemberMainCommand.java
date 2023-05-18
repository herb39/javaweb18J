package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		// 레벨 문자로 처리해서 넘기기
		String strLevel = "";
		if (vo.getLevel() == 0) strLevel = "관리자";
		else if (vo.getLevel() == 1) strLevel = "준회원";
		else if (vo.getLevel() == 2) strLevel = "정회원";
		else if (vo.getLevel() == 3) strLevel = "우수회원";
		else if (vo.getLevel() == 4) strLevel = "운영자";
		
		request.setAttribute("point", vo.getPoint());
		request.setAttribute("todayCnt", vo.getTodayCnt());
		request.setAttribute("visitCnt", vo.getVisitCnt());
		request.setAttribute("strLevel", strLevel);
		request.setAttribute("photo", vo.getPhoto());
		
		
		// 사용자의 게시판 작성 횟수 가져오기
		int boardCnt = dao.getBoardWrite(mid);
		request.setAttribute("boardCnt", boardCnt);
		
		// 준회원 자동 등업 처리
		// 방문횟수 10회 이상 && 방명록 작성 5회 이상 == 정회원
		if (vo.getLevel() == 1 && vo.getVisitCnt() >= 10 && boardCnt >= 5) {
			dao.setLevelUpCheck(mid, 2);
			session.setAttribute("sLevel", 2);
			request.setAttribute("strLevel", "정회원");
		}
		
		
//		GuestDAO dao2 = new GuestDAO();
//		int res = dao2.getList(vo.getMid(), vo.getName(), vo.getNickName());
//		request.setAttribute("res", res);
		
	}
}
