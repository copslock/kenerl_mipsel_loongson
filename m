Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 08:10:05 +0000 (GMT)
Received: from hmail02.netvigator.com ([IPv6:::ffff:218.102.23.141]:30652 "EHLO
	hmail02dat.netvigator.com") by linux-mips.org with ESMTP
	id <S8225210AbUKKIKA>; Thu, 11 Nov 2004 08:10:00 +0000
Received: from HughTan ([220.246.1.125]) by hmail02dat.netvigator.com
          (InterMail vM.6.01.03.02 201-2131-111-104-20040324) with SMTP
          id <20041111080950.HKKD1253.hmail02dat.netvigator.com@HughTan>
          for <linux-mips@linux-mips.org>; Thu, 11 Nov 2004 16:09:50 +0800
Message-ID: <00df01c4c7c5$cffdad90$6e01a8c0@HughTan>
From: "Ho Tan" <ho.tan@avantec.com.hk>
To: <linux-mips@linux-mips.org>
Subject: Kernel compile error
Date: Thu, 11 Nov 2004 16:09:48 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00DC_01C4C808.DDF60D00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <ho.tan@avantec.com.hk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ho.tan@avantec.com.hk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_00DC_01C4C808.DDF60D00
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Dear all,

I download the ELDK tools kit (2.1.0 eldk-mips-linux-x86) from =
www.denx.de website and follow the instruction to install it into the =
RedHat 7.3.
and I successfully installed into the Redhat 7.3 without any problem.

My target hardware platform is infineon INCAIP and i follow the below =
instruction to compile the kernel. The kernel source is download from =
www.denx.de (linux-mips)
make mrproper
make incaip_config
make oldconfig
make dep
make uImage

When compliation, everything go fine until the compiler compling entry.S =
which locate at arch/mips/kernel. and the Error message prompt.

make[1]: Entering directory =
`/usr/eldk/usr/src/linux-mips/arch/mips/kernel'
mips_4KC-gcc -D__ASSEMBLY__ -D__KERNEL__ =
-I/usr/eldk/usr/src/linux-mips/include -D_MIPS_SZLONG=3D32 =
-D_MIPS_SZPTR=3D32 -D_MIPS_SZINT=3D32  -g -G 0 -mno-abicalls -fno-pic =
-pipe   -c -o entry.o entry.S
entry.S: Assembler messages:
entry.S:225: Error: unrecognized opcode `reg_s $8,164($29)'
entry.S:226: Error: unrecognized opcode `reg_s $8,164($29)'
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory =
`/usr/eldk/usr/src/linux-mips/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2

The source of the entry.S is as below:

Line 225:                BUILD_HANDLER(adel,ade,ade,silent)              =
/* #4  */
Line 226:                BUILD_HANDLER(ades,ade,ade,silent)             =
/* #5  */
Line 227:                BUILD_HANDLER(ibe,be,cli,silent)                =
   /* #6  */
Line 228:                BUILD_HANDLER(dbe,be,cli,silent)                =
  /* #7  */
Line 229:                BUILD_HANDLER(bp,bp,sti,silent)                 =
  /* #9  */
Line 230:                BUILD_HANDLER(ri,ri,sti,silent)                 =
     /* #10 */
Line 231:                BUILD_HANDLER(cpu,cpu,sti,silent)               =
/* #11 */
Line 232:                BUILD_HANDLER(ov,ov,sti,silent)                 =
  /* #12 */
Line 233:                BUILD_HANDLER(tr,tr,sti,silent)                 =
    /* #13 */
Line 234:                BUILD_HANDLER(fpe,fpe,fpe,silent)               =
 /* #15 */
Line 235:                BUILD_HANDLER(watch,watch,sti,silent)        /* =
#23 */
Line 236:                BUILD_HANDLER(mcheck,mcheck,cli,silent)  /* #24 =
*/
Line 237:                BUILD_HANDLER(reserved,reserved,sti,silent) /* =
others */

Anyone could give any suggestion on this??

Best Regards,

Hugh
------=_NextPart_000_00DC_01C4C808.DDF60D00
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1276" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Dear all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I download the ELDK tools kit (2.1.0=20
eldk-mips-linux-x86) from <A href=3D"http://www.denx.de">www.denx.de</A> =
website=20
and follow the instruction to install it into the RedHat =
7.3.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and I successfully installed into the =
Redhat 7.3=20
without any problem.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My target hardware platform is infineon =
INCAIP=20
and&nbsp;i follow the below instruction to compile the kernel. The =
kernel source=20
is download from <A href=3D"http://www.denx.de">www.denx.de</A>=20
(linux-mips)</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>make mrproper</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>make incaip_config</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>make oldconfig</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>make dep</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>make uImage</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When compliation, everything go fine =
until the=20
compiler compling entry.S which locate at arch/mips/kernel. and the =
Error=20
message prompt.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>
<DIV><FONT face=3DArial size=3D2>make[1]: Entering directory=20
`/usr/eldk/usr/src/linux-mips/arch/mips/kernel'<BR>mips_4KC-gcc =
-D__ASSEMBLY__=20
-D__KERNEL__ -I/usr/eldk/usr/src/linux-mips/include -D_MIPS_SZLONG=3D32=20
-D_MIPS_SZPTR=3D32 -D_MIPS_SZINT=3D32&nbsp; -g -G 0 -mno-abicalls =
-fno-pic=20
-pipe&nbsp;&nbsp; -c -o entry.o entry.S<BR>entry.S: Assembler=20
messages:<BR>entry.S:225: Error: unrecognized opcode `reg_s=20
$8,164($29)'<BR>entry.S:226: Error: unrecognized opcode `reg_s=20
$8,164($29)'<BR>make[1]: *** [entry.o] Error 1<BR>make[1]: Leaving =
directory=20
`/usr/eldk/usr/src/linux-mips/arch/mips/kernel'<BR>make: ***=20
[_dir_arch/mips/kernel] Error 2<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The source of the entry.S is as =
below:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2>Line=20
225:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(adel,ade,ade,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #4&nbsp; */<BR>Line=20
226:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(ades,ade,ade,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #5&nbsp; */<BR>Line=20
227:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(ibe,be,cli,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;/* #6&nbsp; */<BR>Line=20
228:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(dbe,be,cli,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #7&nbsp; */<BR>Line=20
229:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(bp,bp,sti,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #9&nbsp; */<BR>Line=20
230:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(ri,ri,sti,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp; /* #10 */<BR>Line=20
231:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(cpu,cpu,sti,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #11 */<BR>Line=20
232:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(ov,ov,sti,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #12 */<BR>Line=20
233:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(tr,tr,sti,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
/* #13 */<BR>Line=20
234:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(fpe,fpe,fpe,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* #15 */<BR>Line=20
235:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(watch,watch,sti,silent)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;/*=20
#23 */<BR>Line=20
236:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(mcheck,mcheck,cli,silent)&nbsp;&nbsp;/* #24 */<BR>Line=20
237:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
BUILD_HANDLER(reserved,reserved,sti,silent)&nbsp;/* others =
*/</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Anyone could give any suggestion on=20
this??</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Best Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Hugh</DIV></FONT></BODY></HTML>

------=_NextPart_000_00DC_01C4C808.DDF60D00--
