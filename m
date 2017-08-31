Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2017 17:12:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49639 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993898AbdHaPMIngVm1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2017 17:12:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C1A01B63EB649;
        Thu, 31 Aug 2017 16:11:57 +0100 (IST)
Received: from [10.20.78.153] (10.20.78.153) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 31 Aug 2017
 16:12:00 +0100
Date:   Thu, 31 Aug 2017 16:11:53 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <20170830132350.GA2110@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1708311259220.17596@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain> <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk> <20170830132350.GA2110@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.153]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Fredrik,

> >  Is there an external explicitly-driven write-back buffer there with the 
> > R5900?  That would be odd with a MIPS III ISA processor, however if there 
> > indeed is, then I think the CPU_HAS_WB setting needs to go along with the 
> > code that implements `__wbflush' for this platform.
> 
> The C790 block diagram contains a WBB connected to the BIU bus (p. 2-2) in the
> "TX System RISC TX79 Core Architecture" manual:
> 
>     The Writeback Buffer (WBB) is an 8 entry by 16 byte (one quadword) FIFO
>     queuing up stores prior to accessing the CPU bus. It increases C790
>     performance by decoupling the processor from the latencies of the CPU bus.
>     It is also used during the gathering operation of uncached accelerated
>     stores; sequential stores less than a quadword in length are gathered in
>     the WBB, thereby reducing bus bandwidth usage. (p. 2-4)

 That's no different though from the write-back buffer the R4400 CPU has, 
as do many more modern MIPS architecture implementations, with strong bus 
(and hence memory) ordering enforced by the SYNC instruction.  In that 
case a lone SYNC instruction is sufficient as the implementation of the 
`wmb', `rmb' and `mb' memory ordering barrier operations.

> __wbflush is implemented in arch/mips/ps2/setup.c:193 in the remaining patch
> (link below):
> 
> static void ps2_wbflush(void)
> {
> 	__asm__ __volatile__("sync.l":::"memory");
> 
> 	/* flush write buffer to bus */
> 	inl(ps2sif_bustophys(0));
> }
> 
> https://github.com/frno7/linux/blob/ps2-v4.12-squashed/arch/mips/ps2/setup.c#L193
> 
> Then ps2sif_bustophys is implemented in arch/mips/ps2/iopheap.c:
> 
> phys_addr_t ps2sif_bustophys(dma_addr_t a)
> {
> 	return(a + PS2_IOP_HEAP_BASE);
> }
> 
> which in turn uses
> 
> #define PS2_IOP_HEAP_BASE 0x1c000000
> 
> from arch/mips/include/asm/mach-ps2/ps2.h. Would you like to move this code
> somewhere else to go along with the declaration of CPU_HAS_WB?

 This looks to me like a completion barrier, rather than a bus ordering 
barrier that would require a special `__wbflush' implementation.  Here 
SYNC.L (which is BTW an assembly idiom for plain SYNC) enforces strong 
ordering, acting as `mb' as per the architecture requirement, and the 
following read back causes all the outstanding bus accesses to retire 
beforehand, acting as a completion barrier.

 So I think this `ps2_wbflush' completion barrier should be used as the 
implementation of `mmiowb', or (suspecting that with SYNC already in the 
picture it would be too strong for this platform, unless the chipset can 
do further write merging or reordering) perhaps just `iob', or a more 
general `iobarrier_sync' operation I have outlined here:

<https://marc.info/?l=linux-kernel&m=139868504324701&w=2>

(but never got to implementing).  In that case you don't need to select 
CPU_HAS_WB, as the platform does not have a write-back buffer that would 
require special handling for bus ordering purposes.

 Let me know if you have any questions or comments.

  Maciej
