Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 12:43:16 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:52410
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225192AbTB0MnP>; Thu, 27 Feb 2003 12:43:15 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1RCnk44031309;
	Thu, 27 Feb 2003 21:49:46 +0900
Date: Thu, 27 Feb 2003 21:37:07 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: yoichi_yuasa@montavista.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
Message-Id: <20030227213707.5d8eb02a.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <Pine.GSO.3.96.1030227125046.19733C-100000@delta.ds2.pg.gda.pl>
References: <20030227104119.4fb8b07e.yoichi_yuasa@montavista.co.jp>
	<Pine.GSO.3.96.1030227125046.19733C-100000@delta.ds2.pg.gda.pl>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 27 Feb 2003 13:05:02 +0100 (MET)
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On Thu, 27 Feb 2003, Yoichi Yuasa wrote:
> 
> > $ mipsel-linux-gcc -v -mcpu=vr4100 -mips2 -Wa,--trap -xassembler -c /dev/null -o /dev/null
> > Reading specs from /usr/local/lib/gcc-lib/mipsel-linux/2.95.4/specs
> > gcc version 2.95.4 20011002 (Debian prerelease)
> >  /usr/local/mipsel-linux/bin/as -EL -mips2 -mcpu=vr4100 -v -KPIC --trap -o /dev/null /dev/null
> > GNU assembler version 2.12.90.0.1 (mipsel-linux) using BFD version 2.12.90.0.1 20020307 Debian/GNU Linux
> 
>  Ah, I see how it happens now -- "-mipsN" has a higher priority than
> "-mcpu=" (but lower than "-march=") so in this case "-mips2" overrides
> "-mcpu=vr4100".  How about:
> 
> GCCFLAGS	+= -mcpu=vr4100 -Wa,--trap
> 
> then?

That is fine.
However, the following warning is displayed.

Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.

>  Ralf, it seems the "-mcpu=XXXX -mipsN" settings are contradicting and
> XXXX is ignored (I don't see it as my gcc translates "-mcpu=XXXX" into
> "-march=XXXX -mtune=XXXX" as a step towards transiting to 3.x).  I think
> the following settings would be more reasonable:
> 
> GCCFLAGS	+= -mabi=32 -mcpu=XXXX	# for the 32-bit kernel
> 
> GCCFLAGS	+= -mabi=n64 -mcpu=XXXX	# for the 64-bit kernel
> 
> (additional processor-specific flags skipped).  Is that supported by the
> oldest version of binutils you want to support?

Thanks,

Yoichi
