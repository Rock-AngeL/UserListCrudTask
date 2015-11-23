package mvc.controller;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Created by Rock-AngeL on 13.11.15.
 */
public class PageStateInfo {
    private int pageNumber = 1;
    private int pageOffset = 0;
    private int rowsPerPage = 10;
    private String orderField = "id";
    private boolean orderFieldDesc = false;
    private String filterField = "";
    private String filterFieldValue = "";
    private boolean strictFilter = true;

    public static PageStateInfo getInstance(String jsonStr){
        ObjectMapper objectMapper = new ObjectMapper();
        PageStateInfo pageStateInfo = null;
        try {
            pageStateInfo = objectMapper.readValue(jsonStr, PageStateInfo.class);
        } catch (Exception e) {
            pageStateInfo = new PageStateInfo();
        }
        return pageStateInfo;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public int getRowsPerPage() {
        return rowsPerPage;
    }

    public void setRowsPerPage(int rowsPerPage) {
        this.rowsPerPage = rowsPerPage;
    }

    public String getOrderField() {
        return orderField;
    }

    public void setOrderField(String orderField) {
        this.orderField = orderField;
    }

    public String getFilterField() {
        return filterField;
    }

    public void setFilterField(String filterField) {
        this.filterField = filterField;
    }

    public int getPageOffset() {
        return pageOffset;
    }

    public void setPageOffset(int pageOffset) {
        this.pageOffset = pageOffset;
    }

    public String getFilterFieldValue() {
        return filterFieldValue;
    }

    public void setFilterFieldValue(String filterFieldValue) {
        this.filterFieldValue = filterFieldValue;
    }

    public boolean isStrictFilter() {
        return strictFilter;
    }

    public void setStrictFilter(boolean strictFilter) {
        this.strictFilter = strictFilter;
    }

    public boolean isOrderFieldDesc() {
        return orderFieldDesc;
    }

    public void setOrderFieldDesc(boolean orderFieldDesc) {
        this.orderFieldDesc = orderFieldDesc;
    }
}
