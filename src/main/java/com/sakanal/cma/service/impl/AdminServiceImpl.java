package com.sakanal.cma.service.impl;

import com.sakanal.cma.dao.AdminMapper;
import com.sakanal.cma.pojo.Admin;
import com.sakanal.cma.pojo.AdminExample;
import com.sakanal.cma.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(String id, String password) {
        if (id!=null && !id.equals("")){
            if (password!=null && !password.equals("")){
                AdminExample adminExample = new AdminExample();
                adminExample.createCriteria().andAdminIdEqualTo(Integer.valueOf(id)).andAdminPasswordEqualTo(password);
                List<Admin> admins = adminMapper.selectByExample(adminExample);
                if (admins!=null && admins.size()==1){
                    return admins.get(0);
                }
            }
        }
        return null;
    }

    @Override
    public boolean checkAdminPassword(String id, String password) {
        if (id!=null && !id.equals("")){
            Admin admin = adminMapper.selectByPrimaryKey(Integer.valueOf(id));
            if (admin!=null && admin.getAdminPassword()!=null && !admin.getAdminPassword().equals("")){
                return admin.getAdminPassword().equals(password);
            }
        }
        return false;
    }

    @Override
    public boolean updateAdminPassword(String id, String password) {
        if (id!=null && !id.equals("")){
            if (password!=null && !password.equals("")){
                Admin admin = new Admin();
                admin.setAdminId(Integer.valueOf(id));
                admin.setAdminPassword(password);
                int i = adminMapper.updateByPrimaryKeySelective(admin);
                return i!=0;
            }
        }
        return false;
    }
}
