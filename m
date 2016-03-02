Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 11:41:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56662 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012482AbcCBKllGoooC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Mar 2016 11:41:41 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u22AfYuj013081;
        Wed, 2 Mar 2016 11:41:34 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u22AfT5x013080;
        Wed, 2 Mar 2016 11:41:29 +0100
Date:   Wed, 2 Mar 2016 11:41:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V4 3/5] MIPS: Loongson: Invalidate special TLBs when
 needed
Message-ID: <20160302104128.GA18341@linux-mips.org>
References: <1456567658-14694-1-git-send-email-chenhc@lemote.com>
 <1456567658-14694-4-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456567658-14694-4-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52419
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

On Sat, Feb 27, 2016 at 06:07:36PM +0800, Huacai Chen wrote:

> Loongson-2 has a 4 entry itlb which is a subset of jtlb, Loongson-3 has
> a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. We should
> write diag register to invalidate itlb/dtlb when flushing jtlb because
> itlb/dtlb are not totally transparent to software.
> 
> For Loongson-3A R2 (and newer), we should invalidate ITLB, DTLB, VTLB
> and FTLB before we enable/disable FTLB.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/kernel/cpu-probe.c |  2 ++
>  arch/mips/mm/tlb-r4k.c       | 27 +++++++++++++++------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 2a2ae86..ef605e2 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -562,6 +562,8 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
>  					   << MIPS_CONF7_FTLBP_SHIFT));
>  		break;
>  	case CPU_LOONGSON3:
> +		/* Flush ITLB, DTLB, VTLB and FTLB */
> +		write_c0_diag(1<<2 | 1<<3 | 1<<12 | 1<<13);

Too many magic numbers.  Could you use defines for the magic numbers you're
writing to these registers?

>  		/* Loongson-3 cores use Config6 to enable the FTLB */
>  		config = read_c0_config6();
>  		if (enable)
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index c17d762..7593529 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -28,25 +28,28 @@
>  extern void build_tlb_refill_handler(void);
>  
>  /*
> - * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
> - * unfortunately, itlb is not totally transparent to software.
> + * LOONGSON-2 has a 4 entry itlb which is a subset of jtlb, LOONGSON-3 has
> + * a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. Unfortunately,
> + * itlb/dtlb are not totally transparent to software.
>   */
> -static inline void flush_itlb(void)
> +static inline void flush_spec_tlb(void)
>  {
>  	switch (current_cpu_type()) {
>  	case CPU_LOONGSON2:
> +		write_c0_diag(0x4);

Same here.

> +		break;
>  	case CPU_LOONGSON3:
> -		write_c0_diag(4);
> +		write_c0_diag(0xc);

And here.

Also, why did the magic number change from 4 to 0xc?

>  		break;
>  	default:
>  		break;
>  	}
>  }
>  
> -static inline void flush_itlb_vm(struct vm_area_struct *vma)
> +static inline void flush_spec_tlb_vm(struct vm_area_struct *vma)
>  {
>  	if (vma->vm_flags & VM_EXEC)
> -		flush_itlb();
> +		flush_spec_tlb();

Hm..  "spec tlb" is not very descriptive in my opinion.  How about
renameing this function to flush_micro_tlb().

  Ralf
