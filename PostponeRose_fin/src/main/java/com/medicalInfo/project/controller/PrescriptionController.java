package com.medicalInfo.project.controller;

import javax.servlet.http.HttpSession;

import org.hibernate.boot.model.source.internal.hbm.ModelBinder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.service.PrescriptService;

@Controller
public class PrescriptionController {
	
	@Autowired
	PrescriptService prescriptionService;
	
	@GetMapping("/prescriptwrite")
	public void prescriptWrite() {
		
	}
	
	@GetMapping("/prescriptList")
	public void prescript(Model model, HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("member_info");
		model.addAttribute("prescriptList",prescriptionService.showMyPrescription(dto.getMemberNum()));
	}
	
	@GetMapping("/prescriptMod")
	public void prescriptMod(@RequestParam("prescript_no") int prescript_no,Model model) {
		PrescriptDTO prescriptDTO =prescriptionService.getPrescript(prescript_no);
		model.addAttribute("prescript", prescriptDTO);
	}
}
