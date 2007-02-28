Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 22:19:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4505 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039438AbXB1WS7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 22:18:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SMIofl025766;
	Wed, 28 Feb 2007 22:18:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SMIo2R025765;
	Wed, 28 Feb 2007 22:18:50 GMT
Date:	Wed, 28 Feb 2007 22:18:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Message-ID: <20070228221850.GA24105@linux-mips.org>
References: <45E5F5A4.6040809@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45E5F5A4.6040809@pmc-sierra.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 28, 2007 at 01:35:32PM -0800, Marc St-Jean wrote:

> Ralf Baechle wrote:
> > On Tue, Feb 27, 2007 at 05:38:41PM +0000, Thiemo Seufer wrote:
> > 
> >  > Something like
> >  >
> >  > #if LOADADDR == 0xffffffff80000000
> >  >       .fill   0x400
> >  > #endif
> >  >
> >  > but by defining an appropriate name in arch/mips/Makefile instead of
> >  > externalizing the load-y/LOADADDR there.
> > 
> > Basically a good idea but it will fail for 64-bit kernels so the test
> > would need to be extended to cover XKPHYS as well.  Also R2 processors
> > which have the c0_ebase registers do no need to reserve space for
> > exception handlers as they can easily move them elsewhere.
> > 
> >   Ralf
> 
> Hi Ralf,
> 
>  From your description it sounds like not all R2 CPUs have c0_ebase registers?
> 
> I don't know how to check for c0_ebase from the pre-processor, the test below
> assumes they all do.

Sorry for being ambigous.  All R2 processors have ebase.  However Linux
happens to support older processors as well, that was my point.

> How about something like:
> 
> #if (defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) && \
>                  VMLINUX_LOAD_ADDRESS == CKSEG0) || \
>          ((defined(CONFIG_SYS_HAS_CPU_MIPS64_R1) || defined(CONFIG_SYS_HAS_CPU_MIPS64_R2)) && \
>                  VMLINUX_LOAD_ADDRESS == XKPHYS)
> 	.fill 0x400
> #endif

There are several potencial addresses in XKPHYS, so if anything:

#if !defined(CONFIG_CPU_MIPSR2) && \
    ((VMLINUX_LOAD_ADDRESS == CKSEG0) || \
     (VMLINUX_LOAD_ADDRESS & 0xc7ffffffffffffffUL) == XKPHYS)

However even where ebase actually exists there might be reasons not to use
it.  So a config option might be the safe thing to do.

  Ralf
