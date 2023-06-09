package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;

	// 아이디 중복 체크 -> 자료 있으면 vo에 개인정보 담기
	public MemberVO getMemberMidCheck(String mid) {
		vo = new MemberVO();
		try {
			sql = "select * from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setSalt(rs.getString("salt"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 m1 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
	
	// 회원가입
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values (default,?,?,?,?,?,default,default,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getNickName());
			pstmt.setString(4, vo.getName());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getSalt());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 m2 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 닉네임 중복 체크
	public MemberVO getMemberNickNameCheck(String nickName) {
		vo = new MemberVO();
		try {
			sql = "select * from member where nickName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				vo.setNickName(rs.getString("nickName"));
				vo.setSalt(rs.getString("salt"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 m3 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	
	// 전체 회원 리스트
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize) {
		ArrayList<MemberVO> vos = new ArrayList<>();
		try {
			sql = "select * from member order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setLevel(rs.getInt("level"));
				vo.setSalt(rs.getString("salt"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 m4 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 비밀번호 변경
	public int setMemberPwdUpdateOk(String mid, String newPwd) {
		int res = 0;
		try {
			sql = "update member set pwd = ? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 m5 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 유저 정보 수정
	public int setMemberUpdateOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "update member set nickName=?, name=?, email=? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getMid());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 m6 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
		return res;
	}

	// 전체 회원 수 ?
	public int getTotRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(idx) cnt from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 m7 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 사용자 탈퇴 신청
	public void setDeleteAskOk(String mid) {
		try {
			sql = "update member set userDel = 'OK' where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 m8 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
	}

	// 사용자 탈퇴 (DB에서 삭제)
	public void setMemberDelete(int idx) {
		try {
			sql = "delete from member where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 m9 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
	}


	// 게시글 작성 횟수 ?
	public int getBoardWrite(String mid) {
		int boardCnt = 0;
		try {
			sql = "select count(*) as cnt from board where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			rs.next();
			boardCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 m10 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return boardCnt;
	}
	
	// 등업 처리
	public void setLevelUpCheck(String mid, int level) {
		try {
			sql = "update member set level = ? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 m11 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}
	
	//  레벨 업데이트 / 포인트 >= 100 {레벨+1 / 포인트-100} 
	public void updateLevelAndResetPoint() {
	    try {
	        // 1. point가 100 이상인 회원 조회
	        String sql = "SELECT * FROM member WHERE point >= 100";
	        // 데이터베이스 연결 및 쿼리 실행
	        rs = pstmt.executeQuery(sql);

	        while (rs.next()) {
	            // 2. point 값을 가져와서 100 이상인 경우에는 100을 뺀 값을 설정
	            String mid = rs.getString("mid");
	            int level = rs.getInt("level");
	            int point = rs.getInt("point");

	            int updatedLevel = level;
	            int updatedPoint = point;

	            if (point >= 100 && level != 0 && level != 99 && level != 100) {
	                updatedLevel += 1;
	                updatedPoint -= 100;
	            }

	            // 3. level과 point 값을 업데이트하는 쿼리 실행
	            sql = "UPDATE member SET level = ?, point = ? WHERE mid = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, updatedLevel);
	            pstmt.setInt(2, updatedPoint);
	            pstmt.setString(3, mid);
	            pstmt.executeUpdate();
	        }
	    } catch (SQLException e) {
	        System.out.println("SQL 오류 m12 : " + e.getMessage());
	    } finally {
	    	getConn.rsClose();
	    }
	}

}
