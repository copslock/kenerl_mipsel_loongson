Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2006 10:24:04 +0000 (GMT)
Received: from web38411.mail.mud.yahoo.com ([209.191.125.42]:58247 "HELO
	web38411.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20053095AbWL2KX6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Dec 2006 10:23:58 +0000
Received: (qmail 66338 invoked by uid 60001); 29 Dec 2006 10:23:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type;
  b=xf2milACNmx73PnpQgiJWDh1wQUFPmFR7bD9oGZswOsrrNJ6x2Mf3zr1KQ5xdu0JyhSVxJpvGOjJRm5bCRyp20rPLgYBsNudhcas5zxXM4QA9rvSKMFkZ5OGp6Bd3yQjGELPnshW69XA5omHMMntMIX3p29XrqLko16oFg64f/E=  ;
Message-ID: <20061229102351.66336.qmail@web38411.mail.mud.yahoo.com>
Received: from [203.92.57.132] by web38411.mail.mud.yahoo.com via HTTP; Fri, 29 Dec 2006 02:23:51 PST
Date:	Fri, 29 Dec 2006 02:23:51 -0800 (PST)
From:	ashley jones <ashley_jones_2000@yahoo.com>
Subject: Doubt on mmap
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-403511557-1167387831=:65720"
Return-Path: <ashley_jones_2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashley_jones_2000@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-403511557-1167387831=:65720
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

hi,=0A         Can i "mmap" a physical memory region (part of dram) not giv=
en to linux, using remap_pfn_range ? During booting instead of giving whole=
 available memory to linux i have reserved around 10 MB which i use as a sh=
ared memory between driver and user space application. Can i pass this pfn =
no. to remap_pfn_range to get the mapping done for user space application?=
=0A=0AThanks,=0AAshley.=0A=0A______________________________________________=
____=0ADo You Yahoo!?=0ATired of spam?  Yahoo! Mail has the best spam prote=
ction around =0Ahttp://mail.yahoo.com 
--0-403511557-1167387831=:65720
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>hi,</DIV>=0A<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Can i "mmap" a physical memory region (part of dram) not given =
to linux, using remap_pfn_range ? During booting instead of&nbsp;giving who=
le available memory to linux i have reserved around 10 MB which i use as a =
shared memory between driver and user space application. Can i pass this pf=
n no. to remap_pfn_range to get the mapping done for user space application=
?</DIV>=0A<DIV><BR>Thanks,</DIV>=0A<DIV>Ashley.</DIV></div><br>____________=
______________________________________<br>Do You Yahoo!?<br>Tired of spam? =
 Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com =
</body></html>
--0-403511557-1167387831=:65720--
