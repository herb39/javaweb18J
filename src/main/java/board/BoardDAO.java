package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import member.MemberVO;

public class BoardDAO {
	// 싱글톤으로 선언된 DB연결객체(GetConn)을 연결한다.
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	BoardVO vo = null;
	
	// 게시글 전체 조회
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		ArrayList<BoardVO> vos = new ArrayList<>();
		try {
			sql = "SELECT b.*, m.level, "
					+ "DATEDIFF(b.wDate, NOW()) AS day_diff, "
					+ "TIMESTAMPDIFF(HOUR, b.wDate, NOW()) AS hour_diff "
					+ "FROM board b "
					+ "JOIN member m ON b.memberIdx = m.idx "
					+ "WHERE DATE_FORMAT(b.wDate, '%Y-%m-%d') = CURDATE() "
					+ "ORDER BY b.idx DESC "
					+ "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setLevel(rs.getInt("level"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDay_diff(rs.getInt("day_diff"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 b1 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 게시글 저장하기
	public int setBoardInputOk(BoardVO vo) {
	    int res = 0;
	    try {
	        sql = "INSERT INTO board VALUES (default,?,?,?,?,default,default,default,?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, vo.getMid());
	        pstmt.setString(2, vo.getNickName());
	        pstmt.setString(3, vo.getTitle());
	        pstmt.setString(4, vo.getContent());
	        pstmt.setInt(5, vo.getMemberIdx());
	        pstmt.executeUpdate();
	        res = 1;
	    } catch (SQLException e) {
	        System.out.println("SQL 오류 b2 : " + e.getMessage());
	    } finally {
	        getConn.pstmtClose();
	    }
	    return res;
	}


	// 전체 레코드 건수 구하기
	public int getTotRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(idx) as cnt from board where date_format(wDate, '%Y-%m-%d') = curdate()";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 b3 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 게시글 1건 가져오기
	public BoardVO getBoardContent(int idx) {
		BoardVO vo = new BoardVO();
		try {
			sql = "select b.*, m.level FROM board b JOIN member m ON b.memberIdx = m.idx where b.idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("b.idx"));
			vo.setMid(rs.getString("mid"));
			vo.setNickName(rs.getString("nickName"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setReadNum(rs.getInt("readNum"));
			vo.setwDate(rs.getString("wDate"));
			vo.setGood(rs.getInt("good"));
			vo.setLevel(rs.getInt("level"));
		} catch (SQLException e) {
			System.out.println("SQL 오류 b4 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 조회수 1 증가
	public void setReadNumUpdate(int idx) {
		try {
			sql = "update board set readNum = readNum + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 b5 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 좋아요 1 증가
	public void setGoodUpdate(int idx) {
		try {
			sql = "UPDATE board b JOIN member m ON b.memberIdx = m.idx SET b.good = b.good + 1, m.point = m.point + 20 WHERE b.idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 b6 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}		
	}
	
	// 이전글 / 다음글 ?
	public BoardVO getPreNextSearch(int idx, String str) {
		vo = new BoardVO();
		try {
			if (str.equals("preVo")) {
				sql = "select idx,title from board where idx < ? order by idx desc limit 1";
			} else {
				sql = "select idx,title from board where idx > ? limit 1";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if (str.equals("preVo") && rs.next()) {
				vo.setPreIdx(rs.getInt("idx"));
				vo.setPreTitle(rs.getString("title"));
			} else if (str.equals("nextVo") && rs.next()) {
				vo.setNextIdx(rs.getInt("idx"));
				vo.setNextTitle(rs.getString("title"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 b8 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 검색
	public ArrayList<BoardVO> getBoardContentSearch(String search, String searchString) {
		ArrayList<BoardVO> vos = new ArrayList<>();
		try {
			sql = "select * from board where "+search+" like ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 b9 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 게시글 삭제
	public int setBoardDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 b10 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 게시글 수정
	public int setBoardUpdateOk(BoardVO vo) {
		int res = 0;
		try {
			sql = "update board set title = ?, content = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getIdx());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 b11 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 사용자가 쓴 게시글 전체 건수 ?
	public int getTotRecCntMember(String mid) {
		int totRecCnt = 0;
		try {
			sql = "select count(idx) as cnt from board where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 b12 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}
	
	// 사용자가 쓴 전체 게시글 가져오기
	public ArrayList<BoardVO> getBoardSearchMember(int startIndexNo, int pageSize, String mid) {
		ArrayList<BoardVO> vos = new ArrayList<>();
		try {
			sql = "select *, datediff(wDate, now()) as day_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
				+ "(select count(*) from board1Reply where board1Idx = b.idx) as replyCount "
				+ "from board b where mid = ? order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDay_diff(rs.getInt("day_diff"));
				
				vo.setReplyCount(rs.getInt("replyCount"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 b13 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 검색
	public int getList(String mid, String name, String nickName) {
		int res = 0;
        try {
            sql = "select count(idx) as cnt from board where name in(?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mid);
            pstmt.setString(2, name);
            pstmt.setString(3, nickName);
            rs = pstmt.executeQuery();
            
            rs.next();
            res = rs.getInt("cnt");
            
        } catch (SQLException e) {
            System.out.println("SQL 오류 b14 : " + e.getMessage());
        } finally {
            getConn.rsClose();
        }
        return res;
	}
	
	
}
