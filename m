Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 01:19:31 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:51303 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20022105AbYADBTW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Jan 2008 01:19:22 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84E6F.A6F04519"
Subject: BUG: BUS error while returning from read() in /dev/oprofile/buffer
Date:	Thu, 3 Jan 2008 17:18:01 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C56440FC@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BUG: BUS error while returning from read() in /dev/oprofile/buffer
Thread-Index: AchOb6YezCF8sxJbR7Ou5yLm8ezCzg==
From:	"Anirban Sinha" <ASinha@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>, "Ralf Baechle" <ralf@linux-mips.org>
Return-Path: <ASinha@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ASinha@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C84E6F.A6F04519
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi:

=20

I have been trying to hunt down this bug for several days now. What
mainly happens is that when oprofiled wakes up from read() in
/dev/oprofile/buffer on receiving a signal USR1 (i.e, when someone does
opcontrol -start after doing opcontrol-start-daemon), it somehow gets
SIGBUS within glibc read().  We are using a mips machine with Sybyte SB1
processor. On intel, this error does not show up. Interestingly, when I
tried running a small test program that simply reads
/dev/oprofile/buffer, the error can't be reproduced!=20

=20

Ralf and others, any insights, suggestions or useful comments from
experience will be really really appreciated. I am spending a lot of
time trying to fix this bug.

=20

Cheers,

=20

Ani

=20


------_=_NextPart_001_01C84E6F.A6F04519
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have been trying to hunt down this bug for =
several days
now. What mainly happens is that when oprofiled wakes up from read() in
/dev/oprofile/buffer on receiving a signal USR1 (i.e, when someone does
opcontrol &#8211;start after doing opcontrol&#8212;start-daemon), it =
somehow
gets SIGBUS within glibc read(). &nbsp;We are using a mips machine with =
Sybyte
SB1 processor. On intel, this error does not show up. Interestingly, =
when I
tried running a small test program that simply reads =
/dev/oprofile/buffer, the
error can&#8217;t be reproduced! <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Ralf and others, any insights, suggestions or =
useful
comments from experience will be really really appreciated. I am =
spending a lot
of time trying to fix this bug.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Cheers,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Ani<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01C84E6F.A6F04519--
