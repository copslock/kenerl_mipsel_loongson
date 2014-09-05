Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 21:06:06 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008131AbaIETGBiWyLZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 21:06:01 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XPypU-00030g-F1; Fri, 05 Sep 2014 21:05:52 +0200
Date:   Fri, 5 Sep 2014 21:05:50 +0200 (CEST)
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
Subject: Re: [PATCH v2 14/16] irqchip: mips-gic: Support local interrupts
In-Reply-To: <1409938218-9026-15-git-send-email-abrestic@chromium.org>
Message-ID: <alpine.DEB.2.10.1409052056400.5472@nanos>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org> <1409938218-9026-15-git-send-email-abrestic@chromium.org>
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
X-archive-position: 42448
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
>  static void gic_mask_irq(struct irq_data *d)
>  {
> -	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
> +	unsigned int irq = d->irq - gic_irq_base;
> +
> +	if (gic_is_local_irq(irq)) {
> +		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK),
> +			 1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
> +	} else {
> +		GIC_CLR_INTR_MASK(irq);
> +	}
>  }
>  
>  static void gic_unmask_irq(struct irq_data *d)
>  {
> -	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
> +	unsigned int irq = d->irq - gic_irq_base;
> +
> +	if (gic_is_local_irq(irq)) {
> +		GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK),
> +			 1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
> +	} else {
> +		GIC_SET_INTR_MASK(irq);
> +	}

Why are you adding a conditional in all these functions instead of
having two interrupt chips with separate callbacks and irqdata?

And looking at GIC_SET_INTR_MASK(irq) makes me shudder even more. The
whole thing can be replaced with the generic interrupt chip functions.

If you set it up proper, then there is not a single conditional or
runtime calculation of bitmasks, address offsets etc.

Thanks,

	tglx
