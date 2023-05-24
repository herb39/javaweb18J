package board1;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import board.BoardVO;
import conn.GetConn;

public class Board1DAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	Board1VO vo = null;
	

	public Board1VO getBoard1Content(int idx) {
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
	            sql = "INSERT INTO board1 (boardIdx, mid, nickName, title, content, hostIp, wDate) VALUES (?,?,?,?,?,?,?)";
	            pstmt = conn.prepareStatement(sql);

	            // board1 테이블에 추가할 레코드의 값 설정
	            pstmt.setInt(1, boardIdx);
	            pstmt.setString(2, rs.getString("mid"));
	            pstmt.setString(3, rs.getString("nickName"));
	            pstmt.setString(4, rs.getString("title"));
	            pstmt.setString(5, rs.getString("content"));
	            pstmt.setString(6, rs.getString("hostIp"));
	            pstmt.setString(7, rs.getString("wDate"));
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
	        }

	        // 리소스 정리
	        rs.close();
	    } catch (SQLException e) {
	        System.out.println("SQL 오류: " + e.getMessage());
	    } finally {
	        getConn.rsClose();
	    }
	    return vo;
	}



}
