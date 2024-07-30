package com.medicalInfo.project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.NoticeDTO;
import com.medicalInfo.project.model.PageDTO;
import com.medicalInfo.project.service.NoticeService;
import com.medicalInfo.project.service.QaService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class NoticeController {
	
	@Autowired
	private final NoticeService noticeService;
	@Autowired
	private final QaService qaService;

	@GetMapping("/notice") // 게시판 목록 조회
	public void allnotice(Model model,Criteria cri) {
		List<NoticeDTO> notices = noticeService.getNoticeList(cri);
		System.out.println("노티스 리스트: " + notices);
		model.addAttribute("allnotice", notices);
		
		int total = noticeService.noticeTotal(cri);
		log.info("total: "+total);
		
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		log.info("-------------- 페이징 --------------");
		log.info(pageResult);
	}
	
	@GetMapping("/noticedetail") // 게시글 상세보기
	public String noticedetail(@RequestParam("id_announcement") int id_announcement, Model model) {
		NoticeDTO notice = noticeService.getNoticeById(id_announcement);
		model.addAttribute("notice", notice);
		return "noticedetail";
	}
	
	@GetMapping("/noticewrite") // 게시글 작성
	public String noticewrite(Model model) {
		return "noticewrite";
	}
	
	@PostMapping("/insertnotice") // 게시글 등록
	public String insertnotice(@RequestParam("noticetitle") String noticetitle,
			 @RequestParam("noticecontent") String noticecontent, @RequestParam("writerName") String writerName,HttpSession session) {
		NoticeDTO notice = new NoticeDTO();
		MemberDTO memberdto = (MemberDTO)session.getAttribute("member_info");
		
		notice.setTitle(noticetitle);
		notice.setMember_num(memberdto.getMemberNum());
		notice.setWriterName(writerName);
		notice.setContent(noticecontent);
		noticeService.saveNotice(notice);
		System.out.println("notice 잘찍히나");
		return "redirect:/notice";
	}
	
	@GetMapping("/deletenotice") // 게시글 삭제
	public String deletenotice(@RequestParam("id_announcement") int id_announcement) {
		System.out.println("id_announcement ㅇㅇㅇ" + id_announcement);
		noticeService.deleteNotice(id_announcement);
		return "redirect:/notice";
	}
	
	@GetMapping("/modnotice") // 게시글 수정
	public void modnotice(@RequestParam("id_announcement") int id_announcement, Model model) {
		NoticeDTO notice = noticeService.getNoticeById(id_announcement);

		model.addAttribute("notice", notice);
		System.out.println("id_announcement 수정수정" + id_announcement);
		noticeService.getNotice(id_announcement);
	}
	
	@PostMapping("/modnotice")
	public String modnotice(@RequestParam("id_announcement") int id_announcement,
	    @RequestParam("title") String noticetitle, @RequestParam("content") String noticecontent) {
		System.out.println("수정 커밋");
		NoticeDTO notice = new NoticeDTO();
		notice.setId_announcement(id_announcement);
		notice.setTitle(noticetitle);
		notice.setContent(noticecontent);
		noticeService.modNotice(notice);
		return "redirect:/noticedetail?id_announcement="+id_announcement;
	}
	
	@GetMapping("/agreement")
	public void agreement() {		
	}

}
