Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 16:25:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59970 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492375Ab0BBPY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 16:24:59 +0100
Date:   Tue, 2 Feb 2010 15:24:59 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] Virtual memory size detection for 64 bit MIPS CPUs
In-Reply-To: <20100202114259.GA10837@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1002021328370.3578@eddie.linux-mips.org>
References: <1265064686-31278-1-git-send-email-guenter.roeck@ericsson.com> <4B676755.10600@caviumnetworks.com> <20100202001026.GA6883@ericsson.com> <20100202114259.GA10837@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 2 Feb 2010, Ralf Baechle wrote:

> > > > +	if (cpu_has_64bits) {
> > > > +		write_c0_entryhi(0xfffffffffffff000ULL);
> > > 
> > > macro indicated that we need to avoid hazards here on R4000.
> 
> A MTC0 instruction on an R4000 writes EntryHi on pipeline stage 7 but
> will read from the same register on stage 4 which leaves a window of
> 2 instructions, that is 2 NOP instructions needed.

 A footnote says: "An MTC0 of a CPR must not be immediately followed by 
MFC0 of the same CPR." -- that seems to imply a single intermediate 
instruction is sufficient, but that's not stated explicitly and obviously 
adding an extraneous instruction here, where performance does not matter, 
cannot hurt.

> > > Perhaps adding:
> > > 
> > >   	back_to_back_c0_hazard();
> > > 
> > Compiler already added a nop, so I thought it wasn't necessary.
> > Doesn't hurt either, so I'll put it in.
> 
> This probe is needed as per MIPSxx architecture spec and several CPUs will
> missbehave without it.  The 74K which of course is 32-bit but it
> illustrates the issue might even issue these instructions out of order.
> back_to_back_c0_hazard will expand into a suitable sequence to handle
> the pipeline hazard.  And we can't trust on the compiler doing the right
> thing here; as explained above we might need multiple nops and some CPUs
> will need other instructions to deal with the hazard, for example a number
> of SSNOPs or an EHB instruction.

 I reckon there are MIPS64r2 ISA implementations out there already, so an 
EHB is a necessity where appropriate.

  Maciej
