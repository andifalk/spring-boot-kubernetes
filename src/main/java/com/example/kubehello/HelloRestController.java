package com.example.kubehello;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class HelloRestController {

    @GetMapping
    public String sayHello() {
        return "Hello Kubernetes";
    }

    @GetMapping("/infos")
    public String infos() {
        StringBuilder builder = new StringBuilder();
        try {
            InetAddress ip = InetAddress.getLocalHost();
            String hostname = ip.getHostName();
            builder.append(hostname).append(" (").append(ip.getHostAddress()).append(")\n");
        } catch (UnknownHostException ex) {
            
        }
        builder.append("Jdk version: " + System.getProperty("java.version"));
        return builder.toString();
    }

    @PostMapping
    public String sayCustomizedHello(@RequestBody String message) {
        return "Hello " + message;
    }
}