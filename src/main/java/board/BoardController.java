package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardInterface command = null;
		String viewPage = "/WEB-INF/board";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
		
		// 세션 끊김 -> 작업 진행 중지 -> 홈으로 이동
//		HttpSession session = request.getSession();
//		int level = session.getAttribute("sLevel") == null ? 101 : (int)session.getAttribute("sLevel");
//		
//		if (level > 100) {
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
//			dispatcher.forward(request, response);
//		}
//		else
		if (com.equals("/BoardList")) {
			command = new BoardListCommand();
			command.execute(request, response);
			viewPage += "/boardList.jsp";
		}
		else if (com.equals("/BoardInput")) {
			viewPage += "/boardInput.jsp";
		}
		else if (com.equals("/BoardInputOk")) {
			command = new BoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/BoardContent")) {
			command = new BoardContentCommand();
			command.execute(request, response);
			viewPage += "/boardContent.jsp";
		}
//		else if (com.equals("/BoardGoodCheck")) {
//			command = new BoardGoodCheckCommand();
//			command.execute(request, response);
//			viewPage += "/boardContent.jsp";
//		}
		else if (com.equals("/BoardGoodCheckAjax")) {
			command = new BoardGoodCheckAjaxCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/BoardGoodPlusMinus")) {
			command = new BoardGoodPlusMinusCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/BoardSearch")) {
			command = new BoardSearchCommand();
			command.execute(request, response);
			viewPage += "/boardSearch.jsp";
		}
		else if (com.equals("/BoardDelete")) {
			command = new BoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/BoardUpdate")) {
			command = new BoardUpdateCommand();
			command.execute(request, response);
			viewPage += "/boardUpdate.jsp";
		}
		else if (com.equals("/BoardUpdateOk")) {
			command = new BoardUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if (com.equals("/BoardSearchMember")) {
			command = new BoardSearchMemberCommand();
			command.execute(request, response);
			viewPage += "/boardSearchMember.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
