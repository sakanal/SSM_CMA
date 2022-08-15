package test;

import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.Stack;

@Configuration
public class Test {

    public static void main(String[] args) {
        System.out.println(strStr("asdfawqrwe",null));
        System.out.println("test");
        System.out.println("test");
        System.out.println("test");
        System.out.println("test");
        System.out.println("master修改");
        System.out.println("hot-fix修改");
    }

    public static int strStr(String haystack, String needle) {
        if(needle==null) return 0;
        int index=-1;
        return haystack.indexOf(needle);
    }
}
