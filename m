Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 19:26:54 +0000 (GMT)
Received: from web21603.mail.yahoo.com ([IPv6:::ffff:66.163.169.178]:8343 "HELO
	web21603.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225413AbUA1T0y>; Wed, 28 Jan 2004 19:26:54 +0000
Message-ID: <20040128192636.32578.qmail@web21603.mail.yahoo.com>
Received: from [206.31.31.3] by web21603.mail.yahoo.com via HTTP; Wed, 28 Jan 2004 11:26:36 PST
Date: Wed, 28 Jan 2004 11:26:36 -0800 (PST)
From: Rajesh Palani <rpalani2@yahoo.com>
Subject: SoftFloat implementation for MIPS in GCC
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2005043698-1075317996=:32138"
Return-Path: <rpalani2@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpalani2@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-2005043698-1075317996=:32138
Content-Type: text/plain; charset=us-ascii

Hi,
 
   We are using a gcc 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1) GCC cross-compiler with -msoftfloat to use software floating point routines.
 
   When we profied an application using the Linux Trace Toolkit, we observed that  there were a lot of CpU (Co-processor unusable) exceptions.  Some of the floating point routines ( eg. __floatdidf) expect values to be passed in floating point registers and take FP exceptions even though the application has been built with -msoftfloat.  Is this a general MIPS/GCC issue?  What is the status of softfloat  for MIPS in GCC?
 
   Thanks in advance.
 
   Rajesh


---------------------------------
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
--0-2005043698-1075317996=:32138
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; We are using a gcc 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1) GCC cross-compiler with -msoftfloat to use software floating point routines.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; When we profied an application using the Linux Trace Toolkit, we observed that<FONT size=2>&nbsp; there were a lot of CpU (Co-processor unusable) exceptions.&nbsp; Some of the floating point routines ( eg. __floatdidf) expect values to be passed in floating point registers and take FP exceptions even though the application has been built with -msoftfloat.&nbsp; Is this a general MIPS/GCC issue?&nbsp; What is the status of softfloat&nbsp; for MIPS in GCC?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; Thanks in advance.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; Rajesh</DIV><p><hr SIZE=1>
Do you Yahoo!?<br>
Yahoo! SiteBuilder - Free web site building tool. <a href="http://us.rd.yahoo.com/evt=21608/*http://webhosting.yahoo.com/ps/sb/"><b>Try it!</b></a>
--0-2005043698-1075317996=:32138--
