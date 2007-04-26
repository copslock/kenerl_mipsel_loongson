Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 22:57:00 +0100 (BST)
Received: from smtp-out.sigp.net ([63.237.78.44]:40685 "EHLO smtp-out.sigp.net")
	by ftp.linux-mips.org with ESMTP id S20021450AbXDZV46 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Apr 2007 22:56:58 +0100
Received: from gamd-ex-001.ss.drs.master (gamd-ex-001.ss.drs.master [172.22.132.94])
	by smtp-out.sigp.net (8.14.1/8.14.1) with ESMTP id l3QLnRBt014516
	for <linux-mips@linux-mips.org>; Thu, 26 Apr 2007 17:49:27 -0400 (EDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7884C.C2CDFC39"
Subject: bug in arch/mips/sibyte/cfe/cfe_api.c ?
Date:	Thu, 26 Apr 2007 17:49:22 -0400
Message-ID: <DEB94D90ABFC8240851346CFD4ACFF14011DC8CC@gamd-ex-001.ss.drs.master>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: bug in arch/mips/sibyte/cfe/cfe_api.c ?
Thread-Index: AceITMAja369+xbgTq2GTnEwfJNdOA==
From:	"van Tassell, Eric" <Eric.VanTassell@drs-ss.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Eric.VanTassell@drs-ss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Eric.VanTassell@drs-ss.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7884C.C2CDFC39
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,

            The following change which showed up merging from 2.6.20.1
appears to be a bug.

=20

diff -U 3 linux/arch/mips/sibyte/cfe/cfe_api.c
linux-2.6.20.1/arch/mips/sibyte/cfe/cfe_api.c

--- linux/arch/mips/sibyte/cfe/cfe_api.c           2007-04-25
14:33:46.000000000 -0400

+++ linux-2.6.20.1/arch/mips/sibyte/cfe/cfe_api.c     2007-02-20
19:47:41.000000000 -0500

@@ -135,7 +135,7 @@

 {

            cfe_xiocb_t xiocb;

=20

-           xiocb.xiocb_fcode =3D CFE_CMD_ENV_ENUM;

+          xiocb.xiocb_fcode =3D CFE_CMD_ENV_SET;

            xiocb.xiocb_status =3D 0;

            xiocb.xiocb_handle =3D 0;

            xiocb.xiocb_flags =3D 0;

=20

=20

-         Eric van Tassell

=20

DRS Intelligence Technologies

Advanced Processing Group

21 Continental Blvd

Merrimack, NH 03054

P: 603.424.3750

www.drs-ss.com

=20


------_=_NextPart_001_01C7884C.C2CDFC39
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PostalCode"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	font-variant:normal !important;
	color:windowtext;
	text-transform:none;
	text-decoration:none none;
	vertical-align:baseline;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1575430080;
	mso-list-type:hybrid;
	mso-list-template-ids:682938830 -1580966302 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; The following change which showed up merging
from 2.6.20.1 appears to be a bug.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>diff -U 3 linux/arch/mips/sibyte/cfe/cfe_api.c
linux-2.6.20.1/arch/mips/sibyte/cfe/cfe_api.c<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>--- =
linux/arch/mips/sibyte/cfe/cfe_api.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 2007-04-25
14:33:46.000000000 -0400<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>+++ =
linux-2.6.20.1/arch/mips/sibyte/cfe/cfe_api.c&nbsp;&nbsp;&nbsp;&nbsp; =
2007-02-20
19:47:41.000000000 -0500<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>@@ -135,7 +135,7 @@<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; cfe_xiocb_t xiocb;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; xiocb.xiocb_fcode =3D =
CFE_CMD_ENV_ENUM;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; xiocb.xiocb_fcode =3D CFE_CMD_ENV_SET;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; xiocb.xiocb_status =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; xiocb.xiocb_handle =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; xiocb.xiocb_flags =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]>Eric van =
Tassell<o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>DRS Intelligence =
Technologies<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>Advanced Processing =
Group<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><st1:Street =
w:st=3D"on"><st1:address
 w:st=3D"on"><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>21
  Continental =
Blvd</span></font></st1:address></st1:Street><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><st1:place =
w:st=3D"on"><st1:City
 w:st=3D"on"><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Merrimack</span></font></st1:City>,
 <st1:State w:st=3D"on">NH</st1:State> <st1:PostalCode =
w:st=3D"on">03054</st1:PostalCode></st1:place><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>P: 603.424.3750<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'>www.drs-ss.com<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7884C.C2CDFC39--
