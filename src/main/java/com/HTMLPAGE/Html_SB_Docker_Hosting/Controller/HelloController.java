package com.HTMLPAGE.Html_SB_Docker_Hosting.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {
    @GetMapping("/hello")
    public String helloPage() {
        return "hello"; // resolves to hello.html from templates/
    }
}
