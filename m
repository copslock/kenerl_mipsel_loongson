Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 08:55:32 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:26774 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21103049AbZA3Iza (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Jan 2009 08:55:30 +0000
Received: (qmail 12931 invoked by uid 1000); 30 Jan 2009 09:55:28 +0100
Date:	Fri, 30 Jan 2009 09:55:28 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: GCC-4.3.3 sillyness
Message-ID: <20090130085528.GA12912@roarinelk.homelinux.net>
References: <20090130074407.GA12368@roarinelk.homelinux.net> <Pine.LNX.4.64.0901300921380.17617@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0901300921380.17617@anakin>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Geert,

On Fri, Jan 30, 2009 at 09:23:38AM +0100, Geert Uytterhoeven wrote:
> On Fri, 30 Jan 2009, Manuel Lauss wrote:
> >   CC      arch/mips/kernel/traps.o
> > cc1: warnings being treated as errors
> > /linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
> > /linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments
> > 
> > The fastest fix is the patch below, but I don't know whether it is
> > the right thing to do.
> > 
> > ---
> > 
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 7378b91..70ddf83 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -78,7 +78,7 @@ all-$(CONFIG_BOOT_ELF64)	:= $(vmlinux-64)
> >  # machines may also.  Since BFD is incredibly buggy with respect to
> >  # crossformat linking we rely on the elf2ecoff tool for format conversion.
> >  #
> > -cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
> > +cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe -Wno-format
> >  cflags-y			+= -msoft-float
> >  LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
> >  MODFLAGS			+= -mlong-calls
> 
> No, you don't want to disable printf()-style format checking.
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index f6083c6..16f499c 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1596,7 +1596,7 @@ void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
>  		ebase += (read_c0_ebase() & 0x3ffff000);
>  
>  	if (!addr)
> -		panic(panic_null_cerr);
> +		panic("%s", panic_null_cerr);
>  
>  	memcpy((void *)(uncached_ebase + offset), addr, size);
>  }
> 
> Hwoever, I'm a bit surprised gcc isn't smart enough to notice the string is
> fixed and safe. Perhaps because panic_null_cerr is not const?

There's a similar one in cpu-probe.c which doesn't bother it at all,
probably because the call to panic() has 2 arguments instead of one.
I say it's a gcc bug ;-)

Thanks!
	Manuel Lauss
