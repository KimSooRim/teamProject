package com.ojo.spring;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.ojo.dao.LoginDAO;
import com.ojo.dao.MainPageDAO;
import com.ojo.dao.MyPageDAO;
import com.ojo.dao.PostTblDAO;
import com.ojo.sns.KakaoLoginBO;
import com.ojo.sns.NaverLoginBO;
import com.ojo.vo.AddressVO;
import com.ojo.vo.ChattblVO;
import com.ojo.vo.DongtblVO;
import com.ojo.vo.PostimageVO;
import com.ojo.vo.PosttblVO;
import com.ojo.vo.RoomtblVO;
import com.ojo.vo.UsertblVO;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class HomeController {
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	/* KakaoLogin */
	@Autowired
	private KakaoLoginBO kakaoLoginBO;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private SqlSession SqlSession;

	@RequestMapping("/")
	public String start(Locale locale, Model model) {
		logger.info("start()");

		return "redirect:MYpage";
	}

	@RequestMapping(value = "main")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();

		// 로그아웃
		if (request.getParameter("remove") != null) {
			session.removeAttribute("userid");
		}

		// 로고클릭
		if (request.getParameter("clear") != null) {
			// System.out.println("클리어:" + request.getAttribute("clear"));
			session.setAttribute("session_gu", "강동구");
			session.setAttribute("session_search", "");
		}
		String usergu = "강남구";
		if (session.getAttribute("userid") != null) {
			logger.info("진입");
			String userid = (String) session.getAttribute("userid");
			MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
			UsertblVO vo = mapper.search_user(userid);
			usergu = vo.getUsergu();
			// logger.info("{}", vo);
		}
		// logger.info(usergu);

		// 검색값 session에 넣기
		if (request.getParameter("search") != null) {
			session.setAttribute("session_search", request.getParameter("search"));
		}

		// session에 검색값이 있을 경우
		ArrayList<PosttblVO> postlist = new ArrayList<PosttblVO>();
		if (session.getAttribute("session_search") != null) {
			String category = "";
			// 구, 카테고리
			if (request.getParameter("gu") == null && request.getParameter("category") == null) {
				session.setAttribute("session_gu", usergu);
			}
			if (request.getParameter("gu") != null) {
				session.setAttribute("session_gu", request.getParameter("gu"));
			}
			if (request.getParameter("category") != null) {
				category = request.getParameter("category");
			}
			String gu = (String) session.getAttribute("session_gu");
			String search = (String) session.getAttribute("session_search");

			if (category != "") {
				HashMap<String, String> hmap = new HashMap<String, String>();
				hmap.put("search", search);
				hmap.put("gu", gu);
				hmap.put("category", category);
				MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
				postlist = mapper.post_search_gu_category(hmap);

			} else {
				HashMap<String, String> hmap = new HashMap<String, String>();
				hmap.put("search", search);
				hmap.put("gu", gu);
				MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
				postlist = mapper.post_search_gu(hmap);
			}
		} else {
			String category = "";

			if (request.getParameter("gu") == null && request.getParameter("category") == null) {
				session.setAttribute("session_gu", usergu);
			}
			if (request.getParameter("gu") != null) {
				session.setAttribute("session_gu", request.getParameter("gu"));
			}
			if (request.getParameter("category") != null) {
				category = request.getParameter("category");
			}
			String gu = (String) session.getAttribute("session_gu");

			if (category != "") {
				HashMap<String, String> hmap = new HashMap<String, String>();
				hmap.put("category", category);
				hmap.put("gu", gu);
				MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
				postlist = mapper.post_gu_category(hmap);
			} else {
				HashMap<String, String> hmap = new HashMap<String, String>();
				hmap.put("gu", gu);
				MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
				postlist = mapper.post_gu(hmap);
			}
		}
		MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);

		ArrayList<String> postimages = new ArrayList<String>();
		for (PosttblVO vo : postlist) {
			PostimageVO postimage_vo = mapper.search_postimage(vo.getPostnum());
			postimages.add(postimage_vo.getFilename());
		}
		ArrayList<String> gulist = mapper.search_Gutbl();
		ArrayList<String> categorylist = mapper.search_Categorytbl();

		/*
		 * if (session.getAttribute("userid") != null) { String userid = (String)
		 * session.getAttribute("userid"); UsertblVO vo = mapper.search_user(userid);
		 * String userprofile = vo.getUserprofile(); model.addAttribute("userprofile",
		 * userprofile); logger.info("profile: {}", userprofile); }
		 */
		
		if (session.getAttribute("userid") != null) {
	         String userid = (String) session.getAttribute("userid");
	         UsertblVO vo = mapper.search_user(userid);
	         String userprofile = vo.getUserprofile();
	         model.addAttribute("userprofile", userprofile);
	         //logger.info("profile: {}", userprofile);
	         
	         //chat
	         String nickname = vo.getNickname();
	         // sell list
	         ArrayList<RoomtblVO> sell_room_list = mapper.find_seller_room(nickname);
	         // purchase list
	         ArrayList<RoomtblVO> purchase_room_list = mapper.find_purchaser_nick_room(nickname);
	         
	         model.addAttribute("user",vo);
	         model.addAttribute("sell_room_list",sell_room_list);
	         model.addAttribute("purchase_room_list",purchase_room_list);
	      }

		model.addAttribute("postlist", postlist);
		model.addAttribute("postimages", postimages);
		model.addAttribute("gulist", gulist);
		model.addAttribute("categorylist", categorylist);

		return "mainPage";

	}
	@ResponseBody
	   @RequestMapping(value = "loadChatting",produces = "application/text; charset=utf8")
	   public String loadChatting(HttpServletRequest request) {
	   
	      HttpSession session = request.getSession();
	      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
	      //String userid = (String) session.getAttribute("userid");
	      //UsertblVO vo = mapper.search_user(userid);
	      
	      //String nickname = vo.getNickname();
	      String room = request.getParameter("room");
	      
	      /*
	       * HashMap<String, String> hmap = new HashMap<String, String>();
	       * hmap.put("room",room);
	       */
	      
	      // Chattbl vo 리스트
	      List<ChattblVO> chatlist = mapper.read_chatting_room(room);
	      
	      
	      // 문자열형태의 JSON으로 파싱
	      // String 형태의 배열시작
	      String JSONlist = "[";
	      // Object -> Json String
	      ObjectMapper objectMapper = new ObjectMapper();
	      for(ChattblVO chat:chatlist) {
	         try {
	            String jsonStr = objectMapper.writeValueAsString(chat);
	            JSONlist += jsonStr+", ";
	         } catch (JsonProcessingException e) {
	            e.printStackTrace();
	         }
	      }
	      JSONlist = JSONlist.substring(0, JSONlist.length()-2);
	      JSONlist += "]";
	      
	      //logger.info("{}",JSONlist);
	      
	      return JSONlist;
	   }
	   @ResponseBody
	   @RequestMapping(value = "insert_chat")
	   public Map<String, String> insert_chat(@RequestBody Map<String, String> map) {
	      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
	      HashMap<String, String> hmap = (HashMap<String, String>) map;
	      logger.info("{}",map);
	      mapper.insert_chat(hmap);
	      
	      return hmap;
	   }
	

	@RequestMapping(value = "/loginPage", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginPage(Model model, HttpSession session) {
		
		/* 네아로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		/* 인증요청문 확인 */
		System.out.println("네이버:" + naverAuthUrl);
		/* 객체 바인딩 */
		model.addAttribute("urlNaver", naverAuthUrl);
		
		/* 카카오 URL */
		String kakaoAuthUrl = kakaoLoginBO.getAuthorizationUrl(session);
		System.out.println("카카오:" + kakaoAuthUrl);		
		model.addAttribute("urlKakao", kakaoAuthUrl);
		
		/* 생성한 인증 URL을 View로 전달 */
		return "loginPage";
	}
	
	@RequestMapping(value = "/callbackKakao", method = { RequestMethod.GET, RequestMethod.POST })
	public String callbackKakao(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("로그인 성공 callbackKako");
		OAuth2AccessToken oauthToken;
		oauthToken = kakaoLoginBO.getAccessToken(session, code, state);	
		// 로그인 사용자 정보를 읽어온다
		apiResult = kakaoLoginBO.getUserProfile(oauthToken);
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj;
		
		jsonObj = (JSONObject) jsonParser.parse(apiResult);
		JSONObject response_obj = (JSONObject) jsonObj.get("kakao_account");	
		JSONObject response_obj2 = (JSONObject) response_obj.get("profile");
		// 프로필 조회
		String email = (String) response_obj.get("email");
		String name = (String) response_obj2.get("nickname");
		// 세션에 사용자 정보 등록
		// session.setAttribute("islogin_r", "Y");
		session.setAttribute("signIn", apiResult);
		session.setAttribute("email", email);
		session.setAttribute("name", name);
		System.out.println("카카오: "+ apiResult);
		System.out.println("카카오: "+ email);
		System.out.println("카카오: "+ name);
		
		
		// 카카오 유저 DB에 저장
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");

	    Date now = new Date();
		
		  String id = (String) response_obj.get("email");
	      String password = "123456789";
	      String nickname = (String) response_obj2.get("nickname");
	      String gu = "강남구";
	      String dong = "신사동";
	      String opendate = sdf.format(now);
	      System.out.println(id);

	      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
	      
	      UsertblVO vo = new UsertblVO();
	      vo.setUserid(id);
	      vo.setUserpw(password);
	      vo.setNickname(nickname);
	      vo.setUsergu(gu);
	      vo.setUserdong(dong);
	      vo.setOpendate(opendate);
	      
	      mapper.userSignUp(vo);
	      System.out.println("1:" + vo);
	      

	      session.setAttribute("naver_id", id);
	      session.setAttribute("naver_pw", password);
	      System.out.println("완료");
	      
		return "callbackKakao";
	}
	
	@RequestMapping(value = "start")
	   public void start(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("start 완료");
		 HttpSession session = request.getSession();
		  String id = request.getParameter("id");
	      String password = request.getParameter("password");
	      HashMap<String, String> hmap = new HashMap<String, String>();
	      hmap.put("id", id);
	      hmap.put("password", password);
	      LoginDAO mapper = SqlSession.getMapper(LoginDAO.class);
	      int result = mapper.usercheck(hmap);
	      logger.info("{}", result);
	      if (result == 0) {
	         PrintWriter out;
	         try {
	            out = response.getWriter();
	            out.print("로그인실패");
	         } catch (IOException e) {
	            e.printStackTrace();
	         }
	      } else {
	         session.setAttribute("userid", id);
	         System.out.println("!!!!!!");
	      }
	   }
	      
	
	
	//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callbackNaver", method = { RequestMethod.GET, RequestMethod.POST })
			public String callbackNaver(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, 
					HttpServletRequest request, HttpServletResponse response)
					throws Exception {
				System.out.println("로그인 성공 callbackNaver");
				OAuth2AccessToken oauthToken;
		        oauthToken = naverLoginBO.getAccessToken(session, code, state);
		        //로그인 사용자 정보를 읽어온다.
			    apiResult = naverLoginBO.getUserProfile(oauthToken);
			    System.out.println("네이버gg:");
			    
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj;
				
				jsonObj = (JSONObject) jsonParser.parse(apiResult);
				JSONObject response_obj = (JSONObject) jsonObj.get("response");			
				// 프로필 조회
				String email = (String) response_obj.get("email");
				String name = (String) response_obj.get("name");
				// 세션에 사용자 정보 등록
				// session.setAttribute("islogin_r", "Y");
				session.setAttribute("signIn", apiResult);
				session.setAttribute("email", email);
				session.setAttribute("name", name);
				
				System.out.println("네이버:" + apiResult);
				System.out.println("네이버:" + email);
				System.out.println("네이버:" + name);
				
				// 네이버 유저 DB에 저장
				SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");

			    Date now = new Date();
				
				  String id = (String) response_obj.get("email");
			      String password = "123456789";
			      String nickname = (String) response_obj.get("name");
			      String gu = "강남구";
			      String dong = "신사동";
			      String opendate = sdf.format(now);
			      System.out.println(id);

			      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
			      
			      UsertblVO vo = new UsertblVO();
			      vo.setUserid(id);
			      vo.setUserpw(password);
			      vo.setNickname(nickname);
			      vo.setUsergu(gu);
			      vo.setUserdong(dong);
			      vo.setOpendate(opendate);
			      
			      mapper.userSignUp(vo);
			      System.out.println("1:" + vo);
			      

			      session.setAttribute("naver_id", id);
			      session.setAttribute("naver_pw", password);
			      
			      
				
		        /* 네이버 로그인 성공 페이지 View 호출 */
				return "callbackNaver";
			}

	


	@RequestMapping("/MYpage")
	public String MYpage(HttpServletRequest request, HttpServletResponse response, Model model) {
		logger.info("MYpage()");

		HttpSession session = request.getSession();
		MyPageDAO mapper = SqlSession.getMapper(MyPageDAO.class);
		if (session.getAttribute("userid") != null) {
			String userid = (String) session.getAttribute("userid");
			UsertblVO vo = mapper.search_user(userid);
			String userprofile = vo.getUserprofile();
			String usercontent = vo.getUsercontent();
			String nickname = vo.getNickname();
			String gu = vo.getUsergu();
			String dong = vo.getUserdong();
			model.addAttribute("usercontent", usercontent);
			model.addAttribute("userprofile", userprofile);
			model.addAttribute("nickname", nickname);
			model.addAttribute("gu", gu);
			model.addAttribute("dong", dong);
			logger.info("profile: {}", userprofile);
			logger.info("nickname: {}", nickname);
			logger.info("usercontent: {}", usercontent);
			logger.info("gu: {}", gu);
			logger.info("dong: {}", dong);
		}
		
	    ArrayList<String> gulist = mapper.search_Gutbl();
	    logger.info("구 목록:{}",gulist);
	    model.addAttribute("gulist", gulist);
	    
		return "MYpage";
	}
	
	@RequestMapping(value = "/update_content", method = { RequestMethod.GET, RequestMethod.POST })
	public String update_content(HttpServletRequest request, HttpServletResponse response, Model model, UsertblVO vo)throws Exception {
		logger.info("update_content()");
		
		MyPageDAO mapper = SqlSession.getMapper(MyPageDAO.class);
		HttpSession session = request.getSession();

		String usercontent = (String) vo.getUsercontent();
		String userid = (String) session.getAttribute("userid");
		
		mapper.updatecontent(usercontent, userid);
			
		return "redirect:MYpage";
		
	}

	@RequestMapping("/uploadAction")
	public String uploadAction(MultipartHttpServletRequest mpRequest, HttpServletRequest request, Model model)throws Exception {
		logger.info("uploadAction()");
		
		MyPageDAO mapper = SqlSession.getMapper(MyPageDAO.class);
		HttpSession session = request.getSession();
		
		String userprofile = FileUtil.updateImg(mpRequest);
		
		String userid = (String) session.getAttribute("userid");
		
		mapper.updateImg(userprofile, userid);
		System.out.println("1."+userprofile);
		
		
		
		return "redirect:MYpage";
	}
	
	@RequestMapping(value = "/updateuser", method = {RequestMethod.GET, RequestMethod.POST })
	public String updateuser(HttpServletRequest request, UsertblVO vo, Model model, RedirectAttributes rttr)throws Exception{
		logger.info("updateuser()");
		MyPageDAO mapper = SqlSession.getMapper(MyPageDAO.class);
		HttpSession session = request.getSession();

		String nickname = request.getParameter("nickname");
		String userpw = request.getParameter("userpw");
	    String gu = request.getParameter("gu");
	    String dong = request.getParameter("dong");
	    String userid = request.getParameter("userid");
	    System.out.println("1" + userid);
	    
	    vo.setUsergu(nickname);
	    vo.setUsergu(userpw);
	    vo.setUsergu(gu);
	    vo.setUserdong(dong);
	    vo.setUserid(userid);
	    mapper.updateuser(vo);

		System.out.println("vo" + vo);

		return "redirect:MYpage";
	}
	
	@RequestMapping("/detailPageOk")
	public String detailPageOk(HttpServletRequest request, Model model) {
		System.out.println("detailpageOk() 실행");
		HttpSession session = request.getSession();
		PostTblDAO mapper = SqlSession.getMapper(PostTblDAO.class);

		int postnum = Integer.parseInt(request.getParameter("postnum"));
//		System.out.println("넘어온 postnum: " + postnum);
//		int postnum = mapper.selectByPostnum();

		ArrayList<PostimageVO> images = mapper.selectByImages(postnum);
		PosttblVO vo = mapper.selectByContent(postnum);
		System.out.println(vo);
		System.out.println(images);

		model.addAttribute("images", images);
		model.addAttribute("vo", vo);
		model.addAttribute("postnum", postnum);

		return "detailPage";
	}

	@RequestMapping("/productUpload")

	public String AddressController(HttpServletRequest request, Model model) {
		System.out.println("productUpload 실행");
		PostTblDAO mapper = SqlSession.getMapper(PostTblDAO.class);

//		String gu = request.getParameter("gu");
//		System.out.println(gu);

		ArrayList<AddressVO> guList = mapper.selectGu();
		System.out.println(guList);

		model.addAttribute("guList", guList);
//		model.addAttribute("dongList", dongList);

		return "productUpload";

	}

	@ResponseBody
	@RequestMapping(value = "/address", produces = "application/text; charset=utf8")
	public String address(@RequestParam("gu") String gu, HttpServletRequest request, HttpServletResponse response,
			Model model) {

		PostTblDAO mapper = SqlSession.getMapper(PostTblDAO.class);

		System.out.println(gu);
		ArrayList<AddressVO> dongList = mapper.selectDong(gu);
		System.out.println(dongList);

		String str = "";

		for (AddressVO dong : dongList) {
			str += dong.getDong() + " ";
		}

		System.out.println(str);

		return str;
	}

	@RequestMapping("/prodcutUploadOk")
	public String prodcutUploadOk(MultipartHttpServletRequest request, HttpSession session, Model model, PosttblVO po, PostimageVO io) {
		System.out.println("productUploadOk()실행");

		PostTblDAO mapper = SqlSession.getMapper(PostTblDAO.class);
		List<MultipartFile> filelist = request.getFiles("uploadFile");
//		ArrayList<String> list = new ArrayList<String>();
		
//		업로드 하는 파일이 저장될 업로드 디렉토리를 지정한다.
		String rootUploadDir = "C:/Users/jack0/spring/sts-bundle/pivotal-tc-server/instances/base-instance/wtpwebapps/OJO2/WEB-INF/uploadImages/"; // 여기를 바꿔주면 되요!!
		String rootUploadDir2 = "C:/Users/jack0/spring/workspace/OJO2/src/main/webapp/WEB-INF/uploadImages/"; // 여기를 바꿔주면 되요!!
		
		
		System.out.println(rootUploadDir);
		File dir = new File(rootUploadDir);
		File dir2 = new File(rootUploadDir2);
		if(!dir.exists()) {
			dir.mkdir();
		}
		
		System.out.println(po);
		mapper.upload(po);
		int postnum = mapper.selectByPostnum();
		if (postnum == 0) {
			postnum = 1;
		}
		

		for(MultipartFile multipartFile : filelist) {
			String uploadFileName = multipartFile.getOriginalFilename();
			long filesize = multipartFile.getSize();
			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			String saveFile = uuid + "-" + uploadFileName;
			File file = new File(dir, saveFile);
			File file2 = new File(dir2, saveFile);
			
			System.out.println(file);
			
			try {
				multipartFile.transferTo(file);
				multipartFile.transferTo(file2);
				
				postnum = mapper.selectByPostnum();
				io.setFilename(saveFile);
				io.setFilerealname(uploadFileName);
				io.setPostnum(postnum);
				mapper.uploadImage(io);
				System.out.println(io);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	
		model.addAttribute("io", io);
		model.addAttribute("postnum", postnum);
		
		return "redirect:detailPageOk";
	
	}
	
	
	@RequestMapping("/updateProduct")
	public String updateProduct(HttpServletRequest request, Model model) {
		System.out.println("updateProduct() 실행");
		HttpSession session = request.getSession();
		PostTblDAO mapper = SqlSession.getMapper(PostTblDAO.class);
		
		int postnum = Integer.parseInt(request.getParameter("postnum"));
		//	System.out.println(postnum);
		
		PosttblVO vo = mapper.selectByContent(postnum);
		ArrayList<PostimageVO> io = mapper.selectByImages(postnum);
		System.out.println(vo);
		ArrayList<AddressVO> guList = mapper.selectGu();
		System.out.println(guList);

		model.addAttribute("guList", guList);
		model.addAttribute("vo", vo);
		model.addAttribute("io",io);
		
		
		return "updateProduct";
	}
	
	@RequestMapping("/updateProductOk")
	public String updateProductOk(MultipartHttpServletRequest request, HttpSession session ,Model model, PosttblVO po, PostimageVO io) {
		System.out.println("updateProductOk()실행");

		PostTblDAO mapper = SqlSession.getMapper(PostTblDAO.class);
		List<MultipartFile> filelist = request.getFiles("uploadFile");
		
		
//		ArrayList<String> list = new ArrayList<String>();
		
		ArrayList<PostimageVO> images = mapper.selectByImages(io.getPostnum());
		System.out.println("updateProduct: " + images);
		for (int  i = 0;  i < images.size();  i++) {
			String imageNum = "image" + images.get(i).getImageNum();
			System.out.println("폼이미지:" + request.getParameter(imageNum));
			if(request.getParameter(imageNum) == null) {
				mapper.deleteImg(images.get(i).getImageNum());
			}
			
		}
		if(request.getParameter("is_trade") != null) {
			po.setIstrade(1);
		}
		
//		업로드 하는 파일이 저장될 업로드 디렉토리를 지정한다.
//		String rootUploadDir = session.getServletContext().getRealPath("/"); // realPath 얻어줌.
		// String rootUploadDir = "C:\\uploadImage";
		String rootUploadDir = "C:/Users/jack0/spring/workspace/OJO2/src/main/webapp/WEB-INF/uploadImages/"; // 여기를 바꿔주면 되요!!
//		rootUploadDir += "\\WEB-INF\\uploadImages";
		System.out.println(rootUploadDir);
		
		File dir = new File(rootUploadDir);
		if(!dir.exists()) {
			dir.mkdir();
		}
		
		//System.out.println(po);
		//System.out.println(io);
		mapper.update(po);
		int postnum = mapper.selectByPostnum();
		if (postnum == 0) {
			postnum = 1;
		}
		
		//System.out.println(postnum);

		for(MultipartFile multipartFile : filelist) {
			String uploadFileName = multipartFile.getOriginalFilename();
			long filesize = multipartFile.getSize();
			UUID uuid = UUID.randomUUID();
			String saveFile = uuid + "-" + uploadFileName;
			String[] temp = saveFile.split("-");
			if(temp.length > 5) {
//				System.out.println("이미지 realname: " + temp[5]);
				File file = new File(dir, saveFile);
				try {
					multipartFile.transferTo(file);
					// File thumbnailFile = new File(dir, "S_" + saveFile);
					// Thumbnails.of(file).size(160, 160).toFile(thumbnailFile);
					postnum = mapper.selectByPostnum();
					// System.out.println(postnum);
					io.setFilename(saveFile);
					io.setFilerealname(uploadFileName);
					io.setPostnum(postnum);
					mapper.uploadImage(io);
					System.out.println(io);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
			//System.out.println("0번: " + temp[0] + "1번: " + temp[5]);
		
		model.addAttribute("io", io);
		model.addAttribute("postnum", postnum);
		
		return "redirect:detailPageOk";
		
		
	}
	
	@RequestMapping(value = "login")
	   public void login(HttpServletRequest request, HttpServletResponse response) {

	      HttpSession session = request.getSession();

	      String id = request.getParameter("id");
	      String password = request.getParameter("password");
	      HashMap<String, String> hmap = new HashMap<String, String>();
	      hmap.put("id", id);
	      hmap.put("password", password);
	      LoginDAO mapper = SqlSession.getMapper(LoginDAO.class);
	      int result = mapper.usercheck(hmap);
	      logger.info("{}", result);
	      if (result == 0) {
	         PrintWriter out;
	         try {
	            out = response.getWriter();
	            out.print("로그인실패");
	         } catch (IOException e) {
	            e.printStackTrace();
	         }
	      } else {
	         session.setAttribute("userid", id);
	      }
	   }

	   @RequestMapping(value = "signup")
	   public String signup(Model model) {
	      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
	      ArrayList<String> gulist = mapper.search_Gutbl();
	      model.addAttribute("gulist", gulist);
	      return "signUp";
	   }

	   @RequestMapping(value = "dongselect")
	   @ResponseBody
	   public void dongselect(HttpServletRequest request, HttpServletResponse response) {
	      String gu = request.getParameter("gu");
	      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
	      ArrayList<DongtblVO> donglistVO = mapper.search_Dongtbl(gu);
	      String str = "";
	      for (DongtblVO vo : donglistVO) {
	         str += vo.getDong() + " ";
	      }
	      PrintWriter out;

	      try {
	         out = response.getWriter();
	         out.print(str);
	      } catch (IOException e) {
	         e.printStackTrace();
	      }

	   }

	   @RequestMapping(value = "user_signup")
	   @ResponseBody
	   public void user_signup(HttpServletRequest request, HttpServletResponse response, Model model) {
	      SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");

	      Date now = new Date();

	      String id = request.getParameter("id");
	      String password = request.getParameter("password");
	      String nickname = request.getParameter("nickname");
	      String gu = request.getParameter("gu");
	      String dong = request.getParameter("dong");
	      String userprofile = request.getParameter("userprofile");
	      String opendate = sdf.format(now);

	      MainPageDAO mapper = SqlSession.getMapper(MainPageDAO.class);
	      Boolean a = (mapper.userIDCheck(id) == 1);
	      Boolean b = mapper.userNicknameCheck(nickname) == 1;
	      PrintWriter out;
	      try {
	         if (a) {
	            out = response.getWriter();
	            out.print("아이디중복");
	         }
	         if (b) {
	            out = response.getWriter();
	            out.print("닉네임중복");
	         }

	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	      
	      if(a || b) {
	         return;
	      }
	      UsertblVO vo = new UsertblVO();
	      vo.setUserid(id);
	      vo.setUserpw(password);
	      vo.setNickname(nickname);
	      vo.setUsergu(gu);
	      vo.setUserdong(dong);
	      vo.setOpendate(opendate);
	      
	      mapper.userSignUp(vo);
	      
	      try {
	         out = response.getWriter();
	         out.print("회원가입완료");
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }

}
