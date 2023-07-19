import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.Process;
import java.lang.Runtime;


public class Ffmpeg {
    public static void main(String[] args)throws IOException, InterruptedException {
        String line2;
        String fpath = "\"/Users/yuma/Desktop/Git_Hub/ditherings/target.gif\"";
        
        Process p;

        p = new ProcessBuilder("ffmpeg -nostdin -i "+fpath+" -f rawvideo -vcodec rawvideo -an -pix_fmt rgb24 -")
        .redirectError(ProcessBuilder.Redirect.INHERIT)
        .start();
        System.out.print(p.getInputStream());
    }
}
