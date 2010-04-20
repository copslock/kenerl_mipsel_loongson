Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 15:57:17 +0200 (CEST)
Received: from tomts20.bellnexxia.net ([209.226.175.74]:43257 "EHLO
        tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492772Ab0DTN5J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 15:57:09 +0200
Received: from toip4.srvr.bell.ca ([209.226.175.87])
          by tomts20-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20100420135704.HYQQ3465.tomts20-srv.bellnexxia.net@toip4.srvr.bell.ca>
          for <linux-mips@linux-mips.org>; Tue, 20 Apr 2010 09:57:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAKVOzUtGGNqG/2dsb2JhbACcAXK9S4UPBIZP
Received: from bas6-montreal19-1176033926.dsl.bell.ca (HELO krystal.dyndns.org) ([70.24.218.134])
  by toip4.srvr.bell.ca with ESMTP; 20 Apr 2010 10:11:40 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Tue, 20 Apr 2010 09:56:59 -0400
  id 001B6594.4BCDB2AB.0000727D
Date:   Tue, 20 Apr 2010 09:56:59 -0400
From:   Mathieu Desnoyers <compudj@krystal.dyndns.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ltt-dev@lists.casi.polymtl.ca, linux-mips@linux-mips.org
Subject: Re: [ltt-dev] [PATCH 3/3] lttng: MIPS: Use 64 bit counter for
        trace clock on Octeon CPUs.
Message-ID: <20100420135659.GC25175@Krystal>
References: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com> <1271722791-27885-4-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1271722791-27885-4-git-send-email-ddaney@caviumnetworks.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.6.27.31-grsec (i686)
X-Uptime: 09:56:10 up 12 days, 23:49,  3 users,  load average: 0.33, 0.27,
        0.20
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: compudj@krystal.dyndns.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) wrote:
> Cavium Octeon CPUs have a 64-bit cycle counter that is synchronized
> when the CPUs are brought on-line.  So for this case we don't need any
> fancy stuff.

Merged into the LTTng tree, with refactoring of the Octeon-specific
header file code into a new arch/mips/include/asm/octeon/trace-clock.h
file.

Thanks!

Mathieu

> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/Kconfig                   |    4 +-
>  arch/mips/include/asm/trace-clock.h |   39 ++++++++++++++++++++++++++++++++++-
>  arch/mips/kernel/smp.c              |    2 +
>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a690e9b..9e91e8c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1782,8 +1782,8 @@ config HAVE_GET_CYCLES_32
>  	def_bool y
>  	depends on !CPU_R4400_WORKAROUNDS
>  	select HAVE_TRACE_CLOCK
> -	select HAVE_TRACE_CLOCK_32_TO_64
> -	select HAVE_UNSYNCHRONIZED_TSC
> +	select HAVE_TRACE_CLOCK_32_TO_64 if (!CPU_CAVIUM_OCTEON)
> +	select HAVE_UNSYNCHRONIZED_TSC if (!CPU_CAVIUM_OCTEON)
>  
>  #
>  # Use the generic interrupt handling code in kernel/irq/:
> diff --git a/arch/mips/include/asm/trace-clock.h b/arch/mips/include/asm/trace-clock.h
> index 3d8cb0f..a052f42 100644
> --- a/arch/mips/include/asm/trace-clock.h
> +++ b/arch/mips/include/asm/trace-clock.h
> @@ -12,6 +12,43 @@
>  
>  #define TRACE_CLOCK_MIN_PROBE_DURATION 200
>  
> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
> +
> +#include <asm/octeon/octeon.h>
> +
> +#define TC_HW_BITS			64
> +
> +static inline u32 trace_clock_read32(void)
> +{
> +	return (u32)read_c0_cvmcount(); /* only need the 32 LSB */
> +}
> +
> +static inline u64 trace_clock_read64(void)
> +{
> +	return read_c0_cvmcount();
> +}
> +
> +static inline u64 trace_clock_frequency(void)
> +{
> +	return octeon_get_clock_rate();
> +}
> +
> +static inline u32 trace_clock_freq_scale(void)
> +{
> +	return 1;
> +}
> +
> +static inline void get_trace_clock(void)
> +{
> +	return;
> +}
> +
> +static inline void put_trace_clock(void)
> +{
> +	return;
> +}
> +
> +#else /* !CONFIG_CPU_CAVIUM_OCTEON */
>  /*
>   * Number of hardware clock bits. The higher order bits are expected to be 0.
>   * If the hardware clock source has more than 32 bits, the bits higher than the
> @@ -65,7 +102,7 @@ static inline void put_trace_clock(void)
>  {
>  	put_synthetic_tsc();
>  }
> -
> +#endif /* CONFIG_CPU_CAVIUM_OCTEON */
>  static inline void set_trace_clock_is_sync(int state)
>  {
>  }
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index f8c50d1..42083eb 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -159,7 +159,9 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  {
>  	mp_ops->cpus_done();
>  	synchronise_count_master();
> +#ifdef CONFIG_HAVE_UNSYNCHRONIZED_TSC
>  	test_tsc_synchronization();
> +#endif
>  }
>  
>  /* called from main before smp_init() */
> -- 
> 1.6.6.1
> 
> 
> _______________________________________________
> ltt-dev mailing list
> ltt-dev@lists.casi.polymtl.ca
> http://lists.casi.polymtl.ca/cgi-bin/mailman/listinfo/ltt-dev
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
