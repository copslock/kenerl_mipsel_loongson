Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2003 09:32:26 +0000 (GMT)
Received: from ip-227-82-56-61.rev.dyxnet.com ([IPv6:::ffff:61.56.82.227]:27402
	"EHLO mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8224847AbTCFJcZ>; Thu, 6 Mar 2003 09:32:25 +0000
Received: from msx.realtek.com.tw (unverified [203.69.112.4]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.6) with ESMTP id <T60d094adc4cb45701f374@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Thu, 6 Mar 2003 16:31:05 +0800
Received: from jackson ([172.19.31.122])
          by msx.realtek.com.tw (Lotus Domino Release 5.0.8)
          with ESMTP id 2003030616322149:42751 ;
          Thu, 6 Mar 2003 16:32:21 +0800 
Message-ID: <001a01c2e3ba$dd490e90$7405a8c0@realtek.com.tw>
From: "jackson" <jackson@realtek.com.tw>
To: <linux-mips@linux-mips.org>
Subject: gnu tool-chain support for mips16?
Date: Thu, 6 Mar 2003 16:32:02 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 5.0.8 |June 18, 2001) at 03/06/2003
 04:32:21 PM,
	Serialize by Router on msx/Realtek(Release 5.0.8 |June 18, 2001) at 03/06/2003
 04:32:23 PM,
	Serialize complete at 03/06/2003 04:32:23 PM
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01C2E3FD.EAFC4EB0"
Return-Path: <jackson@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jackson@realtek.com.tw
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C2E3FD.EAFC4EB0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="big5"



Dear all:

I follow rules on http://www.ltc.com/~brad/mips/mips-cross-toolchain/
to build gnu tool-cahin.=20
It works pefect for me to build linux/glibc/ulibc, and perform excellent =
on my Demo Board.

However, it report some bug messags as following when I compile a test.c =

