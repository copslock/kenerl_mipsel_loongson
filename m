Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Mar 2006 15:28:32 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:63412 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133714AbWCYP2W
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Mar 2006 15:28:22 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2PFcJil022262;
	Sat, 25 Mar 2006 07:38:20 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k2PFcHY0027937;
	Sat, 25 Mar 2006 07:38:18 -0800 (PST)
Message-ID: <000d01c65022$90d758a0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kishore K" <hellokishore@gmail.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com> <20060324165518.GA16567@linux-mips.org> <f07e6e0603250122t6328c09coe37141d14396dc12@mail.gmail.com>
Subject: Re: 2.6.14 - problem with malta
Date:	Sat, 25 Mar 2006 16:41:19 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C6502A.F13D4210"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C6502A.F13D4210
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

See below...
  ----- Original Message -----=20
  From: Kishore K=20
  To: Ralf Baechle=20
  Cc: linux-mips@linux-mips.org=20
  Sent: Saturday, March 25, 2006 10:22 AM
  Subject: Re: 2.6.14 - problem with malta


  On 3/24/06, Ralf Baechle <ralf@linux-mips.org> wrote:
    On Fri, Mar 24, 2006 at 08:06:43PM +0530, Kishore K wrote:

    > hi
    > I am trying to bring up the malta board (MIPS 4kec), using the =
2.6.14 kernel
    > downloaded from linux-mips. The kernel is built with =
malta_defconfig located=20
    > in arch/mips/configs. After loading this kernel, board halts after =
printing
    > "Linux Started
    > Config serial console: console=3DttyS0, 38400n8r"
    >
    > Kernel is built with the tool chain based on gcc 3.3.6, binutils =
2.14.90.0.8
    > .

    Note I generally don't test with HJ.Lu's toolchain at all.  It may =
be
    broken for MIPS, I don't know.  Also due to known bugs in older =
toolchains
    the minimal requirement is binutils 2.16; the vanilla FSF version =
from
    ftp.gnu.org will do.

    (2.15 will core dump for some configurations but if it doesn't die, =
it seems
    to do just fine)

  Thanks for the reply. I observed the same problem  even when compiled =
with tool chain based on gcc 3.4.4 binutils 2.15.97 and uclibc- 0.9.27. =
I 'll try with binutils 2.16. Please note that my malta is based on 4kc =
but not 4kec.
Ah.  That makes a difference.  In your earlier mssage, you said you had =
a 4KEc.
The malta_defconfig file by default configures the kernel to be built =
assuming
MIPS32 Release 2.  The 4KEc is Release 2 compatible, but the older 4Kc =
and
5K cores are not.   You need to tweak the configuration such that=20
CONFIG_CPU_MIPS32_R1=3Dy but CONFIG_CPU_MIPS32_R2 is not set
(it's the other way around in the malta_defconfig in the linux-mips =
git),
and, to be on the safe side, such that CONFIG_SYS_HAS_CPU_MIPS32_R2
isn't set.

Your failure was so early that I was wondering what on earth could have
nailed you, but if the kernel was built for Release 2, you would have =
had
"DI" (disable interrupts) instructions very early on, and these could =
have
caused a fatal early exception on a Release 1 part.

            Regards,

            Kevin K.
------=_NextPart_000_000A_01C6502A.F13D4210
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>See below...</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dhellokishore@gmail.com =
href=3D"mailto:hellokishore@gmail.com">Kishore=20
  K</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dralf@linux-mips.org=20
  href=3D"mailto:ralf@linux-mips.org">Ralf Baechle</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Saturday, March 25, 2006 =
10:22=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: 2.6.14 - problem =
with=20
  malta</DIV>
  <DIV><BR></DIV>On 3/24/06, <B class=3Dgmail_sendername>Ralf =
Baechle</B> &lt;<A=20
  href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</A>&gt; wrote:
  <DIV><SPAN class=3Dgmail_quote></SPAN>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">On=20
    Fri, Mar 24, 2006 at 08:06:43PM +0530, Kishore K wrote:<BR><BR>&gt;=20
    hi<BR>&gt; I am trying to bring up the malta board (MIPS 4kec), =
using the=20
    2.6.14 kernel<BR>&gt; downloaded from linux-mips. The kernel is =
built with=20
    malta_defconfig located <BR>&gt; in arch/mips/configs. After loading =
this=20
    kernel, board halts after printing<BR>&gt; "Linux Started<BR>&gt; =
Config=20
    serial console: console=3DttyS0, 38400n8r"<BR>&gt;<BR>&gt; Kernel is =
built=20
    with the tool chain based on gcc 3.3.6, binutils 2.14.90.0.8<BR>&gt; =

    .<BR><BR>Note I generally don't test with HJ.Lu's toolchain at=20
    all.&nbsp;&nbsp;It may be<BR>broken for MIPS, I don't =
know.&nbsp;&nbsp;Also=20
    due to known bugs in older toolchains<BR>the minimal requirement is =
binutils=20
    2.16; the vanilla FSF version from<BR><A=20
    href=3D"http://ftp.gnu.org">ftp.gnu.org</A> will do.<BR><BR>(2.15 =
will core=20
    dump for some configurations but if it doesn't die, it seems<BR>to =
do just=20
    fine)</BLOCKQUOTE>
  <DIV><BR>Thanks for the reply. I observed the same problem&nbsp; even =
when=20
  compiled with tool chain based on gcc 3.4.4 binutils 2.15.97 and =
uclibc-=20
  0.9.27. I 'll try with binutils 2.16. Please note that my malta is =
based on=20
  4kc but not 4kec.</DIV></DIV></BLOCKQUOTE>
<DIV><FONT face=3DArial size=3D2>Ah.&nbsp; That makes a =
difference.&nbsp; In your=20
earlier mssage, you said you had a 4KEc.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The malta_defconfig file by default =
configures the=20
kernel to be built assuming</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>MIPS32 Release 2.&nbsp; The 4KEc is =
Release 2=20
compatible, but the older 4Kc and</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>5K cores are not.&nbsp;&nbsp; You need =
to tweak the=20
configuration such that </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>CONFIG_CPU_MIPS32_R1=3Dy but =
CONFIG_CPU_MIPS32_R2 is=20
not set</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>(it's the other way around in the =
malta_defconfig=20
in the linux-mips git),</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and, to be on the safe side, such that=20
CONFIG_SYS_HAS_CPU_MIPS32_R2</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>isn't set.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Your failure was so early that I was =
wondering what=20
on earth could have</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>nailed you, but if the kernel was built =
for Release=20
2, you would have had</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>"DI" (disable interrupts) instructions =
very early=20
on, and these could have</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>caused a fatal early exception on a =
Release 1=20
part.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; Kevin K.</FONT></DIV></BODY></HTML>

------=_NextPart_000_000A_01C6502A.F13D4210--
