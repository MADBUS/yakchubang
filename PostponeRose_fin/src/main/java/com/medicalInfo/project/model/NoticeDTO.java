package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeDTO {
	private int id_announcement;
	private String content;
	private int member_num;
	private String writerName;
	private String title;
	private Timestamp created_at;
}
