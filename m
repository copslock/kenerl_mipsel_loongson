Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:28:58 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:52062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993912AbdFHN0knplIT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 15:26:40 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6C492B;
        Thu,  8 Jun 2017 06:26:33 -0700 (PDT)
Received: from on-the-bus (on-the-bus.cambridge.arm.com [10.1.32.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3CE3F578;
        Thu,  8 Jun 2017 06:26:32 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] irqchip/mips-gic: mark count and compare accessors notrace
In-Reply-To: <1496927183-31987-1-git-send-email-marcin.nowakowski@imgtec.com>
        (Marcin Nowakowski's message of "Thu, 8 Jun 2017 15:06:23 +0200")
Organization: ARM Ltd
References: <1496927183-31987-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Thu, 08 Jun 2017 14:26:30 +0100
Message-ID: <87k24mipa1.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On Thu, Jun 08 2017 at  3:06:23 pm BST, Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> gic_read_count(), gic_write_compare() and gic_write_cpu_compare() are
> often used in a sequence to update the compare register with a count
> value increased by a small offset.
> With small delta values used to update the compare register, the time to
> update function trace for these operations may be longer than the update
> timeout leading to update failure.
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index eb7fbe1..ecee073 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -140,7 +140,7 @@ static inline void gic_map_to_vpe(unsigned int intr, unsigned int vpe)
>  }
>  
>  #ifdef CONFIG_CLKSRC_MIPS_GIC
> -u64 gic_read_count(void)
> +notrace u64 gic_read_count(void)

The attributes are usually placed between the return type and the
function name.

>  {
>  	unsigned int hi, hi2, lo;
>  
> @@ -167,7 +167,7 @@ unsigned int gic_get_count_width(void)
>  	return bits;
>  }
>  
> -void gic_write_compare(u64 cnt)
> +notrace void gic_write_compare(u64 cnt)
>  {
>  	if (mips_cm_is64) {
>  		gic_write(GIC_REG(VPE_LOCAL, GIC_VPE_COMPARE), cnt);
> @@ -179,7 +179,7 @@ void gic_write_compare(u64 cnt)
>  	}
>  }
>  
> -void gic_write_cpu_compare(u64 cnt, int cpu)
> +notrace void gic_write_cpu_compare(u64 cnt, int cpu)
>  {
>  	unsigned long flags;

What guarantees do you have that some event (interrupt? frequency
scaling?) won't delay these anyway, generating the same missed deadline?
Shouldn't the code deal with these case and acknowledge that the
deadline has already expired?

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
