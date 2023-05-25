package board1;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import board.BoardVO;
import conn.GetConn;

public class Board1DAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	Board1VO vo = null;
	
	// 오늘의 주제 추가
	public Board1VO setBoard1Content(int idx) {
		vo = new Board1VO();
	    try {
	        // 어제 날짜를 가져옴
	        LocalDate yesterday = LocalDate.now().minusDays(1);

	        // 어제 날짜 중에서 좋아요가 가장 많은 글 조회
	        sql = "SELECT * FROM board WHERE DATE(wDate) = ? ORDER BY good DESC LIMIT 1";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setDate(1, Date.valueOf(yesterday));
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            // 조회된 레코드의 idx 값을 가져옴
	            int boardIdx = rs.getInt("idx");

	            // 조회된 레코드의 정보를 board1 테이블에 추가
	            sql = "INSERT INTO board1 (boardIdx, mid, nickName, title, content, hostIp, wDate, level) VALUES (?,?,?,?,?,?,?,?)";
	            pstmt = conn.prepareStatement(sql);

	            // board1 테이블에 추가할 레코드의 값 설정
	            pstmt.setInt(1, boardIdx);
	            pstmt.setString(2, rs.getString("mid"));
	            pstmt.setString(3, rs.getString("nickName"));
	            pstmt.setString(4, rs.getString("title"));
	            pstmt.setString(5, rs.getString("content"));
	            pstmt.setString(6, rs.getString("hostIp"));
	            pstmt.setString(7, rs.getString("wDate"));
	            pstmt.setString(8, rs.getString("level"));
	            // board1 테이블에 레코드 추가
	            pstmt.executeUpdate();
	            
	            // Board1VO 객체 생성 및 값 설정
	            vo = new Board1VO();
	            vo.setBoardIdx(boardIdx);
	            vo.setMid(rs.getString("mid"));
	            vo.setNickName(rs.getString("nickName"));
	            vo.setTitle(rs.getString("title"));
	            vo.setContent(rs.getString("content"));
	            vo.setHostIp(rs.getString("hostIp"));
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

	// 오늘의 주제 조회
	public Board1VO getBoard1Content(int idx) {
	    Board1VO vo = null;
	    try {
	        // 어제 날짜를 가져옴
	        LocalDate yesterday = LocalDate.now().minusDays(1);

	        // 어제 날짜 데이터 가져오기
	        sql = "SELECT * FROM board1 WHERE DATE(wDate) = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setDate(1, Date.valueOf(yesterday));
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            vo = new Board1VO();
	            vo.setBoardIdx(rs.getInt("boardIdx"));
	            vo.setMid(rs.getString("mid"));
	            vo.setNickName(rs.getString("nickName"));
	            vo.setTitle(rs.getString("title"));
	            vo.setContent(rs.getString("content"));
	            vo.setHostIp(rs.getString("hostIp"));
	            vo.setwDate(rs.getString("wDate"));
	            vo.setLevel(rs.getInt("level"));
	        } else {
	        	return setBoard1Content(idx);
	        }
	    } catch (SQLException e) {
	        System.out.println("SQL 오류: " + e.getMessage());
	    } finally {
	        getConn.rsClose();
	    }
	    return vo;
	}

	// 게시글 1건 가져오기
	public Board1VO getBoard1PastContent(int idx) {
		Board1VO vo = new Board1VO();
		try {
			sql = "select * from board1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setBoardIdx(rs.getInt("boardIdx"));
            vo.setMid(rs.getString("mid"));
            vo.setNickName(rs.getString("nickName"));
            vo.setTitle(rs.getString("title"));
            vo.setContent(rs.getString("content"));
            vo.setHostIp(rs.getString("hostIp"));
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
			sql = "select count(idx) as cnt from board where date_format(wDate, '%Y-%m-%d') = curdate()";
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
				vo.setLevel(rs.getInt("Level"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setImage(rs.getString("image"));
				vo.setHostIp(rs.getString("hostIp"));
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
				sql = "select * from board1 order by idx desc limit ?,?";
//				sql = "select *, datediff(wDate, now()) as day_diff,timestampdiff(hour, wDate, now()) as hour_diff from"
//						+ " board1 where date_format(wDate, '%Y-%m-%d') = curdate() order by idx desc limit ?,?";
//				sql = "select *, datediff(wDate, now()) as day_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
//						+ "(select count(*) from boardReply where boardIdx = b.idx) replyCount "
//						+ "from board b order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new Board1VO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setLevel(rs.getInt("level"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
//					vo.setImage(rs.getString("image"));
					vo.setHostIp(rs.getString("hostIp"));
					vo.setwDate(rs.getString("wDate"));
					
//					vo.setHour_diff(rs.getInt("hour_diff"));
//					vo.setDay_diff(rs.getInt("day_diff"));
					
//					vo.setReplyCount(rs.getInt("replyCount"));
					
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
}