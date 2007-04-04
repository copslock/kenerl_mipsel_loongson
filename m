Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 14:35:50 +0100 (BST)
Received: from web7907.mail.in.yahoo.com ([202.86.4.83]:58758 "HELO
	web7907.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021970AbXDDNfo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Apr 2007 14:35:44 +0100
Received: (qmail 96667 invoked by uid 60001); 4 Apr 2007 13:34:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=DaEumORm0clT254KP0qq2VZgUZwDuV0OYSIUOsyZmgyotVyAVGy2fSgPWuAgcxRjjTDWghWKRfsG/Ab8ZmsocCjLqQNvDNLjPe8bOjMUdhRX3lXrkqclH4tCy2kmmnEpVyCF2H/hwcLoxSwoZt+NcjXleR/g7t8cISp6YOYZIbc=;
X-YMail-OSG: Lk8FnbYVM1mNvnjVvlIGdqRn5ibc32iLDpkvNUOFpjC_zNB7yCqoscP5kcjtYmkOvO9DrNQZAiKvdSYA.U1N49L3pHZLpf5ZIeIsCa7HdTJZlMkCv4PSTk9ipgiUSQ--
Received: from [199.239.167.162] by web7907.mail.in.yahoo.com via HTTP; Wed, 04 Apr 2007 14:34:29 BST
Date:	Wed, 4 Apr 2007 14:34:29 +0100 (BST)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Back ground user process display issue on linux-2.6.18 kernel  
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-875335224-1175693669=:96419"
Content-Transfer-Encoding: 8bit
Message-ID: <718603.96419.qm@web7907.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-875335224-1175693669=:96419
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi ,
    
  We are running a sample user application "samp_app" in the background using "samp_app &" form rcS script file.
  We are using linux-2.6.18 kernel.
  In this application code we have put some debug messages to display it on console using printf() function.
  We are unable to see any of these debug messages on the console.
  When we run the same application in the foreground (without &) from same rcS script, we are getting these messages on console.
   
  WE RAN THE SAME APPLICATION AS A BACKGROUND PROCESS ('samp_app &') ON LINUX-2.6.12 KERNEL. WE ARE ABLE TO GET THESE DEBUG PRINTS.
   
  Could you please tell us what might be the reason for this behavior on linux-2.6.18.
  Did we miss any configuration option in the 2.6.18 kernel.
   
  Note that we are using same toolchain for both the kernel versions.
   
  Thanks in Advance.
   
  Regards,
  Sathesh.

 				
---------------------------------
 Here’s a new way to find what you're looking for - Yahoo! Answers 
--0-875335224-1175693669=:96419
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi ,</div>  <div>&nbsp; </div>  <div>We are running a sample user application&nbsp;"samp_app"&nbsp;in the background using "samp_app &amp;" form rcS script file.</div>  <div>We are using linux-2.6.18 kernel.</div>  <div>In this application code we&nbsp;have put some debug messages to&nbsp;display it on&nbsp;console&nbsp;using printf() function.</div>  <div>We are unable to see any of these debug messages on the console.</div>  <div>When we run the same application in the foreground (without &amp;) from same rcS script, we are getting these messages on console.</div>  <div>&nbsp;</div>  <div>WE RAN THE SAME APPLICATION AS A BACKGROUND PROCESS ('samp_app &amp;') ON LINUX-2.6.12 KERNEL. WE ARE ABLE TO GET THESE DEBUG PRINTS.</div>  <div>&nbsp;</div>  <div>Could you please tell us what might be the reason for this behavior on linux-2.6.18.</div>  <div>Did we miss any configuration option in the 2.6.18 kernel.</div>  <div>&nbsp;</div>  <div><STRONG><EM>Note that we are
 using same toolchain for both the kernel versions</EM>.</STRONG></div>  <div>&nbsp;</div>  <div>Thanks in Advance.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Sathesh.</div><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-875335224-1175693669=:96419--
