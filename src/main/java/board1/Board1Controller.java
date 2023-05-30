package board1;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardGoodCheckAjaxCommand;

@SuppressWarnings("serial")
@WebServlet("*.tsb")
public class Board1Controller extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board1Interface command = null;
		String viewPage = "/WEB-INF/board1";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if (com.equals("/Board1List")) {
			command = new Board1ListCommand();
			command.execute(request, response);
			viewPage += "/board1List.jsp";
		}
		else if (com.equals("/Board1Content")) {
			command = new Board1ContentCommand();
			command.execute(request, response);
			viewPage += "/board1Content.jsp";
		}
		else if (com.equals("/Board1ReplyInput")) {
			command = new Board1ReplyInputCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/Board1ReplyGoodCheckAjax")) {
			command = new Board1ReplyGoodCheckAjaxCommand();
			command.execute(request, response);
			return;
		}
		else if (com.equals("/Board1ReplyDelete")) {
			command = new Board1ReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
