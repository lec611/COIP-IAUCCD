package edu.seu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: yxl
 * @Date: 2019-05-14 14:40
 */
@Controller
public class PageController {

    @RequestMapping(path = {"/", "/index"})
    public String index(){
        return "index";
    }

    @RequestMapping("/login")
    public String login(){return "login";}

    @RequestMapping("/register")
    public String register(){return "register";}

    @RequestMapping("/findPassword")
    public String findPassword(){return "findPassword";}

    @RequestMapping("/updatePassword")
    public String updatePassword(){ return "updatePassword";}

    @RequestMapping("/updatePasswordFromFind")
    public String updatePasswordFromFind(){return "updatePasswordFromFind";}
}
