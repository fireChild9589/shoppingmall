package com.shopping.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.dao.QnADAO;
import com.shopping.vo.Criteria;
import com.shopping.vo.PageMakerDTO;
import com.shopping.vo.QnAVO;

@Service
public class QnAService {

	@Autowired
	private QnADAO qnADAO;

	// ----------------- 문의 리스트
	public List<QnAVO> getQnAList() {
		System.out.println("getQnAList DAO()");

		int total = qnADAO.getTotal();
		System.out.println(total);

		return qnADAO.getQnAList();
	}

	// ----------------- 문의 리스트2
	public Map<String, Object> getQnAList2(Criteria cri) {
		System.out.println("getQnAList DAO()");
		
		Map<String, Object> map = new HashMap<>();
		
		int total = qnADAO.getTotal();
			
		List<QnAVO> qnAList = qnADAO.getQnAList2(cri);
		
		PageMakerDTO pageMaker = new PageMakerDTO(cri, total);
		map.put("pageMaker", pageMaker);
		map.put("qnAList", qnAList);

		return map;
	}

	// ----------------- 문의 등록
	public int insertQnA(QnAVO vo) {
		System.out.println("insertQnA Service()");

		return qnADAO.insertQnA(vo);
	}

	// ----------------- 문의 삭제
	public int deleteQnA(QnAVO vo) {
		System.out.println("deleteQnA Service()");

		qnADAO.deleteQnAComment(vo);

		return qnADAO.deleteQnA(vo);

	}

	// ----------------- 관리자 문의 등록
	public int insertQnAAdmin(QnAVO vo) {
		System.out.println("insertQnAAdmin Service()");

		return qnADAO.insertQnAAdmin(vo);
	}

}