Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2003 02:25:08 +0100 (BST)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:4106
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225471AbTJNBZF>; Tue, 14 Oct 2003 02:25:05 +0100
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <SK19JBP2>; Tue, 14 Oct 2003 09:19:17 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F6801AC0D67@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: Ralf Baechle <ralf@linux-mips.org>,
	Thomas Horsten <thomas@horsten.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: need help on unaligned loads,stores!
Date: Tue, 14 Oct 2003 09:18:20 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C391F1.0DD4EDB0"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C391F1.0DD4EDB0
Content-Type: text/plain;
	charset="ISO-8859-1"

Hi All,

I have rewritten the codes,and now it really works.
Our cpu is bought from others,it really doesnt support unaligned access.

Thanks for you all.

Best Regards,
Alan

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Tuesday, October 14, 2003 5:37 AM
To: Thomas Horsten
Cc: Geert Uytterhoeven; Liu Hongming (Alan); Linux/MIPS Development
Subject: Re: need help on unaligned loads,stores!


On Mon, Oct 13, 2003 at 10:15:59PM +0100, Thomas Horsten wrote:

> > That correct.  Unfortunately emulating of these instructions in
exception
> > handlers would also be covered by the patents, so rewriting which would
> > be rather easy in all cases I can think of is the way to go ...
> 
> Surely not in Europe (yet), at least?

The patent itself is a hardware patent and those also cover software
implementations by interpretation of US, European and various national
European patent offices.  Otoh the patent will expire in like a year or
two anyway :-)

  Ralf

------_=_NextPart_001_01C391F1.0DD4EDB0
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2653.12">
<TITLE>RE: need help on unaligned loads,stores!</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>Hi All,</FONT>
</P>

<P><FONT SIZE=2>I have rewritten the codes,and now it really works.</FONT>
<BR><FONT SIZE=2>Our cpu is bought from others,it really doesnt support unaligned access.</FONT>
</P>

<P><FONT SIZE=2>Thanks for you all.</FONT>
</P>

<P><FONT SIZE=2>Best Regards,</FONT>
<BR><FONT SIZE=2>Alan</FONT>
</P>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Ralf Baechle [<A HREF="mailto:ralf@linux-mips.org">mailto:ralf@linux-mips.org</A>]</FONT>
<BR><FONT SIZE=2>Sent: Tuesday, October 14, 2003 5:37 AM</FONT>
<BR><FONT SIZE=2>To: Thomas Horsten</FONT>
<BR><FONT SIZE=2>Cc: Geert Uytterhoeven; Liu Hongming (Alan); Linux/MIPS Development</FONT>
<BR><FONT SIZE=2>Subject: Re: need help on unaligned loads,stores!</FONT>
</P>
<BR>

<P><FONT SIZE=2>On Mon, Oct 13, 2003 at 10:15:59PM +0100, Thomas Horsten wrote:</FONT>
</P>

<P><FONT SIZE=2>&gt; &gt; That correct.&nbsp; Unfortunately emulating of these instructions in exception</FONT>
<BR><FONT SIZE=2>&gt; &gt; handlers would also be covered by the patents, so rewriting which would</FONT>
<BR><FONT SIZE=2>&gt; &gt; be rather easy in all cases I can think of is the way to go ...</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; Surely not in Europe (yet), at least?</FONT>
</P>

<P><FONT SIZE=2>The patent itself is a hardware patent and those also cover software</FONT>
<BR><FONT SIZE=2>implementations by interpretation of US, European and various national</FONT>
<BR><FONT SIZE=2>European patent offices.&nbsp; Otoh the patent will expire in like a year or</FONT>
<BR><FONT SIZE=2>two anyway :-)</FONT>
</P>

<P><FONT SIZE=2>&nbsp; Ralf</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C391F1.0DD4EDB0--
