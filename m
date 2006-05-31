Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 06:18:51 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:54977 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133427AbWEaESk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 06:18:40 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k4V4IW3g019194;
	Tue, 30 May 2006 21:18:33 -0700 (PDT)
Received: from ism-mail01.corp.ad.wrs.com ([147.11.96.20]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 30 May 2006 21:18:32 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C68469.4557660F"
Subject: RE: Problem with TLB mcheck!
Date:	Wed, 31 May 2006 06:18:26 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080EDC158B@ism-mail01.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with TLB mcheck!
Thread-Index: AcaEZHT4NdAIHrnnQhyU2pxKtuNSsAABJoRQ
From:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
To:	"art" <art@sigrand.ru>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 31 May 2006 04:18:32.0324 (UTC) FILETIME=[46F08C40:01C68469]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68469.4557660F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

Please see: =
http://www.linux-mips.org/archives/linux-mips/2005-04/msg00026.html

=20

Best Regards,

Mark. Zhan

---------------------------------------

Wind River System, Inc. China Beijing Office

     Tel: +86 010 64398185/86/87 Ext. 16

Mobile: +86 139 1097 7353

    Fax: +86 64398189

E-Mail: rongkai.zhan@windriver.com

---------------------------------------

-----Original Message-----
From: linux-mips-bounce@linux-mips.org =
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of art
Sent: Wednesday, May 31, 2006 11:42 AM
To: linux-mips@linux-mips.org
Subject: Problem with TLB mcheck!

=20

Sorry for resending, but I find out that I wasn't subscribed!

I use 2.6.16 kernel from linux-mips.org (from tarrball).

When I execute:

# cat /bin/busybox > box

Got mcheck at 800f9b68

Cpu 0

$ 0   : 00000000 10008400 c00216bc c00316bc

$ 4   : c00116bc 00004000 00000005 00008000

$ 8   : c00356bc c003d6bc c00016bc 00010000

$12   : 0000000f 00008000 00007fff 00007fff

$16   : 00000003 8024da80 00000008 c0000000

$20   : 00000000 803d7000 8118c000 80240000

$24   : 0000000f 00000000

$28   : 81200000 81201b80 00001000 800f9c0c

Hi    : 0000000b

Lo    : 5555555b

epc   : 800f9b68 zlib_deflateInit2_+0x184/0x200     Not tainted

ra    : 800f9c0c zlib_deflateInit_+0x28/0x34

Status: 10208403    KERNEL EXL IE

Cause : 00800060

PrId  : 0001800b

Hi    : 0000000b

Pagemask: ffffffff

EntryHi : c0000096

EntryLo0: 0000a05f

EntryLo1: 0000a09f

=20

Index:  3 pgmask=3D4kb va=3D00468000 asid=3D96

                        [pa=3D00378000 c=3D3 d=3D0 v=3D1 g=3D0]

                        [pa=3D00000000 c=3D0 d=3D0 v=3D0 g=3D0]

=20

Index:  6 pgmask=3D4kb va=3D7fa0a000 asid=3D96

                        [pa=3D012f7000 c=3D3 d=3D1 v=3D1 g=3D0]

                        [pa=3D01244000 c=3D3 d=3D1 v=3D1 g=3D0]

=20

Index:  7 pgmask=3D4kb va=3D004f0000 asid=3D96

                        [pa=3D012f4000 c=3D3 d=3D1 v=3D1 g=3D0]

                        [pa=3D00000000 c=3D0 d=3D0 v=3D0 g=3D0]

=20

Index: 10 pgmask=3D4kb va=3D0046e000 asid=3D96

                        [pa=3D00310000 c=3D3 d=3D0 v=3D1 g=3D0]

                        [pa=3D00311000 c=3D3 d=3D0 v=3D1 g=3D0]

=20

Index: 11 pgmask=3D4kb va=3D0046a000 asid=3D96

                        [pa=3D0030c000 c=3D3 d=3D0 v=3D1 g=3D0]

                        [pa=3D00000000 c=3D0 d=3D0 v=3D0 g=3D0]

=20

Index: 15 pgmask=3D4kb va=3D0048c000 asid=3D96

                        [pa=3D0032e000 c=3D3 d=3D0 v=3D1 g=3D0]

                        [pa=3D0032f000 c=3D3 d=3D0 v=3D1 g=3D0]

=20

=20

Code: 00684021  00055880  ae33001c <ae640038> a272001d  ae740018=20

ae6e002c  ae6f004c  ae660050

Kernel panic - not syncing: Caught Machine Check exception - caused

by multiple matching entries in the TLB.

=20

This thig happens, as I noted, when work with relatively big amounts

of memory ( more than 10-60Kb). busybox for example 700Kb

=20

=20

--=20

Best regards,

 art                            mailto:art@sigrand.ru

=20

=20

=20


------_=_NextPart_001_01C68469.4557660F
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"country-region"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chsdate" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"chmetcnv" downloadurl=3D""/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PersonName"/>
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:SimSun;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt .65pt 72.0pt .65pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Please see: <a
href=3D"http://www.linux-mips.org/archives/linux-mips/2005-04/msg00026.ht=
ml">http://www.linux-mips.org/archives/linux-mips/2005-04/msg00026.html</=
a><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Best Regards,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Mark. Zhan<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>---------------------------------------<o:p></o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Wind River System, Inc. <st1:country-region =
w:st=3D"on">China</st1:country-region>
<st1:City w:st=3D"on"><st1:place =
w:st=3D"on">Beijing</st1:place></st1:City> =
Office<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0 Tel: +86 010 64398185/86/87 Ext. =
16<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DDE
style=3D'font-size:9.0pt'>Mobile: +86 139 1097 =
7353<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DDE
style=3D'font-size:9.0pt'>=A0=A0=A0 Fax: +86 =
64398189<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DDE
style=3D'font-size:9.0pt'>E-Mail: =
rongkai.zhan@windriver.com<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>---------------------------------------<o:p></o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>-----Original Message-----<br>
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of art<br>
Sent: Wednesday, May 31, 2006 11:42 AM<br>
To: <st1:PersonName =
w:st=3D"on">linux-mips@linux-mips.org</st1:PersonName><br>
Subject: Problem with TLB mcheck!</span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Sorry for resending, but I find out that I =
wasn't
subscribed!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>I use <st1:chsdate IsROCDate=3D"False" =
IsLunarDate=3D"False"
Day=3D"30" Month=3D"12" Year=3D"1899" w:st=3D"on">2.6.16</st1:chsdate> =
kernel from
linux-mips.org (from tarrball).<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>When I execute:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'># cat /bin/busybox &gt; =
box<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Got mcheck at <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"800" UnitName=3D"F" =
w:st=3D"on">800f</st1:chmetcnv>9b68<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Cpu 0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$ 0=A0=A0 : 00000000 <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"10008400" =
UnitName=3D"C" w:st=3D"on">10008400
 c</st1:chmetcnv>00216bc c00316bc<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$ 4=A0=A0 : c00116bc 00004000 00000005 =
00008000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$ 8=A0=A0 : c00356bc c003d6bc c00016bc =
00010000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$12=A0=A0 : <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"0" UnitName=3D"F" =
w:st=3D"on">0000000f</st1:chmetcnv>
00008000 00007fff 00007fff<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$16=A0=A0 : 00000003 8024da80 <st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"8" =
UnitName=3D"C"
w:st=3D"on">00000008 =
c</st1:chmetcnv>0000000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$20=A0=A0 : 00000000 803d7000 <st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"8118" UnitName=3D"C"
w:st=3D"on">8118c</st1:chmetcnv>000 =
80240000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$24=A0=A0 : <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"0" UnitName=3D"F" =
w:st=3D"on">0000000f</st1:chmetcnv>
00000000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>$28=A0=A0 : 81200000 81201b80 00001000 =
<st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"800"
UnitName=3D"F" w:st=3D"on">800f</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"9" UnitName=3D"C" =
w:st=3D"on">9c</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"0"
UnitName=3D"C" =
w:st=3D"on">0c</st1:chmetcnv><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Hi=A0=A0=A0 : =
0000000b<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Lo=A0=A0=A0 : =
5555555b<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>epc=A0=A0 : <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"800" UnitName=3D"F" =
w:st=3D"on">800f</st1:chmetcnv>9b68
zlib_deflateInit2_+0x184/0x200=A0=A0=A0=A0 Not =
tainted<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>ra=A0=A0=A0 : <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"800" UnitName=3D"F" =
w:st=3D"on">800f</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"9"
UnitName=3D"C" w:st=3D"on">9c</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"0" UnitName=3D"C" =
w:st=3D"on">0c</st1:chmetcnv>
zlib_deflateInit_+0x28/0x34<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Status: 10208403=A0=A0=A0 KERNEL EXL =
IE<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Cause : 00800060<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>PrId=A0 : =
0001800b<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Hi=A0=A0=A0 : =
0000000b<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Pagemask: =
ffffffff<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>EntryHi : =
c0000096<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>EntryLo0: <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"0" UnitName=3D"a" =
w:st=3D"on">0000a</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"5"
UnitName=3D"F" =
w:st=3D"on">05f</st1:chmetcnv><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>EntryLo1: <st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"0" UnitName=3D"a" =
w:st=3D"on">0000a</st1:chmetcnv><st1:chmetcnv
TCSC=3D"0" NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"9"
UnitName=3D"F" =
w:st=3D"on">09f</st1:chmetcnv><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Index:=A0 3 pgmask=3D4kb va=3D00468000 =
asid=3D96<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"378000"
UnitName=3D"C" w:st=3D"on">00378000 c</st1:chmetcnv>=3D3 d=3D0 =
v=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"1" =
UnitName=3D"g"
w:st=3D"on">1 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"C"
w:st=3D"on">00000000 c</st1:chmetcnv>=3D0 d=3D0 v=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"g"
w:st=3D"on">0 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Index:=A0 6 pgmask=3D4kb va=3D7fa<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"0" =
UnitName=3D"a"
w:st=3D"on">0a</st1:chmetcnv>000 asid=3D96<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"12" UnitName=3D"F"
w:st=3D"on">012f</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"7000" UnitName=3D"C" =
w:st=3D"on">7000
 c</st1:chmetcnv>=3D3 d=3D1 v=3D<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1" Negative=3D"False"
HasSpace=3D"True" SourceValue=3D"1" UnitName=3D"g" w:st=3D"on">1 =
g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"1244000"
UnitName=3D"C" w:st=3D"on">01244000 c</st1:chmetcnv>=3D3 d=3D1 =
v=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"1" =
UnitName=3D"g"
w:st=3D"on">1 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Index:=A0 7 pgmask=3D4kb va=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"4" =
UnitName=3D"F"
w:st=3D"on">004f</st1:chmetcnv>0000 =
asid=3D96<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"12" UnitName=3D"F"
w:st=3D"on">012f</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"4000" UnitName=3D"C" =
w:st=3D"on">4000
 c</st1:chmetcnv>=3D3 d=3D1 v=3D<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1" Negative=3D"False"
HasSpace=3D"True" SourceValue=3D"1" UnitName=3D"g" w:st=3D"on">1 =
g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0[pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"C"
w:st=3D"on">00000000 c</st1:chmetcnv>=3D0 d=3D0 v=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"g"
w:st=3D"on">0 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Index: 10 pgmask=3D4kb va=3D0046e000 =
asid=3D96<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"310000"
UnitName=3D"C" w:st=3D"on">00310000 c</st1:chmetcnv>=3D3 d=3D0 =
v=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"1" =
UnitName=3D"g"
w:st=3D"on">1 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" =
SourceValue=3D"311000"
UnitName=3D"C" w:st=3D"on">00311000 c</st1:chmetcnv>=3D3 d=3D0 =
v=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"1" =
UnitName=3D"g"
w:st=3D"on">1 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Index: 11 pgmask=3D4kb va=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"46" UnitName=3D"a"
w:st=3D"on">0046a</st1:chmetcnv>000 =
asid=3D96<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0[pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"30" UnitName=3D"C"
w:st=3D"on">0030c</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" UnitName=3D"C" =
w:st=3D"on">000 c</st1:chmetcnv>=3D3
d=3D0 v=3D<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"True"
SourceValue=3D"1" UnitName=3D"g" w:st=3D"on">1 =
g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"C"
w:st=3D"on">00000000 c</st1:chmetcnv>=3D0 d=3D0 v=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"g"
w:st=3D"on">0 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Index: 15 pgmask=3D4kb va=3D<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"48" UnitName=3D"C"
w:st=3D"on">0048c</st1:chmetcnv>000 =
asid=3D96<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D0032e<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" =
UnitName=3D"C"
w:st=3D"on">000 c</st1:chmetcnv>=3D3 d=3D0 v=3D<st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"1" UnitName=3D"g" =
w:st=3D"on">1 g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [pa=3D<st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"32" UnitName=3D"F"
w:st=3D"on">0032f</st1:chmetcnv><st1:chmetcnv TCSC=3D"0" =
NumberType=3D"1"
Negative=3D"False" HasSpace=3D"True" SourceValue=3D"0" UnitName=3D"C" =
w:st=3D"on">000 c</st1:chmetcnv>=3D3
d=3D0 v=3D<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"True"
SourceValue=3D"1" UnitName=3D"g" w:st=3D"on">1 =
g</st1:chmetcnv>=3D0]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Code: 00684021=A0 00055880=A0 ae<st1:chmetcnv =
TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" =
SourceValue=3D"33001"
UnitName=3D"C" w:st=3D"on">33001c</st1:chmetcnv> &lt;ae640038&gt; =
a272001d=A0
ae740018 <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>ae6e<st1:chmetcnv TCSC=3D"0" NumberType=3D"1"
Negative=3D"False" HasSpace=3D"False" SourceValue=3D"2" UnitName=3D"C" =
w:st=3D"on">002c</st1:chmetcnv>=A0
ae<st1:chmetcnv TCSC=3D"0" NumberType=3D"1" Negative=3D"False" =
HasSpace=3D"False"
SourceValue=3D"6" UnitName=3D"F" =
w:st=3D"on">6f</st1:chmetcnv><st1:chmetcnv TCSC=3D"0"
NumberType=3D"1" Negative=3D"False" HasSpace=3D"False" SourceValue=3D"4" =
UnitName=3D"C"
w:st=3D"on">004c</st1:chmetcnv>=A0 ae660050<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Kernel panic - not syncing: Caught Machine =
Check
exception - caused<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>by multiple matching entries in the =
TLB.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>This thig happens, as I noted, when work with
relatively big amounts<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>of memory ( more than 10-60Kb). busybox for =
example
700Kb<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>-- <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>Best regards,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US
style=3D'font-size:9.0pt'>=A0art=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
mailto:art@sigrand.ru<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D1 face=3D&#23435;&#20307;><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C68469.4557660F--
