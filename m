Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 19:25:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30324 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995045AbdH2RY6lp01U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 19:24:58 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CE54182B64299;
        Tue, 29 Aug 2017 18:24:48 +0100 (IST)
Received: from [10.20.78.165] (10.20.78.165) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 29 Aug 2017
 18:24:51 +0100
Date:   Tue, 29 Aug 2017 18:24:41 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <20170827132309.GA32166@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.165]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi Fredrik,

 Thank you for your contribution.  As Ralf has noted your change looks 
good overall.  I just have a couple of nits to address.  Please take them 
into account with the next version of your change.

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2828ecde133d..2a3592032861 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1708,6 +1708,16 @@ config CPU_BMIPS
>  	help
>  	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
>  
> +config CPU_R5900
> +	bool "R5900"
> +	depends on SYS_HAS_CPU_R5900
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_64BIT_KERNEL
> +	select IRQ_MIPS_CPU
> +	select CPU_HAS_WB

 Is there an external explicitly-driven write-back buffer there with the 
R5900?  That would be odd with a MIPS III ISA processor, however if there 
indeed is, then I think the CPU_HAS_WB setting needs to go along with the 
code that implements `__wbflush' for this platform.

> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 98f59307e6a3..f332aaa9e69b 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -326,6 +327,11 @@ enum cpu_type_enum {
>  
>  	CPU_QEMU_GENERIC,
>  
> +	/*
> +	 * Playstation 2 processors
> +	 */
> +	CPU_R5900,

 Shouldn't it go along with `R4000 class processors' earlier above?

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 1aba27786bd5..b8bed9f26f8d 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -1518,6 +1518,16 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  		}
>  
>  		break;
> +	case PRID_IMP_R5900:
> +		c->cputype = CPU_R5900;
> +		__cpu_name[cpu] = "R5900";
> +		c->isa_level = MIPS_CPU_ISA_III;
> +		c->tlbsize = 48;
> +		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE |
> +			     MIPS_CPU_4KEX | MIPS_CPU_DIVEC |
> +			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
> +			     MIPS_CPU_COUNTER;
> +		break;

 If this is a MIPS III base ISA implementation, then presumably you need 
to set `c->fpu_msk31' as well, to exclude FPU_CSR_CONDX bits introduced 
with the MIPS IV ISA only.  Double-check with hardware documentation for 
the details.

 If you don't have documentation, but you have the hardware at hand, then 
you'll best check it yourself by writing a small user program that writes 
to CP1.FCSR and checks which bits stick (of course you need to leave the 
exception cause/mask bits alone for this check or you'll get SIGFPE sent 
instead).

 Please let me know if you have any questions.

  Maciej
