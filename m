Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2005 14:51:57 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:43938 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8228951AbVCXOvm>;
	Thu, 24 Mar 2005 14:51:42 +0000
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DETgn-0006k0-Nj; Thu, 24 Mar 2005 09:52:01 -0500
Date:	Thu, 24 Mar 2005 09:52:01 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Alex Gonzalez <alex.gonzalez@packetvision.com>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: ABI incompatibility when building util-linux
Message-ID: <20050324145201.GA25778@nevyn.them.org>
Mail-Followup-To: Thiemo Seufer <ths@networkno.de>,
	Alex Gonzalez <alex.gonzalez@packetvision.com>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
References: <1111663536.27220.32.camel@euskadi.packetvision> <20050324120109.GI8876@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324120109.GI8876@hattusa.textio>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 24, 2005 at 01:01:09PM +0100, Thiemo Seufer wrote:
> Alex Gonzalez wrote:
> > Hi,
> > 
> > When compiling the util-linux-2.12q sources, I get the following linker
> > ABI incompatibility error:
> [snip]
> > mips64-linux-gnu-gcc -c -O2 -pipe -march=rm9000 -mabi=32 -static -mips4 -DPTYS_ARE_GETPT -DPTYS_ARE_SEARCHED -Wl,-t -Wl,-EB -O2 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes    -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\"  getopt.c -o getopt.o
> > mips64-linux-gnu-gcc: -t: linker input file unused because linking not done
> > mips64-linux-gnu-gcc: -EB: linker input file unused because linking not done
> 
> The compiler is broken and fails to recognize -Wl,-t -Wl,-EB as linker
> options.

Actually, the compiler's fine.  It's always issued this warning for
linker options, whether or not they are input files.

> > mips64-linux-gnu-ld -V -static -t -EB getopt.o -o getopt
> > GNU ld version 2.13-mips64linux-031001 20020920
> 
> This toolchain is very old, and unlikely to work correctly for mips64.

It should be binary compatible with current toolchains, more or less;
I've used it before.

The problem is in Alex's environment.  Alex, whatever you're setting to
force use of the cross compilers, it's wrong.  You should _never_ link
directly with ld.  That's the error here.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
