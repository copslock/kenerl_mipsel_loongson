Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 21:37:24 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:35980 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039435AbXB1VhR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 21:37:17 +0000
Received: (qmail 28705 invoked by uid 101); 28 Feb 2007 21:36:07 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 28 Feb 2007 21:36:07 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1SLZakM015799;
	Wed, 28 Feb 2007 13:35:36 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPGCJ2>; Wed, 28 Feb 2007 13:35:36 -0800
Message-ID: <45E5F5A4.6040809@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Andrew Sharp <tigerand@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Wed, 28 Feb 2007 13:35:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 28 Feb 2007 21:35:32.0631 (UTC) FILETIME=[5FE7B270:01C75B80]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:
> On Tue, Feb 27, 2007 at 05:38:41PM +0000, Thiemo Seufer wrote:
> 
>  > Something like
>  >
>  > #if LOADADDR == 0xffffffff80000000
>  >       .fill   0x400
>  > #endif
>  >
>  > but by defining an appropriate name in arch/mips/Makefile instead of
>  > externalizing the load-y/LOADADDR there.
> 
> Basically a good idea but it will fail for 64-bit kernels so the test
> would need to be extended to cover XKPHYS as well.  Also R2 processors
> which have the c0_ebase registers do no need to reserve space for
> exception handlers as they can easily move them elsewhere.
> 
>   Ralf

Hi Ralf,

 From your description it sounds like not all R2 CPUs have c0_ebase registers?

I don't know how to check for c0_ebase from the pre-processor, the test below
assumes they all do.

How about something like:

#if (defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) && \
                 VMLINUX_LOAD_ADDRESS == CKSEG0) || \
         ((defined(CONFIG_SYS_HAS_CPU_MIPS64_R1) || defined(CONFIG_SYS_HAS_CPU_MIPS64_R2)) && \
                 VMLINUX_LOAD_ADDRESS == XKPHYS)
	.fill 0x400
#endif

Marc
