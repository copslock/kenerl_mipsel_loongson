Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 22:35:08 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:51113 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992456AbdJRUey61HAQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 22:34:54 +0200
Received: from p4fea5642.dip0.t-ipconnect.de ([79.234.86.66] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e4v3B-00064y-Rd; Wed, 18 Oct 2017 22:34:50 +0200
Date:   Wed, 18 Oct 2017 22:34:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@mips.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "# v3 . 19 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clocksource/mips-gic-timer: Fix rcu_sched timeouts
 from multithreading
In-Reply-To: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
Message-ID: <alpine.DEB.2.20.1710182226080.2477@nanos>
References: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Wed, 11 Oct 2017, Matt Redfearn wrote:

> When the MIPS GIC clockevent code was written, it appears to have
> inherited the 0x300 cycle min delta from the MIPS CPU timer driver. This
> is suboptimal for two reasons.
> 
> Firstly, the CPU timer counts once every other cycle (i.e. half the
> clock rate). The GIC counts once per clock. Assuming that the GIC and
> CPU share the same clock this means the GIC is counting twice as fast,
> and so the min delta should be (at least) doubled. Fix this by doubling
> the min delta to 0x600.
> 
> Secondly, the fixed min delta ignores the fact that with MIPS
> multithreading active, execution resource within a core is shared
> between the hardware threads within that core. An inconvenienly timed
> switch of executing thread within gic_next_event, between the read and
> write of updated count, can result in the CPU writing an event in the
> past, and subsequently not receiving a tick interrupt until the counter
> wraps. This stalls the CPU from the RCU scheduler. Other CPUs detect
> this and print rcu_sched timeout messages in  the kernel log. It can
> lead to other issues as well if the CPU is holding locks or other
> resources at the point at which it stalls. Fix this by scaling the min
> delta for the timer based on the number of threads in the core
> (smp_num_siblings). This accounts for the greater average runtime of
> CPUs within a multithreading core.

I don't understand why this is not catched by the check at the end of the
next_event() function:

        res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;

Btw, the local_irq_save() in this function is pointless as this function is
always called with interrupts disabled from the core code.

Thanks,

	tglx
