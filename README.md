
#Climate DATA Viewer(CDV)  - Data Viz

##Why support this project?

The goal for this repository is to open the CDV to the world via GitHub, to help us create the ultimate data visualization tool that our scientists, educators, friends and families can connect with the hundreds of petabytes of data that are provided freely by science teams at NASA, NOAA, CDC, NWS without politics or strings attached.

##What does this software already do?

The Climate Data Viewer (CDV) is a web server that can be configured to allow users to access climate and Earth science data. The CDV uses DODs networking to enable data users to view distributed datasets in one viewer, or host data locally. The CDV uses the Ferret visualization engine to visualize data within the CDV, however, other applications such as Matlab, IDL, GrADS can also be used within the CDV as it currently stands.

The CDV can also be used to visualize other data, on other servers throughout the world. The CDV has been used by NOAA, NASA, and other governmental agencies to visualize data, providing an easy-to-use way to access geo-referenced scientific data.

##What can I do?

Recent developments have forced individual users to introduce the CDV (also known as the Live Access Server - LAS) into a mainstream crowd-sourced software package, to insure the safety of its’ use by current and future users. What really needs to happen here is that you need to help make the CDV bombproof. If you have a background in securing Java based applications against attacks such as XSS, Command Injection, SQL-injection or related vulnerabilities, *please lend a hand in making this software as secure as you can. *

##Who initially developed the CDV?

The Climate Data Viewer was originally developed by the dedicated staff at the PMEL – Pacific Marine Environmental Lab, with all credit going to them for the initial, current, and on-going development. I’ve been in close contact with lead developer at PMEL, and we will share any concrete developments with the team at PMEL for evaluation and feedback.

