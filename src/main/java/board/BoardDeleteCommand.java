package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardDeleteCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 정상적인 경로를 통해서 삭제하지 않는 경우 홈으로 이동
		HttpSession session = request.getSession();
		String sNickName = (String)session.getAttribute("sMid");
		int sLevel = (int)session.getAttribute("sLevel");
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");

		if (sLevel != 0 || sLevel != 100) {
				request.setAttribute("msg", "잘못된 접근입니다.");
				request.setAttribute("url", request.getContextPath()+ "/");
		}
		
		// 정상 처리
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		
		BoardDAO dao = new BoardDAO();
		
		
		// 현재 게시글에 댓글이 없다면 삭제 처리
		int res = dao.setBoardDelete(idx);
		
		if(res == 1) {
			request.setAttribute("msg", "게시글이 삭제되었습니다.");
			request.setAttribute("url", request.getContextPath()+"/BoardList.bo?pag="+pag+"&pageSize="+pageSize);
		}
		else {
			request.setAttribute("msg", "게시글 삭제 실패");
			request.setAttribute("url", request.getContextPath()+"/BoardContent.bo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		
	}

}
