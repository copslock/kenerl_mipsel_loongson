Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 12:42:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46597 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492230Ab0BBLmr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 12:42:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o12Bh11Z011980;
        Tue, 2 Feb 2010 12:43:02 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o12Bgx9E011972;
        Tue, 2 Feb 2010 12:42:59 +0100
Date:   Tue, 2 Feb 2010 12:42:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v3] Virtual memory size detection for 64 bit MIPS CPUs
Message-ID: <20100202114259.GA10837@linux-mips.org>
References: <1265064686-31278-1-git-send-email-guenter.roeck@ericsson.com>
 <4B676755.10600@caviumnetworks.com>
 <20100202001026.GA6883@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100202001026.GA6883@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 01, 2010 at 04:10:26PM -0800, Guenter Roeck wrote:

> > > +	if (cpu_has_64bits) {
> > > +		write_c0_entryhi(0xfffffffffffff000ULL);
> > 
> > macro indicated that we need to avoid hazards here on R4000.

A MTC0 instruction on an R4000 writes EntryHi on pipeline stage 7 but
will read from the same register on stage 4 which leaves a window of
2 instructions, that is 2 NOP instructions needed.

> > Perhaps adding:
> > 
> >   	back_to_back_c0_hazard();
> > 
> Compiler already added a nop, so I thought it wasn't necessary.
> Doesn't hurt either, so I'll put it in.

This probe is needed as per MIPSxx architecture spec and several CPUs will
missbehave without it.  The 74K which of course is 32-bit but it
illustrates the issue might even issue these instructions out of order.
back_to_back_c0_hazard will expand into a suitable sequence to handle
the pipeline hazard.  And we can't trust on the compiler doing the right
thing here; as explained above we might need multiple nops and some CPUs
will need other instructions to deal with the hazard, for example a number
of SSNOPs or an EHB instruction.

  Ralf
