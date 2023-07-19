import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.Process;
import java.lang.Runtime;


public class Ffmpeg {
    public static void main(String[] args) {
        
        fpath = "D:/Desktop/GIt Hub/ditherings/target.jpg";
        Process p = Runtime.getRuntime().exec("ffmpeg -i "+fpath+" -");
        var buf = new BufferedReader( new InputStreamReader( p.getInputStream() ) ); 

        while( ( line = buf.readLine() ) != null ){
            System.out.println( line );
        }
    }
}
