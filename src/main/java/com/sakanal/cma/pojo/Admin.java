package com.sakanal.cma.pojo;

public class Admin {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column cma_admin.admin_id
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    private Integer adminId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column cma_admin.admin_name
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    private String adminName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column cma_admin.admin_password
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    private String adminPassword;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column cma_admin.admin_authority
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    private Integer adminAuthority;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column cma_admin.admin_id
     *
     * @return the value of cma_admin.admin_id
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public Integer getAdminId() {
        return adminId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column cma_admin.admin_id
     *
     * @param adminId the value for cma_admin.admin_id
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column cma_admin.admin_name
     *
     * @return the value of cma_admin.admin_name
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public String getAdminName() {
        return adminName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column cma_admin.admin_name
     *
     * @param adminName the value for cma_admin.admin_name
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public void setAdminName(String adminName) {
        this.adminName = adminName == null ? null : adminName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column cma_admin.admin_password
     *
     * @return the value of cma_admin.admin_password
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public String getAdminPassword() {
        return adminPassword;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column cma_admin.admin_password
     *
     * @param adminPassword the value for cma_admin.admin_password
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword == null ? null : adminPassword.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column cma_admin.admin_authority
     *
     * @return the value of cma_admin.admin_authority
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public Integer getAdminAuthority() {
        return adminAuthority;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column cma_admin.admin_authority
     *
     * @param adminAuthority the value for cma_admin.admin_authority
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    public void setAdminAuthority(Integer adminAuthority) {
        this.adminAuthority = adminAuthority;
    }
}