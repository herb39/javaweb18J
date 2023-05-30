//package board1;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//public class Board1PastContentCommand implements Board1Interface {
//
//	@Override
//	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
//		
//		Board1DAO dao = new Board1DAO();
//		
//		Board1VO vo = null;
//		// 현재 선택된 게시글(idx)의 전체 내용 가져오기
//		
//		
//		vo = dao.getBoard1PastContent(idx);
//		
//		request.setAttribute("vo", vo);
//		
////		 본문에 딸린 댓글 가져오기
////		ArrayList<Board1ReplyVO>replyVos = dao.getBoard1Reply(idx);
////		request.setAttribute("replyVos", replyVos);
//	}
//
//}
package board1;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Board1ContentCommand implements Board1Interface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
		String search = request.getParameter("search") == null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString");
		
		Board1DAO dao = new Board1DAO();
		
		// 현재 선택된 게시글(idx)의 전체 내용 가져오기
		Board1VO vo = dao.getBoard1Content(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		
		// 이전글 / 다음글
		Board1VO preVo = dao.getPreNextSearch(idx, "preVo");
		Board1VO nextVo = dao.getPreNextSearch(idx, "nextVo");
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);

		
		
		// 본문에 딸린 댓글 가져오기
		ArrayList<Board1ReplyVO>replyVos = dao.getBoard1Reply(idx);
		request.setAttribute("replyVos", replyVos);
		
	}

}
