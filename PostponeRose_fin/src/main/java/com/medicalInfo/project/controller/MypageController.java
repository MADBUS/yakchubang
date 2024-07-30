package com.medicalInfo.project.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.medicalInfo.project.model.CommentDTO;
import com.medicalInfo.project.model.KakaoDTO;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.model.PageDTO;
import com.medicalInfo.project.model.QaDTO;
import com.medicalInfo.project.model.QaRatingMixDTO;
import com.medicalInfo.project.model.Ratedtable_type;
import com.medicalInfo.project.model.RatingDTO;
import com.medicalInfo.project.service.BestExpertService;
import com.medicalInfo.project.service.CommentService;
import com.medicalInfo.project.service.MemberService;
import com.medicalInfo.project.service.PrescriptDetailService;
import com.medicalInfo.project.service.PrescriptService;
import com.medicalInfo.project.service.QaService;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/*")
@RequiredArgsConstructor
@Log4j
public class MypageController {
	
	private final BestExpertService bestExpertService;
	private final PrescriptService prescriptSevice;
	private final PrescriptDetailService prescriptDetailService;
	private final CommentService commentService;
	private final MemberService memberService;
	private final QaService qaService;

	// comment 작성
	@PostMapping("/mypage/write")
	public String write(CommentDTO commentDTO, RedirectAttributes rttr, HttpSession session) {
		log.info("MypageController write >>>");
		commentService.preWrite(commentDTO);

		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController write 이거찍힘?" + membertype);

		return "redirect:/mypage/prescriptDetail?prescript_no="+commentDTO.getPrescript_no();
	}

	// 마이페이지(환자), 처방전 목록 화면으로 이동
	@GetMapping("/mypage/patientMypage")
	public void preList(HttpSession session, Model model, Criteria cri) {
		log.info("MypageController prelist >>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController listAll  membertype 이거찍힘?" + membertype);
		cri.setType("all");
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController preList dto :" + dto);
		int memberNum = dto.getMemberNum();
		
		cri.setMemberNum(memberNum);
		
		System.out.println("preList prescriptCri 찍히니?" + cri);
		
		int total = prescriptSevice.getTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		
		log.info("<<< list out >>>");
		log.info(total);
		log.info("이거 잘찍혀?"+pageResult.toString());
		model.addAttribute("prescript", prescriptSevice.listAll(cri));
		System.out.println("prescript model 찍혀?? " + model);

	}
	
	@PostMapping("/mypage/getPatientMypage")
	@ResponseBody
	public List<PrescriptDTO> preListTest(HttpSession session, Model model, Criteria cri, PrescriptDTO prescript) {
		log.info("Ajax로 전체 게시글 조회 >>>");
		
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController preListTest  membertype 이거찍힘?" + membertype);
		cri.setType("all");
		
		System.out.println("preListTest 이거잘못받아왔지?"+cri);
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController preListTest dto :" + dto);
		int memberNum = dto.getMemberNum();

		cri.setMemberNum(memberNum);

		System.out.println("이거잘못받아왔지2222"+cri);
		
		int total = prescriptSevice.getTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		
		model.addAttribute("prescript", prescriptSevice.listAll(cri));
		
		log.info("<<< preListTest list out >>>");
		log.info(total);
		log.info("이거 잘찍혀?"+pageResult.toString());
		
		return prescriptSevice.listAll(cri);
	}
	
	// 마이페이지(환자), 처방전 목록 화면으로 이동
	@GetMapping("/mypage/prescript")
	public void prescriptList(HttpSession session, Model model, Criteria cri) {
		log.info("MypageController prescriptList >>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController listAll  membertype 이거찍힘?" + membertype);
		cri.setType("all");
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController prescriptList dto :" + dto);
		int memberNum = dto.getMemberNum();
		
		cri.setMemberNum(memberNum);
		
		System.out.println("prescriptList prescriptCri 찍히니?" + cri);
		
		int total = prescriptSevice.getTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		
		log.info("<<< prescriptList list out >>>");
		log.info(total);
		log.info("이거 잘찍혀?"+pageResult.toString());
		model.addAttribute("prescript", prescriptSevice.listAll(cri));
		System.out.println("prescript model 찍혀?? " + model);

	}

	// 처방전 상세보기 화면으로 이동
	@GetMapping("/mypage/prescriptDetail")
	public void read(@RequestParam("prescript_no") int prescript_no, Model model, HttpSession session) {
		log.info("PrescriptController read >>>");
		model.addAttribute("dto", prescriptSevice.get(prescript_no));
		model.addAttribute("detaillist", prescriptDetailService.selectPrescript(prescript_no));
		model.addAttribute("commentdto", commentService.preGetComment(prescript_no));
		model.addAttribute("commentlist", commentService.preSelectComment(prescript_no));
		log.info("MypageController read model >>>" + model);

		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController read 이거찍힘?" + membertype);
	}

	// 처방전 수정 화면으로 이동
	@GetMapping("/mypage/prescriptDetailModify")
	public void readContent(@RequestParam("prescript_no") int prescript_no,
			@RequestParam("comment_id") int comment_id, Model model, HttpSession session) {
		log.info("MypageController read >>>");
		System.out.println("commentid 받아짐?" + comment_id);
		model.addAttribute("dto", prescriptSevice.get(prescript_no));
		model.addAttribute("detaillist", prescriptDetailService.selectPrescript(prescript_no));
		model.addAttribute("commentsdto", commentService.preGetComment(comment_id));
		model.addAttribute("commentlist", commentService.preSelectComment(prescript_no));
		log.info("MypageController read model >>>" + model);

		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController readContent 이거찍힘?" + membertype);
	}

	// comment 수정
	@PostMapping("/mypage/modify")
	public String modify(CommentDTO commentDTO, RedirectAttributes rttr, HttpSession session) {
		log.info("PrescriptController modify >>>");
		System.out.println("이거 들어있음?" + commentDTO);
		int row = commentService.modify(commentDTO);
		if (row == 1) {
			rttr.addAttribute("result", "success");
		}

		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController modify 이거찍힘?" + membertype);

		return "redirect:/mypage/prescriptDetail?prescript_no=" + commentDTO.getPrescript_no() + "&comment_id="
				+ commentDTO.getComment_id() + "#modifyContent";
	}
	
	// comment 수정
	@PostMapping("/mypage/remove")
	public String remove(CommentDTO commentDTO, RedirectAttributes rttr, HttpSession session) {
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController remove 이거찍힘?" + membertype);
		
		
		
		log.info("preRemove 이거 들어있음? >>>" + commentDTO);
		int row = commentService.preRemove(commentDTO);
		if (row == 1) {
			rttr.addAttribute("result", "success");
		}
		return "redirect:/mypage/prescriptDetail?prescript_no="+commentDTO.getPrescript_no()+"&comment_id="+commentDTO.getComment_id();
	}
	
	// comment 별점
	@GetMapping("/mypage/addRate")
    @ResponseBody
    public void addGetRate(@RequestParam("prescript_no") int prescript_no, Model model, RatingDTO ratingDTO, RedirectAttributes rttr, HttpSession session) {
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController addGetRate membertype 이거찍힘?" + membertype);
		model.addAttribute("dto", prescriptSevice.get(prescript_no));
        log.info("addRate 이거 들어있음? >>>" + ratingDTO);
        prescriptDetailService.addRate(ratingDTO);
    }
	
	// comment 별점
		@PostMapping("/mypage/addRate")
	    @ResponseBody
	    public boolean addRate(Model model, RedirectAttributes rttr, HttpSession session,@RequestParam("rate")int rate, 
	    	@RequestParam("memberNum") int memberNum,@RequestParam("ratedtable_type") String ratedtable_Type,@RequestParam("membertype")String memberType,
	    	@RequestParam("ratedtprescript_no")int ratedtprescript_no,@RequestParam("expertNum") int expertNum,@RequestParam("expertype") String expertType ){
			RatingDTO ratingdto = new RatingDTO(expertNum, memberNum, ratedtprescript_no, rate); 
			System.out.println("ratingdto<<<"+ratingdto);
	    	int cntPrescriptRating = prescriptDetailService.MyPrescriptRating(ratingdto);
	    	System.out.println("cntPrescriptRating>>>>>"+cntPrescriptRating);
	    	
	    	if(cntPrescriptRating == 0) {
	    		MemberType expertype= commentService.expertmemtype(expertNum);
	    		Ratedtable_type ratedtable_type = null;
	    		if(ratedtable_Type.equals("PRESCRIPT")) {
	        		ratedtable_type = ratedtable_type.PRESCRIPT;
	        	}
	    		MemberType membertype = null;
	        	if(memberType.equals("PATIENT")) {
	        		membertype = membertype.PATIENT;
	        	}else if(memberType.equals("EXPERT")) {
	        		membertype = membertype.EXPERT;
	        	}
	        	
	        	RatingDTO RatingDTO = new RatingDTO(memberNum, membertype, ratedtprescript_no, rate, expertype, expertNum);
	        	System.out.println(">>>>>>"+RatingDTO);
	        	commentService.prescriptRating(RatingDTO);
	        	
	        	return true;
	    	}else {
	    		return false;
	    	}
			
			
	    }
	
	
	
	
	
	
	
	
	// MyQa문의 controller
	
	@GetMapping("/mypage/myQa")
	public void myQa(Model model, HttpSession session, Criteria cri) {
		System.out.println(">>>>>>>> MypageController getMyQa >>>>>>>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController getMyQa membertype 이거찍힘?" + membertype);
		
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		System.out.println("MypageController getMyQa dto? " + dto);
		int member_num = dto.getMemberNum();
		
		

		cri.setMember_num(member_num);

		System.out.println("MypageController prescriptCri"+cri);
		
		int total = qaService.getQaTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("qaPageMaker", pageResult);
		
        model.addAttribute("myQaList", qaService.getMyQaList(cri));
    }
	
	@PostMapping("/mypage/getMyQa")
	@ResponseBody
	public List<QaDTO> getMyQa(Model model, HttpSession session, Criteria cri) {
		System.out.println(">>>>>>>> MypageController getMyQa >>>>>>>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController getMyQa membertype 이거찍힘?" + membertype);
		
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		System.out.println("MypageController getMyQa dto? " + dto);
		int member_num = dto.getMemberNum();
		
		

		cri.setMember_num(member_num);

		System.out.println("MypageController prescriptCri"+cri);
		
		int total = qaService.getQaTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		System.out.println("pageResult>>>>"+pageResult);
		model.addAttribute("qaPageMaker", pageResult);
		
        model.addAttribute("myQaList", qaService.getMyQaList(cri));
        return qaService.getMyQaList(cri);
    }

	
	
	
	
	
	
	
	// EXPERT controller
	
	// 마이페이지(전문가), 처방전 목록 화면으로 이동
	@GetMapping("/mypage/expertMypage")
	public void expertpreList(HttpSession session, Model model, Criteria cri) {
		log.info("MypageController prelist >>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController listAll  membertype 이거찍힘?" + membertype);
		cri.setType("all");
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController preList dto :" + dto);
		int memberNum_expert = dto.getMemberNum();
		int memberNum = dto.getMemberNum();
		
		cri.setMemberNum(memberNum);
		cri.setMemberNum_expert(memberNum_expert);
		
		System.out.println("preList prescriptCri 찍히니?" + cri);
		
		int total = prescriptSevice.getExpertTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("expertPageMaker", pageResult);
		
		log.info("<<< list out >>>");
		log.info(total);
		log.info("이거 잘찍혀?"+pageResult.toString());
		model.addAttribute("prescript", prescriptSevice.expertListAll(cri));
		System.out.println("prescript model 찍혀?? " + model);
		
		// 나의 평균평점
		MemberDTO memberDTO =(MemberDTO) session.getAttribute("member_info");
		System.out.println("나의정보 memberDTO"+memberDTO.getMemberNum());
		model.addAttribute("myAvgRating",bestExpertService.myAvgRating(memberDTO.getMemberNum()));
		
		// 나의 평균평점 리스트
		System.out.println("컨트롤로 나의평점리스트: "+bestExpertService.myQaRating(memberDTO.getMemberNum()));
		List<QaRatingMixDTO> qaratingdto = new ArrayList<>();
		List<RatingDTO> listRating = bestExpertService.myQaRating(memberDTO.getMemberNum());
		
		for(int i=0; i< listRating.size();i++){
			QaDTO qadto	=  qaService.getQadtoByQaNo(listRating.get(i).getRatedqa_no());
			System.out.println("qadto>>"+qadto);
			RatingDTO ratingdto = listRating.get(i);
			System.out.println("ratingdto>>"+ratingdto);
			QaRatingMixDTO qaMixDto = new QaRatingMixDTO();	
			qaMixDto.setQadto(qadto);
			qaMixDto.setRatingdto(ratingdto);
			System.out.println("qaMixDto>>"+qaMixDto);
			qaratingdto.add(qaMixDto);
			System.out.println("qaratingdto<<<<"+qaratingdto);
			
		}
		model.addAttribute("myQaMixList", qaratingdto);
		
		List<QaRatingMixDTO> mixDTO = new ArrayList<>();
		List<RatingDTO> listPrescriptRating = bestExpertService.myPrescriptRating(memberDTO.getMemberNum());
		
		for(int j=0;j<listPrescriptRating.size();j++) {
			PrescriptDTO prescriptdto = qaService.getPrescriptdtoByNo(listPrescriptRating.get(j).getRatedtprescript_no());
			System.out.println("prescriptdto>>"+prescriptdto);
			RatingDTO Ratingdto = listPrescriptRating.get(j);
			System.out.println("Ratingdto>>"+Ratingdto);
			QaRatingMixDTO qaRatingMixDto = new QaRatingMixDTO();
			qaRatingMixDto.setPrescriptdto(prescriptdto);
			qaRatingMixDto.setRatingdto(Ratingdto);
			System.out.println("qaRatingMixDto>>"+qaRatingMixDto);
			mixDTO.add(qaRatingMixDto);
			model.addAttribute("myPrescriptList", mixDTO);
			System.out.println("mixDTO<<<<"+mixDTO);
		}
	}
	
	
	
	@PostMapping("/mypage/getExpertMypage")
	@ResponseBody
	public List<PrescriptDTO> expertPreListTest(HttpSession session, Model model, Criteria cri, PrescriptDTO prescript) {
		log.info("Ajax로 전체 게시글 조회 >>>");
		
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController preListTest  membertype 이거찍힘?" + membertype);
		cri.setType("all");
		
		System.out.println("preListTest 이거잘못받아왔지?"+cri);
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController preListTest dto :" + dto);
		int memberNum_expert = dto.getMemberNum();
		int memberNum = dto.getMemberNum();
		
		cri.setMemberNum(memberNum);
		cri.setMemberNum_expert(memberNum_expert);

		System.out.println("이거잘못받아왔지2222"+cri);
		
		int total = prescriptSevice.getExpertTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("expertPageMaker", pageResult);
		
		model.addAttribute("expertPrescript", prescriptSevice.expertListAll(cri));
		
		log.info("<<< preListTest list out >>>");
		log.info(total);
		log.info("이거 잘찍혀?"+pageResult.toString());
		
		return prescriptSevice.expertListAll(cri);
	}
	
	// 처방전 상세보기 화면으로 이동
	@GetMapping("/mypage/expertPrescriptDetail")
	public void expertRead(@RequestParam("prescript_no") int prescript_no, Model model, HttpSession session) {
		log.info("PrescriptController read >>>");
		model.addAttribute("dto", prescriptSevice.get(prescript_no));
		model.addAttribute("detaillist", prescriptDetailService.selectPrescript(prescript_no));
		model.addAttribute("commentdto", commentService.preGetComment(prescript_no));
		model.addAttribute("commentlist", commentService.preSelectComment(prescript_no));
		log.info("MypageController read model >>>" + model);

		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController read 이거찍힘?" + membertype);
	}

	@GetMapping("/mypage/memberEdit")
	public void memberEdit(HttpSession session, Model model, Criteria cri) {
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController memberEdit 이거찍힘?" + membertype);
		
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController memberEdit memberDTO :" + memberDTO);
		int memberNum = memberDTO.getMemberNum();
		System.out.println("MypageController expertRead memberNum 이거찍힘?" + memberNum);
		String memId = memberDTO.getMemberId();
		String memAddress = memberDTO.getMemberAddress();
		String memPhone = memberDTO.getMemberPhone();
		
		model.addAttribute("memId", memId);
		model.addAttribute("memAddress", memAddress);
		model.addAttribute("memPhone", memPhone);
	
		MemberInfoDTO memberInfoDTO = memberService.getMemberInfo(memberNum);
		log.info("MypageController memberEdit memberInfoDTO :" + memberInfoDTO);
		session.setAttribute("member", memberInfoDTO);
		
		String memberEmail = memberDTO.getMemberEmail();
		MemberDTO memDto = memberService.getMember(memberEmail);
		session.setAttribute("memberDto", memDto);
	}
	
	@PostMapping("/mypage/edit")
	public String membEdit(@RequestParam("memberAddress")String memberAddress, @RequestParam("memberPhone") String memberPhone, 
			HttpSession session, Model model, Criteria cri, RedirectAttributes rttr) {
		System.out.println("membEdit 여기에 들어오냐?");
		
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member_info");
		log.info("MypageController memberEdit memberDTO :" + memberDTO);
		int memberNum = memberDTO.getMemberNum();
		System.out.println("MypageController expertRead memberNum 이거찍힘?" + memberNum);
		
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController membEdit 이거찍힘?" + membertype);
		MemberDTO dto = new MemberDTO();
		dto.setMemberAddress(memberAddress);
		dto.setMemberPhone(memberPhone);
		dto.setMemberNum(memberNum);
		System.out.println("dto체크"+dto.toString());

		memberService.updateMember(dto);
		return "redirect:/mypage/patientMypage";
	}
	
	// comment 수정
	@PostMapping("/mypage/withdraw")
	public String withdraw(MemberDTO memberDTO, RedirectAttributes rttr, HttpSession session) {
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController withdraw 이거찍힘?" + membertype);
		int memberNum = memberDTO.getMemberNum();
		System.out.println("MypageController withdraw memberNum 찍힘?" + memberNum);
		
		log.info("withdraw 이거 들어있음? >>>" + memberDTO);
		int row = memberService.withdraw(memberDTO);
		if (row == 1) {
			rttr.addAttribute("result", "success");
		}
		return "redirect:/logout";
	}
	
	@GetMapping("/mypage/expertMyQaComment")
	public void expertQaComment(Model model, HttpSession session, Criteria cri) {
		System.out.println(">>>>>>>> MypageController expertQaComment >>>>>>>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController expertQaComment membertype 이거찍힘?" + membertype);
		
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		System.out.println("MypageController expertQaComment dto? " + dto);
		int member_num = dto.getMemberNum();
		
		cri.setMember_num(member_num);

		System.out.println("MypageController cri"+cri);
		
		int total = qaService.getQaCommentTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("qaCommentPageMaker", pageResult);
		
        model.addAttribute("qaCommentList", qaService.getQaCommentList(cri));
    }
	
	
	@PostMapping("/mypage/getExpertMyQaComment")
	@ResponseBody
	public List<CommentDTO> getExpertQaComment(Model model, HttpSession session, Criteria cri) {
		System.out.println(">>>>>>>> MypageController getExpertQaComment >>>>>>>>");
		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController getExpertQaComment membertype 이거찍힘?" + membertype);
		
		
		MemberDTO dto = (MemberDTO) session.getAttribute("member_info");
		System.out.println("MypageController getExpertQaComment dto? " + dto);
		int member_num = dto.getMemberNum();

		cri.setMember_num(member_num);

		System.out.println("MypageController cri"+cri);
		
		int total = qaService.getQaCommentTotal(cri);

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("qaCommentPageMaker", pageResult);
		
        model.addAttribute("qaCommentList", qaService.getQaCommentList(cri));
        return qaService.getQaCommentList(cri);
    }

	
}
