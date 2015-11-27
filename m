Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 09:38:45 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:42956 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006607AbbK0IioN6YJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 09:38:44 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1a2EYA-0006po-EJ; Fri, 27 Nov 2015 09:38:38 +0100
Date:   Fri, 27 Nov 2015 09:37:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Simon Arlott <simon@fire.lp0.eu>
cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH (v4) 2/11] MIPS: bmips: Add bcm6345-l2-timer interrupt
 controller
In-Reply-To: <5657886F.3090908@simon.arlott.org.uk>
Message-ID: <alpine.DEB.2.11.1511270926580.3572@nanos>
References: <5650BFD6.5030700@simon.arlott.org.uk> <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com> <5653612A.4050309@simon.arlott.org.uk> <565361AF.20400@simon.arlott.org.uk> <70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5654E67A.9060800@gmail.com> <5657886F.3090908@simon.arlott.org.uk>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50141
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

Simon,

On Thu, 26 Nov 2015, Simon Arlott wrote:
> +static inline u32 bcm6345_timer_read_int_status(struct bcm6345_timer *timer)
> +{
> +	if (timer->interrupt_bits == 32)
> +		return __raw_readl(timer->base + timer->regs[TIMER_INT_STATUS]);
> +	else
> +		return __raw_readb(timer->base + timer->regs[TIMER_INT_STATUS]);
> +}

Instead of having that pile of conditionals you could just define two
functions and have a function pointer in struct bcm6345_timer which
you initialize at init time.

> +static inline void bcm6345_timer_write_control(struct bcm6345_timer *timer,
> +	unsigned int id, u32 val)
> +{
> +	if (id >= timer->nr_timers) {
> +		WARN(1, "%s: %d >= %d", __func__, id, timer->nr_timers);

This is more than silly. You call that form the init function via:

	for (i = 0; i < timer->nr_timers; i++)

Hmm?

> +static void bcm6345_timer_unmask(struct irq_data *d)
> +{
> +	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
> +	unsigned long flags;
> +	u8 val;
> +
> +	if (d->hwirq < timer->nr_timers) {

Again. You can have two different interrupt chips without that
completely undocumented and non obvious conditional.

BTW, how are those simple interrupts masked at all?

> +		raw_spin_lock_irqsave(&timer->lock, flags);
> +		val = bcm6345_timer_read_int_enable(timer);
> +		val |= BIT(d->hwirq);
> +		bcm6345_timer_write_int_enable(timer, val);
> +		raw_spin_unlock_irqrestore(&timer->lock, flags);
> +	}
> +}

> +	raw_spin_lock_init(&timer->lock);
> +	timer->regs = regs;
> +	timer->interrupt_bits = interrupt_bits;
> +	timer->nr_timers = nr_timers;
> +	timer->nr_interrupts = nr_timers + 1;

What is that extra interrupt about? For the casual reader this looks
like a bug ... Comments exist for a reason.

Thanks,

	tglx
