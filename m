Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 20:52:23 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56643 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008131AbaIESwVc5AMo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 20:52:21 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XPyc4-0002qH-WF; Fri, 05 Sep 2014 20:52:01 +0200
Date:   Fri, 5 Sep 2014 20:51:59 +0200 (CEST)
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
Subject: Re: [PATCH v2 01/16] MIPS: Provide a generic plat_irq_dispatch
In-Reply-To: <1409938218-9026-2-git-send-email-abrestic@chromium.org>
Message-ID: <alpine.DEB.2.10.1409052051240.5472@nanos>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org> <1409938218-9026-2-git-send-email-abrestic@chromium.org>
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
X-archive-position: 42447
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
> For platforms which boot with device-tree and use the MIPS CPU interrupt
> controller binding, a generic plat_irq_dispatch() can be used since all
> CPU interrupts should be mapped through the CPU IRQ domain.  Implement a
> plat_irq_dispatch() which simply handles the highest pending interrupt.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Tested-by: Jonas Gorski <jogo@openwrt.org>
> ---
> No changes from v1.
> ---
>  arch/mips/kernel/irq_cpu.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
> index e498f2b..9cf8459 100644
> --- a/arch/mips/kernel/irq_cpu.c
> +++ b/arch/mips/kernel/irq_cpu.c
> @@ -116,6 +116,24 @@ void __init mips_cpu_irq_init(void)
>  }
>  
>  #ifdef CONFIG_IRQ_DOMAIN
> +static struct irq_domain *mips_intc_domain;
> +
> +asmlinkage void __weak plat_irq_dispatch(void)
> +{
> +	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +	unsigned int hw;
> +	int irq;
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		return;
> +	}
> +
> +	hw = fls(pending) - CAUSEB_IP - 1;
> +	irq = irq_linear_revmap(mips_intc_domain, hw);
> +	do_IRQ(irq);

Why are you not handling all pending interrupts in a loop?

Thanks,

	tglx
