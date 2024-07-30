package com.medicalInfo.project.model;

import java.sql.Timestamp;


import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import com.medicalInfo.project.model.MemberType;

import lombok.Data;

@Data
public class QaDTO {
	

	
	private int qa_id;
	private String writer;
	private int member_num;
	private String title;
	private Timestamp created_at;
	private String context;
	
	@Enumerated(EnumType.STRING)
	private MemberType member_type;
	private int prescript_no;
	private int viewcnt;
	
	public QaDTO() {}

	

	public QaDTO(String writer, int member_num, String title, String context, MemberType member_type) {
		super();
		this.writer = writer;
		this.member_num = member_num;
		this.title = title;
		this.context = context;
		this.member_type = member_type;
	}



	public QaDTO(String writer, int member_num, String title, String context, MemberType member_type,int prescript_no) {
		super();
		this.writer = writer;
		this.member_num = member_num;
		this.title = title;
		this.context = context;
		this.member_type = member_type;
		this.prescript_no = prescript_no;
	};
	
}
