package board1;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Board1ReplyGoodCheckAjaxCommand implements Board1Interface {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int replyIdx = request.getParameter("replyIdx") == null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		Board1DAO dao = new Board1DAO();
		
		// 좋아요 증가 처리
		// 초기값 0 -> 좋아요 누르면 1 / 이미 눌렀으면 0
		String sw = "0";
		HttpSession session = request.getSession();
		ArrayList<String> goodIdx = (ArrayList)session.getAttribute("sGoodIdx");
		if (goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "boardGood" + replyIdx;
		if (!goodIdx.contains(imsiGoodIdx)) {
			dao.setGoodUpdate(replyIdx);
			goodIdx.add(imsiGoodIdx);
			sw = "1"; // 처음으로 좋아요 누르면 1 반환
		}
		session.setAttribute("sGoodIdx", goodIdx);
		
		response.getWriter().write(sw);
		
	}

}
