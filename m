Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f855CJ513244
	for linux-mips-outgoing; Tue, 4 Sep 2001 22:12:19 -0700
Received: from viditec-netmedia.com.tw (61-220-240-70.HINET-IP.hinet.net [61.220.240.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f855CAd13240
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 22:12:10 -0700
Received: from kjlin ([61.220.240.66])
	by viditec-netmedia.com.tw (8.10.0/8.10.0) with SMTP id f857cXW18996
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 15:38:33 +0800
Message-ID: <008901c135c6$87b88c60$056aaac0@kjlin>
From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
To: <linux-mips@oss.sgi.com>
Subject: How to install the cross-compiler toolchain?
Date: Wed, 5 Sep 2001 12:52:13 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0086_01C13609.95BA3AA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_0086_01C13609.95BA3AA0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi=20

My host is x86 running RedHat 7.1.
I downloaded the cross-compiler, toolchain-mips-20010810-1.i386.rpm, =
from the sgi ftp site and tried to install it.
But i found that GLIBC_2.2.3 is needed by toolchain-mips-20010810-1.
However, the system library of RedHat 7.1 is glibc-2.2.2 and the "failed =
dependencies" error message showed while installing.
Therefore, i downloaded the glibc-2.2.3-13.3.i386.rpm and installed.
But failed.
#rpm -ivh glibc-2.2.3-13.3.i386.rpm=20
error: failed dependencies:
                glibc-common =3D 2.2.3-13.3 is needed by =
glibc-2.2.3-13.3
                glibc-devel < 2.2.3 conflicts with glibc-2.2.3-13.3
I also tried to install glibc-common-2.2.3-13.3.i386.rpm but still =
failed.
#rpm -ivh glibc-common-2.2.3-13.3.i386.rpm
error: failed dependencies:
                glibc < 2.2.3 conflicts with glibc-common-2.2.3-13.3

I am confused by the result.
Can anybody tell me how to install the =
toolchain-mips-20010810-1.i386.rpm successfully?

Thanks in advance.
KJ


------=_NextPart_000_0086_01C13609.95BA3AA0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dbig5" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>My host is x86 running RedHat 7.1.</FONT></DIV>
<DIV><FONT size=3D2>I downloaded the cross-compiler,=20
toolchain-mips-20010810-1.i386.rpm, from the sgi ftp site and tried to =
install=20
it.</FONT></DIV>
<DIV><FONT size=3D2>But i found that GLIBC_2.2.3 is needed by=20
toolchain-mips-20010810-1.</FONT></DIV>
<DIV><FONT size=3D2>However, the system library of RedHat 7.1 is =
glibc-2.2.2 and=20
the "failed dependencies" error message showed while =
installing.</FONT></DIV>
<DIV><FONT size=3D2>Therefore, i downloaded the =
glibc-2.2.3-13.3.i386.rpm and=20
installed.</FONT></DIV>
<DIV><FONT size=3D2>But failed.</FONT></DIV>
<DIV><FONT size=3D2>#rpm -ivh glibc-2.2.3-13.3.i386.rpm </FONT></DIV>
<DIV><FONT size=3D2>error: failed=20
dependencies:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
glibc-common =3D 2.2.3-13.3 is needed by=20
glibc-2.2.3-13.3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
glibc-devel &lt; 2.2.3 conflicts with glibc-2.2.3-13.3</FONT></DIV>
<DIV><FONT size=3D2>I also tried to install =
glibc-common-2.2.3-13.3.i386.rpm but=20
still failed.</FONT></DIV>
<DIV><FONT size=3D2>#rpm -ivh =
glibc-common-2.2.3-13.3.i386.rpm</FONT></DIV>
<DIV><FONT size=3D2>error: failed=20
dependencies:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
glibc &lt; 2.2.3 conflicts with glibc-common-2.2.3-13.3<BR></FONT></DIV>
<DIV><FONT size=3D2>I am confused by&nbsp;the result.</FONT></DIV>
<DIV><FONT size=3D2>Can anybody tell me how to install the=20
toolchain-mips-20010810-1.i386.rpm successfully?</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Thanks in advance.</FONT></DIV>
<DIV><FONT size=3D2>KJ</DIV></FONT>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0086_01C13609.95BA3AA0--
