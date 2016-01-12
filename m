Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 01:42:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49844 "EHLO localhost"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009041AbcALAmOGiH3j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2016 01:42:14 +0100
Date:   Tue, 12 Jan 2016 00:42:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Petri Gynther <pgynther@google.com>, linux-mips@linux-mips.org,
        f.fainelli@gmail.com, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: switch BMIPS5000 to use r4k_wait_irqoff()
In-Reply-To: <20151109092412.GA2775@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1601120038000.23714@eddie.linux-mips.org>
References: <1445280264-42016-1-git-send-email-pgynther@google.com> <20151109092412.GA2775@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51065
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

On Mon, 9 Nov 2015, Ralf Baechle wrote:

> > Programming notes:
> > The WAIT instruction should be executed while interrupts are disabled
> > by the IE bit in the Status register. This avoids a potential timing
> > hazard, which occurs if an interrupt is taken between testing the counter
> > and executing the WAIT instruction. In this hazard case, the interrupt
> > will have been completed before the WAIT instruction is executed, so
> > the processor will remain indefinitely in wait state until the next
> > interrupt.
> 
> Note that this is the opposite restriction than many older MIPS CPUs
> where it is undefined if an interrupt will restart execution of
> instructions if interrupts are disabled.  So this might be a violation
> of the architecture specification.  However I rather have it the BMIPS
> way than the other way ...

 It's been implementation-dependent since MIPSr1 whether a non-enabled 
interrupt breaks out of WAIT, so no architecture specification violation 
here.

  Maciej
