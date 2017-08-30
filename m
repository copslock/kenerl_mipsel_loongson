Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 15:24:45 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:34736 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdH3NYRORdXD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 15:24:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 52CFD40926;
        Wed, 30 Aug 2017 15:24:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sW4qlLtMcxtR; Wed, 30 Aug 2017 15:23:56 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6C9953F644;
        Wed, 30 Aug 2017 15:23:51 +0200 (CEST)
Date:   Wed, 30 Aug 2017 15:23:50 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170830132350.GA2110@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

Thank you for your review!

>  Is there an external explicitly-driven write-back buffer there with the 
> R5900?  That would be odd with a MIPS III ISA processor, however if there 
> indeed is, then I think the CPU_HAS_WB setting needs to go along with the 
> code that implements `__wbflush' for this platform.

The C790 block diagram contains a WBB connected to the BIU bus (p. 2-2) in the
"TX System RISC TX79 Core Architecture" manual:

    The Writeback Buffer (WBB) is an 8 entry by 16 byte (one quadword) FIFO
    queuing up stores prior to accessing the CPU bus. It increases C790
    performance by decoupling the processor from the latencies of the CPU bus.
    It is also used during the gathering operation of uncached accelerated
    stores; sequential stores less than a quadword in length are gathered in
    the WBB, thereby reducing bus bandwidth usage. (p. 2-4)

__wbflush is implemented in arch/mips/ps2/setup.c:193 in the remaining patch
(link below):

static void ps2_wbflush(void)
{
	__asm__ __volatile__("sync.l":::"memory");

	/* flush write buffer to bus */
	inl(ps2sif_bustophys(0));
}

https://github.com/frno7/linux/blob/ps2-v4.12-squashed/arch/mips/ps2/setup.c#L193

Then ps2sif_bustophys is implemented in arch/mips/ps2/iopheap.c:

phys_addr_t ps2sif_bustophys(dma_addr_t a)
{
	return(a + PS2_IOP_HEAP_BASE);
}

which in turn uses

#define PS2_IOP_HEAP_BASE 0x1c000000

from arch/mips/include/asm/mach-ps2/ps2.h. Would you like to move this code
somewhere else to go along with the declaration of CPU_HAS_WB?

>  Shouldn't it go along with `R4000 class processors' earlier above?

Sure!

>  If this is a MIPS III base ISA implementation, then presumably you need 
> to set `c->fpu_msk31' as well, to exclude FPU_CSR_CONDX bits introduced 
> with the MIPS IV ISA only.  Double-check with hardware documentation for 
> the details.

Good catch, I'm checking it with the "TX System RISC TX79 Core Architecture"
manual (link below). The FPU is IEEE754-1985 compatible MIPS III ISA (p. 1-2),
the same as the TX49HF CPU core (p. 2-18). FCR31 looks like this (p. 10-6):

    31       25 24 23 22  18 17   12 11      7 6     2 1  0
    +----------+--+--+------+-------+---------+-------+----+
    |    0     |FS| C|   0  | Cause | Enables | Flags | RM |
    +----------+--+--+------+-------+---------+-------+----+
         7       1  1    5      6        5        5      2

http://www.lukasz.dk/files/tx79architecture.pdf

Fredrik
