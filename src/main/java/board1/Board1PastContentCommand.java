package board1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Board1PastContentCommand implements Board1Interface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		Board1DAO dao = new Board1DAO();
		
		Board1VO vo = null;
		// 현재 선택된 게시글(idx)의 전체 내용 가져오기
		
		
		vo = dao.getBoard1PastContent(idx);
		
		request.setAttribute("vo", vo);
		
//		 본문에 딸린 댓글 가져오기
//		ArrayList<Board1ReplyVO>replyVos = dao.getBoard1Reply(idx);
//		request.setAttribute("replyVos", replyVos);
	}

}
