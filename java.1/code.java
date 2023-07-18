import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;
import java.io.IOException;


public class Tast {
   	public static void main( String[] args ) {
        BufferedImage img = ImageIO.read( new File( "./target.jpg" ) );
        System.out.print(Integer.toString(img.getType()));
    }
}