Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jun 2015 16:11:47 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:33591 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006852AbbFTOLqPxyRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jun 2015 16:11:46 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Z6JUj-00006K-LH; Sat, 20 Jun 2015 16:11:41 +0200
Date:   Sat, 20 Jun 2015 16:11:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Norris <computersforpeace@gmail.com>
cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to
 irq_chip
In-Reply-To: <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <alpine.DEB.2.11.1506201605290.4107@nanos>
References: <20150619224123.GL4917@ld-irv-0074> <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
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
X-archive-position: 47994
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

On Fri, 19 Jun 2015, Brian Norris wrote:
> This patch adds a second set of suspend/resume hooks to irq_chip, this
> time to represent *chip* suspend/resume, rather than IRQ suspend/resume.
> These callbacks will always be called for an irqchip and are based on
> the per-chip irq_chip_generic struct, rather than the per-IRQ irq_data
> struct.

There is no per-chip irq_chip_generic struct. It's only there if the
irq chip has been instantiated as a generic chip.
 
>  /**
>   * struct irq_chip - hardware interrupt chip descriptor
>   *
> @@ -317,6 +319,12 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>   * @irq_suspend:	function called from core code on suspend once per chip
>   * @irq_resume:		function called from core code on resume once per chip
>   * @irq_pm_shutdown:	function called from core code on shutdown once per chip
> + * @chip_suspend:	function called from core code on suspend once per
> + *			chip; for handling chip details even when no interrupts
> + *			are in use
> + * @chip_resume:	function called from core code on resume once per chip;
> + *			for handling chip details even when no interrupts are
> + *			in use
>   * @irq_calc_mask:	Optional function to set irq_data.mask for special cases
>   * @irq_print_chip:	optional to print special chip info in show_interrupts
>   * @irq_request_resources:	optional to request resources before calling
> @@ -357,6 +365,8 @@ struct irq_chip {
>  	void		(*irq_suspend)(struct irq_data *data);
>  	void		(*irq_resume)(struct irq_data *data);
>  	void		(*irq_pm_shutdown)(struct irq_data *data);
> +	void		(*chip_suspend)(struct irq_chip_generic *gc);
> +	void		(*chip_resume)(struct irq_chip_generic *gc);

I really don't want to set a precedent for random (*foo)(*bar)
callbacks.
 
> +
> +		if (ct->chip.chip_suspend)
> +			ct->chip.chip_suspend(gc);

So wouldn't it be the more intuitive solution to make this a callback
in the struct gc itself?

Thanks,

	tglx
