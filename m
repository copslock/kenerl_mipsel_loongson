Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 15:13:21 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:65209 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8133477AbWGSONM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Jul 2006 15:13:12 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 3D57220654
	for <linux-mips@linux-mips.org>; Wed, 19 Jul 2006 19:40:10 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 2901020626
	for <linux-mips@linux-mips.org>; Wed, 19 Jul 2006 19:40:10 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 19 Jul 2006 19:43:03 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AB3D.728FBB18"
Subject: CRAMFS  Ramdisk image as Rootfs
Date:	Wed, 19 Jul 2006 19:43:03 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D2DE@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CRAMFS  Ramdisk image as Rootfs
Thread-Index: AcarPJ0J09gYqrEETqyoWap0XUe/Hg==
From:	<hemanth.venkatesh@wipro.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 19 Jul 2006 14:13:03.0280 (UTC) FILETIME=[72BA3B00:01C6AB3D]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AB3D.728FBB18
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

=20

I was trying to mount cramfs image as Ramdisk rootfs for 2.6.14 kernel.
Even though the kernel seems to detect the cramfs image, it is not able
to mount it as rootfs. It throws the error "cramfs: bad root offset
4864" The target is little endian, and  RHEL host on which the image was
built is also little endian.=20

=20

The other images like EXT2 for ramdisk don't seem to get detected at
all, and just throws error "VFS: Unable to mount root fs on
unknown-block(1,0)".  Anyone faced similar issue before or knows what
could be causing the problem.

=20

go r root=3D/dev/ram rd_start=3D0x85000000 rd_size=3D5009408 =
rootfstype=3Dcramfs

=20

Initializing IPsec netlink socket

NET: Registered protocol family 1

NET: Registered protocol family 17

md: Autodetecting RAID arrays.

md: autorun ...

md: ... autorun DONE.

WIPRO path_lookup retval 0

WIPRO security_sb_mount  retval 0

WIPRO do_new_mount retval 0

WIPRO do_mount retval 0

RAMDISK: cramfs filesystem found at block 0

RAMDISK: Loading 4892KiB [1 disk] into ram disk... done.

cramfs: bad root offset 4864

=20

Thanks

Hemanth


------_=_NextPart_001_01C6AB3D.728FBB18
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
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
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
font-family:Arial'>Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I was trying to <st1:place w:st=3D"on"><st1:PlaceType =
w:st=3D"on">mount</st1:PlaceType>
 <st1:PlaceName w:st=3D"on">cramfs</st1:PlaceName></st1:place> image as =
Ramdisk
rootfs for 2.6.14 kernel. Even though the kernel seems to detect the =
cramfs
image, it is not able to mount it as rootfs. It throws the error =
&#8220;cramfs:
bad root offset 4864&#8221; The target is little endian, and &nbsp;RHEL =
host on
which the image was built is also little endian. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The other images like EXT2 for ramdisk don&#8217;t =
seem to
get detected at all, and just throws error &#8220;VFS: Unable to mount =
root fs
on unknown-block(1,0)&#8221;.&nbsp; Anyone faced similar issue before or =
knows
what could be causing the problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>go r root=3D/dev/ram rd_start=3D0x85000000 =
rd_size=3D5009408
rootfstype=3Dcramfs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initializing IPsec netlink =
socket<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET: Registered protocol family =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET: Registered protocol family =
17<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>md: Autodetecting RAID =
arrays.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>md: autorun ...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>md: ... autorun DONE.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>WIPRO path_lookup retval =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>WIPRO security_sb_mount&nbsp; retval =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>WIPRO do_new_mount retval =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>WIPRO do_mount retval 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>RAMDISK: cramfs filesystem found at block =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>RAMDISK: Loading 4892KiB [1 disk] into ram disk... =
done.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>cramfs: bad root offset =
4864<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hemanth<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6AB3D.728FBB18--
