Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2003 15:04:27 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:420
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225363AbTH2OEZ>; Fri, 29 Aug 2003 15:04:25 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <RGSFMMYW>; Fri, 29 Aug 2003 18:58:23 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA382627228@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: Steffen Malmgaard Mortensen <smm@futarque.com>
Cc: linux-mips@linux-mips.org
Subject: RE: help
Date: Fri, 29 Aug 2003 18:58:20 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C36E35.9C702180"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C36E35.9C702180
Content-Type: text/plain


Hi Steffen,
               I couldn't understand your point. I want to disable module
versioning and for this I start make menuconfig in the linux folder. From
this I disable module versioning and then I launck make dep, make clean and
then make from the toplevel directory.
I havn't checked the top-level makefile. Can you tell me what fields need to
be added to CFLAGS to disable the MODVERSIONING.



Regards,
Adeel

 -----Original Message-----
From: Steffen Malmgaard Mortensen [mailto:smm@futarque.com]
Sent: Friday, August 29, 2003 6:21 PM
To: Adeel Malik
Subject: Re: help


Have you tried with the CFLAGS from the kernel makefile?? 
/Steffen

Adeel Malik wrote:


 



------_=_NextPart_001_01C36E35.9C702180
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=US-ASCII">
<TITLE></TITLE>

<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY text=#000000 bgColor=#ffffff>
<BLOCKQUOTE><FONT face=Tahoma>
  <DIV class=OutlookMessageHeader dir=ltr align=left><SPAN 
  class=460415113-29082003></SPAN><FONT face=Arial><FONT color=#0000ff><FONT 
  size=2>H<SPAN class=460415113-29082003>i 
  Steffen,</SPAN></FONT></FONT></FONT></DIV>
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT><FONT 
  color=#0000ff><FONT size=2><SPAN 
  class=460415113-29082003></SPAN></FONT></FONT></FONT><SPAN 
  class=460415113-29082003></SPAN><FONT face=Arial><FONT color=#0000ff><FONT 
  size=2>&nbsp;<SPAN 
  class=460415113-29082003>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  I couldn't understand your point. I want to disable module versioning and for 
  this I start make menuconfig in the linux folder. From this I disable module 
  versioning and then I launck make dep,&nbsp;make clean and then make from the 
  toplevel directory.</SPAN></FONT></FONT></FONT></DIV>
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT><FONT 
  color=#0000ff><FONT size=2><SPAN 
  class=460415113-29082003></SPAN></FONT></FONT></FONT><SPAN 
  class=460415113-29082003></SPAN><FONT face=Arial><FONT color=#0000ff><FONT 
  size=2>I<SPAN class=460415113-29082003> havn't checked the top-level makefile. 
  Can you tell me what fields need to be added to CFLAGS to disable the 
  MODVERSIONING.</SPAN></FONT></FONT></FONT></DIV><FONT face=Arial><FONT 
  color=#0000ff><FONT size=2><SPAN 
  class=460415113-29082003></SPAN></FONT></FONT></FONT></FONT></BLOCKQUOTE>
<BLOCKQUOTE><FONT face=Tahoma><FONT face=Arial><FONT color=#0000ff><FONT 
  size=2><SPAN class=460415113-29082003></SPAN></FONT></FONT></FONT>
  <DIV class=OutlookMessageHeader dir=ltr align=left><SPAN 
  class=460415113-29082003></SPAN><FONT face=Arial><FONT color=#0000ff><FONT 
  size=2>R<SPAN 
  class=460415113-29082003>egards,</SPAN></FONT></FONT></FONT></DIV>
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT><FONT 
  color=#0000ff><FONT size=2><SPAN 
  class=460415113-29082003></SPAN></FONT></FONT></FONT><SPAN 
  class=460415113-29082003></SPAN><FONT face=Arial><FONT color=#0000ff><FONT 
  size=2>A<SPAN 
  class=460415113-29082003>deel</SPAN></FONT></FONT></FONT><BR></DIV>
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT size=2><SPAN 
  class=460415113-29082003>&nbsp;</SPAN>-----Original 
  Message-----<BR><B>From:</B> Steffen Malmgaard Mortensen 
  [mailto:smm@futarque.com]<BR><B>Sent:</B> Friday, August 29, 2003 6:21 
  PM<BR><B>To:</B> Adeel Malik<BR><B>Subject:</B> Re: 
  help<BR><BR></DIV></FONT></FONT>Have you tried with the CFLAGS from the kernel 
  makefile?? <BR>/Steffen<BR><BR>Adeel Malik wrote:<BR>
  <BLOCKQUOTE cite=mid10C6C1971DA00C4BB87AC0206E3CA382627222@1aurora.enabtech 
  type="cite">
    <META content="MSHTML 6.00.2600.0" name=GENERATOR>
    <DIV>&nbsp;</DIV></BLOCKQUOTE><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C36E35.9C702180--
