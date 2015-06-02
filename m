Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 12:08:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54175 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006954AbbFBKIvhowl4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 12:08:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A4D259808E795;
        Tue,  2 Jun 2015 11:08:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 2 Jun 2015 11:08:41 +0100
Received: from localhost (192.168.159.151) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 2 Jun
 2015 11:08:39 +0100
Date:   Tue, 2 Jun 2015 11:08:35 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>, <davem@davemloft.net>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
Message-ID: <20150602100835.GG24014@NP-P-BURTON>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.151]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47781
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

Hi Leonid,

On Mon, Jun 01, 2015 at 05:09:34PM -0700, Leonid Yegoshin wrote:
> This instructions were specifically designed to work for smp_*() sort of
> memory barriers in MIPS R2/R3/R5 and R6.
> 
> Unfortunately, it's description is very cryptic and is done in HW engineering
> style which prevents use of it by SW.

FYI this reads to me like "I couldn't figure it out from the manuals"
which you might want to leave out.

> This instructions are not mandatory but
> there is a mandatory requirement - if not implemented, then a regular MIPS
> SYNC 0 must be used instead.
> 
> The reason for this change is - SYNC 0 is a heavvy-weighted in many CPUs, it may
> disrupt other cores pipelines etc.
> 
> Due to concern about verification of old MIPS R2 compatible cores of other
> vendors it is enforced only for MIPS R6 and other MIPS32/64 R2/R5 processors
> have it configurable.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/Kconfig               |   22 ++++++++++++++++++++++
>  arch/mips/include/asm/barrier.h |    6 ++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index be384d6a58bb..c7d0cacece3d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1347,6 +1347,7 @@ config CPU_MIPS32_R2
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_MSA
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
>  	select HAVE_KVM
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
> @@ -1365,6 +1366,8 @@ config CPU_MIPS32_R6
>  	select GENERIC_CSUM
>  	select HAVE_KVM
>  	select MIPS_O32_FP64_SUPPORT
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
> +	select WEAK_REORDERING_BEYOND_LLSC

This WEAK_REORDERING_BEYOND_LLSC change should probably be split out
into a separate patch, since it has nothing to do with the smp_*
barriers and is just left as a sync 0 (__WEAK_LLSC_MB) as of this patch.

>  	help
>  	  Choose this option to build a kernel for release 6 or later of the
>  	  MIPS32 architecture.  New MIPS processors, starting with the Warrior
> @@ -1399,6 +1402,7 @@ config CPU_MIPS64_R2
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_HUGEPAGES
>  	select CPU_SUPPORTS_MSA
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
>  	help
>  	  Choose this option to build a kernel for release 2 or later of the
>  	  MIPS64 architecture.  Many modern embedded systems with a 64-bit
> @@ -1415,6 +1419,8 @@ config CPU_MIPS64_R6
>  	select CPU_SUPPORTS_HIGHMEM
>  	select CPU_SUPPORTS_MSA
>  	select GENERIC_CSUM
> +	select CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
> +	select WEAK_REORDERING_BEYOND_LLSC

Ditto.

>  	help
>  	  Choose this option to build a kernel for release 6 or later of the
>  	  MIPS64 architecture.  New MIPS processors, starting with the Warrior
> @@ -1876,6 +1882,20 @@ config WEAK_ORDERING
>  #
>  config WEAK_REORDERING_BEYOND_LLSC
>  	bool
> +
> +config MIPS_LIGHTWEIGHT_SYNC
> +	bool "CPU lightweight SYNC instruction for weak reordering"
> +	depends on CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC && WEAK_ORDERING
> +	default y if CPU_MIPSR6
> +	help
> +	  This option enforces a use of "lightweight sync" instructions
> +	  for SMP (multi-CPU) memory barriers. This instructions are much
> +	  more faster than a traditional "SYNC 0".

"enforces a use" would probably read better as "makes use", and "much
more faster" should just be "much faster". Personally I'd not make the
SYNC so shouty - sync is perfectly valid & generally the way the
instruction is named even in the kernel.

> +
> +	  If that instructions are not implemented in processor then it is
> +	  converted to generic "SYNC 0".

I think this would read better as something like:

  If a processor does not implement the lightweight sync operations then
  the architecture requires that they interpret the corresponding sync
  instructions as the typical heavyweight "sync 0". Therefore this
  should be safe to enable on all CPUs implementing release 2 or
  later of the MIPS architecture.

> +
> +	  If you unsure, say N here, it may slightly decrease your performance
>  endmenu
>  
>  #
> @@ -1928,6 +1948,8 @@ config CPU_SUPPORTS_HUGEPAGES
>  	bool
>  config CPU_SUPPORTS_UNCACHED_ACCELERATED
>  	bool
> +config CPU_SUPPORTS_MIPS_LIGHTWEIGHT_SYNC
> +	bool

I'm not sure putting MIPS_ in the name of this makes sense either BTW.
Other things around it don't bother (eg. UNCACHED_ACCELERATED right
above) and it's already under arch/mips/Kconfig.

>  config MIPS_PGD_C0_CONTEXT
>  	bool
>  	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index 2b8bbbcb9be0..d2a63abfc7c6 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -96,9 +96,15 @@
>  #  define smp_rmb()	barrier()
>  #  define smp_wmb()	__syncw()
>  # else
> +#  ifdef CONFIG_MIPS_LIGHTWEIGHT_SYNC
> +#  define smp_mb()      __asm__ __volatile__("sync 0x10" : : :"memory")
> +#  define smp_rmb()     __asm__ __volatile__("sync 0x13" : : :"memory")
> +#  define smp_wmb()     __asm__ __volatile__("sync 0x4" : : :"memory")

Tabs please.

Thanks,
    Paul

> +#  else
>  #  define smp_mb()	__asm__ __volatile__("sync" : : :"memory")
>  #  define smp_rmb()	__asm__ __volatile__("sync" : : :"memory")
>  #  define smp_wmb()	__asm__ __volatile__("sync" : : :"memory")
> +#  endif
>  # endif
>  #else
>  #define smp_mb()	barrier()
> 
> 
