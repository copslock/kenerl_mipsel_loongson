Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 17:39:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47765 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007263AbbEZPjDhhiQc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 May 2015 17:39:03 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4QFd0CT018862;
        Tue, 26 May 2015 17:39:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4QFcxj0018861;
        Tue, 26 May 2015 17:38:59 +0200
Date:   Tue, 26 May 2015 17:38:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH v5 06/37] MIPS: irq_cpu: declare irqchip table entry
Message-ID: <20150526153859.GA18514@linux-mips.org>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
 <1432480307-23789-7-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432480307-23789-7-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, May 24, 2015 at 04:11:16PM +0100, Paul Burton wrote:

> Subject: [PATCH v5 06/37] MIPS: irq_cpu: declare irqchip table entry
> Content-Type: text/plain
> 
> Allow the MIPS CPU interrupt controller to be probed from DT using the
> generic __irqchip_of_table for platforms which use irqchip_init. This
> will avoid such platforms needing to duplicate the compatible string &
> init function pointer.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Rebase.
> 
> Changes in v2: None
> 
>  arch/mips/kernel/irq_cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
> index 6eb7a3f..f96313d 100644
> --- a/arch/mips/kernel/irq_cpu.c
> +++ b/arch/mips/kernel/irq_cpu.c
> @@ -38,6 +38,8 @@
>  #include <asm/mipsmtregs.h>
>  #include <asm/setup.h>
>  
> +#include "../../drivers/irqchip/irqchip.h"
> +
>  static inline void unmask_mips_irq(struct irq_data *d)
>  {
>  	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
> @@ -167,3 +169,4 @@ int __init mips_cpu_irq_of_init(struct device_node *of_node,
>  	__mips_cpu_irq_init(of_node);
>  	return 0;
>  }
> +IRQCHIP_DECLARE(cpu_intc, "mti,cpu-interrupt-controller", mips_cpu_irq_of_init);

Having to type "../" to get an include file should be a strong indicator
something is wrong.  In this case it probably means irq_cpu.c should be
moved to drivers/irqchip/.

The same gem also exists in arch/arc/kernel/irq.c and arch/microblaze/-
kernel/intc.c.  And two more files arch/arm/mach-imx/gpc.c and
arch/arm/mach-omap2/omap-wakeupgen.c are avoiding the issue by coding
their private variants of IRQCHIP_DECLARE.

  Ralf
