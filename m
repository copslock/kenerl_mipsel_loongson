Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 03:46:20 +0100 (BST)
Received: from cnxtsmtp8.conexant.com ([IPv6:::ffff:216.89.70.36]:51212 "EHLO
	mime-nj.bbnet.ad") by linux-mips.org with ESMTP id <S8224769AbVDFCqC>;
	Wed, 6 Apr 2005 03:46:02 +0100
Received: Conexant Mail
Received: Conexant Mail
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative; 
    boundary="----_=_NextPart_001_01C53A52.D9177C15"
Subject: Cross compile
Date:	Wed, 6 Apr 2005 08:16:33 +0530
Message-ID: <4D6E93075B31154298572E6B73CA849D72EC03@noida-mail.bbnet.ad>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cross compile
Thread-Index: AcU6UteoiX38l1tITmKuprCVhpo9Dw==
From:	"B Srinivas " <b.srinivas@conexant.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Apr 2005 02:46:43.0833 (UTC) 
    FILETIME=[DE208690:01C53A52]
Return-Path: <b.srinivas@conexant.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: b.srinivas@conexant.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53A52.D9177C15
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

     Iam trying to build a crosscompiler for MIPS64 big endian. Host
system being i686.

I have downloaded gcc 3.4.2 , binutils 2.15 and glibc 2.3.3 with kernel
2.4.20.

Iam following steps given below :

                     =20

    tar -xvf binutils-2.15.tar

    cd binutils-2.15

     ./configure - - prefix=3D/opt/cross  - - target=3Dmips3-linux=20

     make=20

     make install

=20

  =20

=20

   tar -xvf gcc-3.4.2.tar

   cd gcc-3.4.2

   ./configure - - prefix=3D/opt/cross - - target=3Dmips3-linux  - -
with-headers=3D../linux/include -enable-languages=3Dc -disable-threads

(I have my untarred linux directory in the parent directory.)

=20

   cd gcc

    vi tconfig.h

   =20

   I edit at the end #ifndef inhibit_libc

                           #define inhibit_libc

                           #endif

=20

    make

=20

    here I get the following errors :

=20

                                    sys/types.h , unistd.h , errno.h ,
time.h  no such file or directory !!!

=20

can anybody please direct me where iam goin wrong or is it that I need
patches for this ??

=20

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


------_=_NextPart_001_01C53A52.D9177C15
Content-Type: text/html; charset="us-ascii"
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
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; Iam trying to build a crosscomp=
iler
for MIPS64 big endian. Host system being i686.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>I have downloaded gcc 3.4.2 , binutils 2.15 and glibc 2.=
3.3
with kernel 2.4.20.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Iam following steps given below :<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; tar &#8211;xvf binutils-2.15.tar<o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; cd binutils-2.15<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; ./configure - - prefix=3D/opt/c=
ross &nbsp;-
- target=3Dmips3-linux <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; make <o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; make install<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; tar &#8211;xvf gcc-3.4.2.tar<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; cd gcc-3.4.2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; ./configure - - prefix=3D/opt/cross - - tar=
get=3Dmips3-linux
&nbsp;- - with-headers=3D../linux/include &#8211;enable-languages=3Dc &#821=
1;disable-threads<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>(I have my untarred linux directory in the parent
directory.)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; cd gcc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; vi tconfig.h<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; I edit at the end #ifndef inhibit_libc<o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
#define inhibit_libc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
#endif<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp; &nbsp;make<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp; here I get the following errors :<o:p=
></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
sys/types.h , unistd.h , errno.h , time.h&nbsp; no such file or directory !=
!!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>can anybody please direct me where iam goin wrong or is =
it
that I need patches for this ??<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

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

------_=_NextPart_001_01C53A52.D9177C15--
