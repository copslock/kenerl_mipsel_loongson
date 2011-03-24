Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 16:21:08 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35426 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491921Ab1CXPVE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 16:21:04 +0100
Date:   Thu, 24 Mar 2011 15:21:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: Re: [patch 06/38] mips: dec: Convert to new irq_chip functions
In-Reply-To: <20110324141815.GG30990@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1103241513140.18858@eddie.linux-mips.org>
References: <20110323210437.398062704@linutronix.de> <20110323210535.149703003@linutronix.de> <20110324141815.GG30990@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 24 Mar 2011, Ralf Baechle wrote:

> Thanks, queued for 2.6.39.

 Ralf, thanks for cc-ing me.

 NACK, where's the logic to ack IOASIC DMA IRQs gone?  The SIR has to be 
written as in clear_ioasic_irq() for the respective DMA transfer to resume 
and the interrupt in question be able to retrigger in the future.

 The rest is probably OK, but why has the inline hint been removed?  
These functions are simple, worth a couple of assembly instructions at 
most and used throughout these files, so it's good to ask GCC to inline 
them if worthwhile even if -fno-unit-at-a-time has been requested for 
whatever reason.

  Maciej
