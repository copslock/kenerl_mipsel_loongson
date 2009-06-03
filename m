Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 12:21:46 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48251 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022560AbZFCLVi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 12:21:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n53BL6mA018825;
	Wed, 3 Jun 2009 12:21:06 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n53BL4Jc018823;
	Wed, 3 Jun 2009 12:21:04 +0100
Date:	Wed, 3 Jun 2009 12:21:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	yan hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzj@lemote.com>,
	Hongbing Hu <huhb@lemote.com>
Subject: Re: [PATCH] Hibernation Support in mips system
Message-ID: <20090603112104.GD13250@linux-mips.org>
References: <1243956702-16276-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243956702-16276-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 02, 2009 at 11:31:42PM +0800, wuzhangjin@gmail.com wrote:
> diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
> new file mode 100644
> index 0000000..5fe43e5
> --- /dev/null
> +++ b/arch/mips/power/cpu.c
> @@ -0,0 +1,31 @@
> +/*
> + * Suspend support specific for mips.
> + *
> + */
> +#include <linux/mm.h>
> +#include <linux/suspend.h>
> +#include <asm/mipsregs.h>
> +#include <asm/page.h>
> +#include <asm/suspend.h>
> +#include <asm/ptrace.h>
> +
> +static uint32_t saved_status;
> +struct pt_regs saved_regs;
> +
> +void save_processor_state(void)
> +{
> +	saved_status = read_c0_status();
> +}
> +
> +void restore_processor_state(void)
> +{
> +	write_c0_status(saved_status);
> +}
> +
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
> +	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
> +
> +	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> +}

I'm missing FPU handling here.

> diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
> new file mode 100644
> index 0000000..4ca9149
> --- /dev/null
> +++ b/arch/mips/power/hibernate.S
> @@ -0,0 +1,67 @@
> +#incldue <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/regdef.h>
> +#include <asm/asm.h>
> +
> +	.extern __flush_cache_all
> +#ifdef CONFIG_SMP
> +	.extern flush_tlb_all
> +#else
> +	.extern local_flush_tlb_all
> +#define flush_tlb_all local_flush_tlb_all
> +#endif

For ease of maintenance, could you do these flushes from C code and only
do the bits that absolutely must be done in assembler, in assembler?

> +	/* flush caches to make sure context is in memory */
> +	PTR_L t0, __flush_cache_all
> +	jalr t0
> +	/* flush tlb entries */
> +	PTR_LA t0, flush_tlb_all

In addition to the above said - there is no PTR_L JALR sequence needed here
because this code is never compiled as a loadable module.  So a jal would
do the job.

All in all this is looking much better than the first version!

  Ralf
