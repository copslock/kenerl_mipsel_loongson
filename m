Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 18:34:31 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:50175 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226102AbVF3ReJ>; Thu, 30 Jun 2005 18:34:09 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc12) with SMTP
          id <2005063017334001200h9fsne>; Thu, 30 Jun 2005 17:33:45 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Seg fault when compiled with -mabi=64 and -lpthread
Date:	Thu, 30 Jun 2005 13:33:39 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0057_01C57D78.566479A0"
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-index: AcV9mdoBnM33Jz9ERSG+iD9SiRy2CQ==
Message-Id: <20050630173409Z8226102-3678+735@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0057_01C57D78.566479A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have a problem when linking a 64 bit application with libpthread.  I
appears to link fine, but it will seg fault when I execute it.  I wrote an
empty C program called empty.c:

 

int main (void)

{  

    return 0;

}

 

I cross compile it with:

/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/bin/mips64-linux-g
nu-gcc -mabi=64 empty.c -o empty -lpthread

The executable will seg fault.  If I remove the -lpthread, it is fine.
Also, if I change the 64 to 32, it is fine.

 

Maybe I have a bad libpthread in /lib64?  If I type "file
/lib64/libpthread-0.10.so" I get: "ELF 64-bit MSB shared object, mips-3 MIPS
R3000_BE, version 1, not stripped".  Looks fine to me.  Should I cross
compile and replace libpthread?  If so, where can I find the source?

 

The other strange thing is that ldd does not work on 64 bit applications.
It will always return:  "not a dynamic executable".  Does anyone know how
this could be fixed?  

 

I'm using a PMC Yosemite board with an RM9224 processor.  The kernel is
2.6.12 64bit SMP.  I am using the PMC supplied cross compile tools, kernel,
and NFS file system. 

 

Thanks for your help!

Bryan

  

 


------=_NextPart_000_0057_01C57D78.566479A0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a problem when linking a 64 bit application =
with
libpthread.&nbsp; I appears to link fine, but it will seg fault when I =
execute
it.&nbsp; I wrote an empty C program called =
empty.c:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>int main (void)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>{&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; return =
0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I cross compile it with:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc=
2.2/bin/mips64-linux-gnu-gcc
&#8211;mabi=3D64 empty.c &#8211;o empty =
&#8211;lpthread<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The executable will seg fault.&nbsp; If I remove the
&#8211;lpthread, it is fine.&nbsp; Also, if I change the 64 to 32, it is =
fine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Maybe I have a bad libpthread in /lib64?&nbsp; If I =
type &#8220;file
/lib64/libpthread-0.10.so&#8221; I get: &#8220;ELF 64-bit MSB shared =
object,
mips-3 MIPS R3000_BE, version 1, not stripped&#8221;.&nbsp; Looks fine =
to
me.&nbsp; Should I cross compile and replace libpthread?&nbsp; If so, =
where can
I find the source?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The other strange thing is that ldd does not work on =
64 bit
applications.&nbsp; It will always return:&nbsp; &#8220;not a dynamic
executable&#8221;.&nbsp; Does anyone know how this could be fixed?&nbsp; =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m using a PMC Yosemite board with an RM9224
processor.&nbsp; The kernel is 2.6.12 64bit SMP.&nbsp; I am using the =
PMC
supplied cross compile tools, kernel, and NFS file system. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks for your help!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:City w:st=3D"on"><st1:place w:st=3D"on"><font =
size=3D2
  face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Bryan</span></font></st1:pla=
ce></st1:City><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0057_01C57D78.566479A0--
