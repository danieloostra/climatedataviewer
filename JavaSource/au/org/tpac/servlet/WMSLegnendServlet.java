/*
*	Copyright Insight4 Pty Ltd 2005-2007 (http://www.insight4.com)
*	See the COPYRIGHT file supplied with the source distribution for information about
*	distribution and copying of this software.
*/
package au.org.tpac.servlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.media.jai.RenderedOp;
import javax.media.jai.JAI;
import javax.imageio.ImageIO;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileInputStream;
import java.awt.image.BufferedImage;
import java.awt.*;

import au.org.tpac.las.wrapper.lib.converters.RequestConverterLasToWms;
import au.org.tpac.wms.request.WMSRequest;
import com.sun.media.jai.codec.FileCacheSeekableStream;

/**
 * Created by IntelliJ IDEA.
 * User: pauline
 * Date: 20/12/2006
 * Time: 10:32:11
 * To change this template use File | Settings | File Templates.
 */
public class WMSLegnendServlet extends WMSServlet
{
    private static Logger log = LoggerFactory.getLogger(WMSLegnendServlet.class);
    private int top;
    private int width;  //how far to go in from the right edge of the image
    private int height;
    private int bottom;

    public void init(ServletConfig config) throws ServletException
    {
        super.init(config);
        top = Integer.parseInt(config.getInitParameter("top"));
        width = Integer.parseInt(config.getInitParameter("width"));
        bottom = Integer.parseInt(config.getInitParameter("bottom"));
    }

    /**
     * A convinient way of creating a LAS to WMS converter.
     * @param request HttpServletRequest - used for extracting the WMS query string
     * @return a brand new LAS to WMS converter
     */
    protected RequestConverterLasToWms makeConverter(HttpServletRequest request)
    {
//jli
    //    return (new RequestConverterLasToWms("/usr/local/armstrong-beta-0.1/conf/server/las.xml", this.makeURL(request) + "?" + request.getQueryString(), this.makeURL(request), RequestConverterLasToWms.OP_PLOT_2D_WITHOUT_HTML, this.makeProductServerURL(request)));

        return (new RequestConverterLasToWms("/home/porter/jing/armstrong/conf/server/las.xml", this.makeURL(request) + "?" + request.getQueryString(), this.makeURL(request), RequestConverterLasToWms.OP_PLOT_2D_WITHOUT_HTML, this.makeProductServerURL(request)));
    }

    /**
     * Shows the image generated by LAS
     * @param imgLoc This is the LOCAL file location (not URL)
     * @param wmsReq WMSRequest that constructed this image
     * @param response Response for getting
     */
    protected void showPicture(String imgLoc, WMSRequest wmsReq, HttpServletResponse response)
    {
        try
        {
            System.out.println(imgLoc);
            InputStream picStream = new FileInputStream(imgLoc);
            response.setHeader("Content-Type", "png");

            RenderedOp image = JAI.create("stream", new FileCacheSeekableStream(picStream));
            BufferedImage img = image.getAsBufferedImage();

            height = image.getHeight() - bottom - top;
            BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

            Graphics2D canvas = (Graphics2D)newImage.getGraphics();
            canvas.drawImage(img, 0, 0, width, height, image.getWidth() - width, top, image.getWidth(), top + height,  null);
           
            ServletOutputStream outStream  = response.getOutputStream();
            ImageIO.write(newImage, "png", outStream);
            outStream.flush();
            outStream.close();
        }
        catch(IOException ioe)
        {
            //something's gone wrong....
            log.info("error: " + ioe.toString());
        }
    }
}
