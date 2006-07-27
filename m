Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 16:54:04 +0100 (BST)
Received: from cluster-a.mailcontroller.altohiway.com ([213.83.66.193]:26603
	"EHLO cluster-a.mailcontroller.altohiway.com") by ftp.linux-mips.org
	with ESMTP id S8134022AbWG0Pxy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Jul 2006 16:53:54 +0100
Received: from efs01.eventmine.local (host-212-158-201-87.bulldogdsl.com [212.158.201.87])
	by rlya6a.mailcontroller.altohiway.com (MailControl) with SMTP id k6RFrlTr009217
	for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 16:53:47 +0100
Content-class: urn:content-classes:message
Subject: is sde lite a complete toolchain?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6B194.D8D498EE"
Date:	Thu, 27 Jul 2006 16:53:47 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <583C102FDFBE2E4FB8ADF0D680B0798C0B53CB@efs01.eventmine.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: is sde lite a complete toolchain?
Thread-Index: AcaxlNiWg1ugYcxmR2GbTjm4BJ3SKg==
From:	"Shan Wang" <swang@eventmine.com>
To:	<linux-mips@linux-mips.org>
X-Scanned-By: MailControl A-06-00-05 (www.mailcontrol.com) on 10.60.0.116
Return-Path: <swang@eventmine.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swang@eventmine.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6B194.D8D498EE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

I downloaded the SDE lite toolchain from MIPS Technologies. I can use
the makefiles to build all the examples come with the package and test
them with the simulator. But when I tried to use sde-gcc to cross
compile the hello world example directly:

=20

sde-gcc -Wall -mips32 -mtune=3D4kc -EL hello.c -o hello

=20

I got errors like the following:

/home/linuxdev/packages/sde-lite-linux/bin/../lib/gcc/sde/3.4.4/../../..
/../sde/bin/ld: warning: cannot find entry symbol __start;

 defaulting to 0000000080020000

/tmp/ccEaLxlW.o: In function `main':

hello.c:(.text+0x20): undefined reference to `printf'

hello.c:(.text+0x20): relocation truncated to fit: R_MIPS_26 against
`printf'

collect2: ld returned 1 exit status

=20

=20

Does that mean the SDE lite package is not a complete cross toolchain,
can I use it to compile my own application?=20

=20

Any help will be appropriated, thanks very much.

=20

=20

Best Regards,

=20

Shan



This message has been scanned by MailController - www.MailController.altohi=
way.com

------_=_NextPart_001_01C6B194.D8D498EE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>I downloaded the SDE lite toolchain from MIPS
Technologies. I can use the makefiles to build all the examples come with t=
he
package and test them with the simulator. But when I tried to use sde-gcc to
cross compile the hello world example directly:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>sde-gcc -Wall -mips32 -mtune=3D4kc -EL hello.c -o=
 hello<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>I got errors like the following:<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>/home/linuxdev/packages/sde-lite-linux/bin/../lib=
/gcc/sde/3.4.4/../../../../sde/bin/ld:
warning: cannot find entry symbol __start;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;defaulting to 0000000080020000<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>/tmp/ccEaLxlW.o: In function `main':<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>hello.c:(.text+0x20): undefined reference to `pri=
ntf'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>hello.c:(.text+0x20): relocation truncated to fit:
R_MIPS_26 against `printf'<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>collect2: ld returned 1 exit status<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Does that mean the SDE lite package is not a comp=
lete
cross toolchain, can I use it to compile my own application? <o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Any help will be appropriated, thanks very much.<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Best Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Shan<o:p></o:p></span></font></p>

</div>

<br><br>
<P align=3Dcenter>This message has been scanned by <A href=3D"http://www.ma=
ilcontroller.altohiway.com/">MailController</A>.</P>
</body>

</html>

------_=_NextPart_001_01C6B194.D8D498EE--
