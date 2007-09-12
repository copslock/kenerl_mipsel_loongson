Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 10:19:31 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:39141 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20022232AbXILJTX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 10:19:23 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l8C9BOIC017409;
	Wed, 12 Sep 2007 02:11:24 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l8C9BgGu012030;
	Wed, 12 Sep 2007 02:11:42 -0700 (PDT)
Message-ID: <00b301c7f51c$f0709d30$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"zhuzhenhua" <zzh.hust@gmail.com>,
	"linux-mips" <linux-mips@linux-mips.org>
References: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
Subject: Re: does the SAVE_ALL nesting in kernel?
Date:	Wed, 12 Sep 2007 11:11:42 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00B0_01C7F52D.B2CCFB20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00B0_01C7F52D.B2CCFB20
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

SAVE_ALL can certainly nest in MIPS Linux.  This is why there's a check =
at the beginning of SAVE_SOME to determine whether the exception was =
take in user-mode, to see if the kernel stackpointer should be loaded =
from memory or computed relative to the current stack frame.   Another =
thing to keep in mind in looking at these sorts of optimizations is that =
each scheduling thread has its own kernel stack area. So if you're very =
very motivated, you could conceivably come up with a hack whereby the =
first level of exceptions uses your internal RAM array for a stack, but =
nested ones use external memory, *but*, you'd at least need room for as =
many first-level stack frames in your internal RAM as you have =
concurrent processes/threads in the system, or you'd need to mutilate =
the context switch code to copy the first level stack frames in and out =
of external memory on a context switch.  I don't think that's a good =
path to go down.

If you have functioning caches, they won't be as perfect as a =
scratchpad, but you won't have all the additional context switch =
overhead, and they will automagically do approximately what you want, =
without your having to change any code.

            Kevin K.
  ----- Original Message -----=20
  From: zhuzhenhua=20
  To: linux-mips=20
  Sent: Wednesday, September 12, 2007 4:21 AM
  Subject: does the SAVE_ALL nesting in kernel?


  hello, all
              i have a mips board,  and the SDRAM speed(bus clock) is =
not too fast.
               so i want change  the SAVE_ALL and RESTORE_ALL to use =
internal-ram(high speed).
              i just wonder whether the SAVE_ALL netsting in kernel  for =
mips arch?
              if not, i think  maybe 1k byte for SAVE_ALL is enough( =
32regs X4, and some cp0_regs).
              but if  the SAVE_ALL nesting, maybe i need to keep a stack =
in internal-ram.
              thanks for any hints=1B$B!%=1B(B

  Best Regards

  --
  zzh


------=_NextPart_000_00B0_01C7F52D.B2CCFB20
Content-Type: text/html;
	charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-2022-jp">
<META content=3D"MSHTML 6.00.2800.1597" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>SAVE_ALL can certainly nest in MIPS =
Linux.&nbsp;=20
This is why there's a check at the beginning of SAVE_SOME to determine =
whether=20
the exception was take in user-mode, to see if the kernel stackpointer =
should be=20
loaded from memory or computed relative to the current stack=20
frame.&nbsp;&nbsp;&nbsp;Another thing to keep in mind in looking at =
these sorts=20
of optimizations is that each scheduling thread has its own kernel stack =
area.=20
So if you're very very motivated, you could conceivably come up with a =
hack=20
whereby the first level&nbsp;of exceptions uses your internal RAM array =
for a=20
stack, but nested ones use external memory, *but*, you'd at least need =
room for=20
as many first-level stack frames in your internal RAM&nbsp;as you have=20
concurrent processes/threads in the system, or you'd need to mutilate =
the=20
context switch code to copy the first level stack frames in and out of =
external=20
memory on a context switch.&nbsp; I don't think&nbsp;that's</FONT><FONT=20
face=3DArial size=3D2>&nbsp;a good path to go down.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If you have functioning caches, they =
won't be as=20
perfect as a scratchpad, but you&nbsp;won't have all the additional =
context=20
switch overhead, and they will automagically do&nbsp;approximately what =
you=20
want, without your having to change any code.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; Kevin K.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dzzh.hust@gmail.com =
href=3D"mailto:zzh.hust@gmail.com">zhuzhenhua</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  href=3D"mailto:linux-mips@linux-mips.org">linux-mips</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, September 12, =
2007 4:21=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> does the SAVE_ALL =
nesting in=20
  kernel?</DIV>
  <DIV><BR></DIV>hello,=20
  =
all<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 i=20
  have a mips board,&nbsp; and the SDRAM speed(bus clock) is not too=20
  fast.<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; so i want=20
  change&nbsp; the SAVE_ALL and RESTORE_ALL to use internal-ram(high=20
  =
speed).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;=20
  i just wonder whether the SAVE_ALL netsting in kernel&nbsp; for mips=20
  arch?<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if not, i =
think&nbsp; maybe=20
  1k byte for SAVE_ALL is enough( 32regs X4, and some =
cp0_regs).<BR>&nbsp;=20
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; but if&nbsp; the SAVE_ALL nesting, =
maybe i=20
  need to keep a stack in=20
  =
internal-ram.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
  thanks for any hints=1B$B!%=1B(B<BR><BR>Best=20
Regards<BR><BR>--<BR>zzh<BR><BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_00B0_01C7F52D.B2CCFB20--
