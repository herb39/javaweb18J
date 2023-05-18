package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import conn.SecurityUtil;


public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/member");
		int maxSize = 1024 * 1024 * 2;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 프로필 사진 업로드 되었는지 ?
		String filesystemName = multipartRequest.getFilesystemName("fName");
		if (filesystemName == null) filesystemName = multipartRequest.getParameter("photo");
		String photo = "noimage.jpg";
		
		String mid = multipartRequest.getParameter("mid") == null ? "" : multipartRequest.getParameter("mid");
		String pwd = multipartRequest.getParameter("pwd") == null ? "" : multipartRequest.getParameter("pwd");
		String nickName = multipartRequest.getParameter("nickName") == null ? "" : multipartRequest.getParameter("nickName");		
		String name = multipartRequest.getParameter("name") == null ? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender") == null ? "" : multipartRequest.getParameter("gender");
		String birthday = multipartRequest.getParameter("birthday") == null ? "" : multipartRequest.getParameter("birthday");
		String tel = multipartRequest.getParameter("tel") == null ? "" : multipartRequest.getParameter("tel");
		String address = multipartRequest.getParameter("address") == null ? "" : multipartRequest.getParameter("address");
		String email = multipartRequest.getParameter("email") == null ? "" : multipartRequest.getParameter("email");
		String userInfor = multipartRequest.getParameter("userInfor") == null ? "" : multipartRequest.getParameter("userInfor");

		
		// BackEnd check : DB에 저장되는 자료의 Null값, 길이, 중복여부 체크
		
		// 아이디, 닉네임 중복 체크
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getMemberMidCheck(mid);
		if (vo.getMid() != null) {
			request.setAttribute("msg", "이미 사용중인 아이디입니다.");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
			return;
		}
		vo = dao.getMemberMidCheck(nickName);
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
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setPhoto(photo);
		vo.setUserInfor(userInfor);
		vo.setSalt(salt);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "회원가입이 완료되었습니다.\\n다시 로그인해 주세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
		} else {
			request.setAttribute("msg", "회원가입에 실패했습니다.\\n관리자에게 문의 바랍니다. ");
			request.setAttribute("url", request.getContextPath()+"/MemberJoin.mem");
		}
	}
}
