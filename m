Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 18:19:40 +0000 (GMT)
Received: from news.ti.com ([IPv6:::ffff:192.94.94.33]:2973 "EHLO
	dragon.ti.com") by linux-mips.org with ESMTP id <S8225196AbUKWSTf>;
	Tue, 23 Nov 2004 18:19:35 +0000
Received: from dlep90.itg.ti.com ([157.170.152.54])
	by dragon.ti.com (8.13.1/8.13.1) with ESMTP id iANIJSQ3026310
	for <linux-mips@linux-mips.org>; Tue, 23 Nov 2004 12:19:28 -0600 (CST)
Received: from dlee2k70.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id iANIJRXS016610
	for <linux-mips@linux-mips.org>; Tue, 23 Nov 2004 12:19:28 -0600 (CST)
Received: from dlee2k03.ent.ti.com ([157.170.152.86]) by dlee2k70.ent.ti.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 23 Nov 2004 12:19:21 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4D188.F405672E"
Subject: Cache Question
Date: Tue, 23 Nov 2004 12:19:21 -0600
Message-ID: <C4D23DECD6CD714BBFB38B0AE8D25A3A24FF66@dlee2k03.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cache Question
Thread-Index: AcTRhzy8XngZwh2oS1CoJxTrlx5FAgAAVwNQ
From: "Kapoor, Pankaj" <pkapoor@ti.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 23 Nov 2004 18:19:21.0383 (UTC) FILETIME=[F4128B70:01C4D188]
Return-Path: <pkapoor@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkapoor@ti.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4D188.F405672E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any specific reason why the cache invalidation routine is
executed with interrupts disabled?=20

Example:=20

static void
mips32_dma_cache_inv_pc(unsigned long addr, unsigned long size)
{
	unsigned long end, a;
	unsigned int flags;

	if (size >=3D dcache_size) {
		flush_cache_all();
	} else {
	        __save_and_cli(flags);
		a =3D addr & ~(dc_lsize - 1);
		end =3D (addr + size) & ~(dc_lsize - 1);
		while (1) {
			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
			if (a =3D=3D end) break;
			a +=3D dc_lsize;
		}
		__restore_flags(flags);
	}

	bc_inv(addr, size);
}

Thanks.
- Pankaj

------_=_NextPart_001_01C4D188.F405672E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6603.0">
<TITLE>Cache Question</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">Hi,</SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000000">Is there =
any specific reason why the</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000"> cache invalidation routine is executed with =
interrupts disabled? </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000">Example:</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000"></FONT></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000000">static =
void</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000">mips32_dma_cache_inv_pc(unsigned long addr, unsigned =
long size)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000">{</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">unsigned long end, a;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">unsigned int flags;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">if (size &gt;=3D dcache_size) {</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">flush_cache_all();</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">} else {</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
__save_and_cli(flags);</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT COLOR=3D"#000000">a =3D =
addr &amp; ~(dc_lsize - 1);</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT COLOR=3D"#000000">end =
=3D (addr + size) &amp; ~(dc_lsize - 1);</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT COLOR=3D"#000000">while =
(1) {</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">flush_dcache_line(a); /* Hit_Writeback_Inv_D =
*/</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT COLOR=3D"#000000">if (a =
=3D=3D end) break;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT COLOR=3D"#000000">a =
+=3D dc_lsize;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">}</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">__restore_flags(flags);</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">}</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN =
LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
COLOR=3D"#000000">bc_inv(addr, size);</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000">}</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT =
COLOR=3D"#000000">Thanks.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000000">- =
Pankaj</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C4D188.F405672E--
