Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2003 16:43:44 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:11141
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225391AbTIIPnm>; Tue, 9 Sep 2003 16:43:42 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <SBLGY745>; Tue, 9 Sep 2003 20:36:57 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38262742D@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: linux-mips@linux-mips.org
Cc: Dan Aizenstros <daizenstros@quicklogic.com>
Subject: NFS Server and Client Setup on MIPS Platform
Date: Tue, 9 Sep 2003 20:36:56 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C376E8.33AB5C70"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C376E8.33AB5C70
Content-Type: text/plain;
	charset="iso-8859-1"

Hi All,
 
         I am using Buildroot-QuickMIPS environment for porting Linux-2.4 to
MIPS Target Platform. I need to Netwrok-Mount the root filesystem and for
this I need to configure the NFS Server on the Host and NFS Client on the
Target.
 
Can someone tell me that what are the steps needed to compile the Buildroot
MIPS kernel for NFS Mounting of MIPS root filesystem ?.
 
I mean what are the configuration settings that need to be made during the
make menuconfig process of MIPS kernel source and then how to make the
zImage with NFS support that could be downloaded on the target system
memory.
 
Regards,
Adeel

------_=_NextPart_001_01C376E8.33AB5C70
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial">
<DIV><SPAN class=156471715-09092003><FONT size=2>Hi All,</FONT></SPAN></DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=156471715-09092003><FONT 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am using 
Buildroot-QuickMIPS environment for porting Linux-2.4 to MIPS Target Platform. I 
need to Netwrok-Mount the root filesystem and for this I need to configure the 
NFS Server on the Host and NFS Client on the Target.</FONT></SPAN></DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2>Can someone tell me that what 
are the steps needed to compile the Buildroot MIPS kernel for NFS Mounting of 
MIPS root filesystem ?.</FONT></SPAN></DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2>I mean what are the 
configuration settings that need to be made during the make menuconfig process 
of MIPS kernel source and then how to make the zImage with NFS support that 
could be downloaded on the target system memory.</FONT></SPAN></DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=156471715-09092003><FONT size=2>Regards,</FONT></SPAN></DIV>
<DIV><SPAN class=156471715-09092003><FONT 
size=2>Adeel</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C376E8.33AB5C70--
