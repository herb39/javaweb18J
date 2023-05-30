package board1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Board1ReplyDeleteCommand implements Board1Interface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int replyIdx = request.getParameter("replyIdx") == null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		
		Board1DAO dao = new Board1DAO();
		
		String res = dao.setBoard1ReplyDeleteOk(replyIdx);
		response.getWriter().write(res);
	}

}