like:
int test()
{
    return 0;
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mips-linux-gcc -c -mips16 -o test test.c
/tmp/ccjnCwV7.s: Assembler messages:
/tmp/ccjnCwV7.s:14: Internal error!
Assertion failure in macro_build_lui at ../../gas/config/tc-mips.c line =
3107.
Please report this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
my mips-linux-gcc info:
Reading specs from /usr/local/lib/gcc-lib/mips-linux/3.0.3/specs
Configured with: ../configure --target=3Dmips-linux =
--enable-languages=3Dc --disable-shared =
--with-headers=3D/usr/local/include --with-newlib
Thread model: single
gcc version 3.0.3
 /usr/local/lib/gcc-lib/mips-linux/3.0.3/cpp0 -lang-c -v -D__GNUC__=3D3 =
-D__GNUC_MINOR__=3D0 -D__GNUC_PATCHLEVEL__=3D3 -DMIPSEB -D_MIPSEB -Dunix =
-Dmips -D_mips -DR3000 -D_R3000 -Dlinux -D__ELF__ -D__PIC__ -D__pic__ =
-D__MIPSEB__ -D_MIPSEB -D__unix__ -D__mips__ -D__mips__ -D__R3000__ =
-D_R3000 -D__linux__ -D__ELF__ -D__PIC__ -D__pic__ -D__MIPSEB -D__unix =
-D__mips -D__mips -D__R3000 -D__linux -Asystem=3Dposix -Acpu=3Dmips =
-Amachine=3Dmips -D__NO_INLINE__ -D__STDC_HOSTED__=3D1 -D__LANGUAGE_C =
-D_LANGUAGE_C -DLANGUAGE_C -D__SIZE_TYPE__=3Dunsigned int =
-D__PTRDIFF_TYPE__=3Dint -D_MIPS_FPSET=3D32 =
-D_MIPS_ISA=3D_MIPS_ISA_MIPS1 -D_MIPS_SIM=3D_MIPS_SIM_ABI32 =
-D_MIPS_SZINT=3D32 -D_MIPS_SZLONG=3D32 -D_MIPS_SZPTR=3D32 -U__mips =
-D__mips -U__mips64 -
GNU CPP version 3.0.3 (cpplib) (MIPS GNU/Linux with ELF)
#include "..." search starts here:
#include <...> search starts here:
 /usr/local/lib/gcc-lib/mips-linux/3.0.3/include
 /usr/local/mips-linux/sys-include
 /usr/local/mips-linux/include
End of search list.


Can you kindly give me some help in this?=20
Thank you very much.
=20

------=_NextPart_000_0017_01C2E3FD.EAFC4EB0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="big5"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2920.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>Dear all:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>I follow rules on <A=20
href=3D"http://www.ltc.com/~brad/mips/mips-cross-toolchain/">http://www.l=
tc.com/~brad/mips/mips-cross-toolchain/</A></FONT></DIV>
<DIV><FONT size=3D2>to build gnu tool-cahin. </FONT></DIV>
<DIV><FONT size=3D2>It works pefect for me to build linux/glibc/ulibc, =
and perform=20
excellent on my Demo Board.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>However, it report some bug messags as following =
when I=20
compile a test.c </FONT></DIV>
<DIV><FONT size=3D2>like:</FONT></DIV>
<DIV><FONT size=3D2>int test()</FONT></DIV>
<DIV><FONT size=3D2>{</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp; return 0;</FONT></DIV>
<DIV><FONT size=3D2>}</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT =
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT>=
</DIV>
<DIV><FONT size=3D2>mips-linux-gcc -c -mips16 -o test =
test.c<BR>/tmp/ccjnCwV7.s:=20
Assembler messages:<BR>/tmp/ccjnCwV7.s:14: Internal error!<BR>Assertion =
failure=20
in macro_build_lui at ../../gas/config/tc-mips.c line 3107.<BR>Please =
report=20
this =
bug.<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</=
FONT></DIV>
<DIV><FONT size=3D2>my mips-linux-gcc info:</FONT></DIV>
<DIV><FONT size=3D2>Reading specs from=20
/usr/local/lib/gcc-lib/mips-linux/3.0.3/specs<BR>Configured with: =
../configure=20
--target=3Dmips-linux --enable-languages=3Dc --disable-shared=20
--with-headers=3D/usr/local/include --with-newlib<BR>Thread model: =
single<BR>gcc=20
version 3.0.3<BR>&nbsp;/usr/local/lib/gcc-lib/mips-linux/3.0.3/cpp0 =
-lang-c -v=20
-D__GNUC__=3D3 -D__GNUC_MINOR__=3D0 -D__GNUC_PATCHLEVEL__=3D3 -DMIPSEB =
-D_MIPSEB=20
-Dunix -Dmips -D_mips -DR3000 -D_R3000 -Dlinux -D__ELF__ -D__PIC__ =
-D__pic__=20
-D__MIPSEB__ -D_MIPSEB -D__unix__ -D__mips__ -D__mips__ -D__R3000__ =
-D_R3000=20
-D__linux__ -D__ELF__ -D__PIC__ -D__pic__ -D__MIPSEB -D__unix -D__mips =
-D__mips=20
-D__R3000 -D__linux -Asystem=3Dposix -Acpu=3Dmips -Amachine=3Dmips =
-D__NO_INLINE__=20
-D__STDC_HOSTED__=3D1 -D__LANGUAGE_C -D_LANGUAGE_C -DLANGUAGE_C=20
-D__SIZE_TYPE__=3Dunsigned int -D__PTRDIFF_TYPE__=3Dint =
-D_MIPS_FPSET=3D32=20
-D_MIPS_ISA=3D_MIPS_ISA_MIPS1 -D_MIPS_SIM=3D_MIPS_SIM_ABI32 =
-D_MIPS_SZINT=3D32=20
-D_MIPS_SZLONG=3D32 -D_MIPS_SZPTR=3D32 -U__mips -D__mips -U__mips64 =
-<BR>GNU CPP=20
version 3.0.3 (cpplib) (MIPS GNU/Linux with ELF)<BR>#include "..." =
search starts=20
here:<BR>#include &lt;...&gt; search starts=20
here:<BR>&nbsp;/usr/local/lib/gcc-lib/mips-linux/3.0.3/include<BR>&nbsp;/=
usr/local/mips-linux/sys-include<BR>&nbsp;/usr/local/mips-linux/include<B=
R>End=20
of search list.<BR></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>Can you kindly give me some help&nbsp;in=20
this?&nbsp;</FONT></DIV>
<DIV><FONT size=3D2>Thank you very much.</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0017_01C2E3FD.EAFC4EB0--
