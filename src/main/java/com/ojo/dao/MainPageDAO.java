package com.ojo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.ojo.vo.ChattblVO;
import com.ojo.vo.DongtblVO;
import com.ojo.vo.PostimageVO;
import com.ojo.vo.PosttblVO;
import com.ojo.vo.RoomtblVO;
import com.ojo.vo.UsertblVO;

public interface MainPageDAO {

	int userIDCheck(String id);

	int userNicknameCheck(String nickname);

	void userSignUp(UsertblVO vo);

	UsertblVO search_user(String userid);

	ArrayList<String> search_Gutbl();

	ArrayList<String> search_Categorytbl();

	PostimageVO search_postimage(int postnum);

	ArrayList<PosttblVO> post_search_gu_category(HashMap<String, String> hmap);

	ArrayList<PosttblVO> post_search_gu(HashMap<String, String> hmap);

	ArrayList<PosttblVO> post_gu_category(HashMap<String, String> hmap);

	ArrayList<PosttblVO> post_gu(HashMap<String, String> hmap);
	ArrayList<DongtblVO> search_Dongtbl(String gu);
	
//	chat
	ArrayList<RoomtblVO> find_seller_room (String nickname);
	ArrayList<RoomtblVO> find_purchaser_nick_room (String nickname);
	ArrayList<ChattblVO> read_chatting_room(String room);
	void insert_chat(HashMap<String, String> hmap);
}
