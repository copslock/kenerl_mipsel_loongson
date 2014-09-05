Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 21:09:07 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008131AbaIETJFqPnPy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 21:09:05 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XPysU-00034q-LA; Fri, 05 Sep 2014 21:08:58 +0200
Date:   Fri, 5 Sep 2014 21:08:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Bresticker <abrestic@chromium.org>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/16] MIPS: GIC: Use local interrupts for timer
In-Reply-To: <1409938218-9026-16-git-send-email-abrestic@chromium.org>
Message-ID: <alpine.DEB.2.10.1409052108090.5472@nanos>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org> <1409938218-9026-16-git-send-email-abrestic@chromium.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42449
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

On Fri, 5 Sep 2014, Andrew Bresticker wrote:

> Instead of using GIC interrupt 0 for the timer (which was not even
> handled correctly by the GIC irqchip code and could conflict with an
> actual external interrupt), use the designated local interrupt for
> the GIC timer.
> 
> Also, since the timer is a per-CPU interrupt, initialize it with
> setup_percpu_irq() and enable it with enable_percpu_irq() instead
> of using direct register writes.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> No changes from v1.
> ---
>  arch/mips/kernel/cevt-gic.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
> index 6093716..cae72a4 100644
> --- a/arch/mips/kernel/cevt-gic.c
> +++ b/arch/mips/kernel/cevt-gic.c
> @@ -68,7 +68,7 @@ int gic_clockevent_init(void)
>  	if (!cpu_has_counter || !gic_frequency)
>  		return -ENXIO;
>  
> -	irq = MIPS_GIC_IRQ_BASE;
> +	irq = MIPS_GIC_LOCAL_IRQ_BASE + GIC_LOCAL_INTR_COMPARE;
>  
>  	cd = &per_cpu(gic_clockevent_device, cpu);
>  
> @@ -91,15 +91,13 @@ int gic_clockevent_init(void)
>  
>  	clockevents_register_device(cd);
>  
> -	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE_MAP), 0x80000002);
> -	GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), GIC_VPE_SMASK_CMP_MSK);
> +	if (!gic_timer_irq_installed) {
> +		setup_percpu_irq(irq, &gic_compare_irqaction);
> +		irq_set_handler(irq, handle_percpu_irq);
> +		gic_timer_irq_installed = 1;
> +	}
>  
> -	if (gic_timer_irq_installed)
> -		return 0;
> +	enable_percpu_irq(irq, 0);

Please use a proper IRQ_TYPE constant instead of 0

Thanks,

	tglx
