Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 03:11:50 +0000 (GMT)
Received: from mf2.realtek.com.tw ([220.128.56.22]:29456 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8134360AbVLNDLb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Dec 2005 03:11:31 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T7535630cdddc80381613b4@mf2.realtek.com.tw>;
 Wed, 14 Dec 2005 11:14:17 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2005121411115927-66069 ;
          Wed, 14 Dec 2005 11:11:59 +0800 
Message-ID: <01f101c6005c$1faf2100$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	"Yoichi Yuasa" <yyuasa@gmail.com>,
	"Florian DELIZY" <florian.delizy@sagem.com>
Cc:	<linux-mips@linux-mips.org>
References: <OFCB10026D.F6B473F3-ONC12570D6.0043AA59-C12570D6.00447CD7@sagem.com>
Subject: =?iso-8859-1?Q?Re:_R=E9f._:_Re:_To_put_Linux_kernel_as_closer_as_possible?=
	=?iso-8859-1?Q?_to_0x80000000?=
Date:	Wed, 14 Dec 2005 11:11:49 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/12/14 =?Bog5?B?pFekyCAxMToxMTo1OQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/12/14 =?Bog5?B?pFekyCAxMToxMjowMQ==?=,
	Serialize complete at 2005/12/14 =?Bog5?B?pFekyCAxMToxMjowMQ==?=
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01EE_01C6009F.2DCDA610"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_01EE_01C6009F.2DCDA610
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="iso-8859-1"


Hi Florian,
We use MIPS 4kec.
Linux runs in Interrupt Compatibility Mode, and it will use 0x80000200 =
to store the "Jump" instruction.
Therefore, we can move Linux kernel to 0x80000204. Is it right?

Another new question. If we modify Linux to use Ventored Interrupt mode, =
can we gain much performance?

Regards,
Colin

  ----- Original Message -----=20
  From: Florian DELIZY=20
  To: Yoichi Yuasa=20
  Cc: colin ; linux-mips@linux-mips.org=20
  Sent: Tuesday, December 13, 2005 8:28 PM
  Subject: R=E9f. : Re: To put Linux kernel as closer as possible to =
0x80000000




  > Yoichi Yuasa wrote :=20
  > Hi
  >
  > It has no problem.
  > Kernel has reserved space for exception handlers.
  >=20
  > Yoichi
  >=20
  > 2005/12/13, colin <colin@realtek.com.tw>:
  > >
  > > Hi all,
  > > We want to put Linux kernel as closer as possible to the bottom of =
memory.
  > > I know that there is some stuff put in the beginning of memory, =
like
  > > Exception table.
  > > So, what's the closest address to 0x80000000 that is allowable to =
store
  > > kernel?=20


  You should just take care to start after reserved =
exception/interruption vectors=20

  0x80000000 : TLB Refull=20
  0x80000080 : General Exception Vector=20

  + 32 instructions.=20

  Depending on your architecture, those addresses may vary (I don't know =
anything about MIPS64=20

  BTW, what's your arch ?=20

  -- Florian=20

  -----BEGIN GEEK CODE BLOCK-----=20
  GCS:GE:GM/ d? s-:+ a-- C+++=20
  U(BLUAVHISX)++++ P++++ L++++=20
  E--- W+++ N+++ o++++ w--- O M V=20
  PS PE- PGP++ t 5 X+++ R+++ tv-=20
  b+ BI++++ D+++ G e+++ h-- r+++ y+++=20
  -----END GEEK CODE BLOC------=20

------=_NextPart_000_01EE_01C6009F.2DCDA610
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1515" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>Hi =
Florian,</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>We use MIPS =
4kec.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>Linux runs in =
Interrupt Compatibility Mode, and it will use=20
0x80000200 to store the "Jump" instruction.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>Therefore, we can =
move Linux kernel to 0x80000204. Is it=20
right?</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>Another new question. =
If we modify Linux to use Ventored=20
Interrupt mode, can we gain much performance?</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>Regards,</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;>Colin</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636;></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt &#26032;&#32048;&#26126;&#39636;">----- =
Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;; font-color: black"><B>From:</B>=20
  <A title=3Dflorian.delizy@sagem.com=20
  href=3D"mailto:florian.delizy@sagem.com">Florian DELIZY</A> </DIV>
  <DIV style=3D"FONT: 10pt &#26032;&#32048;&#26126;&#39636;"><B>To:</B> =
<A title=3Dyyuasa@gmail.com=20
  href=3D"mailto:yyuasa@gmail.com">Yoichi Yuasa</A> </DIV>
  <DIV style=3D"FONT: 10pt &#26032;&#32048;&#26126;&#39636;"><B>Cc:</B> =
<A title=3Dcolin@realtek.com.tw=20
  href=3D"mailto:colin@realtek.com.tw">colin</A> ; <A=20
  title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;"><B>Sent:</B> Tuesday, December 13, =
2005 8:28=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt =
&#26032;&#32048;&#26126;&#39636;"><B>Subject:</B> R=E9f. : Re: To put =
Linux kernel as=20
  closer as possible to 0x80000000</DIV>
  <DIV><FONT =
face=3D&#26032;&#32048;&#26126;&#39636;></FONT><BR></DIV><BR><BR><FONT =
face=3D"Courier New"=20
  size=3D2>&gt; Yoichi Yuasa wrote :</FONT> <BR><FONT face=3D"Courier =
New"=20
  size=3D2>&gt; Hi<BR>&gt;<BR>&gt; It has no problem.<BR>&gt; Kernel has =
reserved=20
  space for exception handlers.<BR>&gt; <BR>&gt; Yoichi<BR>&gt; <BR>&gt; =

  2005/12/13, colin &lt;<A=20
  =
href=3D"mailto:colin@realtek.com.tw">colin@realtek.com.tw</A>&gt;:<BR>&gt=
;=20
  &gt;<BR>&gt; &gt; Hi all,<BR>&gt; &gt; We want to put Linux kernel as =
closer=20
  as possible to the bottom of memory.<BR>&gt; &gt; I know that there is =
some=20
  stuff put in the beginning of memory, like<BR>&gt; &gt; Exception=20
  table.<BR>&gt; &gt; So, what's the closest address to 0x80000000 that =
is=20
  allowable to store<BR>&gt; &gt; kernel?</FONT> <BR><BR><BR><FONT=20
  face=3D"Courier New" size=3D2>You should just take care to start after =
reserved=20
  exception/interruption vectors </FONT><BR><BR><FONT face=3D"Courier =
New"=20
  size=3D2>0x80000000 : TLB Refull</FONT> <BR><FONT face=3D"Courier New" =

  size=3D2>0x80000080 : General Exception Vector</FONT> <BR><BR><FONT=20
  face=3D"Courier New" size=3D2>+ 32 instructions. </FONT><BR><BR><FONT=20
  face=3D"Courier New" size=3D2>Depending on your architecture, those =
addresses may=20
  vary (I don't know anything about MIPS64</FONT> <BR><BR><FONT=20
  face=3D"Courier New" size=3D2>BTW, what's your arch ?</FONT> =
<BR><BR><FONT=20
  face=3D"Courier New" size=3D2>-- Florian</FONT> <BR><BR><FONT =
face=3D"Courier New"=20
  size=3D2>-----BEGIN GEEK CODE BLOCK-----</FONT> <BR><FONT =
face=3D"Courier New"=20
  size=3D2>GCS:GE:GM/ d? s-:+ a-- C+++ </FONT><BR><FONT face=3D"Courier =
New"=20
  size=3D2>U(BLUAVHISX)++++ P++++ L++++ </FONT><BR><FONT face=3D"Courier =
New"=20
  size=3D2>E--- W+++ N+++ o++++ w--- O M V </FONT><BR><FONT =
face=3D"Courier New"=20
  size=3D2>PS PE- PGP++ t 5 X+++ R+++ tv- </FONT><BR><FONT =
face=3D"Courier New"=20
  size=3D2>b+ BI++++ D+++ G e+++ h-- r+++ y+++</FONT> <BR><FONT =
face=3D"Courier New"=20
  size=3D2>-----END GEEK CODE BLOC------</FONT> =
<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_01EE_01C6009F.2DCDA610--
