Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 14:34:43 +0100 (BST)
Received: from cnxtsmtp8.conexant.com ([IPv6:::ffff:216.89.70.36]:43277 "EHLO
	mime-nj.bbnet.ad") by linux-mips.org with ESMTP id <S8224914AbVDFNe3>;
	Wed, 6 Apr 2005 14:34:29 +0100
Received: Conexant Mail
Received: Conexant Mail
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative; 
    boundary="----_=_NextPart_001_01C53AAD.700E8EAF"
Subject: cross compiling
Date:	Wed, 6 Apr 2005 19:05:04 +0530
Message-ID: <4D6E93075B31154298572E6B73CA849D72F496@noida-mail.bbnet.ad>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cross compiling
Thread-Index: AcU6rXDE7LHF7ctJSHmLcg0QF+aegQ==
From:	"B Srinivas " <b.srinivas@conexant.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Apr 2005 13:35:11.0637 (UTC) 
    FILETIME=[74FC4450:01C53AAD]
Return-Path: <b.srinivas@conexant.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: b.srinivas@conexant.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53AAD.700E8EAF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

     Iam trying to set up a cross compiler tool chain for mips 64 bit
big endian.

Iam fixed in a chicken-egg kind of situation ......  during the
compilation the linker doesn't find the crti.o which is built using the
glibc but I still don't have glibc which need the compiler !!!. can
anybody point me to a solution.

=20

Regards

Srinivas

------------------------------------------------------------------------
------------

=20

=20

B.Srinivas

Software Engineer

Conexant Systems Inc. , Noida

Email : b.srinivas@conexant.com

=20





********************** Legal Disclaimer ****************************
"This email may contain confidential and privileged material for the sole u=
se of the intended recipient.  Any unauthorized review, use or distribution=
 by others is strictly prohibited.  If you have received the message in err=
or, please advise the sender by reply email and delete the message. Thank y=
ou."
**********************************************************************


------_=_NextPart_001_01C53AAD.700E8EAF
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; Iam trying to set up a cross co=
mpiler tool chain for
mips 64 bit big endian.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Iam fixed in a chicken-egg kind of situation &#8230;&#82=
30;&nbsp;
during the compilation the linker doesn&#8217;t find the crti.o which is bu=
ilt
using the glibc but I still don&#8217;t have glibc which need the compiler =
!!!.
can anybody point me to a solution.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Regards</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Srinivas</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>--------------------------------------------------------=
----------------------------</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>B.Srinivas</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Software Engineer</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Conexant Systems Inc. , Noida</span></font><o:p></o:p></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Email : b.srinivas@conexant.com</span></font><o:p></o:p>=
</p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>


<P STYLE=3D"margin-top: 0pt;margin-bottom: 0pt;"><SPAN STYLE=3D"FONT-FAMILY=
:'Arial';FONT-SIZE:8pt;"> </SPAN>
</P>
<P STYLE=3D"margin-top: 0pt;margin-bottom: 0pt;"><SPAN STYLE=3D"FONT-FAMILY=
:'Arial';FONT-SIZE:8pt;"> </SPAN>
</P>
<P STYLE=3D"margin-top: 0pt;margin-bottom: 0pt;"><SPAN STYLE=3D"FONT-FAMILY=
:'Arial';FONT-SIZE:8pt;">********************** Legal Disclaimer **********=
****************** </SPAN>
</P>
<P STYLE=3D"margin-top: 0pt;margin-bottom: 0pt;"><SPAN STYLE=3D"FONT-FAMILY=
:'Arial';FONT-SIZE:8pt;">&quot;This email may contain confidential and priv=
ileged material for the sole use of the intended recipient.  Any unauthoriz=
ed review, use or distribution by others is strictly prohibited.  If you ha=
ve received the message in error, please advise the sender by reply email a=
nd delete the message. Thank you.&quot; </SPAN>
</P>
<P STYLE=3D"margin-top: 0pt;margin-bottom: 0pt;"><SPAN STYLE=3D"FONT-FAMILY=
:'Arial';FONT-SIZE:8pt;">**************************************************=
******************** </SPAN> </P></body>

</html>

------_=_NextPart_001_01C53AAD.700E8EAF--
