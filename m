Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 10:30:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3939 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008889AbbGNIa0rGGjx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 10:30:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B0D8ADCE24F2;
        Tue, 14 Jul 2015 09:30:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 14 Jul 2015 09:30:20 +0100
Received: from localhost (10.100.200.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 14 Jul
 2015 09:30:19 +0100
Date:   Tue, 14 Jul 2015 09:30:19 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH v2 10/19] MIPS: asm: mips-cm: Extend CM accessors for
 64-bit CPUs
Message-ID: <20150714083019.GD2519@NP-P-BURTON>
References: <1436434853-30001-11-git-send-email-markos.chandras@imgtec.com>
 <1436861652-2063-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1436861652-2063-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.168]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Tue, Jul 14, 2015 at 09:14:12AM +0100, Markos Chandras wrote:
> Previously, the CM accessors were only accessing CM registers as u32
> types instead of using the native CM register with. However, newer CMs
> may actually be 64-bit on MIPS64 cores. Fortunately, current 64-bit CMs
> (CM3) hold all the useful configuration bits in the lower half of the
> 64-bit registers (at least most of them) so they can still be accessed
> using the current 32-bit accessors.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Changes since v1
> - Use 32-bit CM I/O on 32-bit kernels

A concern I have, but haven't yet drank enough coffee to think through
fully, is whether this will work on big endian systems. These are 64b
addresses and you're writing 32b to their addresses which I suspect may
go horribly wrong.

Thanks,
    Paul

> ---
>  arch/mips/include/asm/mips-cm.h | 48 +++++++++++++++++++++++++++++++++++++----
>  arch/mips/kernel/mips-cm.c      |  4 ++++
>  2 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> index ca3f2c963fbd..46cc0c69b77c 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -33,6 +33,20 @@ extern void __iomem *mips_cm_l2sync_base;
>   */
>  extern phys_addr_t __mips_cm_phys_base(void);
>  
> +/*
> + * mips_cm_is64 - determine CM register width
> + *
> + * The CM register width is processor and CM specific. A 64-bit processor
> + * usually has a 64-bit CM and a 32-bit one has a 32-bit CM but a 64-bit
> + * processor could come with a 32-bit CM. Moreover, accesses on 64-bit CMs
> + * can be done either using regular 64-bit load/store instructions, or 32-bit
> + * load/store instruction on 32-bit register pairs. We opt for using 64-bit
> + * accesses on 64-bit CMs and kernels and 32-bit in any other case.
> + *
> + * It's set to 0 for 32-bit accesses and 1 for 64-bit accesses.
> + */
> +extern int mips_cm_is64;
> +
>  /**
>   * mips_cm_probe - probe for a Coherence Manager
>   *
> @@ -90,20 +104,46 @@ static inline bool mips_cm_has_l2sync(void)
>  
>  /* Macros to ease the creation of register access functions */
>  #define BUILD_CM_R_(name, off)					\
> -static inline u32 __iomem *addr_gcr_##name(void)		\
> +static inline unsigned long __iomem *addr_gcr_##name(void)	\
>  {								\
> -	return (u32 __iomem *)(mips_cm_base + (off));		\
> +	return (unsigned long __iomem *)(mips_cm_base + (off));	\
>  }								\
>  								\
> -static inline u32 read_gcr_##name(void)				\
> +static inline u32 read32_gcr_##name(void)			\
>  {								\
>  	return __raw_readl(addr_gcr_##name());			\
> +}								\
> +								\
> +static inline u64 read64_gcr_##name(void)			\
> +{								\
> +	return __raw_readq(addr_gcr_##name());			\
> +}								\
> +								\
> +static inline unsigned long read_gcr_##name(void)		\
> +{								\
> +	if (mips_cm_is64)					\
> +		return read64_gcr_##name();			\
> +	else							\
> +		return read32_gcr_##name();			\
>  }
>  
>  #define BUILD_CM__W(name, off)					\
> -static inline void write_gcr_##name(u32 value)			\
> +static inline void write32_gcr_##name(u32 value)		\
>  {								\
>  	__raw_writel(value, addr_gcr_##name());			\
> +}								\
> +								\
> +static inline void write64_gcr_##name(u64 value)		\
> +{								\
> +	__raw_writeq(value, addr_gcr_##name());			\
> +}								\
> +								\
> +static inline void write_gcr_##name(unsigned long value)	\
> +{								\
> +	if (mips_cm_is64)					\
> +		write64_gcr_##name(value);			\
> +	else							\
> +		write32_gcr_##name(value);			\
>  }
>  
>  #define BUILD_CM_RW(name, off)					\
> diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> index 42602f30949f..3d2cb6f47898 100644
> --- a/arch/mips/kernel/mips-cm.c
> +++ b/arch/mips/kernel/mips-cm.c
> @@ -15,6 +15,7 @@
>  
>  void __iomem *mips_cm_base;
>  void __iomem *mips_cm_l2sync_base;
> +int mips_cm_is64;
>  
>  phys_addr_t __mips_cm_phys_base(void)
>  {
> @@ -124,5 +125,8 @@ int mips_cm_probe(void)
>  	/* probe for an L2-only sync region */
>  	mips_cm_probe_l2sync();
>  
> +	/* determine register width for this CM */
> +	mips_cm_is64 = config_enabled(CONFIG_64BIT) && (mips_cm_revision() >= CM_REV_CM3);
> +
>  	return 0;
>  }
> -- 
> 2.4.5
> 
