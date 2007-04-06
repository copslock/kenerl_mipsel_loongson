Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2007 09:51:51 +0100 (BST)
Received: from web7912.mail.in.yahoo.com ([202.86.4.88]:62570 "HELO
	web7912.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022591AbXDFIvt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Apr 2007 09:51:49 +0100
Received: (qmail 73446 invoked by uid 60001); 6 Apr 2007 08:50:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LmZfybKhM1w8rjDBKB1NPYVjwm5XQddLxaS/HlNaGVD/kvxfBrSchcnjikXAlu+5C40k5+gkN5JbITp0ZxoO056TFEBI4w/Q4T5ZagRirKA5yK35gJz/c7MO8JrQVCS7vb6ZZeKf/NNHYLqQdfju/QKdRXmQTKMlZAe/QXn7uzg=;
X-YMail-OSG: dvY71H4VM1nVwADJANrKHn8kEOtSAos14H8Xjh.B9dHIsfenc6Vt1OyrluGeIcj24LFV.GiUxz2Ug8zlnNt8WbPUCEEZJXNkpJEGflxXH_D5itj0XnPazr3CQ5tnow--
Received: from [199.239.167.162] by web7912.mail.in.yahoo.com via HTTP; Fri, 06 Apr 2007 09:50:41 BST
Date:	Fri, 6 Apr 2007 09:50:41 +0100 (BST)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Back ground user process display issue on linux-2.6.18 kernel 
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-259282827-1175849441=:72711"
Content-Transfer-Encoding: 8bit
Message-ID: <990986.72711.qm@web7912.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-259282827-1175849441=:72711
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
--0-259282827-1175849441=:72711
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi ,</DIV>  <DIV> </DIV>  <DIV>We are running a sample user application&nbsp;"samp_app"&nbsp;in the background using "samp_app &amp;" form rcS script file.</DIV>  <DIV>We are using linux-2.6.18 kernel.</DIV>  <DIV>In this application code we&nbsp;have put some debug messages to&nbsp;display it on&nbsp;console&nbsp;using printf() function.</DIV>  <DIV>We are unable to see any of these debug messages on the console.</DIV>  <DIV>When we run the same application in the foreground (without &amp;) from same rcS script, we are getting these messages on console.</DIV>  <DIV>&nbsp;</DIV>  <DIV>WE RAN THE SAME APPLICATION AS A BACKGROUND PROCESS ('samp_app &amp;') ON LINUX-2.6.12 KERNEL. WE ARE ABLE TO GET THESE DEBUG PRINTS.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Could you please tell us what might be the reason for this behavior on linux-2.6.18.</DIV>  <DIV>Did we miss any configuration option in the 2.6.18 kernel.</DIV>  <DIV>&nbsp;</DIV>  <DIV><STRONG><EM>Note that we are using same
 toolchain for both the kernel versions</EM>.</STRONG></DIV>  <DIV>&nbsp;</DIV>  <DIV>Thanks in Advance.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Regards,</DIV>  <DIV>Sathesh.</DIV><p>&#32;
	

	
		<hr size=1></hr> 
Here’s a new way to find what you're looking for - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> 
--0-259282827-1175849441=:72711--
