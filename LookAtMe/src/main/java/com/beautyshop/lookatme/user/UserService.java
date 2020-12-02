package com.beautyshop.lookatme.user;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.FileUtils;
import com.beautyshop.lookatme.SecurityUtils;
import com.beautyshop.lookatme.user.model.UserDMI;
import com.beautyshop.lookatme.user.model.UserPARAM;

@Service
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	
//	@Autowired
//	private ShopMapper shopMapper;

	// 1번 로그인 성공, 2번 아이디 없음, 3번 비번 틀림
		public int login(UserPARAM param) {
			String input_id = param.getUser_id();
			if(input_id.equals("")) {
				return Const.NO_ID; // 2
			}
			UserDMI dbUser = userMapper.selUser(param);
			
			if(dbUser == null) {
				return Const.NO_ID; // 2
			}
			
			String salt = dbUser.getSalt();
			String encrypt_input_pw = SecurityUtils.getEncrypt(param.getUser_pw(), salt);
			
			if(!encrypt_input_pw.equals(dbUser.getUser_pw())) {
				return Const.NO_PW; // 3
			} 
			param.setI_user(dbUser.getI_user());
			param.setUser_pw(null);
			param.setNm(dbUser.getNm());
			param.setProfile_img(dbUser.getProfile_img());
			return Const.SUCCESS; // 1
		
		}
		
		public int join(UserPARAM param, MultipartHttpServletRequest mr) {
			try {
				String pw = param.getUser_pw();
				String salt = SecurityUtils.generateSalt();
				String cryptPw = SecurityUtils.getEncrypt(pw, salt);
				
				param.setSalt(salt);
				param.setUser_pw(cryptPw);
				
				int result = userMapper.insUser(param);
				
				if(result == 1) {
					MultipartFile mf = mr.getFile("user_profile");
					
					if(!mf.isEmpty()) {
						int i_user = userMapper.selUser(param).getI_user();
						param.setI_user(i_user);
						
						String path = Const.realPath + "/resources/img/user/" + i_user + "/";
						String originFileNm = mf.getOriginalFilename();
						String ext = FileUtils.getExt(originFileNm);
						String saveFileNm = UUID.randomUUID() + ext;
						
						mf.transferTo(new File(path + saveFileNm));
						param.setProfile_img(saveFileNm);
						
						userMapper.updUser(param);
					}
				}
				
				return result;				
			}catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
		}

}
