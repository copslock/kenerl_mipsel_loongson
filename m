Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 17:42:30 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:46830 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBXRm3>;
	Mon, 24 Feb 2003 17:42:29 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA09953;
	Mon, 24 Feb 2003 09:42:22 -0800
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: Dan Malek <dan@embeddededge.com>, linux-mips@linux-mips.org
In-Reply-To: <20030221195031.I20129@luca.pas.lab>
References: <200302201135.09154.krishnakumar@naturesoft.net>
	 <20030221.112456.41627052.nemoto@toshiba-tops.co.jp>
	 <20030221122515.E20129@luca.pas.lab> <3E568ECC.2090601@embeddededge.com>
	 <20030221195031.I20129@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1046108783.16540.512.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 09:46:24 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-02-21 at 19:50, Jeff Baitis wrote:
> Dan & Pete:
> 
> Thank you very much for your help!
> 
> I've patched things up, and my kernel runs, but the yenta_socket kernel module
> still locks the system. Time to break out GDB and take a look at everything!
> Please let me know if ya'll have some suggestions. :*)

yenta socket? There's no hardware on the board to support this.

pcmcia is always a pain in the neck to setup, but it does work on the Db
and Pb boards cause I very recently tested it. Note that I've tested it
only as a module though. The defconfig-db1500 in linux-mips.org already
has pcmcia support turned on. The socket driver module you'll end up
with is drivers/pcmcia/au1x00_ss.o. That's the module you want to load.
Note also that there is a small patch in my directory for pcmcia.

I've tested wireless cards in the past, but not recently. Recently I've
tested ata cards only. You might want to start with that as proof that
you have everything else working.

> After the 36-bit PCI patch, I had to alter include/asm-mips/io.h in order to
> get drivers/net/wireless to compile. Preprocessor expansion of outw_p in the
> hermes.h -> hermes_enable_interrupt and hermes_set_irqmask inline functions
> caused some issues; I hope this patch is of some use!

Only if Ralf applies it :)

Pete

> Regards,
> 
> Jeff
> 
> 
> diff -u -r1.29.2.19 include/asm-mips/io.h
> --- include/asm-mips/io.h        28 Nov 2002 23:04:11 -0000      1.29.2.19
> +++ include/asm-mips/io.h        22 Feb 2003 03:44:27 -0000
> @@ -329,12 +329,25 @@
>         SLOW_DOWN_IO;                                                   \
>  } while(0)
>  
> -#define outw_p(val,port)                                               \
> -do {                                                                   \
> -       *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
> -               __ioswab16(val);                                        \
> -       SLOW_DOWN_IO;                                                   \
> -} while(0)
> +/* baitisj */
> +static inline u16 outw_p(u16 val, unsigned long port)
> +{
> +    register u16 retval;
> +    do {
> +        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
> +            __ioswab16(val);
> +        SLOW_DOWN_IO;
> +    } while(0);
> +    return retval;
> +}
> +/*  
> + *  #define outw_p(val,port)                                           \
> + *  do {                                                                       \
> + *     *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
> + *             __ioswab16(val);                                        \
> + *     SLOW_DOWN_IO;                                                   \
> + *  } while(0)
> + */
>  
>  #define outl_p(val,port)                                               \
>  do {                                                                   \
> 
> 
> 
> On Fri, Feb 21, 2003 at 03:40:44PM -0500, Dan Malek wrote:
> > Jeff Baitis wrote:
> > 
> > > I'd love to know where this mystery fixup_bigphys_addr comes from!?
> > 
> > You need the 36-bit patch from Pete that is not yet part of the
> > linux-mips tree.
> > 
> > You can find it on linux-mips.org in /pub/linux/mips/people/ppopov.
> > 
> > Have fun!
> > 
> > 
> > 	-- Dan
> > 
> > 
> > 
