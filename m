Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 16:19:20 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:32930 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038459AbWIKPTS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2006 16:19:18 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 0BDA6465DB; Mon, 11 Sep 2006 17:19:17 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GMnXT-0006oJ-0h; Mon, 11 Sep 2006 16:17:35 +0100
Date:	Mon, 11 Sep 2006 16:17:34 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
Message-ID: <20060911151734.GC13414@networkno.de>
References: <20060911.140403.126141483.nemoto@toshiba-tops.co.jp> <20060911.175029.37531637.nemoto@toshiba-tops.co.jp> <20060911094905.GB13414@networkno.de> <20060911.231314.25910522.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911.231314.25910522.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 11 Sep 2006 10:49:05 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > > +	tlbp
> > 
> > This needs a .set mips3/.set mips0 pair.
> 
> The TLBP is belong to MIPS I ISA, isn't it?

Uh, right. I wasn't awake when I wrote that mail. :-)

> > > +#ifdef CONFIG_CPU_MIPSR2
> > > +	_ehb			/* tlb_probe_hazard */
> > > +#else
> > > +	nop; nop; nop; nop; nop; nop	/* tlb_probe_hazard */
> > > +#endif
> > 
> > What about a mtc0_tlbp_hazard macro here?
> 
> You mean mtc0_tlbw_hazard?  I took them from tlb_probe_hazard macro in
> queue branch.

Actually, I meant an equivalent to the build_tlb_probe_entry in tlbex.c,
plus a tlb_use_hazard.

> And it looks current mtc0_tlbw_hazard asm macro does not match with
> its C equivalent ...
> 
> 	.macro	mtc0_tlbw_hazard
> 	b	. + 8
> 	.endm
> 
> #define mtc0_tlbw_hazard()						\
> 	__asm__ __volatile__(						\
> 	"	.set	noreorder				\n"	\
> 	"	nop						\n"	\
> 	"	nop						\n"	\
> 	"	nop						\n"	\
> 	"	nop						\n"	\
> 	"	nop						\n"	\
> 	"	nop						\n"	\
> 	"	.set	reorder					\n")

It also lacks a case for R2 CPUs, where IIRC _ehb is the the way
approved by the spec.


Thiemo
