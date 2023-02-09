package com.ojo.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ojo.vo.DongtblVO;
import com.ojo.vo.UsertblVO;

public interface MyPageDAO {

	UsertblVO search_user(String userid);

	UsertblVO usercontent(String usercontent);

	void updateImg(@Param("userprofile")String userprofile, @Param("userid")String userid);

	UsertblVO nickname(String nickname);

	ArrayList<String> search_Gutbl();

	ArrayList<DongtblVO> search_Dongtbl(String gu);

	void updatecontent(@Param("usercontent")String usercontent, @Param("userid")String userid);

	void updateuser(UsertblVO vo);


	
	









	
}
