package Saying;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import conn.GetConn;

public class SayingDAO {
	// 싱글톤으로 선언된 DB연결객체(GetConn)을 연결한다.
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private String sql = "";

	SayingVO vo = null;

	
	
	// Saying 1건 가져오기 (랜덤 idx)
	public SayingVO getRandomSayingContent(int idx) {
        SayingVO vo = new SayingVO();
        try {
            sql = "select * from saying where idx = ?";
            pstmt = conn.prepareStatement(sql);

            // 랜덤한 int 값을 생성하여 idx에 할당
            Random random = new Random();
            int totalRows = 0;
            if (rs.next()) totalRows = rs.getInt("totalRows");
            int randomIdx = random.nextInt(totalRows) + 1;
            pstmt.setInt(1, randomIdx);
            rs = pstmt.executeQuery();
            rs.next();


            vo.setIdx(rs.getInt("idx"));
            vo.setImage(rs.getString("image"));
            vo.setContent(rs.getString("content"));
            vo.setName(rs.getString("name"));
        } catch (SQLException e) {
            System.out.println("SQL 오류: " + e.getMessage());
        } finally {
            getConn.rsClose();
        }
        return vo;
    }
}
