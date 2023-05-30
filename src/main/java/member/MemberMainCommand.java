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
		String level = "";
		if (vo.getLevel() == 0) level = "관리자";
		else if (vo.getLevel() == 100) level = "운영자";
		else {
			for (int i = 1; i <= 99; i++) {
				if (vo.getLevel() == i) {
					level = Integer.toString(i);
				}
			}
		}
		request.setAttribute("point", vo.getPoint());
		request.setAttribute("level", level);
		
		
		// 사용자의 게시판 작성 횟수 가져오기
		int boardCnt = dao.getBoardWrite(mid);
		request.setAttribute("boardCnt", boardCnt);
		
		
		
		
	}
}
