Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 17:09:58 +0100 (BST)
Received: from 3phoenix.com ([207.234.209.100]:58858 "EHLO
	dedicated.3phoenix.com") by ftp.linux-mips.org with ESMTP
	id S20023607AbXFSQJz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 17:09:55 +0100
X-ClientAddr: 24.106.202.234
Received: from 3PiGAS (rrcs-24-106-202-234.se.biz.rr.com [24.106.202.234] (may be forged))
	(authenticated bits=0)
	by dedicated.3phoenix.com (8.13.6/8.13.6) with ESMTP id l5JGBj9o001148;
	Tue, 19 Jun 2007 12:11:47 -0400
From:	"Gary Smith" <gary.smith@3phoenix.com>
To:	<linux-mips@linux-mips.org>
Subject: Question About Timers for Performance Analysis on BCM1480/1250 Systems
Date:	Tue, 19 Jun 2007 12:07:21 -0400
Organization: 3 Phoenix, Inc.
Message-ID: <005a01c7b28b$ed279120$8facaac0@3PiGAS>
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_005B_01C7B26A.6615F120"
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: Aceyi+kOi1zTl48dTfK4NBZ228POZw==
X-3PHOENIX-MailScanner-Information: Please contact the ISP for more information
X-3PHOENIX-MailScanner:	Found to be clean
X-3PHOENIX-MailScanner-From: gary.smith@3phoenix.com
Return-Path: <gary.smith@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gary.smith@3phoenix.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_005B_01C7B26A.6615F120
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_005C_01C7B26A.6615F120"


------=_NextPart_001_005C_01C7B26A.6615F120
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

 

All,

 

The following message thread is present in the Linux-Mips archives regarding
the use of gettimeofday on Broadcom MIPS systems.
http://www.linux-mips.org/archives/linux-mips/2006-01/msg00144.html  The
message thread specifically addresses the Dual-core Broadcom 1250 system,
and the kernel version mentioned in the message thread is 2.6.12.  I looked
at the files mentioned in the message thread in the 2.6.17 kernel, and the
changes suggested for arch/mips/dec/time.c were present in 2.6.17.  However,
the subsequent patches suggested in the message thread were not present in
the version of the 2.6.17 kernel I checked.  We'd like to ask if the patches
suggested in the message thread have been observed to influence performance
numbers obtained by other Linux system developers for Quad-core Broadcom
1480 systems?  If so, do the Linux-Mips developers suggest that we apply the
patches suggested in the message thread for our Broadcom 1480 MIPS specific
Linux 2.6.17 system implementation?

 

Thanks,

Gary

--

Gary A. Smith, ABD PhD
Engineer, 3Phoenix, Inc.

3331 Heritage Trade Drive

Suite 101

Wake Forest, NC  27587

919.562.5333 x107

 <http://www.3Phoenix.com> http://www.3Phoenix.com

Gary.Smith@3Phoenix.com

 


------=_NextPart_001_005C_01C7B26A.6615F120
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"sans serif";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"sans serif";
	color:black;
	mso-believe-normal-left:yes;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Courier New";
	color:black;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<![if mso 9]>
<style>
p.MsoNormal
	{margin-left:37.5pt;}
</style>
<![endif]><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body bgcolor=3Dwhite background=3D"cid:image001.jpg@01C7B26A.61FA7570" =
lang=3DEN-US
link=3Dblue vlink=3Dpurple style=3D'margin-left:37.5pt'>
<img src=3D"cid:image001.jpg@01C7B26A.61FA7570"
v:src=3D"cid:image001.jpg@01C7B26A.61FA7570" v:shapes=3D"_x0000_Mail" =
width=3D0
height=3D0 class=3Dshape style=3D'display:none;width:0;height:0'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>The following =
message thread
is present in the Linux-Mips archives regarding the use of gettimeofday =
on
Broadcom MIPS systems.&nbsp; </span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><a
href=3D"http://www.linux-mips.org/archives/linux-mips/2006-01/msg00144.ht=
ml"
title=3D"blocked::http://www.linux-mips.org/archives/linux-mips/2006-01/m=
sg00144.html">http://www.linux-mips.org/archives/linux-mips/2006-01/msg00=
144.html</a></span></font><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;
The message thread specifically addresses the Dual-core Broadcom 1250 =
system,
and the kernel version mentioned in the message thread is 2.6.12.&nbsp; =
I looked at
the files mentioned in the message thread in the 2.6.17 kernel, and the =
changes
suggested for arch/mips/dec/time.c were present in 2.6.17.&nbsp; =
However, the
subsequent patches suggested in the message thread were not present in =
the
version of the 2.6.17 kernel I checked.&nbsp; We&#8217;d like to ask if =
the patches
suggested in the message thread have been observed to influence =
performance
numbers obtained by other Linux system developers for Quad-core Broadcom =
1480
systems?&nbsp; If so, do the Linux-Mips developers suggest that we apply =
the patches
suggested in the message thread for our Broadcom 1480 MIPS specific =
Linux
2.6.17 system implementation?</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Gary<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>--</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Gary A. Smith, ABD =
PhD<br>
Engineer, 3Phoenix, Inc.</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>3331 Heritage Trade =
Drive</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Suite =
101</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Wake Forest, =
NC&nbsp; 27587</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>919.562.5333 =
x107</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"sans =
serif"><span
style=3D'font-size:12.0pt'><a href=3D"http://www.3Phoenix.com"><font =
size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>http://www.3Phoenix.com</span></font></a><o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Gary.Smith@3Phoenix.com</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"sans =
serif"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_005C_01C7B26A.6615F120--

------=_NextPart_000_005B_01C7B26A.6615F120
Content-Type: image/jpeg;
	name="image001.jpg"
Content-Transfer-Encoding: base64
Content-ID: <image001.jpg@01C7B26A.61FA7570>

/9j/4AAQSkZJRgABAgEASABIAAD/7QSyUGhvdG9zaG9wIDMuMAA4QklNA+kAAAAAAHgAAwAAAEgA
SAAAAAADBgJS//f/9wMPAlsDRwUoA/wAAgAAAEgASAAAAAAC2AIoAAEAAABkAAAAAQADAwMAAAAB
Jw8AAQABAAAAAAAAAAAAAAAAYAgAGQGQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4
QklNA+0AAAAAABAASAAAAAEAAQBIAAAAAQABOEJJTQPzAAAAAAAIAAAAAAAAAAA4QklNBAoAAAAA
AAEAADhCSU0nEAAAAAAACgABAAAAAAAAAAI4QklNA/UAAAAAAEgAL2ZmAAEAbGZmAAYAAAAAAAEA
L2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAAAAYAAAAAAAEANQAAAAEALQAAAAYAAAAAAAE4QklN
A/gAAAAAAHAAAP////////////////////////////8D6AAAAAD/////////////////////////
////A+gAAAAA/////////////////////////////wPoAAAAAP//////////////////////////
//8D6AAAOEJJTQQAAAAAAAACAAA4QklNBAIAAAAAAAIAADhCSU0ECAAAAAAAEAAAAAEAAAJAAAAC
QAAAAAA4QklNBAkAAAAAAqIAAAABAAAAgAAAAAIAAAGAAAADAAAAAoYAGAAB/9j/4AAQSkZJRgAB
AgEASABIAAD//gAnRmlsZSB3cml0dGVuIGJ5IEFkb2JlIFBob3Rvc2hvcKggNC4wAP/uAA5BZG9i
ZQBkgAAAAAH/2wCEAAwICAgJCAwJCQwRCwoLERUPDAwPFRgTExUTExgRDAwMDAwMEQwMDAwMDAwM
DAwMDAwMDAwMDAwMDAwMDAwMDAwBDQsLDQ4NEA4OEBQODg4UFA4ODg4UEQwMDAwMEREMDAwMDAwR
DAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDP/AABEIAAIAgAMBIgACEQEDEQH/3QAEAAj/xAE/
AAABBQEBAQEBAQAAAAAAAAADAAECBAUGBwgJCgsBAAEFAQEBAQEBAAAAAAAAAAEAAgMEBQYHCAkK
CxAAAQQBAwIEAgUHBggFAwwzAQACEQMEIRIxBUFRYRMicYEyBhSRobFCIyQVUsFiMzRygtFDByWS
U/Dh8WNzNRaisoMmRJNUZEXCo3Q2F9JV4mXys4TD03Xj80YnlKSFtJXE1OT0pbXF1eX1VmZ2hpam
tsbW5vY3R1dnd4eXp7fH1+f3EQACAgECBAQDBAUGBwcGBTUBAAIRAyExEgRBUWFxIhMFMoGRFKGx
QiPBUtHwMyRi4XKCkkNTFWNzNPElBhaisoMHJjXC0kSTVKMXZEVVNnRl4vKzhMPTdePzRpSkhbSV
xNTk9KW1xdXl9VZmdoaWprbG1ub2JzdHV2d3h5ent8f/2gAMAwEAAhEDEQA/APROif0Kv6X81T9L
j+ar/m/5K0F8rJJIfqlJfKySKn6pSXyskkp+qUl8rJJKfqlJfKySSn6pSXyskkp+qUl8rJJKfqlJ
fKySSn//2ThCSU0EBgAAAAAABwABAAAAAQEA//4AJ0ZpbGUgd3JpdHRlbiBieSBBZG9iZSBQaG90
b3Nob3CoIDQuMAD/7gAOQWRvYmUAZIAAAAAB/9sAhAAMCAgNCQ0VDAwVGhQQFBogGxoaGyAiFxcX
FxciEQwMDAwMDBEMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMAQ0NDREOERsRERsUDg4OFBQO
Dg4OFBEMDAwMDBERDAwMDAwMEQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAAYBaAD
ASIAAhEBAxEB/90ABABa/8QBPwAAAQUBAQEBAQEAAAAAAAAAAwABAgQFBgcICQoLAQABBQEBAQEB
AQAAAAAAAAABAAIDBAUGBwgJCgsQAAEEAQMCBAIFBwYIBQMMMwEAAhEDBCESMQVBUWETInGBMgYU
kaGxQiMkFVLBYjM0coLRQwclklPw4fFjczUWorKDJkSTVGRFwqN0NhfSVeJl8rOEw9N14/NGJ5Sk
hbSVxNTk9KW1xdXl9VZmdoaWprbG1ub2N0dXZ3eHl6e3x9fn9xEAAgIBAgQEAwQFBgcHBgU1AQAC
EQMhMRIEQVFhcSITBTKBkRShsUIjwVLR8DMkYuFygpJDUxVjczTxJQYWorKDByY1wtJEk1SjF2RF
VTZ0ZeLys4TD03Xj80aUpIW0lcTU5PSltcXV5fVWZnaGlqa2xtbm9ic3R1dnd4eXp7fH/9oADAMB
AAIRAxEAPwCv0T+n4/8AxrP+qavW15J0U/r+P/xrP+qavWg8eKElsWSHZfXWYe4A+ZUMjIFTJBE/
Fc1kXbg63mJP+amk0uesGqdc19Sup2ZrLmWGQxwLR4B35v8A0V0qKlJJJIqUkkkkpSSSSSlJJJJK
UkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSS
SSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJ
KUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpS
SSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJ
JKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkp
SSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJJJKUkkkkpSSSSSlJJ
JJKUkkkkpSSSSSn/0J9G6oKn04zKKXOdYA6x7d1kOP8Ag/3Hs/MXY/sOl/0hYfCT/wCQavnZJArQ
/S1HTXVN21+weYa7/vqzcroeQ+Q3XcYOn/mbF89pIaJfpboXRK+k1uDQPUsILyONPotZ/JatRfKq
SSX6qSXyqkip+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJ
KfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp
+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6
qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqp
JfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl
8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXy
qkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKq
SSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJ
KfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp
+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn6
qSXyqkkp+qkl8qpJKfqpJfKqSSn6qSXyqkkp+qkl8qpJKfqpJfKqSSn/2Q==

------=_NextPart_000_005B_01C7B26A.6615F120--
