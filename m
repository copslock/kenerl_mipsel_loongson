Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 00:11:49 +0100 (BST)
Received: from p508B5DDF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.223]:52821
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225842AbUGLXLp>; Tue, 13 Jul 2004 00:11:45 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6CNBdng014006;
	Tue, 13 Jul 2004 01:11:39 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6CNBcDZ014005;
	Tue, 13 Jul 2004 01:11:38 +0200
Date: Tue, 13 Jul 2004 01:11:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <KevinK@mips.com>
Cc: S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040712231138.GB6176@linux-mips.org>
References: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com> <020201c46859$fa6b98b0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020201c46859$fa6b98b0$0deca8c0@Ulysses>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 12, 2004 at 11:48:31PM +0200, Kevin D. Kissell wrote:

> Your intuition is correct, and the code in r4k_tlb_init() does look scary.

Not scarry at all.  flush_icache_range() has to do whatever is needed to
maintain I-cache coherency for the range passed in as the argument.  And
I don't think we should really have to deal with all the complicated
details of cache maintenance in a function like r4k_tlb_init().

> But at least in the linux-mips CVS tree, flush_icache_range() tests to see
> if "cpu_has_ic_fills_f_dc" (CPU has Icache fills from Dcache, I presume)

Right.  Cpu_has_ic_fills_f_dc is only non-zero for the AMD processors
where the I-cache is refilled from the D-cache.  For typical kernel
configurations The definition of cpu_has_ic_fills_f_dc is a constant so
the compiler can optimize this further.

  Ralf
