Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 21:50:46 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:59823 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20039434AbXB1Vuk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 21:50:40 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l1SLhk7M018040;
	Wed, 28 Feb 2007 13:43:46 -0800 (PST)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id l1SLguNK027868;
	Wed, 28 Feb 2007 13:42:56 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Wed, 28 Feb 2007 13:43:06 -0800
Message-ID: <692AB3595F5D76428B34B9BEFE20BC1FB9A7A2@Exchange.mips.com>
In-Reply-To: <45E5F5A4.6040809@pmc-sierra.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/5] mips: PMC MSP71xx mips common
Thread-Index: AcdbgMsIYeJeyNW2RfeZXHl/dH4oEAAAGPrQ
References: <45E5F5A4.6040809@pmc-sierra.com>
From:	"Uhler, Mike" <uhler@mips.com>
To:	"Marc St-Jean" <Marc_St-Jean@pmc-sierra.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Thiemo Seufer" <ths@networkno.de>,
	"Andrew Sharp" <tigerand@gmail.com>, <linux-mips@linux-mips.org>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

All MIPS Release 2 implementations contain the EBase register.

/gmu
---
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.   Email: uhler AT mips.com
1225 Charleston Road      Voice:  (650)567-5025
Mountain View, CA 94043
   

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Marc St-Jean
> Sent: Wednesday, February 28, 2007 1:36 PM
> To: Ralf Baechle
> Cc: Thiemo Seufer; Andrew Sharp; linux-mips@linux-mips.org
> Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
> 
> 
> 
> Ralf Baechle wrote:
> > On Tue, Feb 27, 2007 at 05:38:41PM +0000, Thiemo Seufer wrote:
> > 
> >  > Something like
> >  >
> >  > #if LOADADDR == 0xffffffff80000000
> >  >       .fill   0x400
> >  > #endif
> >  >
> >  > but by defining an appropriate name in 
> arch/mips/Makefile instead 
> > of  > externalizing the load-y/LOADADDR there.
> > 
> > Basically a good idea but it will fail for 64-bit kernels 
> so the test 
> > would need to be extended to cover XKPHYS as well.  Also R2 
> processors 
> > which have the c0_ebase registers do no need to reserve space for 
> > exception handlers as they can easily move them elsewhere.
> > 
> >   Ralf
> 
> Hi Ralf,
> 
>  From your description it sounds like not all R2 CPUs have 
> c0_ebase registers?
> 
> I don't know how to check for c0_ebase from the 
> pre-processor, the test below assumes they all do.
> 
> How about something like:
> 
> #if (defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) && \
>                  VMLINUX_LOAD_ADDRESS == CKSEG0) || \
>          ((defined(CONFIG_SYS_HAS_CPU_MIPS64_R1) || 
> defined(CONFIG_SYS_HAS_CPU_MIPS64_R2)) && \
>                  VMLINUX_LOAD_ADDRESS == XKPHYS)
> 	.fill 0x400
> #endif
> 
> Marc
> 
> 
