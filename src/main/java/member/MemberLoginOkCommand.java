package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conn.SecurityUtil;

public class MemberLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String idSave = request.getParameter("idSave") == null ? "" : request.getParameter("idSave");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		if (vo.getSalt() == null || vo.getUserDel().equals("OK")) return;
		
		String salt = vo.getSalt();
		pwd = salt + pwd;
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		if (!pwd.equals(vo.getPwd())) return;
		
		
		// 로그인 성공시 처리할 내용 ?
		// 1.주요필드 세션에 저장  2.오늘방문횟수  3.총 방문수, 방문포인트  4.쿠키에 아이디 저장 ?
		
		// 1
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());
		
		
		// 4
		Cookie cMid = new Cookie("cMid", mid);
		if (idSave.equals("on")) {
			cMid.setMaxAge(60*60*24*7);
		} else {
			cMid.setMaxAge(0);
		}
		response.addCookie(cMid);
		
		response.getWriter().write("1");
		
		request.setAttribute("vo", vo);
		
		
	}
}
