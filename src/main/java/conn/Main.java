package conn;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Saying.SayingDAO;
import Saying.SayingVO;
import board.BoardDAO;
import board.BoardVO;
import board1.Board1DAO;
import board1.Board1VO;

@SuppressWarnings("serial")
@WebServlet("/Main")
public class Main extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/WEB-INF/main/main.jsp";
		
		SayingDAO sDao = new SayingDAO();
		SayingVO sayingVo = sDao.getRandomSayingContent();
		
		BoardDAO bDao = new BoardDAO();
		ArrayList<BoardVO> boardVos = bDao.getBoardList(0, 5);

		Board1DAO b1Dao = new Board1DAO();
		ArrayList<Board1VO> board1Vos = b1Dao.getBoard1List(0, 5);
		
		request.setAttribute("sayingVo", sayingVo);
		request.setAttribute("boardVos", boardVos);
		request.setAttribute("board1Vos", board1Vos);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}