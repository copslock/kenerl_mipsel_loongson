Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2003 13:12:01 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:14494
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225475AbTJOML5>; Wed, 15 Oct 2003 13:11:57 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <4RT7BKSL>; Wed, 15 Oct 2003 17:04:01 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264F179@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: linux-mips@linux-mips.org
Subject: How to mount root file system on Flash Device
Date: Wed, 15 Oct 2003 17:03:57 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C39314.6BCC0660"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C39314.6BCC0660
Content-Type: text/plain;
	charset="iso-8859-1"

Presently I am using Buildroot Toolchain to compile the Linux Kernel and
create the Root File System.The Buildroot generates an EXT2 file system
Image by using a program called "genext2fs". The created file system is then
merged with the Kernel image for downloading to SDRAM where it allocates a
portion of memory for file-access and storage by setting-up a Ramdisk
device.
 
We want to mount the file system on a non-volatile memory such as Flash
Memory. What changes do we need to make in the BuildRoot Toolchain to
generate the flash-mountable root file system.
 
Regards,
ADEEL MALIK,


------_=_NextPart_001_01C39314.6BCC0660
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<DIV>
<DIV><SPAN class=870253309-15102003><FONT size=2>Presently&nbsp;<SPAN 
class=650040112-15102003>I am</SPAN>&nbsp;using <STRONG>Buildroot 
Toolchain</STRONG> to compile the Linux Kernel and create the Root File 
System.The <STRONG>Buildroot </STRONG>generates an EXT2 file system Image by 
using a program called <STRONG>"genext2fs". </STRONG>The created file system is 
then merged with the Kernel image for downloading to SDRAM where it allocates a 
portion of memory for file-access and storage by setting-up a Ramdisk 
device.</FONT></SPAN></DIV>
<DIV><SPAN class=870253309-15102003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=870253309-15102003><FONT size=2>We want to mount the file 
system on a non-volatile memory such as Flash Memory. What changes do we need to 
make in the BuildRoot Toolchain to generate the flash-mountable root file 
system.</FONT></SPAN></DIV></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><SPAN class=650040112-15102003><FONT size=2>Regards,</FONT></SPAN></DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM>ADEEL MALIK,</EM></FONT></DIV>
<P></P></BODY></HTML>

------_=_NextPart_001_01C39314.6BCC0660--
