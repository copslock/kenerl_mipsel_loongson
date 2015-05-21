Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:00:12 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:41350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012557AbbEUWAKt-YEg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:00:10 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1YvYVg-0005hN-Co; Fri, 22 May 2015 00:00:12 +0200
Date:   Fri, 22 May 2015 00:00:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien.Horsley@imgtec.com, Govindraj.Raja@imgtec.com
Subject: Re: [PATCH 6/7] clocksource: Add Pistachio clocksource-only driver
In-Reply-To: <1432244506-15388-1-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <alpine.DEB.2.11.1505212352330.5457@nanos>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com> <1432244506-15388-1-git-send-email-ezequiel.garcia@imgtec.com>
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
X-archive-position: 47527
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

On Thu, 21 May 2015, Ezequiel Garcia wrote:
> +static cycle_t clocksource_read_cycles(struct clocksource *cs)
> +{
> +	u32 counter, overflw;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&lock, flags);

Hmm. Is that lock really necessary to read that counter? The
clocksource is global. And if its actually used for timekeeping, the
lock can get heavy contended.

> +	overflw = gpt_readl(TIMER_CURRENT_OVERFLOW_VALUE, 0);
> +	counter = gpt_readl(TIMER_CURRENT_VALUE, 0);
> +	raw_spin_unlock_irqrestore(&lock, flags);
> +
> +	return ~(cycle_t)counter;
> +}

Thanks,

	tglx
