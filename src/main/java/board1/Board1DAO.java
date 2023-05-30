package board1;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import conn.GetConn;

public class Board1DAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	Board1VO vo = null;
	
	public Board1VO setBoard1Content(int idx) {
	    Board1VO vo = new Board1VO();
	    try {
	        // 어제 날짜를 가져옴
	        LocalDate yesterday = LocalDate.now().minusDays(1);

	        // 어제 날짜 중에서 좋아요가 가장 많은 글 조회
	        sql = "SELECT b.*, m.level "
	            + "FROM board1 b JOIN member m ON b.memberIdx = m.idx "
	            + "WHERE DATE(wDate) = ? ORDER BY good DESC LIMIT 1";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setDate(1, Date.valueOf(yesterday));
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            // 조회된 레코드의 idx 값을 가져옴
	            int boardIdx = rs.getInt("idx");

	            // board1 테이블에 추가할 레코드의 값 설정
	            sql = "INSERT INTO board1 VALUES (default,?,?,?,?,?,?,?)";
	            pstmt = conn.prepareStatement(sql);

	            pstmt.setInt(1, boardIdx);
	            pstmt.setString(2, rs.getString("mid"));
	            pstmt.setString(3, rs.getString("nickName"));
	            pstmt.setString(4, rs.getString("title"));
	            pstmt.setString(5, rs.getString("content"));
	            pstmt.setString(6, rs.getString("wDate"));
	            pstmt.setInt(7, rs.getInt("memberIdx"));
	            pstmt.executeUpdate();

	            // 값 설정
	            vo.setBoardIdx(boardIdx);
	            vo.setMid(rs.getString("mid"));
	            vo.setNickName(rs.getString("nickName"));
	            vo.setTitle(rs.getString("title"));
	            vo.setContent(rs.getString("content"));
	            vo.setwDate(rs.getString("wDate"));
	            vo.setLevel(rs.getInt("level"));
	        }
	    } catch (SQLException e) {
	        System.out.println("SQL 오류: " + e.getMessage());
	    } finally {
	        getConn.rsClose();
	    }
	    return vo;
	}


	// 게시글 1건 가져오기
	public Board1VO getBoard1Content(int idx) {
		Board1VO vo = new Board1VO();
		try {
			sql = "select b.*, m.level FROM board1 b JOIN member m ON b.memberIdx = m.idx where b.idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setBoardIdx(rs.getInt("boardIdx"));
            vo.setMid(rs.getString("mid"));
            vo.setNickName(rs.getString("nickName"));
            vo.setTitle(rs.getString("title"));
            vo.setContent(rs.getString("content"));
            vo.setwDate(rs.getString("wDate"));
            vo.setLevel(rs.getInt("level"));
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 전체 레코드 건수 구하기
	public int getTotRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(idx) as cnt from board1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 검색
	public ArrayList<Board1VO> getBoard1ContentSearch(String search, String searchString) {
		ArrayList<Board1VO> vos = new ArrayList<>();
		try {
			sql = "select * from board1 where "+search+" like ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				vo = new Board1VO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 게시글 전체 조회
		public ArrayList<Board1VO> getBoard1List(int startIndexNo, int pageSize) {
			ArrayList<Board1VO> vos = new ArrayList<>();
			try {
				sql = "SELECT b.*, m.level FROM board1 b "
						+ "JOIN member m ON b.memberIdx = m.idx "
						+ "order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new Board1VO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setwDate(rs.getString("wDate"));
					vo.setLevel(rs.getInt("level"));
					
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vos;
		}
		
		// 이전글 / 다음글 ?
		public Board1VO getPreNextSearch(int idx, String str) {
			vo = new Board1VO();
			try {
				if (str.equals("preVo")) {
					sql = "select idx,title from board1 where idx < ? order by idx desc limit 1";
				} else {
					sql = "select idx,title from board1 where idx > ? limit 1";
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
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return vo;
		}
		
		// 댓글 작성
		public String setBoard1ReplyInput(Board1ReplyVO replyVo) {
			String res = "0";
			try {
				sql = "insert into board1Reply values (default,?,?,?,?,default,default,default,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, replyVo.getBoard1Idx());
				pstmt.setString(2, replyVo.getMid());
				pstmt.setString(3, replyVo.getNickName());
				pstmt.setString(4, replyVo.getContent());
				pstmt.setInt(5, replyVo.getMemberIdx());
				pstmt.executeUpdate();
				res = "1";
			} catch (SQLException e) {
				System.out.println("SQL 오류 / 댓글 작성 : " + e.getMessage());
			} finally {
				getConn.pstmtClose();
			}
			return res;
		}
		
		// 본게시글에 있는 댓글 가져오기
		public ArrayList<Board1ReplyVO> getBoard1Reply(int idx) {
			ArrayList<Board1ReplyVO> replyVos = new ArrayList<>();
			try {
				sql = "select br.*, m.level from board1Reply br "
						+ "join member m on br.memberIdx = m.idx "
						+ "where board1Idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					Board1ReplyVO replyVo = new Board1ReplyVO();
					replyVo.setIdx(rs.getInt("idx"));
					replyVo.setBoard1Idx(idx);
					replyVo.setMid(rs.getString("mid"));
					replyVo.setNickName(rs.getString("nickName"));
					replyVo.setContent(rs.getString("content"));
					replyVo.setGood(rs.getInt("br.good"));
					replyVo.setwDate(rs.getString("wDate"));
					replyVo.setoX(rs.getString("oX"));
					replyVo.setLevel(rs.getInt("level"));
					
					replyVos.add(replyVo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 (댓글 가져오기) : " + e.getMessage());
			} finally {
				getConn.rsClose();
			}
			return replyVos;
		}

	// 댓글 삭제
	public String setBoard1ReplyDeleteOk(int replyIdx) {
		String res = "0";
		try {
			sql = "delete from board1Reply where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyIdx);
			pstmt.executeUpdate();
			res = "1";
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
	// 좋아요 1 증가
	public void setGoodUpdate(int replyIdx) {
		try {
			sql = "UPDATE board1Reply b JOIN member m ON b.memberIdx = m.idx SET b.good = b.good + 1, m.point = m.point + 20 WHERE b.idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyIdx);
			System.out.println(replyIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 b6 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}		
	}
}