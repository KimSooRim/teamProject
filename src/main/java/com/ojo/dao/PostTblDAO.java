package com.ojo.dao;

import java.util.ArrayList;

import com.ojo.vo.AddressVO;
import com.ojo.vo.DongtblVO;
import com.ojo.vo.PostimageVO;
import com.ojo.vo.PosttblVO;

public interface PostTblDAO {

	ArrayList<PostimageVO> selectByImages(int postnum);

	PosttblVO selectByContent(int postnum);

	ArrayList<AddressVO> selectGu();

	ArrayList<AddressVO> selectDong(String gu);
	
	ArrayList<DongtblVO> search_Dongtbl(String gu);

	void upload(PosttblVO po);

	int selectByPostnum();

	void uploadImage(PostimageVO io);

	void update(PosttblVO po);

	void deleteImg(int i);




}
