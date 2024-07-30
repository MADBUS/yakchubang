package com.medicalInfo.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.model.ADDORDROP;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.PatientDTO;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.model.PrescriptDetailDTO;
import com.medicalInfo.project.service.MemberService;
import com.medicalInfo.project.service.PatientService;
import com.medicalInfo.project.service.PrescriptDetailService;
import com.medicalInfo.project.service.PrescriptService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PrescriptDetailController {
	
	@Autowired
	PrescriptDetailService prescriptDetailService;
	
	@Autowired
	PrescriptService prescriptService;
	
	@Autowired
	PatientService patientService;
	
	@Autowired
	MemberService memberService;
	
	@PostMapping("/insertprescript")
	public String insertPrescript(@RequestParam("mediID[]") String[] mediID, @RequestParam("itemName[]") String[] itemName,
			@RequestParam("pd[]") int[] perDays,@RequestParam("td[]") int[] totalDays,
			@RequestParam("patientName") String patientName,@RequestParam("addordrop[]") String[] addordrop,@RequestParam("d_comment[]") String[] d_comment,
			@RequestParam("memberId") String memberId,@RequestParam("phoneNum") String phoneNum,
			@RequestParam("prescribingInstitution")String prescribingInstitution,@RequestParam("prescribingDoctor")String prescribingDoctor,
			HttpSession session) {
		System.out.println("check info"+patientName);
		System.out.println("check info"+memberId);
		System.out.println("check info"+phoneNum);
		System.out.println("check info"+prescribingInstitution);
		System.out.println("check info"+prescribingDoctor);
		int maxNum = 0;
		for(String med : mediID) {
			System.out.println("mediId check"+med);
		}
		for(String med : itemName) {
			System.out.println("mediname check"+med);
		}
		for(int med : perDays) {
			System.out.println("medipd check"+med);
		}
		for(int med : totalDays) {
			System.out.println("meditd check"+med);
			maxNum= Math.max(maxNum, med);
		}
		for(String med : addordrop) {
			System.out.println("addordrop check"+med);
		}
		for(String med :  d_comment) {
			System.out.println("comment check"+med);
		}
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member_info");
		
		MemberDTO member = memberService. getMember(memberId);
		if (member==null) {
			PatientDTO patient = patientService.getPatient(memberId);
			if(patient==null) {
			
				PatientDTO patient_ = new PatientDTO();
				patient_.setPatientName(patientName);
				patient_.setPatientTel(phoneNum);
				patient_.setPatientEmail(memberId);
				patientService.registerPatient(patient_);
				patient = patientService.getPatient(memberId);
			}
			PrescriptDTO prescriptDto = new PrescriptDTO(patientName, memberId, phoneNum, prescribingInstitution, prescribingDoctor, memberDTO.getMemberNum(), MemberType.EXPERT);
			int prescriptId = prescriptService.insertPrescipt(prescriptDto);
			for(int i = 0; i<mediID.length; i++) {
				
				String mid = mediID[i];
				String mn = itemName[i];
				int perD = perDays[i];
				int totD = totalDays[i];
				String ad = addordrop[i];
				ADDORDROP add= null;
				if(ad.equals("ADD")) {
					add= ADDORDROP.ADD;
				}else {
					add= ADDORDROP.DROP;
				}
				String com = d_comment[i];
				PrescriptDetailDTO pdd = new PrescriptDetailDTO(prescriptId, mid, mn, perD, totD, add, com);
				prescriptDetailService.insertPrescriptDetail(pdd);
			}
			return "redirect:/mypage/expertMypage";
		}
		System.out.println("멤버체크"+memberDTO.toString());
		PrescriptDTO prescriptDTO = new PrescriptDTO(member.getMemberName(), member.getMemberEmail(),phoneNum,member.getMemberNum(),MemberType.PATIENT,prescribingInstitution, prescribingDoctor, memberDTO.getMemberNum(), MemberType.EXPERT);
		int prescriptId = prescriptService.insertMemPrescipt(prescriptDTO);
		
		for(int i = 0; i<mediID.length; i++) {
			
			String mid = mediID[i];
			String mn = itemName[i];
			int perD = perDays[i];
			int totD = totalDays[i];
			String ad = addordrop[i];
			String com = d_comment[i];
			PrescriptDetailDTO pdd = new PrescriptDetailDTO(prescriptId, mid, mn, perD, totD, ADDORDROP.ADD, com);
			prescriptDetailService.insertPrescriptDetail(pdd);
		}
		
		return "redirect:/mypage/expertMypage";
		
	}
	
	@GetMapping("/mypage/expertPrescriptMod")
	public void read(@RequestParam("prescript_no") int prescript_no, Model model, HttpSession session) {
		log.info("PrescriptController read >>>");
		model.addAttribute("dto", prescriptService.get(prescript_no));
		model.addAttribute("detaillist", prescriptDetailService.selectPrescript(prescript_no));
		log.info("MypageController read model >>>" + model);

		MemberType membertype = (MemberType) session.getAttribute("membertype");
		System.out.println("MypageController read 이거찍힘?" + membertype);
		
	}
	
	@PostMapping("/mypage/modMed")
	public String modMed(@RequestParam("mediID[]") String[] mediID, @RequestParam("itemName[]") String[] itemName,
			@RequestParam("pd[]") int[] perDays,@RequestParam("td[]") int[] totalDays,@RequestParam("addordrop[]") String[] addordrop,
			@RequestParam("d_comment[]") String[] d_comment, @RequestParam("prescript_no") int prescript_no, Model model) {
		for(String med : mediID) {
			System.out.println("mediId check"+med);
		}
		for(String med : itemName) {
			System.out.println("mediname check"+med);
		}
		for(int med : perDays) {
			System.out.println("medipd check"+med);
		}
		for(int med : totalDays) {
			System.out.println("meditd check"+med);
		}
		for(String med : addordrop) {
			System.out.println("addordrop check"+med);
		}
		for(String med :  d_comment) {
			System.out.println("comment check"+med);
		}
		
		prescriptDetailService.deleteDetail(prescript_no);
		for(int i = 0; i<mediID.length; i++) {
			
			String mid = mediID[i];
			String mn = itemName[i];
			int perD = perDays[i];
			int totD = totalDays[i];
			ADDORDROP ad = addordrop[i].equals("ADD")?ADDORDROP.ADD:ADDORDROP.DROP;
			String com = d_comment[i];
			PrescriptDetailDTO pdd = new PrescriptDetailDTO(prescript_no, mid, mn, perD, totD, ad, com);
			prescriptDetailService.insertPrescriptDetail(pdd);
		}
		
		return "redirect:/mypage/expertMypage";
	}
	
	@GetMapping("/mypage/deleteprescript")
	public String deletePrscript(@RequestParam("prescript_no") int prescript_no) {
		prescriptService.deletePrescript(prescript_no);
		return "redirect:/mypage/expertMypage";
	}
}
