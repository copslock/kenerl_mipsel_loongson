Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 16:05:51 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:9963
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225396AbTJAPFs>; Wed, 1 Oct 2003 16:05:48 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <TPC4VW1M>; Wed, 1 Oct 2003 19:58:47 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264EE5C@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: linux-mips@linux-mips.org
Subject: SREC utility
Date: Wed, 1 Oct 2003 19:58:46 +0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3882C.83EA1320"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3882C.83EA1320
Content-Type: text/plain;
	charset="iso-8859-1"

Hi All,
 
I have a binary file in Motorola's SREC format. The address field in each
S-record (S3) has a specific address value for a device such as an SDRAM. I
need to change the SREC file for mapping to another memory device located at
some other memory address. I want to have a utility that can convert the
SREC format file generated for some particular address range to another SREC
file generated for some other address range. I mean that utility should only
change the address field  and checksum field of my S-RECORD and modify it
for another address range. The utility should not change the data field of
S-Records anyhow.
 
Regards,
ADEEL MALIK,
 


------_=_NextPart_001_01C3882C.83EA1320
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<DIV><FONT size=2>
<DIV><SPAN class=153004814-01102003><FONT size=2>Hi All,</FONT></SPAN></DIV>
<DIV><SPAN class=153004814-01102003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=153004814-01102003><FONT size=2>I have a binary file in 
Motorola's SREC format. The address field in each S-record (S3) has a specific 
address value for a device such as an SDRAM. I&nbsp;need to change the SREC file 
for mapping to another memory device located at some other memory address. I 
want to have a utility that can convert the SREC format file generated for some 
particular&nbsp;address range to another SREC file generated for some other 
address range. I mean that utility should only change the 
<STRONG><U>address</U></STRONG> field&nbsp; and 
<U><STRONG>checksum</STRONG></U>&nbsp;field of my S-RECORD and modify it for 
another address range. The utility should not change the 
<STRONG><U>data</U></STRONG> field of S-Records anyhow.</FONT></SPAN></DIV>
<DIV><SPAN class=153004814-01102003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=153004814-01102003><FONT size=2>Regards,</FONT></SPAN></DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM>ADEEL 
MALIK,</EM></FONT></DIV></FONT></DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM></EM></FONT>&nbsp;</DIV>
<P></P></BODY></HTML>

------_=_NextPart_001_01C3882C.83EA1320--
