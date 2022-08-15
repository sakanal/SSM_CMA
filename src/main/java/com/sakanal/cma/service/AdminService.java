package com.sakanal.cma.service;

import com.sakanal.cma.pojo.Admin;

public interface AdminService {
     Admin login(String id,String password);
     boolean checkAdminPassword(String id,String password);
     boolean updateAdminPassword(String id,String password);
}
