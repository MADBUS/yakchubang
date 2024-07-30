package com.medicalInfo.project.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.model.QaDTO;
import com.medicalInfo.project.model.QaRatingMixDTO;
import com.medicalInfo.project.model.RatingDTO;
import com.medicalInfo.project.service.BestExpertService;
import com.medicalInfo.project.service.QaService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class BestExpertController {
	private final BestExpertService bestExpertService;
	private final QaService qaService;
	
	
	@GetMapping("bestRating")
	public void topRatingExpert(Model model, HttpSession session) {
		// 평점 1등
		RatingDTO rating = bestExpertService.ExpertTop();
		System.out.println("컨트롤로>>>>rating" + rating);
		if (rating != null) {
			model.addAttribute("rating", rating);
			System.out.println("expertnum<<<" + rating.getExpertNum());
			model.addAttribute("memberInfo", bestExpertService.bestFirst(rating.getExpertNum()));
			System.out.println("컨트롤로>>>>memberInfo" + bestExpertService.bestFirst(rating.getExpertNum()));
			MemberDTO memberdto = bestExpertService.RatingName(rating.getExpertNum());
			model.addAttribute("ratingName", memberdto);
		}
		// 평점 2등
		RatingDTO ratingTwo = bestExpertService.ExpertSecondTop();
		if (ratingTwo != null) {
			model.addAttribute("ratingTwo", ratingTwo);
			model.addAttribute("memberInfoTwo", bestExpertService.bestFirst(ratingTwo.getExpertNum()));
			MemberDTO memberdtoo = bestExpertService.RatingName(ratingTwo.getExpertNum());
			model.addAttribute("ratingTwoName", memberdtoo);
		}
		// 평점 3등

		RatingDTO ratingThree = bestExpertService.ExpertThridTop();
		if (ratingThree != null) {
			model.addAttribute("ratingThree", ratingThree);
			model.addAttribute("memberInfoThree", bestExpertService.bestFirst(ratingThree.getExpertNum()));
			MemberDTO memberdtooo = bestExpertService.RatingName(ratingThree.getExpertNum());
			model.addAttribute("ratingThreeName", memberdtooo);
		}

	}
}
