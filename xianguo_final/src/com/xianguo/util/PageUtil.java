package com.xianguo.util;

/**
 * Create on 2008-08-28 11:05
 * 
 * @author qpy_2006
 * Ҫ�õ���ҳ�����ڴ����������ʱ
 * ֻ���ڴ���rows��ǰ���µ���counter(page,rows)�����Ϳ�������firstRow��totalRows,totalPages
 * �ڲ�ѯ��dao�У��Ѹ��������Ϊ�������룬
 * ��ͨ�����ö����getFirstRow(),��getMaxSize()����
 */
public class PageUtil {

	private int totalRows;	// ���������ܼ�¼��
	private int totalPages;	// ��ҳ��
	private int currentPage = 1; // ��ǰҳ
	private int maxSize = 8; // ÿҳ���3����¼
	private int firstRow = 0; // ���ݿ��е�һ������

	/** Creates a new instance of PageCounter */
	public PageUtil() {
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getMaxSize() {
		return maxSize;
	}

	public void setMaxSize(int maxSize) {
		this.maxSize = maxSize;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	// �����������pageType��ҳ,������firstRow
	// �����������rows�ܼ�¼��������ҳ��
	public void counter(String pageType,int rows) {
		this.totalRows = rows;
		this.totalPages = (this.totalRows + this.maxSize - 1) / this.maxSize;
		System.out.println("counter �е�totalPages��ֵΪ "+this.totalPages+" ҳ");
		pageType = pageType.toLowerCase();
		if ("first".equals(pageType)) {
			first();
		} else if ("last".equals(pageType)) {
			last();
		} else if ("next".equals(pageType)) {
			next();
		} else if ("previous".equals(pageType)) {
			previous();
		}
	}

	// ��ҳ
	private void first() {
		currentPage = 1;
		firstRow = 0;
	}

	// ��ҳ
	private void previous() {
		if (totalPages == 0) {
			currentPage = 1;
		} else {
			if (currentPage == 1) {
				currentPage = totalPages;
			} else {
				currentPage--;
			}
		}
		firstRow = (currentPage - 1) * maxSize;
	}

	// ��ҳ
	private void next() {
		if (totalPages == 0) {
			currentPage = 1;
		} else {
			if (currentPage < totalPages) {
				currentPage++;
			} else if (currentPage == totalPages) {
				currentPage = 1;
			}
		}
		firstRow = (currentPage - 1) * maxSize;
	}

	// βҳ
	private void last() {
		currentPage = totalPages;
		if (totalPages == 0) {
			currentPage = 1;
		}
		firstRow = (currentPage - 1) * maxSize;
	}
}

