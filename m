Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 20:21:58 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:13947 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28594360AbYHMTVt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Aug 2008 20:21:49 +0100
X-IronPort-AV: E=Sophos;i="4.32,202,1217808000"; 
   d="scan'208,217";a="139639996"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 13 Aug 2008 19:21:37 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m7DJLa6V016767
	for <linux-mips@linux-mips.org>; Wed, 13 Aug 2008 12:21:36 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7DJLaOU023949
	for <linux-mips@linux-mips.org>; Wed, 13 Aug 2008 19:21:36 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 15:21:35 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 15:21:34 -0400
Received: from sausatlexch1.corp.sa.net ([192.133.216.10]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 15:21:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8FD79.CCB9E124"
Subject: [PATCH 1/1] MIPS: Fix "max_mapnr" assignment bug
Date:	Wed, 13 Aug 2008 15:21:37 -0400
Message-ID: <BBF6DACF837F034A87DC3E60E7DD436283CFFD@sausatlexch1.corp.sa.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] MIPS: Fix "max_mapnr" assignment bug
thread-index: Acj9ec5SbgKHBAQgQEiMCICYlIRLGg==
From:	"Williams, Victor L." <WilliaVi@cisco.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 13 Aug 2008 19:21:34.0317 (UTC) FILETIME=[CC7551D0:01C8FD79]
X-ST-MF-Message-Resent:	8/13/2008 15:21
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=7157; t=1218655296; x=1219519296;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=WilliaVi@cisco.com;
	z=From:=20=22Williams,=20Victor=20L.=22=20<WilliaVi@cisco.co
	m>
	|Subject:=20[PATCH=201/1]=20MIPS=3A=20Fix=20=22max_mapnr=22
	=20assignment=20bug
	|Sender:=20;
	bh=mhvRol7ohYMYDVd50x/sHrDZCVv88scQ0CnBgU+iLEs=;
	b=WofDlR3rZQCYbE8gMqP62KDxhpSs8y97N5gxZFtdAtHOblf1/Xg5q2MkZO
	9rxZEEkqKBTQoMOQJtwg6U6D2uTVNTBQ4awDZQHkMVc6XC4+OFMz14JuQi9I
	5rFA8s/p9I;
Authentication-Results:	sj-dkim-2; header.From=WilliaVi@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <WilliaVi@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: WilliaVi@cisco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8FD79.CCB9E124
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fix "max_mapnr" assignment bug for high-memory enabled kernels running
on
platforms with no high memory

Currently, high memory enabled kernels always set "max_mapnr" equal to
"highend_pfn", but "highend_pfn" is only valid if high memory is
available on
the platform.  The proposed fix is to only use "highend_pfn" in the
assignment
when it is valid (non-zero).  In my particular case, this bug was
manifesting
itself via the "pfn_valid()" macro, with "CONFIG_FLATMEM" defined.

Signed-off-by: Victor Williams <williavi@cisco.com>
Signed-off-by: Sudharsan Vijayaraghavan <vijayas@cisco.com>
---

 init.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- old/arch/mips/mm/init.c     2008-08-06 11:19:01.000000000 -0500
+++ new/arch/mips/mm/init.c     2008-08-13 11:17:03.000000000 -0500
@@ -388,13 +388,13 @@
        unsigned long codesize, reservedpages, datasize, initsize;
        unsigned long tmp, ram;

+       max_mapnr =3D max_low_pfn;
 #ifdef CONFIG_HIGHMEM
 #ifdef CONFIG_DISCONTIGMEM
 #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
 #endif
-       max_mapnr =3D highend_pfn;
-#else
-       max_mapnr =3D max_low_pfn;
+       if (highend_pfn)
+          max_mapnr =3D highend_pfn;
 #endif
        high_memory =3D (void *) __va(max_low_pfn << PAGE_SHIFT);





     - - - - -                              Cisco                        =
    - - - - -         
This e-mail and any attachments may contain information which is confiden=
tial, 
proprietary, privileged or otherwise protected by law. The information is=
 solely 
intended for the named addressee (or a person responsible for delivering =
it to 
the addressee). If you are not the intended recipient of this message, yo=
u are 
not authorized to read, print, retain, copy or disseminate this message o=
r any 
part of it. If you have received this e-mail in error, please notify the =
sender 
immediately by return e-mail and delete it from your computer.
------_=_NextPart_001_01C8FD79.CCB9E124
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7653.3=
8">
<TITLE>[PATCH 1/1] MIPS: Fix &quot;max_mapnr&quot; assignment bug</TITLE>
</HEAD>
<BODY><P>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Fix &quot;max_mapnr&quot; assignme=
nt bug for high-memory enabled kernels running on</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">platforms with no high memory</FO=
NT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Currently, high memory enabled ker=
nels always set &quot;max_mapnr&quot; equal to</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&quot;highend_pfn&quot;, but &quo=
t;highend_pfn&quot; is only valid if high memory is available on</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">the platform.&nbsp; The proposed =
fix is to only use &quot;highend_pfn&quot; in the assignment</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">when it is valid (non-zero).&nbsp=
; In my particular case, this bug was manifesting</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">itself via the &quot;pfn_valid()&=
quot; macro, with &quot;CONFIG_FLATMEM&quot; defined.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Signed-off-by: Victor Williams &lt=
;williavi@cisco.com&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Signed-off-by: Sudharsan Vijayara=
ghavan &lt;vijayas@cisco.com&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">---</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;init.c |&nbsp;&nbsp;&nbsp; 6=
 +++---</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;1 file changed, 3 insertion=
s(+), 3 deletions(-)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">--- old/arch/mips/mm/init.c&nbsp;&=
nbsp;&nbsp;&nbsp; 2008-08-06 11:19:01.000000000 -0500</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">+++ new/arch/mips/mm/init.c&nbsp;=
&nbsp;&nbsp;&nbsp; 2008-08-13 11:17:03.000000000 -0500</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">@@ -388,13 +388,13 @@</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; unsigned long codesize, reservedpages, datasize, initsize;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; unsigned long tmp, ram;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max_mapnr =3D max_low_pfn;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;#ifdef CONFIG_HIGHMEM</FONT=
>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;#ifdef CONFIG_DISCONTIGMEM<=
/FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;#error &quot;CONFIG_HIGHMEM=
 and CONFIG_DISCONTIGMEM dont work together yet&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;#endif</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; max_mapnr =3D highend_pfn;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">-#else</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; max_mapnr =3D max_low_pfn;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (highend_pfn)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; max_mapnr =3D highend_pfn;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;#endif</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; high_memory =3D (void *) __va(max_low_pfn &lt;&lt; PAGE_SHIFT);</=
FONT>
</P>

</P>
<HR style=3D"HEIGHT: 1px">

<DIV></DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - - - - 
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cisco&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; - - - - 
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>This e-mail an=
d any 
attachments may contain information which is confidential, <BR>proprietar=
y, 
privileged or otherwise protected by law. The information is solely <BR>i=
ntended 
for the named addressee (or a person responsible for delivering it to <BR=
>the 
addressee). If you are not the intended recipient of this message, you ar=
e 
<BR>not authorized to read, print, retain, copy or disseminate this messa=
ge or 
any <BR>part of it. If you have received this e-mail in error, please not=
ify the 
sender <BR>immediately by return e-mail and delete it from your computer.=
</BODY>
</HTML>

------_=_NextPart_001_01C8FD79.CCB9E124--
