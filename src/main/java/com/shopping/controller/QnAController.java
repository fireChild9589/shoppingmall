package com.shopping.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.shopping.service.QnAService;
import com.shopping.vo.Criteria;
import com.shopping.vo.QnAVO;

@Controller
@RequestMapping("/QnA")
public class QnAController {

	@Autowired
	private QnAService qnaService;

	// ------------------- 문의리스트
	@RequestMapping(value = "/QnAList", method = RequestMethod.GET)
	public String QnAList(Model model, Criteria cri) {
		System.out.println("QnAList()");

		Map<String, Object> map = qnaService.getQnAList(cri);

		model.addAttribute("qnaList", map.get("qnaList"));
		model.addAttribute("pageMaker", map.get("pageMaker"));
	
		return "qna/qnaList";
	}

	// ------------------- 문의 등록
	@RequestMapping(value = "/insertQnA", method = RequestMethod.GET)
	public String insertQnA(@ModelAttribute QnAVO vo) {
		System.out.println("insertQnA()");

		qnaService.insertQnA(vo);

		return "redirect:/QnA/QnAList";

	}
	
	// ------------------- 문의리스트
	@RequestMapping(value = "/addminQnA", method = RequestMethod.GET)
	public String addminQnA(Model model, Criteria cri) {
		System.out.println("addminQnA()");
		
		Map<String, Object> map = qnaService.adminGetQnAList(cri);
		
		model.addAttribute("qnaList", map.get("qnaList"));
		model.addAttribute("pageMaker", map.get("pageMaker"));
		
		return "admin/qnaView";
		
	}

	// ------------------- 문의 답글 등록
	@RequestMapping(value = "/insertQnAAdmin", method = RequestMethod.GET)
	public String insertQnAAdmin(@ModelAttribute QnAVO vo) {
		System.out.println("insertQnAAdmin()");

		qnaService.insertQnAAdmin(vo);

		return "redirect:/QnA/addminQnA";
	}

}
