package Saying;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SayingContentCommand implements SayingInterface{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") ==  null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String image = request.getParameter("image") == null ? "" : request.getParameter("image");
		String content = request.getParameter("content") == null ? "" : request.getParameter("image");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		
		SayingDAO dao = new SayingDAO();
		
		SayingVO vo = dao.getRandomSayingContent();
		
		request.setAttribute("vo", vo);
		request.setAttribute("image", image);
		request.setAttribute("content", content);
		request.setAttribute("name", name);
		
	}

}
