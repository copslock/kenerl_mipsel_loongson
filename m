Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 11:19:08 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:52826 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990414AbdJSJTAUmoPX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 11:19:00 +0200
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e56ye-0004n2-1G; Thu, 19 Oct 2017 11:18:56 +0200
Date:   Thu, 19 Oct 2017 11:18:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Matt Redfearn <matt.redfearn@mips.com>, linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "# v3 . 19 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clocksource/mips-gic-timer: Fix rcu_sched timeouts
 from multithreading
In-Reply-To: <32cc3d3e-88df-405f-5278-7fe00d066a93@linaro.org>
Message-ID: <alpine.DEB.2.20.1710191117010.1971@nanos>
References: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com> <alpine.DEB.2.20.1710182226080.2477@nanos> <32cc3d3e-88df-405f-5278-7fe00d066a93@linaro.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60458
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

On Thu, 19 Oct 2017, Daniel Lezcano wrote:
> On 18/10/2017 22:34, Thomas Gleixner wrote:
> > On Wed, 11 Oct 2017, Matt Redfearn wrote:
> > 
> >> When the MIPS GIC clockevent code was written, it appears to have
> >> inherited the 0x300 cycle min delta from the MIPS CPU timer driver. This
> >> is suboptimal for two reasons.
> >>
> >> Firstly, the CPU timer counts once every other cycle (i.e. half the
> >> clock rate). The GIC counts once per clock. Assuming that the GIC and
> >> CPU share the same clock this means the GIC is counting twice as fast,
> >> and so the min delta should be (at least) doubled. Fix this by doubling
> >> the min delta to 0x600.
> >>
> >> Secondly, the fixed min delta ignores the fact that with MIPS
> >> multithreading active, execution resource within a core is shared
> >> between the hardware threads within that core. An inconvenienly timed
> >> switch of executing thread within gic_next_event, between the read and
> >> write of updated count, can result in the CPU writing an event in the
> >> past, and subsequently not receiving a tick interrupt until the counter
> >> wraps. This stalls the CPU from the RCU scheduler. Other CPUs detect
> >> this and print rcu_sched timeout messages in  the kernel log. It can
> >> lead to other issues as well if the CPU is holding locks or other
> >> resources at the point at which it stalls. Fix this by scaling the min
> >> delta for the timer based on the number of threads in the core
> >> (smp_num_siblings). This accounts for the greater average runtime of
> >> CPUs within a multithreading core.
> > 
> > I don't understand why this is not catched by the check at the end of the
> > next_event() function:
> > 
> >         res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
> > 
> > Btw, the local_irq_save() in this function is pointless as this function is
> > always called with interrupts disabled from the core code.
> 
> Would it be worth to add some comment in include/linux/clockchips.h in
> the structure definition for the different callbacks to tell which ones
> are called with the irq disabled ?

Yes. IIRC all callbacks are invoked with interrupts disabled. Care to check
that and whip up a patch?

Thanks,

	tglx
