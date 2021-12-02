package Compiler;

public class Compiler {


    public void Compile(String str){
        String divRef = "+-*/^", nums = "1234567890";
        int num_counter = 0;
        StringBuilder num1 = null, num2 = null, op = null;
        boolean op_flag = false;

        for (char sym : str.toCharArray()){
            if (nums.matches(String.valueOf(sym))){
                System.out.println(sym);
                if (!op_flag){num1.append(sym);}
                else if (op_flag){num2.append(sym);}

            }

            else if (divRef.matches(String.valueOf(sym))){
                op.append(sym);
                op_flag = true;
            }

//            Integer.parseInt(String.valueOf(num1));



//            char divider = 0;
//            for (char div : divRef){
//                if (ch == div) {
//                    divider = ch;
//                    break;
//                }
//            }
//            if(divider == 0){
//
//            }else {
//
//            }
        }

        System.out.println(Byte.valueOf(String.valueOf(num1)));


    }


}
