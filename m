Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Sep 2013 00:57:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44570 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817904Ab3INW5sCLqaq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Sep 2013 00:57:48 +0200
Date:   Sat, 14 Sep 2013 23:57:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation I/O ASIC DMA interrupt handling fix
In-Reply-To: <alpine.LFD.2.03.1309120249420.24771@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309142353040.16539@linux-mips.org>
References: <alpine.LFD.2.03.1309120249420.24771@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 12 Sep 2013, Maciej W. Rozycki wrote:

> This change complements commit d0da7c002f7b2a93582187a9e3f73891a01d8ee4 
> and brings clear_ioasic_irq back, renaming it to clear_ioasic_dma_irq at 
> the same time, to make I/O ASIC DMA interrupts functional.
> 
> Unlike ordinary I/O ASIC interrupts DMA interrupts need to be deasserted 
> by software by writing 0 to the respective bit in I/O ASIC's System 
> Interrupt Register (SIR), similarly to how CP0.Cause.IP0 and CP0.Cause.IP1 
> bits are handled in the CPU (the difference is SIR DMA interrupt bits are 
> R/W0C so there's no need for an RMW cycle).  Otherwise the handler is 
> reentered over and over again.
> 
> The only current user is the DEC LANCE Ethernet driver and its extremely 
> uncommon DMA memory error handler that does not care when exactly the 
> interrupt is cleared.  Anticipating the use of DMA interrupts by the Zilog 
> SCC driver this change however exports clear_ioasic_dma_irq for device 
> drivers to choose the right application-specific sequence to clear the 
> request explicitly rather than calling it implicitly in the .irq_eoi 
> handler of `struct irq_chip'.  Previously these interrupts were cleared in 
> the .end handler of the said structure, before it was removed.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---

 Please withdraw this change, I'll send a better one (to say nothing of 
the bug it has).  I think with a trick we can handle the two kinds of I/O 
ASIC DMA interrupts DECstations have (informational and errors) 
transparently, no need for an explicit action in the handler.

  Maciej
