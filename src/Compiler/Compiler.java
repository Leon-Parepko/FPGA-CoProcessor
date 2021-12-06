package Compiler;

////////////////////////////////////////////
//// Test String  1+2;2-3;4*5;6/7;
//// Change output format (" # ")
////////////////////////////////////////////

public class Compiler {


    public static String Compile(String str) {

        String op_ref = "+-*/^", num_ref = "1234567890", delim_ref = ";", mat_op_ref = "ASCDd";       // Add, Subtract, Cross, Dot, determinant
        StringBuilder num1 = new StringBuilder(), num2 = new StringBuilder(), Instruction = new StringBuilder();
        int instruct_counter = 1;
        Integer op = 0;
        boolean op_flag = false;



        try {

            for (Character sym : str.toCharArray()) {

//                if (num1 != null && num2 != null) {
//                    if (Integer.parseInt(String.valueOf(num1)) >= 255 || Integer.parseInt(String.valueOf(num2)) >= 255) {
//                        throw new NumberSizeLimitException(" line: " + instruct_counter);
//                    }
//                }

//          NUMS
                if (num_ref.contains(String.valueOf(sym))) {
                    if (!op_flag) {
                        num1.append(sym);
                    }

                    else if (op_flag) {
                        num2.append(sym);
                    }
                }

//          OPERATIONS
                else if (op_ref.contains(String.valueOf(sym))) {

                    switch (sym) {
                        case ('+') -> op = 1;
                        case ('-') -> op = 2;
                        case ('*') -> op = 3;
                        case ('/') -> op = 4;
                    }

                    op_flag = true;
                }


//          DELIMITERS
                else if (delim_ref.contains(String.valueOf(sym))) {
                    Instruction.append(String.format("%08d", Integer.parseInt(Integer.toBinaryString(Integer.parseInt(String.valueOf(num1)))))).append(" ");
                    Instruction.append(String.format("%08d", Integer.parseInt(Integer.toBinaryString(Integer.parseInt(String.valueOf(num2)))))).append(" ");
                    Instruction.append(String.format("%08d", Integer.parseInt(Integer.toBinaryString(op)))).append(" # ");
                    instruct_counter ++;
                    op_flag = false;
                    num1.delete(0, num1.length());
                    num2.delete(0, num2.length());
                    op = 0;
                }

                else{
                    throw new ImproperSymbolException(sym + " line:" + instruct_counter);
                }
            }
            return String.valueOf(Instruction);
        }

        catch (Exception e){
            return "Compilatin error: " + e.getClass() + '"' + e.getMessage() + '"';
        }
    }




//    ---------------------CUSTOM ERRORS-------------------------

    private static class ImproperSymbolException extends Exception {
        public ImproperSymbolException(String massage) {super(massage);}
    }

    private static class NumberSizeLimitException extends Exception {
        public NumberSizeLimitException(String massage) {super(massage);}
    }
}
