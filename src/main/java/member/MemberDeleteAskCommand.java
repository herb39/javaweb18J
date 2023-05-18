package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

public class MemberDeleteAskCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String)session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		
		dao.setDeleteAskOk(mid);
		
		session.invalidate();
		
		request.setAttribute("msg", "탈퇴 완료되었습니다. \\n30일 동안 같은 아이디로 재가입이 제한됩니다.");
		request.setAttribute("url", request.getContextPath()+"/");
		 
	}

}
