Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 12:05:19 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:62349 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTB0MFS>; Thu, 27 Feb 2003 12:05:18 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA21082;
	Thu, 27 Feb 2003 13:05:02 +0100 (MET)
Date: Thu, 27 Feb 2003 13:05:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>,
	Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
In-Reply-To: <20030227104119.4fb8b07e.yoichi_yuasa@montavista.co.jp>
Message-ID: <Pine.GSO.3.96.1030227125046.19733C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 27 Feb 2003, Yoichi Yuasa wrote:

> $ mipsel-linux-gcc -v -mcpu=vr4100 -mips2 -Wa,--trap -xassembler -c /dev/null -o /dev/null
> Reading specs from /usr/local/lib/gcc-lib/mipsel-linux/2.95.4/specs
> gcc version 2.95.4 20011002 (Debian prerelease)
>  /usr/local/mipsel-linux/bin/as -EL -mips2 -mcpu=vr4100 -v -KPIC --trap -o /dev/null /dev/null
> GNU assembler version 2.12.90.0.1 (mipsel-linux) using BFD version 2.12.90.0.1 20020307 Debian/GNU Linux

 Ah, I see how it happens now -- "-mipsN" has a higher priority than
"-mcpu=" (but lower than "-march=") so in this case "-mips2" overrides
"-mcpu=vr4100".  How about:

GCCFLAGS	+= -mcpu=vr4100 -Wa,--trap

then?

 Ralf, it seems the "-mcpu=XXXX -mipsN" settings are contradicting and
XXXX is ignored (I don't see it as my gcc translates "-mcpu=XXXX" into
"-march=XXXX -mtune=XXXX" as a step towards transiting to 3.x).  I think
the following settings would be more reasonable:

GCCFLAGS	+= -mabi=32 -mcpu=XXXX	# for the 32-bit kernel

GCCFLAGS	+= -mabi=n64 -mcpu=XXXX	# for the 64-bit kernel

(additional processor-specific flags skipped).  Is that supported by the
oldest version of binutils you want to support?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
