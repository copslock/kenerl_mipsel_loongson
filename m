Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 17:16:51 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:53848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491835Ab1CXQQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 17:16:47 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2nDF-0006Z9-69; Thu, 24 Mar 2011 17:16:41 +0100
Date:   Thu, 24 Mar 2011 17:16:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch 06/38] mips: dec: Convert to new irq_chip functions
In-Reply-To: <alpine.LFD.2.00.1103241513140.18858@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.00.1103241709430.31464@localhost6.localdomain6>
References: <20110323210437.398062704@linutronix.de> <20110323210535.149703003@linutronix.de> <20110324141815.GG30990@linux-mips.org> <alpine.LFD.2.00.1103241513140.18858@eddie.linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Thu, 24 Mar 2011, Maciej W. Rozycki wrote:

> On Thu, 24 Mar 2011, Ralf Baechle wrote:
> 
> > Thanks, queued for 2.6.39.
> 
>  Ralf, thanks for cc-ing me.
> 
>  NACK, where's the logic to ack IOASIC DMA IRQs gone?  The SIR has to be 
> written as in clear_ioasic_irq() for the respective DMA transfer to resume 
> and the interrupt in question be able to retrigger in the future.

Errm.

#define ack_ioasic_dma_irq ack_ioasic_irq

	.name = "IO-ASIC-DMA",
	.ack = ack_ioasic_dma_irq

So the .ack pointer is filled with ack_ioasic_irq, right ?

So I did:

-#define ack_ioasic_dma_irq ack_ioasic_irq

+       .irq_ack = ack_ioasic_irq,

Pretty identical as far as I can tell. The define is rather pointless,
isn't it ?

>  The rest is probably OK, but why has the inline hint been removed?  
> These functions are simple, worth a couple of assembly instructions at 
> most and used throughout these files, so it's good to ask GCC to inline 
> them if worthwhile even if -fno-unit-at-a-time has been requested for 
> whatever reason.

The only use of these functions is in the chip pointers, so the inline
is pointless. But I really dont care.

Thanks,

	tglx
