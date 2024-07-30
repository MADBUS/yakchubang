package com.medicalInfo.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.BestExpertMapper;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.RatingDTO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BestExpertService {
	
	private final BestExpertMapper bestExpertMapper;
	
	public RatingDTO ExpertTop() {
		System.out.println("전문가1rating"+bestExpertMapper.bestExpert());
		return bestExpertMapper.bestExpert();
	}
	
	public MemberInfoDTO bestFirst(int expertNum) {
		System.out.println("전문가memberinfo"+bestExpertMapper.firstExpert(expertNum));
		return bestExpertMapper.firstExpert(expertNum);
	}
	
	public MemberDTO RatingName(int expertNum) {
		System.out.println("너의이름은뭐니"+bestExpertMapper.ExpertName(expertNum));
		return bestExpertMapper.ExpertName(expertNum);
	}
	
	public RatingDTO ExpertSecondTop() {
		System.out.println("전문가222rating"+bestExpertMapper.bestSecondExpert());
		return bestExpertMapper.bestSecondExpert();
	}
	
	public RatingDTO ExpertThridTop() {
		System.out.println("전문가333rating"+bestExpertMapper.bestThirdExpert());
		return bestExpertMapper.bestThirdExpert();
	}
	
	public RatingDTO myAvgRating(int expertNum){
		System.out.println("나의평균평점"+expertNum);
		return bestExpertMapper.myRating(expertNum);
	}
	
	public List<RatingDTO> myQaRating(int expertNum){
		System.out.println("나의평점 qalist"+expertNum);
		return bestExpertMapper.qaRatingList(expertNum);
	}
	
	public List<RatingDTO> myPrescriptRating(int expertNum){
		System.out.println("나의평점 prescriptlist"+expertNum);
		return bestExpertMapper.prescriptRatingList(expertNum);
	}
}
