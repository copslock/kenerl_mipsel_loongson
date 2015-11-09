Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 10:24:15 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48398 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013014AbbKIJYNYXYvp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Nov 2015 10:24:13 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tA99OCWM002819;
        Mon, 9 Nov 2015 10:24:12 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tA99OC6U002818;
        Mon, 9 Nov 2015 10:24:12 +0100
Date:   Mon, 9 Nov 2015 10:24:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Petri Gynther <pgynther@google.com>
Cc:     linux-mips@linux-mips.org, f.fainelli@gmail.com, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: switch BMIPS5000 to use r4k_wait_irqoff()
Message-ID: <20151109092412.GA2775@linux-mips.org>
References: <1445280264-42016-1-git-send-email-pgynther@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445280264-42016-1-git-send-email-pgynther@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49870
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

On Mon, Oct 19, 2015 at 11:44:24AM -0700, Petri Gynther wrote:

> BCM7425 CPU Interface Zephyr Processor, pages 5-309 and 5-310
> BCM7428B0 CPU Interface Zephyr Processor, pages 5-337 and 5-338
> 
> WAIT instruction:
> Thread enters wait state. No instructions are executed until an
> interrupt occurs. The processor's clocks are stopped if both threads
> are in idle mode.
> 
> Description:
> Execution of this instruction puts the thread into wait state, an idle
> mode in which no instructions are fetched or executed. The thread remains
> in wait state until an interrupt occurs that is not masked by the
> interrupt mask field in the Status register. Then, if interrupts are
> enabled by the IE bit in the Status register, the interrupt is serviced.
> The ERET instruction returns to the instruction following the WAIT
> instruction. If interrupts are disabled, the processor resumes executing
> instructions with the next sequential instruction.
> 
> Programming notes:
> The WAIT instruction should be executed while interrupts are disabled
> by the IE bit in the Status register. This avoids a potential timing
> hazard, which occurs if an interrupt is taken between testing the counter
> and executing the WAIT instruction. In this hazard case, the interrupt
> will have been completed before the WAIT instruction is executed, so
> the processor will remain indefinitely in wait state until the next
> interrupt.

Note that this is the opposite restriction than many older MIPS CPUs
where it is undefined if an interrupt will restart execution of
instructions if interrupts are disabled.  So this might be a violation
of the architecture specification.  However I rather have it the BMIPS
way than the other way ...

  Ralf
