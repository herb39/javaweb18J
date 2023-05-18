package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import board.BoardVO;

public class MemberBoardListCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        String mid = (String) session.getAttribute("sMid");
        MemberDAO dao = new MemberDAO();
        MemberVO vo = dao.getMemberMidCheck(mid);
        
        // 특정 회원의 총 레코드 건수 구하기
        BoardDAO dao2 = new BoardDAO();
        int res = dao2.getList(vo.getMid(), vo.getName(), vo.getNickName());
        request.setAttribute("res", res);
        
        // 1. 현재 페이지번호를 구한다.
        int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
        
        // 2. 한페이지의 분량을 결정한다.
        int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));

        // 3. 총 레코드 건수를 구한다.
        int totRecCnt = res;
        
        // 4. 총 페이지 건수를 구한다.
        int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1 ;
        
        // 5. 현재페이지의 '시작 인덱스번호'를 구한다.
        int startIndexNo = (pag - 1) * pageSize;
        
        // 6. 현재 화면에 표시할 시작번호를 구한다.
        int curScrStartNo = totRecCnt - startIndexNo;
        
        
        // 블록페이징처리.... 블록의 시작번호를 0부터 처리했다.
        // 1. 블록의 크기를 결정한다.(여기선 3으로 결정후 처리)
        int blockSize = 3;
        
        // 2. 현재페이지가 속한 블록 번호를 구한다.(예:1페이지는 0블록, 2페이지도 0블록, 4~6페이지는 1블록)
        int curBlock = (pag - 1) / blockSize;
        
        // 3. 마지막 블록을 구한다.
        int lastBlock = (totPage - 1) / blockSize;
        
        // 지정된 페이지의 자료를 요청한 한페이지 분량만큼 가져온다.
        ArrayList<BoardVO> vos = dao2.getBoardSearchMember(startIndexNo, pageSize, mid);
        
        request.setAttribute("vos", vos);
        request.setAttribute("pag", pag);
        request.setAttribute("totPage", totPage);
        request.setAttribute("curScrStartNo", curScrStartNo);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("blockSize", blockSize);
        request.setAttribute("curBlock", curBlock);
        request.setAttribute("lastBlock", lastBlock);
	}

}
