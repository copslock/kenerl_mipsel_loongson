Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 22:56:01 +0100 (CET)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:42650 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491833Ab1AUVz5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 22:55:57 +0100
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAIOPOU2tJXG9/2dsb2JhbACkanOhVZsZhVAEhG+JWw
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rtp-iport-1.cisco.com with ESMTP; 21 Jan 2011 21:55:50 +0000
Received: from xbh-rcd-101.cisco.com (xbh-rcd-101.cisco.com [72.163.62.138])
        by rcdn-core2-2.cisco.com (8.14.3/8.14.3) with ESMTP id p0LLto6C028594;
        Fri, 21 Jan 2011 21:55:50 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-101.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 15:55:50 -0600
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----_=_NextPart_001_01CBB9B5.F74B8172"
Subject: RE: 24k data cache, PIPT or VIPT?
Date:   Fri, 21 Jan 2011 15:54:35 -0600
Message-ID: <7A9214B0DEB2074FBCA688B30B04400D1756AB@XMB-RCD-208.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 24k data cache, PIPT or VIPT?
Thread-Index: AQHLuUbVXlaQIiHjVkiVJGPYIadBqJPb+Qgg
References: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
From:   "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:     "COLin" <colin@realtek.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 21 Jan 2011 21:55:50.0297 (UTC) FILETIME=[F7830890:01CBB9B5]
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01CBB9B5.F74B8172
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

No, it just means that there is special hardware to detect aliases and =
handle them as if the addresses were not aliased.


-----Original Message-----
From: linux-mips-bounce@linux-mips.org on behalf of COLin
Sent: Fri 1/21/2011 12:52 AM
To: ralf@linux-mips.org; linux-mips@linux-mips.org
Subject: 24k data cache, PIPT or VIPT?
=20

Hi all,
I found that there is this information while Linux is booting:
    [Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 =
bytes]
I thought the latest MIPS CPUs all use VIPT. I didn't find anything =
about PIPT on 24k Software User's Manual, either.
The code related to this is here:
        case CPU_24K:
        case CPU_34K:
        case CPU_74K:
        case CPU_1004K:
                if ((read_c0_config7() & (1 << 16))) {
                        /* effectively physically indexed dcache,
                           thus no virtual aliases. */=20
                        c->dcache.flags |=3D MIPS_CACHE_PINDEX;
                        break;

The 16's bit of config 7 register:
    [Alias removed: This bit indicates that the data cache is organized =
to
avoid virtual aliasing problems. This bit is only set if the data cache
config and MMU type would normally cause aliasing - i.e., only for
the 32KB and larger data cache and TLB-based MMU.]

Does it imply that the CPU is using PIPT?

Thanks and regards,
Colin






------_=_NextPart_001_01CBB9B5.F74B8172
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7655.10">
<TITLE>RE: 24k data cache, PIPT or VIPT?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>No, it just means that there is special hardware to =
detect aliases and handle them as if the addresses were not aliased.<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: linux-mips-bounce@linux-mips.org on behalf of COLin<BR>
Sent: Fri 1/21/2011 12:52 AM<BR>
To: ralf@linux-mips.org; linux-mips@linux-mips.org<BR>
Subject: 24k data cache, PIPT or VIPT?<BR>
<BR>
<BR>
Hi all,<BR>
I found that there is this information while Linux is booting:<BR>
&nbsp;&nbsp;&nbsp; [Primary data cache 32kB, 4-way, PIPT, no aliases, =
linesize 32 bytes]<BR>
I thought the latest MIPS CPUs all use VIPT. I didn't find anything =
about PIPT on 24k Software User's Manual, either.<BR>
The code related to this is here:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CPU_24K:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CPU_34K:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CPU_74K:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CPU_1004K:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if ((read_c0_config7() &amp; (1 &lt;&lt; 16))) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
effectively physically indexed dcache,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; thus no virtual aliases. */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c-&gt;dcache.flags |=3D MIPS_CACHE_PINDEX;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<BR>
<BR>
The 16's bit of config 7 register:<BR>
&nbsp;&nbsp;&nbsp; [Alias removed: This bit indicates that the data =
cache is organized to<BR>
avoid virtual aliasing problems. This bit is only set if the data =
cache<BR>
config and MMU type would normally cause aliasing - i.e., only for<BR>
the 32KB and larger data cache and TLB-based MMU.]<BR>
<BR>
Does it imply that the CPU is using PIPT?<BR>
<BR>
Thanks and regards,<BR>
Colin<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CBB9B5.F74B8172--
