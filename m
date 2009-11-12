Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 21:17:44 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43487 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493234AbZKLURl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 21:17:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACKHbAT026713;
	Thu, 12 Nov 2009 21:17:38 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACKHZnh026711;
	Thu, 12 Nov 2009 21:17:35 +0100
Date:	Thu, 12 Nov 2009 21:17:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com, huhb@lemote.com
Subject: Re: [PATCH -queue 1/3] [loongson] lemote-2f: add cs5536 MFGPT
	timer support
Message-ID: <20091112201735.GA25435@linux-mips.org>
References: <cover.1257923011.git.wuzhangjin@gmail.com> <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 03:09:57PM +0800, Wu Zhangjin wrote:

> When Oprofile is used, it's better not to use the MIPS Timer, but use an
> external timer, in Lemote loongson2f family machines, there is a cs5536
> mfgpt timer, this patch add support for it.
> 
> And also, this external timer is also needed by the next Cpufreq support,
> 'Cause the frequency of the MIPS Timer is half of the cpu frequency, if
> we use it with Cpufreq support, the sytem time will become not accuracy.
> 
> And we export the mfgpt0 counter disable/enable operations for the
> coming suspend support to suspend/resume the timer.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   35 +++
>  arch/mips/loongson/Kconfig                         |   11 +-
>  arch/mips/loongson/common/cs5536/Makefile          |    5 +
>  arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  217 ++++++++++++++++++++
>  arch/mips/loongson/common/time.c                   |    3 +
>  5 files changed, 269 insertions(+), 2 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
>  create mode 100644 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
> 
> diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
> new file mode 100644
> index 0000000..8d45945
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
> @@ -0,0 +1,35 @@
> +/*
> + * cs5536 mfgpt header file
> + */
> +
> +#ifndef _CS5536_MFGPT_H
> +#define _CS5536_MFGPT_H
> +
> +#include <cs5536/cs5536.h>
> +#include <cs5536/cs5536_pci.h>
> +
> +#ifdef CONFIG_CS5536_MFGPT
> +extern void setup_mfgpt_timer(void);
> +extern void disable_mfgpt0_counter(void);
> +extern void enable_mfgpt0_counter(void);
> +#else
> +static inline void __maybe_unused setup_mfgpt0_timer(void)
> +{
> +}
> +static inline void __maybe_unused disable_mfgpt0_counter(void)
> +{
> +}
> +static inline void __maybe_unused enable_mfgpt0_counter(void)
> +{
> +}
> +#endif
> +
> +#define MFGPT_TICK_RATE 14318000
> +#define COMPARE  ((MFGPT_TICK_RATE + HZ/2) / HZ)
> +
> +#define MFGPT_BASE	mfgpt_base
> +#define MFGPT0_CMP2	(MFGPT_BASE + 2)
> +#define MFGPT0_CNT	(MFGPT_BASE + 4)
> +#define MFGPT0_SETUP	(MFGPT_BASE + 6)
> +
> +#endif /*!_CS5536_MFGPT_H */
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index 029360f..648c47d 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -34,10 +34,10 @@ config LEMOTE_MACH2F
>  	select ARCH_SPARSEMEM_ENABLE
>  	select BOARD_SCACHE
>  	select BOOT_ELF32
> -	select CEVT_R4K
> +	select CEVT_R4K if !CS5536_MFGPT
>  	select CPU_HAS_WB
>  	select CS5536
> -	select CSRC_R4K
> +	select CSRC_R4K if !CS5536_MFGPT

A bit inelegant to trust on a user to pick the right value for CS5536_MFGPT.

A non-fixed clock for c0_count is an obvious reason to avoid using CEVT_R4K
and CSRC_R4K; we probably need something like cpu_has_fixed_c0_count_clock
to make that decission at runtime.

>  	select DMA_NONCOHERENT
>  	select GENERIC_HARDIRQS_NO__DO_IRQ
>  	select GENERIC_ISA_DMA_SUPPORT_BROKEN
> @@ -62,6 +62,13 @@ endchoice
>  config CS5536
>  	bool
>  
> +config CS5536_MFGPT
> +	bool "Using cs5536's MFGPT as system clock"
> +	depends on CS5536
> +	help
> +	  This is needed when cpufreq or oprofile is enabled in Lemote Loongson2F
> +	  family machines

A patch to deal with interaction between oprofile and the cp0 count / compare
was queued recently.  So is there any remaining issue or is the comment here
just outdated?

  Ralf
