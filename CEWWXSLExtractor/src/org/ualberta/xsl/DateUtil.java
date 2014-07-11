package org.ualberta.xsl;

/**
 *
 * @author mpm1
 */
public class DateUtil {
    public enum Month{
        Jan("01"),
        Feb("02"),
        Mar("03"),
        Apr("04"),
        May("05"),
        Jun("06"),
        Jul("07"),
        Aug("08"),
        Sep("09"),
        Oct("10"),
        Nov("11"),
        Dec("12");
        
        private String number;
        
        Month(String number){
            this.number = number;
        }
        
        public String getNumber(){
            return number;
        }
    }
    
    public static String convertMonth(String input){
        return Month.valueOf(input).getNumber();
    }
}
