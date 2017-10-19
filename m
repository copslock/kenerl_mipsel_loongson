Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 10:22:23 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:52570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdJSIWQi75ND (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 10:22:16 +0200
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1e565g-0003tw-TA; Thu, 19 Oct 2017 10:22:09 +0200
Date:   Thu, 19 Oct 2017 10:22:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@mips.com>
cc:     James Hogan <james.hogan@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "# v3 . 19 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clocksource/mips-gic-timer: Fix rcu_sched timeouts
 from multithreading
In-Reply-To: <dd1dcbdf-93bc-7807-df5c-2ec36550bd5a@mips.com>
Message-ID: <alpine.DEB.2.20.1710191020510.1971@nanos>
References: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com> <alpine.DEB.2.20.1710182226080.2477@nanos> <dd1dcbdf-93bc-7807-df5c-2ec36550bd5a@mips.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60454
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

On Thu, 19 Oct 2017, Matt Redfearn wrote:
> On 18/10/17 21:34, Thomas Gleixner wrote:
> > On Wed, 11 Oct 2017, Matt Redfearn wrote:
> > > Secondly, the fixed min delta ignores the fact that with MIPS
> > > multithreading active, execution resource within a core is shared
> > > between the hardware threads within that core. An inconvenienly timed
> > > switch of executing thread within gic_next_event, between the read and
> > > write of updated count, can result in the CPU writing an event in the
> > > past, and subsequently not receiving a tick interrupt until the counter
> > > wraps. This stalls the CPU from the RCU scheduler. Other CPUs detect
> > > this and print rcu_sched timeout messages in  the kernel log. It can
> > > lead to other issues as well if the CPU is holding locks or other
> > > resources at the point at which it stalls. Fix this by scaling the min
> > > delta for the timer based on the number of threads in the core
> > > (smp_num_siblings). This accounts for the greater average runtime of
> > > CPUs within a multithreading core.
> >
> > I don't understand why this is not catched by the check at the end of the
> > next_event() function:
> > 
> >          res = ((int)(gic_read_count() - cnt) >= 0) ? -ETIME : 0;
> > 
> > Btw, the local_irq_save() in this function is pointless as this function is
> > always called with interrupts disabled from the core code.
> 
> This is an issue because in some cases (hrtimer_reprogram ->
> clockevents_program_event -> clockevents_program_min_delta, when
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=n) there is no retry performed in the
> case of -ETIME. There has been a patch pending for some time
> https://patchwork.kernel.org/patch/8909491/ which ought to address this and
> retry in the case of an event in the past on this call path. But in the
> meantime this patch vastly improves the situation.

I somehow missed that one. Care to repost so we get that solved at the
place where it should be solved.

Thanks,

	tglx
