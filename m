Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2017 23:07:07 +0200 (CEST)
Received: from Galois.linutronix.de ([IPv6:2a01:7a0:2:106d:700::1]:34553 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990475AbdIYVG5MwAXY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2017 23:06:57 +0200
Received: from p4fea516b.dip0.t-ipconnect.de ([79.234.81.107] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1dwaYP-0008Gz-OY; Mon, 25 Sep 2017 23:04:38 +0200
Date:   Mon, 25 Sep 2017 23:06:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, dianders@chromium.org,
        James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>, jeffy.chen@rock-chips.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        tfiga@chromium.org
Subject: Re: [RFC PATCH v1 2/9] genirq: Support shared per_cpu_devid
 interrupts
In-Reply-To: <20170907232542.20589-3-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.20.1709252259270.2418@nanos>
References: <1682867.tATABVWsV9@np-p-burton> <20170907232542.20589-1-paul.burton@imgtec.com> <20170907232542.20589-3-paul.burton@imgtec.com>
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
X-archive-position: 60150
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

On Thu, 7 Sep 2017, Paul Burton wrote:
> Up until now per_cpu_devid interrupts have not supported sharing. On
> MIPS we have some percpu interrupts which are shared in many systems -
> a single CPU interrupt line may be used to indicate a timer interrupt,
> performance counter interrupt or fast debug channel interrupt. We have
> up until now supported this with a series of hacks, wherein drivers call
> each other's interrupt handlers & our MIPS GIC irqchip driver includes a
> hack which configures the interrupt(s) for all CPUs. In order to allow
> this mess to be cleaned up, this patch introduces support for shared
> per_cpu_devid interrupts.
> 
> The major portion of this is supporting per_cpu_devid interrupts in
> __handle_irq_event_percpu() and then making use of this, via
> handle_irq_event_percpu(), from handler_percpu_devif_irq() to invoke the
> handler for all actions associated with the shared interrupt. This does
> have a few side effects worth noting:
> 
>  - per_cpu_devid interrupts will now add to the entropy pool via
>    add_interrupt_randomness(), where they previously did not.
> 
>  - per_cpu_devid interrupts will record timings when IRQS_TIMINGS is
>    set, via record_irq_time(), where they previously did not.
> 
>  - per_cpu_devid interrupts will handle an IRQ_WAKE_THREAD return from
>    their handlers to wake a thread, where they previously did not.

That's broken because it lacks the magic synchronization which is described
in the comment in __irq_wake_thread().

> I'm not aware of any reason the above should be bad side effects, so
> sharing __handle_irq_event_percpu() for per_cpu_devid interrupts seems
> like a positive.

Now you are :)

The other side effect of this is the extra overhead. You add an extra
conditional into the main interrupt handling function
__handle_irq_event_percpu() and the extra loop and hoops overhead for
handle_percpu_devid_irq().

Thanks,

	tglx
