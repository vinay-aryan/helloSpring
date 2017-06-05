package com.me.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WelcomeController {

     Logger logger = Logger.getLogger(WelcomeController.class);

    @RequestMapping(method = RequestMethod.GET, value ={ "","/","/index","/home"})
    public ModelAndView mapRequestHandler(HttpServletRequest request) {
        Map<String, Object> modelMap = new HashMap<String, Object>();
        return new ModelAndView("/index", modelMap);
    }
    
 }
