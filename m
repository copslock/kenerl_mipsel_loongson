Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2003 16:40:01 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:7388
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225624AbTIZPjz>; Fri, 26 Sep 2003 16:39:55 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <TPC4VWCJ>; Fri, 26 Sep 2003 20:32:55 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264ED5E@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: linux-mips@linux-mips.org
Subject: How to increase download speed for UART 
Date: Fri, 26 Sep 2003 20:32:50 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C38443.749AFBD0"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C38443.749AFBD0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi All,
         I am porting Linux to a MIPS based development platform. The UART
on the board provides a maximum baud rate of 115 kbps. But the download time
for the kernel Image of about 4.3 MB is about 4 hours !!!!!. 
 
Can someone help me address this problem ?. 
 
(I can't download the kernel image via tftp server using ethernet, as the
CPU doesn't have the MAC interface).
 
Regards,
ADEEL MALIK,
 


------_=_NextPart_001_01C38443.749AFBD0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<DIV><SPAN class=054482515-26092003><FONT size=2>Hi All,</FONT></SPAN></DIV>
<DIV><SPAN class=054482515-26092003><FONT 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am porting Linux to a 
MIPS based development platform. The UART on the board provides a maximum baud 
rate of 115&nbsp;kbps. But the download time for the kernel Image of about 4.3 
MB is about 4 hours !!!!!. </FONT></SPAN></DIV>
<DIV><SPAN class=054482515-26092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=054482515-26092003><FONT size=2>Can&nbsp;someone help me 
address this problem ?. </FONT></SPAN></DIV>
<DIV><SPAN class=054482515-26092003></SPAN>&nbsp;</DIV>
<DIV><SPAN class=054482515-26092003><FONT size=2>(I can't download the 
kernel&nbsp;image via tftp server using ethernet, as the CPU doesn't have the 
MAC interface).</FONT></SPAN></DIV>
<DIV><SPAN class=054482515-26092003><FONT size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=054482515-26092003><FONT size=2>Regards,</FONT></SPAN></DIV>
<DIV><FONT face=Georgia color=#0000ff size=2><EM>ADEEL MALIK,</EM></FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<P></P></BODY></HTML>

------_=_NextPart_001_01C38443.749AFBD0--
