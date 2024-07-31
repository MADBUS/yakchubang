package com.medicalInfo.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.RatingDTO;
import com.medicalInfo.project.model.RatingTotDTO;

@Mapper
public interface BestExpertMapper {
	
	public RatingDTO bestExpert();
	
	public MemberInfoDTO firstExpert(int expertNum);
	
	public MemberDTO ExpertName(int expertNum);
	
	public RatingDTO bestSecondExpert();
	
	public RatingDTO bestThirdExpert();
	
	public RatingDTO myRating(int expertNum);
	
	public List<RatingDTO> qaRatingList(int expertNum);
	
	public List<RatingDTO> prescriptRatingList(int expertNum);

	public List<RatingTotDTO> getListWithSearch(Criteria cri);

	public int getListTotalCount(Criteria cri);

	
}
