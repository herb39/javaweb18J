package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;


public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		
		// BackEnd check : DB에 저장되는 자료의 Null값, 길이, 중복여부 체크
		
		// 아이디, 닉네임 중복 체크
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		
		if (vo.getMid() != null) {
			request.setAttribute("msg", "이미 사용중인 아이디입니다.");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
			return;
		}
		vo = dao.getMemberNickNameCheck(nickName);
		if (vo.getNickName() != null) {
			request.setAttribute("msg", "이미 사용중인 닉네임입니다.");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
			return;
		}
		
		// 비밀번호 암호화 처리 (SHA256)
		UUID uuid = UUID.randomUUID();
		String salt = uuid.toString().substring(0, 8);
		pwd = salt + pwd;
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 체크 완료 -> 회원정보 vo에 담아 DB(DAO 객체)로 넘기기
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setEmail(email);
		vo.setSalt(salt);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "회원가입이 완료되었습니다.\\n다시 로그인해 주세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
		} else {
			request.setAttribute("msg", "회원가입에 실패했습니다.\\n관리자에게 문의 바랍니다. ");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
		}
		response.getWriter().write("1");
		
		request.setAttribute("vo", vo);
	}
}
