package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberIdCheckCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		if (vo.getMid() == null) {
			// 사용 가능한 아이디
			request.setAttribute("res", 1);
		} else {
			// 이미 사용중인 아이디
			request.setAttribute("res", 0);
		}
		request.setAttribute("mid", mid);
	}

}
