package board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag") == null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize") == null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag") == null ? "" : request.getParameter("flag");
		String search = request.getParameter("search") == null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString");
		
		BoardDAO dao = new BoardDAO();
		
		// 조회수 1 증가 (중복증가 방지 세션사용 : "'board'+idx" 값을 객체배열(ArrayList)에 추가
		HttpSession session = request.getSession();
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if (contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		
		String imsiContentIdx = "board" + idx;
		
		if (!contentIdx.contains(imsiContentIdx)) {
			dao.setReadNumUpdate(idx);
			contentIdx.add(imsiContentIdx);
		}
		
		session.setAttribute("sContentIdx",	contentIdx);
		
		
		// 현재 선택된 게시글(idx)의 전체 내용 가져오기
		BoardVO vo = dao.getBoardContent(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		
		// 이전글 / 다음글
		BoardVO preVo = dao.getPreNextSearch(idx, "preVo");
		BoardVO nextVo = dao.getPreNextSearch(idx, "nextVo");
	    request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
		
		// 해당 게시글에 좋아요 누르면 세션에 아이디 저장 -> sSw 값 1로 보내서 하트 빨간색 변경 유지
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("sGoodIdx");
		if (goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "boardGood" + idx;
		if (goodIdx.contains(imsiGoodIdx)) {
			session.setAttribute("sSw", "1"); // 로그인 사용자가 이미 좋아요를 눌렀다면 하트 빨간색 표시
		} else {
			session.setAttribute("sSw", "0");
		}
		
	}

}
