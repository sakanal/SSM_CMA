package com.sakanal.cma.dao;

import com.sakanal.cma.pojo.Admin;
import com.sakanal.cma.pojo.AdminExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AdminMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int countByExample(AdminExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int deleteByExample(AdminExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int deleteByPrimaryKey(Integer adminId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int insert(Admin record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int insertSelective(Admin record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    List<Admin> selectByExample(AdminExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    Admin selectByPrimaryKey(Integer adminId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int updateByExampleSelective(@Param("record") Admin record, @Param("example") AdminExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int updateByExample(@Param("record") Admin record, @Param("example") AdminExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int updateByPrimaryKeySelective(Admin record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cma_admin
     *
     * @mbggenerated Fri Apr 01 16:33:26 CST 2022
     */
    int updateByPrimaryKey(Admin record);
}