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
		else if (vo.getLevel() == 100) strLevel = "운영자";
		else if (vo.getLevel() == 101) strLevel = "";
		
//		else if (vo.getLevel() == 1) strLevel = "준회원";
//		else if (vo.getLevel() == 2) strLevel = "정회원";
//		else if (vo.getLevel() == 3) strLevel = "우수회원";
//		else if (vo.getLevel() == 4) strLevel = "운영자";
		else {
			for (int i = 1; i <= 99; i++) {
				if (vo.getLevel() == i) {
					strLevel = Integer.toString(i);
				}
			}
		}
		request.setAttribute("strLevel", strLevel);
		request.setAttribute("image", vo.getImage());
		
		
		// 사용자의 게시판 작성 횟수 가져오기
		int boardCnt = dao.getBoardWrite(mid);
		request.setAttribute("boardCnt", boardCnt);
		
		
		
//		GuestDAO dao2 = new GuestDAO();
//		int res = dao2.getList(vo.getMid(), vo.getName(), vo.getNickName());
//		request.setAttribute("res", res);
		
	}
}
