package board1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Board1ReplyInputCommand implements Board1Interface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int idx = (int) session.getAttribute("sIdx");
		
		int board1Idx = Integer.parseInt(request.getParameter("board1Idx"));
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		
		Board1ReplyVO replyVo = new Board1ReplyVO();
		
		replyVo.setMemberIdx(idx);
		replyVo.setBoard1Idx(board1Idx);
		replyVo.setMid(mid);
		replyVo.setNickName(nickName);
		replyVo.setContent(content);
		
		Board1DAO dao = new Board1DAO();
		
		String res = dao.setBoard1ReplyInput(replyVo);
		
		response.getWriter().write(res);
		
		
	}

}
