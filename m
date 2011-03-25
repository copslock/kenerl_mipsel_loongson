Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 01:33:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58626 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491911Ab1CYAdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 01:33:23 +0100
Date:   Fri, 25 Mar 2011 00:33:22 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch 06/38] mips: dec: Convert to new irq_chip functions
In-Reply-To: <alpine.LFD.2.00.1103242024470.31464@localhost6.localdomain6>
Message-ID: <alpine.LFD.2.00.1103250005470.18858@eddie.linux-mips.org>
References: <20110323210437.398062704@linutronix.de> <20110323210535.149703003@linutronix.de> <20110324141815.GG30990@linux-mips.org> <alpine.LFD.2.00.1103241513140.18858@eddie.linux-mips.org> <alpine.LFD.2.00.1103241709430.31464@localhost6.localdomain6>
 <alpine.LFD.2.00.1103241808300.18858@eddie.linux-mips.org> <alpine.LFD.2.00.1103242024470.31464@localhost6.localdomain6>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 24 Mar 2011, Thomas Gleixner wrote:

> >  The ack used to be made in clear_ioasic_irq(), that was called from 
> > end_ioasic_dma_irq(), that was used as the .end handler.  This semantics 
> > has to be preserved or hardware won't work anymore as expected.  This is a 
> > regression.
> 
> Then that code was broken before. Since MIPS was converted to the flow
> handlers nothing ever called .end(). I seem to miss something.

 Hmm, me too then.  Whoever did the conversion failed to adjust this piece 
or at least notify responsible people that such a change is needed -- if 
.end was going away, then all users should have been checked and the 
respective maintainers queried.  And given these DMA interrupts are really 
only in regular use by Linux with the onboard SCSI driver, chances are the 
breakage could be left unnoticed for a long time (I tend to run these 
systems NFS-rooted for once).

 Note these effectively are edge-triggered interrupts and may only be 
acked in hardware once all higher-level processing has been done as 
otherwise a DMA transfer will resume prematurely and all the hell will 
break loose.  I don't particularly like this double purpose these bits 
have, but there you go -- I can understand the hw engineers saw no reason 
to waste silicon for separate interrupt-ack and DMA-inhibit bits.

 I'll see what I can do about it, but I need a pointer to the offending 
change -- Ralf or anyone, can you provide me with one?

  Maciej
