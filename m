Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 14:27:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59146 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014618AbcALN1zKQsn0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2016 14:27:55 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u0CDRswp002855;
        Tue, 12 Jan 2016 14:27:54 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u0CDRrf4002854;
        Tue, 12 Jan 2016 14:27:53 +0100
Date:   Tue, 12 Jan 2016 14:27:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Petri Gynther <pgynther@google.com>, linux-mips@linux-mips.org,
        f.fainelli@gmail.com, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: switch BMIPS5000 to use r4k_wait_irqoff()
Message-ID: <20160112132753.GA30362@linux-mips.org>
References: <1445280264-42016-1-git-send-email-pgynther@google.com>
 <20151109092412.GA2775@linux-mips.org>
 <alpine.LFD.2.20.1601120038000.23714@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1601120038000.23714@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51075
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

On Tue, Jan 12, 2016 at 12:42:14AM +0000, Maciej W. Rozycki wrote:

> > > Programming notes:
> > > The WAIT instruction should be executed while interrupts are disabled
> > > by the IE bit in the Status register. This avoids a potential timing
> > > hazard, which occurs if an interrupt is taken between testing the counter
> > > and executing the WAIT instruction. In this hazard case, the interrupt
> > > will have been completed before the WAIT instruction is executed, so
> > > the processor will remain indefinitely in wait state until the next
> > > interrupt.
> > 
> > Note that this is the opposite restriction than many older MIPS CPUs
> > where it is undefined if an interrupt will restart execution of
> > instructions if interrupts are disabled.  So this might be a violation
> > of the architecture specification.  However I rather have it the BMIPS
> > way than the other way ...
> 
>  It's been implementation-dependent since MIPSr1 whether a non-enabled 
> interrupt breaks out of WAIT, so no architecture specification violation 
> here.

I probably should have clarified that in the commit message but alas
too late, this commit is long upstream.

  Ralf
