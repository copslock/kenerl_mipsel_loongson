Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 21:32:55 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41213 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225192AbTCaUcx>;
	Mon, 31 Mar 2003 21:32:53 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA30610;
	Mon, 31 Mar 2003 12:32:47 -0800
Subject: Re: Au1500 hardware cache coherency
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Eric DeVolder <eric.devolder@amd.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E889602.62B7AB6B@ekner.info>
References: <3E882FB8.BBFDACE2@ekner.info> <3E8853B3.9080902@amd.com>
	 <3E885B68.6927451E@ekner.info> <3E8883B8.1000000@amd.com>
	 <3E889602.62B7AB6B@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1049142818.26677.68.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 12:33:38 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-03-31 at 11:24, Hartvig Ekner wrote:
> Hi Eric, 
> 
> I did a quick check of a complete kernel disassembly, and there are
> tons of direct or indirect RMW's to config, which do not explicitly
> insure that Config[0D] is set. 
> Pete - are you aware of this? 

Config[OD] is set in setup.c and should not be cleared afterward.

> Thus, there seems to be a potential problem lurking here for anybody
> who is using USB. 
> 
> However, I am not using USB at all, and it is configured out of the
> kernel. So I assume this is not errata #3 we're seeing here? 
> 
> So, to summarize: The first set of problems in my email below seem to
> be fully explained by errata #14. Note that any kernel compiled from
> the current CVS exhibits this problem: 
> Because although NONCOHEHENT_IO is set, the NC bit in PCI_CFG is not
> set. 

Hmm, ok, I'll check that out.

> I have verified that the problem occurs when NC is cleared, regardless
> of the .config option. So some code needs to be changed in
> au1000/xxx/setup.c... (set NC if NONCOHERENT_IO 
> is enabled). 

> But - much wore worrisome: I did this modification, and with the NC
> bit set, and NONCOHERENT_IO set, I get the second set of errors,
> although it takes much longer time. The wback_inv calls are made
> through the generic code  in the subroutine 
> pci_alloc_consistent() (in arch/mips/kernel/pci-dma.c). 

> So something is wrong.... Anybody at AMD who would care to continue
> the debug? 

Can you send me your test and exact instructions on how you're
duplicating the error? I won't have time to look at it until after 4/20
though.

Pete
