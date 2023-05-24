package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardGoodCheckAjaxCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		// 좋아요 증가 처리
		// 초기값 0 -> 좋아요 누르면 1 / 이미 눌렀으면 0
		String sw = "0";
		HttpSession session = request.getSession();
		ArrayList<String> goodIdx = (ArrayList)session.getAttribute("sGoodIdx");
		if (goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "boardGood" + idx;
		if (!goodIdx.contains(imsiGoodIdx)) {
			dao.setGoodUpdate(idx);
			goodIdx.add(imsiGoodIdx);
			sw = "1"; // 처음으로 좋아요 누르면 1 반환
		}
		session.setAttribute("sGoodIdx", goodIdx);
		
		response.getWriter().write(sw);
		
	}

}
