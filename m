Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 10:12:25 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:47034
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225391AbTI3JMU>; Tue, 30 Sep 2003 10:12:20 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <TPC4VWDF>; Tue, 30 Sep 2003 14:05:20 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264EDDC@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: linux-mips@linux-mips.org
Subject: How to generate the kernel image binary file for a specific memor
	y area
Date: Tue, 30 Sep 2003 14:05:17 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C38731.F7D48ED0"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C38731.F7D48ED0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi All,
        I am using Buildroot-QuickMIPS development environment for porting
linux-based applications to a development board. When I run the 'make'
command in the Top level Buildroot folder, the Kernel Image file generated
in srec format defaults to the address where the SDRAM is mapped. In this
way I am able to boot the kernel form SDRAM. I want to load the image to
flash (mapped to some other address) and boot the kernel from it. Can
someone having worked on Buildroot tell me where to locate the linker
directive file and make the necessary change so that I can generate the
Image for a specific memory area.
 
Presently I use the Boot Monitor's load command that stores the Image file
from some server configured as boot server to Target SDRAM and kernel is
executed by issuing the go command. I want to know whether the download
mechanism would remain the same for booting the kernel from Flash as from
SDRAM or I may need to use some ROM directive in the Linker directive file
so that on reset the code is moved from flash to SDRAM and executed from
there.
 
Regards,
 
ADEEL MALIK,
 


------_=_NextPart_001_01C38731.F7D48ED0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<DIV><SPAN class=102094808-30092003><FONT size=2>Hi All,</FONT></SPAN></DIV>
<DIV><SPAN class=102094808-30092003><FONT 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am using 
<STRONG>Buildroot-QuickMIPS </STRONG>development environment for porting 
linux-based applications to a development board. When I run the 'make' command 
in the&nbsp;Top level&nbsp;Buildroot&nbsp;folder, the Kernel Image file 
generated in <STRONG>srec format</STRONG> defaults to the address where the 
SDRAM is mapped. In this way I am able to&nbsp;boot the kernel form 
SDRAM.&nbsp;I want to load the image to flash (mapped to some other address) and 
boot the kernel from it. Can someone having worked on Buildroot tell me where to 
locate the linker directive file and make the necessary change so that I can 
generate the Image for a specific memory area.</FONT></SPAN></DIV>
<DIV><SPAN class=102094808-30092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=102094808-30092003><FONT size=2>Presently I use the Boot 
Monitor's load command that stores the Image file from some server configured as 
boot server to Target SDRAM and kernel is executed by issuing the go command. 
</FONT></SPAN><SPAN class=102094808-30092003><FONT size=2>I want to know whether 
the download mechanism would remain the same for booting the kernel from Flash 
as from SDRAM or I may need to use some ROM directive&nbsp;in the Linker 
directive file so that on reset the code is moved from flash to SDRAM and 
executed from there.</FONT></SPAN></DIV>
<DIV><SPAN class=102094808-30092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=102094808-30092003><FONT size=2>Regards,</FONT></SPAN></DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM></EM></FONT>&nbsp;</DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM>ADEEL MALIK,</EM></FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<P></P></BODY></HTML>

------_=_NextPart_001_01C38731.F7D48ED0--
