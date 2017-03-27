Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2017 15:06:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33534 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993865AbdC0NFz2bPPp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Mar 2017 15:05:55 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2RD5hx9023090;
        Mon, 27 Mar 2017 15:05:43 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2RD5dal023086;
        Mon, 27 Mar 2017 15:05:39 +0200
Date:   Mon, 27 Mar 2017 15:05:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: Does the R10K family support the "wait" instruction?
Message-ID: <20170327130539.GA5734@linux-mips.org>
References: <88c3cc1d-fd80-bb9a-d1ec-ed3c44dea71b@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c3cc1d-fd80-bb9a-d1ec-ed3c44dea71b@gentoo.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Mar 26, 2017 at 09:50:08PM -0400, Joshua Kinard wrote:

> Does anyone know if the R1x000 family of CPUs support the "wait" instruction?
> The 'check_wait' function in arch/mips/kernel/idle.c doesn't have a case for
> any of the R10K CPUs, and I can't find any specific guidance in the final R10K
> manual produced by Renesas, nor in the MIPS-IV instruction set.  It appears
> this was added in MIPS-II, and the R4K CPUs use it, with one version for when
> interrupts are enabled, and one where they're disabled.  Since a lot of CPUs
> tend to reuse R4K-compatible code, I wasn't sure.

Interesting, didn't know Renesas did another R10000 manual.  Presumably
they only rebranded NEC's manual?

If you have any documentation to indicate a MIPS II CPU to support WAIT,
I'm interested.  From all that I know the feature was introduced by the
R4600.

> Kinda-assuming it doesn't, since the R10K lacks any notion of reduced power
> operation.

The R10000 like many of the older MIPS CPU took a hardware-only approach
to low-power operation, that is there are no knobs, no instructions for
software to optimize the power consumption.  That also means, no WAIT
instruction.  Other bits of low-power support in R4x00-processors are
fake also, for example the c0_status.rp "reduced power" bit is documented
but fairly hidden erratas say it's not implemneted.  So just throw in another
plutonium slab and all will be good ;-)

But back to the WAIT instruction.  WAIT uses major opcode COP0 which has
bits 31..27 = 010000.  Traditionally MIPS doesn't fully decode the minor
opcodes, so an unsupported WAIT instruction will not cause an Reserved
Instruction exception anyway because the COP0 opcode does exist.

So one could basically pretend WAIT did exist on all MIPS CPUs, even
R2000 even though it doesn't - but check_wait is paranoid and really
avoids WAIT unless it's officially supported and useful.

Another complexity is that WAIT instruction was defined for many years
to leave it to an implementation if the pipeline would ever restart
after a WAIT instruction was executed with interrupts disabled.  This
is fairly braindead because in a typical idle loop of an OS such as Linux

        for (;;) {
                if (wait_available && !need_resched())
                        asm("wait");
                schedule();
        }

there is the race condition between checking need_resched() and
actually executing WAIT that need_resched() might change, so WAIT-mode
might be entered falsely causing a scheduling delay of up to one tick.
The solution is to disable interrupts like:

        for (;;) {
		disable_irq();
                if (wait_available && !need_resched())
                        asm("wait");
		enable_irq();
                schedule();
        }

But some MIPS CPUs might lockup for good if this is attempted ...

This turned out to be a longer writeup than I meant to because I
recognized much of this is not documented anywhere so I did elaborate
a bit and add it as a new wiki page:

https://www.linux-mips.org/wiki/WAIT_instruction

  Ralf