##Requirements
###You must have the following software installed before you install LAS v8.x
- Java 1.6+ (you need the full SE JDK not just the Run-time Environment (JRE).)  We recommend Java 7. 
- Tomcat v6.x or higher. We recommend Tomcat 7.  We are running all of our servers at Tomcat 7.
- T DS (The THREDDS Data Server) 4.2.5+  You must use TDS 4.  We do not recommend 4.3 yet due to problems with the NCML aggregations.
- ant 1.8+ (if the Java code does not compile and you have the right JDK it's probably because your ant is old.)
- Ferret 6.842 or higher with the etopo05.nc data set and the Ferret environment that goes with the release.

#First steps to installing the CDV

##Prerequisites
###You must have the following software installed before you install
<ol><li>Java<b> 1.6</b>+ (you need the full SE JDK not just the Run-time Environment (JRE).)<b>  We recommend Java 7. <br /></b></li><li>Tomcat v6.x or higher. <b>We recommend Tomcat 7.</b>  We are running all of our servers at Tomcat 7.<br /></li><li>TDS (The THREDDS Data Server) <b>4.2.5</b>+  You <b>must</b> use TDS <b>4</b>.  We do not recommend 4.3 yet due to problems with the NCML aggregations.<br /></li><li>ant 1.8+ (if the Java code does not compile and you have the right JDK it's probably because your ant is old.)<br /></li><li>Ferret<b> 6.842</b> or higher with <a href="ftp://ftp.pmel.noaa.gov/ferret/pub/data/etopo05.nc.Z">the etopo05.nc data set</a> and the Ferret environment that goes with the release.</li></ol>

###Install Java 1.6+
<h3>Read <a href="http://www.oracle.com/technetwork/java/javase/index-137561.html" target="_self">the documentation</a> for details.</h3>
<ol><li>Go to <a href="http://www.oracle.com/technetwork/java/javase/overview/index.html" target="_self">oracle.com</a> to get Java 1.6.</li><li>Follow the instructions for the RPM or self-extracting binary installation as appropriate for your system.</li></ol>

###Install Tomcat 6.x +
<h3 class="Subheading">Here's a quick and dirty "how-to" for Tomcat (read <a href="http://tomcat.apache.org/tomcat-5.5-doc/index.html" target="_self">the documentation</a> for details).<br /></h3>
<ol><li>Go to <a href="http://tomcat.apache.org/" target="_self">tomcat.apache.org</a> get the latest 6.x version.<br /></li><li>Follow the link on the left and download the "core" tar.gz file.</li><li>Explode the tomcat tar file into a directory of your choosing:<br />
<pre> tar -xzf apache-tomcat-6.0.32.tar.gz</pre>
</li><li>I usually make a link from the complicated name (apache-tomcat-6.0.32) to a simple name (tomcat) using a soft link. That way the "tomcat" name can always point to the latest version you have installed:<br />
<pre>ln -s apache-tomcat-6.0.32/ tomcat</pre>
</li><li>If the default port numbers are being used by some other application, you'll need to edit the <b>tomcat/conf/server.xml</b> file to change the three port numbers (the shutdown port, the HTTP Connector port, and the Connector/AJP port). You can also just comment out the AJP connector port since we don't use it in our set up.<br /><br />E.g.<br />
<pre>&lt;Server port="<b>8005</b>" shutdown="SHUTDOWN"&gt;<br />...<br /> &lt;!-- Define a non-SSL HTTP/1.1 Connector on port 8080 --&gt;     <br /> &lt;Connector port="<b>8080</b>" maxHttpHeaderSize="8192"                <br />   maxThreads="150" minSpareThreads="25" maxSpareThreads="75"                <br />   enableLookups="false" redirectPort="8443" acceptCount="100"                <br />   connectionTimeout="20000" disableUploadTimeout="true" /&gt;<br />...<br /> &lt;!-- Define an AJP 1.3 Connector on port 8009 --&gt;<br /> &lt;!-- For the basic LAS installation this connector is not used and could be commented out. --&gt;     <br /> &lt;Connector port="<b>8009</b>"                <br />   enableLookups="false" redirectPort="8443" protocol="AJP/1.3" /&gt;</pre>

That's it. Now remember the full path name of the directory where you installed your tomcat and the port number you selected for the HTTP Connector port. You'll need these in the LAS configure process.</li></ol>
###Install the THREDDS Data Server
####This is not hard, but there are a lot of steps you need to follow.
<p>Because of all the details needed to integrate TDS and LAS we've created <a title="Installing and integrating TDS with LAS." href="https://github.com/danieloostra/climatedataviewer/wiki/More-Details-on-Installing-the-THREDDS-Data-Server">a separate page with instructions</a>.</p>

###Install Ant 1.8+
<h3>This is very easy. The promise of "write once install anywhere in action".</h3>
<ol><li>Check your version with ant -version</li><li>If it's old go to <a href="http://ant.apache.org/" target="_self">ant.apache.org</a>.</li><li>Look for the download link on the welcome page.</li><li>Expand the tar ball somewhere.</li><li>Set your path so that this installation appears in the path ahead of the old version you're trying to replace.</li></ol>

###Install Ferret 6.842 or higher
<ol><li>Download the appropriate package from the Ferret  <a href="http://ferret.pmel.noaa.gov/Ferret/downloads">downloads page</a>.</li><li>There is a <a href="http://ferret.pmel.noaa.gov/Ferret/downloads/ferret-installation-and-update-guide">detailed installation guide</a> and help from the <a href="http://ferret.pmel.noaa.gov/Ferret/email-users-group">mailing list</a>.</li>
<ul><li>N.B. You also need the Ferret environment that goes with this release.<br /></li></ul>
<li>You also need to install the etopo05.nc data set in your FER_DATA directory since this version of LAS depends on this file for computing masks for user defined variables. The example configuration also includes a new dataset, ocean_atlas_subset.nc, a 4-Dimensional dataset for demonstrating LAS capabilities. Both of these files are in the Ferret datasets tar file listed on the Ferret downloads pages. Download the Ferret datasets tar file and install the data to update your installation.</li></ol>


##Further Questions? Insights? We need your help!
Feel free to <a href="mailto:danoostra@gmail.com">email me</a> privately or post to your thoughts on this project. I've been a user of this software for many years, I'm not an expert at application security, but making this software bulletproof will allow students from around the world access research quality data. Our team would like to use this software to make data accessible for teachers to expand their student's understanding and experiences in the areas of Earth science, math, engineering, and above all, insights into the world around them. 

####Please refer to the home page of the Live Access Server for more technical information and NOAA PMEL releases.
<a href="http://ferret.pmel.noaa.gov/LAS/home" target="_blank">Live Access Server Home</a>

Thought I should add this:
####Disclaimer: This repository is not officially affiliated with NOAA PMEL, NASA, NWS or any of the agencies named or implied within this repository. It was contributed under the open source license detailed within the LICENSE.md file located in the main directory for the CDV as requested by the original authors.

#####Please note: This software and documentation referred to are in the public domain and are furnished "as is." The original or current authors, maintainers, editors, or contributors assume no responsibility for the use of this software.
