package board1;

public class Board1VO {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String wDate;
	private int memberIdx;
	// 날짜 차이 계산
	private int day_diff;	// 1일 차이
	private int hour_diff;	// 24시간 차이
	
	// 이전글 / 다음글
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	private int level;
	private int replyCount; // 댓글 개수

	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getDay_diff() {
		return day_diff;
	}
	public void setDay_diff(int day_diff) {
		this.day_diff = day_diff;
	}
	public int getHour_diff() {
		return hour_diff;
	}
	public void setHour_diff(int hour_diff) {
		this.hour_diff = hour_diff;
	}
	public int getPreIdx() {
		return preIdx;
	}
	public void setPreIdx(int preIdx) {
		this.preIdx = preIdx;
	}
	public int getNextIdx() {
		return nextIdx;
	}
	public void setNextIdx(int nextIdx) {
		this.nextIdx = nextIdx;
	}
	public String getPreTitle() {
		return preTitle;
	}
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}
	public String getNextTitle() {
		return nextTitle;
	}
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	
	@Override
	public String toString() {
		return "Board1VO [idx=" + idx + ", boardIdx=" + boardIdx + ", mid=" + mid + ", nickName=" + nickName
				+ ", title=" + title + ", content=" + content + ", wDate=" + wDate + ", memberIdx=" + memberIdx
				+ ", day_diff=" + day_diff + ", hour_diff=" + hour_diff + ", preIdx=" + preIdx + ", nextIdx=" + nextIdx
				+ ", preTitle=" + preTitle + ", nextTitle=" + nextTitle + ", level=" + level + ", replyCount="
				+ replyCount + "]";
	}
}
