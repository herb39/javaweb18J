package board1;

public class Board1ReplyVO {
	private int idx;
	private int board1Idx;
	private String mid;
	private String nickName;
	private String content;
	private int good;
	private String wDate;
	private String oX;
	private int memberIdx;
	
	private int level;

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBoard1Idx() {
		return board1Idx;
	}
	public void setBoard1Idx(int board1Idx) {
		this.board1Idx = board1Idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public String getoX() {
		return oX;
	}
	public void setoX(String oX) {
		this.oX = oX;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	
	@Override
	public String toString() {
		return "Board1ReplyVO [idx=" + idx + ", board1Idx=" + board1Idx + ", mid=" + mid + ", nickName=" + nickName
				+ ", content=" + content + ", good=" + good + ", wDate=" + wDate + ", oX=" + oX + ", memberIdx="
				+ memberIdx + ", level=" + level + "]";
	}
}
