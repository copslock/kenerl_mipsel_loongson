Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2005 12:01:34 +0000 (GMT)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:62346 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8228802AbVCXMBT>;
	Thu, 24 Mar 2005 12:01:19 +0000
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DER1R-0002DL-00; Thu, 24 Mar 2005 13:01:09 +0100
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DER1R-0001Nv-LH; Thu, 24 Mar 2005 13:01:09 +0100
Date:	Thu, 24 Mar 2005 13:01:09 +0100
To:	Alex Gonzalez <alex.gonzalez@packetvision.com>
Cc:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: ABI incompatibility when building util-linux
Message-ID: <20050324120109.GI8876@hattusa.textio>
References: <1111663536.27220.32.camel@euskadi.packetvision>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111663536.27220.32.camel@euskadi.packetvision>
User-Agent: Mutt/1.5.6+20040907i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Alex Gonzalez wrote:
> Hi,
> 
> When compiling the util-linux-2.12q sources, I get the following linker
> ABI incompatibility error:
[snip]
> mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  getopt.c -o getopt.o
> mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
> mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done

The compiler is broken and fails to recognize -Wl,-t -Wl,-EB as linker
options.

> mips64-linux-gnu-ld -V -static -t -EB getopt.o -o getopt
> GNU ld version 2.13-mips64linux-031001 20020920

This toolchain is very old, and unlikely to work correctly for mips64.

[snip]
> Can anybody help with the following:
> 
> 1) What's the difference between -mabi=32 and -mabi=n32?

n32 means 64bit wide registers and 32bit address space. It runs only on
a 64bit kernel.

> 2) What should I do to compile util-linux with -mabi=32?

Use either a mips-linux targeted toolchain (instead of mips64-linux),
or upgrade to gcc 3.3/binutils 2.15, which fixed some known bugs in
that area.


Thiemo
