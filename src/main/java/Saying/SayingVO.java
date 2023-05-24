package Saying;

public class SayingVO {
	private int idx;
	private String image;
	private String content;
	private String name;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "SayingVO [idx=" + idx + ", image=" + image + ", content=" + content + ", name=" + name + "]";
	}
}
