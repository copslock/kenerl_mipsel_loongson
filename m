Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 02:53:41 +0100 (BST)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:34824
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225629AbTJMBxj>; Mon, 13 Oct 2003 02:53:39 +0100
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <SK19289B>; Mon, 13 Oct 2003 09:45:39 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F6801AC0B85@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: linux-mips@linux-mips.org
Subject: need help on unaligned loads,stores!
Date: Mon, 13 Oct 2003 09:44:56 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3912B.9AA742E0"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3912B.9AA742E0
Content-Type: text/plain;
	charset="ISO-8859-1"

Hi all,

I am porting linux for a cpu that doesnt support unaligned loads/stores
instructions.

when using memcpy in arch/mips/memcpy.S,it will not work on these
instructions.

Any one could help me to deal with this? Have you ever ported linux for this
kind cpu?

And anyone could tell me which cpu doesnt support these instructions
either,and has

been ported for linux?

 

Best Regards,

Alan


------_=_NextPart_001_01C3912B.9AA742E0
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial" hb_focus_attach="true">
<P><SPAN class=979394001-13102003><FONT size=2>Hi all,</FONT></SPAN></P>
<P><SPAN class=979394001-13102003><FONT size=2>I am porting linux&nbsp;for a cpu 
that doesnt support unaligned loads/stores instructions.</FONT></SPAN></P>
<P><SPAN class=979394001-13102003><FONT size=2>when using memcpy in 
arch/mips/memcpy.S,it will not work on these instructions.</FONT></SPAN></P>
<P><SPAN class=979394001-13102003><FONT size=2>Any one could help me to deal 
with this? Have you ever ported linux for this kind cpu?</FONT></SPAN></P>
<P><SPAN class=979394001-13102003><FONT size=2>And anyone could tell&nbsp;me 
which cpu doesnt support these instructions either,and has</FONT></SPAN></P>
<P><SPAN class=979394001-13102003><FONT size=2>been ported for 
linux?</FONT></SPAN></P>
<P><SPAN class=979394001-13102003></SPAN>&nbsp;</P>
<P><SPAN class=979394001-13102003></SPAN><SPAN class=979394001-13102003><FONT 
size=2>Best Regards,</FONT></SPAN></P>
<P><SPAN class=979394001-13102003><FONT 
size=2>Alan</FONT></SPAN></P></BODY></HTML>

------_=_NextPart_001_01C3912B.9AA742E0--
