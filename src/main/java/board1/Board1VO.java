package board1;

public class Board1VO {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String hostIp;
	private String wDate;
	private int level;
	
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
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
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
    
	@Override
	public String toString() {
		return "Board1VO [idx=" + idx + ", boardIdx=" + boardIdx + ", mid=" + mid + ", nickName=" + nickName
				+ ", title=" + title + ", content=" + content + ", hostIp=" + hostIp + ", wDate=" + wDate + ", level="
				+ level + "]";
	}
}
