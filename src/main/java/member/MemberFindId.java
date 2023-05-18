package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/member/MemberFindId")
public class MemberFindId extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		
		MemberVO vo = new MemberVO();
		MemberDAO dao = new MemberDAO();
		
		PrintWriter out = response.getWriter();
		
		String viewPage = "/WEB-INF/member/FindIdRes.jsp";
			
		// 입력한 아이디와 이름이 DB에 저장되어있는 아이디, 이름과 같으면 비밀번호를 저장해서 jsp로 넘긴 후 짝수위치만 *로 가리고 출력 
		if(name.equals(vo.getName()) && email.equals(vo.getEmail())) {
			String mid = vo.getMid();
			request.setAttribute("mid", mid);
			request.getRequestDispatcher(viewPage).forward(request, response);
		}
		else {
			out.print("<script>");
			out.print("alert('회원정보가 맞지 않습니다!\\n다시 시도해주세요');");
			out.print("location.href='"+request.getContextPath()+"/WEB-INF/member/FindId.jsp';");
			out.print("</script>");
		}
	}	
}
