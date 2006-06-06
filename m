Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2006 14:33:55 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:43440 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133926AbWFFNdq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2006 14:33:46 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k56DXdpX022190;
	Tue, 6 Jun 2006 06:33:39 -0700 (PDT)
Received: from ism-mail01.corp.ad.wrs.com ([147.11.96.20]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Jun 2006 06:33:38 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6896D.D06A1676"
Subject: RE: Socket buffer allocation outside DMA-able memory
Date:	Tue, 6 Jun 2006 15:33:35 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080EEA2114@ism-mail01.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Socket buffer allocation outside DMA-able memory
Thread-Index: AcaJZjbxp1IvfUOrSwyzJ2H7FF15GwABt95Q
From:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
To:	"ashley jones" <ashley_jones_2000@yahoo.com>,
	"art" <art@sigrand.ru>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Jun 2006 13:33:38.0411 (UTC) FILETIME=[D1649BB0:01C6896D]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6896D.D06A1676
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

Maybe you can enable ISA bus. And then add your low 32MB memory into =
ZONE_DMA, while the high 32MB memory into ZONE_NORMAL.

In the case, you are required to redefine MAX_DMA_ADDRESS to =
(PAGE_OFFSET + 0x00200000) in asm-mips/dma.h

=20

=20

Just a noise.

=20

Best Regards,
Mark. Zhan

________________________________

From: linux-mips-bounce@linux-mips.org =
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of ashley jones
Sent: Tuesday, June 06, 2006 8:38 PM
To: art; linux-mips@linux-mips.org
Subject: Re: Socket buffer allocation outside DMA-able memory

=20

hi,

       I guess your 25 bit dma address field will be word alligned, so =
ur dma engine will be able to index up to 64 MB( 25+2 =3D 27 bits).

=20

        If that is not the case then you can use one of the foll. work =
around,

=20

  * dont give whole 64 MB to linux, give only Lower 32 MB.

  * Give only upper 32 MB to linux, and give memory to ur dma engine =
from lower 32 MB, and once you recv any data you copy to skb and submit =
to linux. ( ofcourse your performance will get hit in this case.)

=20

=20

Regards,

A'Jones.



art <art@sigrand.ru> wrote:

	Hello all!
	I work with ADM5120 chip. it has embedded switch.
	Switch descriptor has 25-bit dma addres field - so addressible only
	32Mb!
	My system has 64Mb memory. But I have to set 32Mb to make it work!
	I thought that setting DMA mask can help. So in
	/arch/mips/adm5120/setup.c i make:
=09
	static struct platform_device adm5120hcd_device =3D {
	.name =3D "adm5120-hcd",
	.id =3D -1,
	.dev =3D {
	.dma_mask =3D &hcd_dmamask,
	.coherent_dma_mask =3D 0x01ffffff,
	},
	.num_resources =3D ARRAY_SIZE(adm5120_hcd_resources),
	.resource =3D adm5120_hcd_resources,
	};
	But It is wrong, because dev_alloc_skb dont know to which device it
	allocates buffer!
=09
	How to tell kernel allocate skbuffers in less then 32Mb addrspace whet
	system has 64Mb?
=09
	--=20
	Best regards,
	art mailto:art@sigrand.ru
=09
=09
=09

=20

__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


------_=_NextPart_001_01C6896D.D06A1676
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place" downloadurl=3D"http://www.5iantlavalamp.com/"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Hi,<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Maybe you can =
enable ISA
bus. And then add your low 32MB memory into ZONE_DMA, while the high =
32MB
memory into ZONE_NORMAL.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>In the case, you =
are
required to redefine MAX_DMA_ADDRESS to (PAGE_OFFSET + 0x00200000) in
asm-mips/dma.h<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'>Just a =
noise.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3Dnavy face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p><=
/span></font></p>

<div>

<p style=3D'margin:0cm;margin-bottom:.0001pt'><font size=3D2 =
color=3Dnavy
face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:10.0pt;color:navy'>Best
Regards,<br>
Mark. Zhan</span></font><span lang=3DEN-US><o:p></o:p></span></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span lang=3DEN-US style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</spa=
n></font></b><font
size=3D2 face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Tahoma'>
linux-mips-bounce@linux-mips.org =
[mailto:linux-mips-bounce@linux-mips.org] <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>ashley jones<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, June 06, =
2006 8:38
PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> art; =
linux-mips@linux-mips.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: Socket =
buffer
allocation outside DMA-able memory</span></font><span =
lang=3DEN-US><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>hi,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I guess =
your 25
bit dma address field will be word alligned, so ur dma engine will be =
able to
index up to 64 MB( 25+2 =3D 27 bits).<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If =
that is
not the case then you can use one of the foll. work =
around,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp; * dont give whole 64 MB to linux, give =
only
Lower 32 MB.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp; * Give only upper 32 MB to linux, and =
give
memory to <st1:City w:st=3D"on"><st1:place =
w:st=3D"on">ur</st1:place></st1:City>
dma engine from lower 32 MB, and once you recv any data you copy to skb =
and
submit to linux. ( ofcourse your performance will get hit in this =
case.)<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>Regards,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'>A'Jones.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'><br>
<br>
<b><i><span style=3D'font-weight:bold;font-style:italic'>art
&lt;art@sigrand.ru&gt;</span></i></b> =
wrote:<o:p></o:p></span></font></p>

</div>

<blockquote style=3D'border:none;border-left:solid #1010FF =
1.5pt;padding:0cm 0cm 0cm 4.0pt;
margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt'>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:12.0pt'>Hello all!<br>
I work with ADM5120 chip. it has embedded switch.<br>
Switch descriptor has 25-bit dma addres field - so addressible only<br>
32Mb!<br>
My system has 64Mb memory. But I have to set 32Mb to make it work!<br>
I thought that setting DMA mask can help. So in<br>
/arch/mips/adm5120/setup.c i make:<br>
<br>
static struct platform_device adm5120hcd_device =3D {<br>
.name =3D &quot;adm5120-hcd&quot;,<br>
.id =3D -1,<br>
.dev =3D {<br>
.dma_mask =3D &amp;hcd_dmamask,<br>
.coherent_dma_mask =3D 0x01ffffff,<br>
},<br>
.num_resources =3D ARRAY_SIZE(adm5120_hcd_resources),<br>
.resource =3D adm5120_hcd_resources,<br>
};<br>
But It is wrong, because dev_alloc_skb dont know to which device it<br>
allocates buffer!<br>
<br>
How to tell kernel allocate skbuffers in less then 32Mb addrspace =
whet<br>
system has 64Mb?<br>
<br>
-- <br>
Best regards,<br>
art mailto:art@sigrand.ru<br>
<br>
<br>
<o:p></o:p></span></font></p>

</blockquote>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p><font size=3D3 face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'font-size:12.0pt'>______________________________________________=
____<br>
Do You Yahoo!?<br>
Tired of spam? Yahoo! Mail has the best spam protection around <br>
http://mail.yahoo.com <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6896D.D06A1676--
