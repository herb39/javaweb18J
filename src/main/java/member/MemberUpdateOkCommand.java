package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 프로필 사진 업로드 되었는지 ?
		String photo = "noimage.jpg";
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String sNickName = (String) session.getAttribute("sNickName");
		
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");		
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String gender = request.getParameter("gender") == null ? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel") == null ? "" : request.getParameter("tel");
		String address = request.getParameter("address") == null ? "" : request.getParameter("address");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage") == null ? "" : request.getParameter("homePage");
		String job = request.getParameter("job") == null ? "" : request.getParameter("job");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		String userInfor = request.getParameter("userInfor") == null ? "" : request.getParameter("userInfor");
		
		// 취미 : 배열로 처리
		String[] hobbys = request.getParameterValues("hobby");
		String hobby = "";
		if (hobbys.length != 0) {
			for (String strHobby : hobbys) {
				hobby += strHobby + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		// BackEnd check : DB에 저장되는 자료의 Null값, 길이, 중복여부 체크
		// 아이디, 닉네임 중복 체크
		MemberDAO dao = new MemberDAO();
		
		if (!nickName.equals(sNickName)) {
			String tempNickName = dao.getMemberNickNameCheck(nickName).getNickName();
			if (tempNickName != null) {
				request.setAttribute("msg", "이미 사용중인 닉네임입니다.");
				request.setAttribute("url", request.getContextPath()+"/MemberUpdate.mem");
				return;
			}
		}

		// 체크 완료 -> 회원정보 vo에 담아 DB(DAO 객체)로 넘기기
		MemberVO vo = new MemberVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setPhoto(photo);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberUpdateOk(vo);
		
		if (res == 1) {
			session.setAttribute("sNickName", nickName);
			request.setAttribute("msg", "회원정보 수정 완료");
			request.setAttribute("url", request.getContextPath()+"/MemberMain.mem");
		} else {
			request.setAttribute("msg", "회원정보 수정 실패");
			request.setAttribute("url", request.getContextPath()+"/MemberUpdate.mem");
		}
	}
}
