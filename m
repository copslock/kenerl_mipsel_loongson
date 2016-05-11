Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 14:56:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52206 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028957AbcEKM4WhR1l2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 14:56:22 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 32EC97776EC3E;
        Wed, 11 May 2016 13:56:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 13:56:15 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 11 May
 2016 13:56:15 +0100
Subject: Re: [PATCH v2 2/5] MIPS: Add defs & probing of extended CP0_EBase
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1462971053-25622-1-git-send-email-james.hogan@imgtec.com>
 <1462971053-25622-3-git-send-email-james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <57332BEF.8030406@imgtec.com>
Date:   Wed, 11 May 2016 13:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1462971053-25622-3-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 11/05/16 13:50, James Hogan wrote:
> The CP0_EBase register may optionally have a write gate (WG) bit to
> allow the upper bits to be written, i.e. bits 31:30 on MIPS32 since r3
> (to allow for an exception base outside of KSeg0/KSeg1 when segmentation
> control is in use) and bits 63:30 on MIPS64 (which also implies the
> extension of CP0_EBase to 64 bits long).
>
> The presence of this feature will need to be known about for VZ support
> in order to correctly save and restore all the bits of the guest
> CP0_EBase register, so add CPU feature definition and probing for this
> feature.
>
> Probing the WG bit on MIPS64 can be a bit fiddly, since 64-bit COP0
> register access instructions were UNDEFINED for 32-bit registers prior
> to MIPS r6, and it'd be nice to be able to probe without clobbering the
> existing state, so there are 3 potential paths:
>
> - If we do a 32-bit read of CP0_EBase and the WG bit is already set, the
>    register must be 64-bit.
>
> - On MIPS r6 we can do a 64-bit read-modify-write to set CP0_EBase.WG,
>    since the upper bits will read 0 and be ignored on write if the
>    register is 32-bit.
>
> - On pre-r6 cores, we do a 32-bit read-modify-write of CP0_EBase. This
>    avoids the potentially UNDEFINED behaviour, but will clobber the upper
>    32-bits of CP0_EBase if it isn't a simple sign extension (which also
>    requires us to ensure BEV=1 or modifying the exception base would be
>    UNDEFINED too). It is hopefully unlikely a bootloader would set up
>    CP0_EBase to a 64-bit segment and leave WG=0.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: linux-mips@linux-mips.org
> ---
> Changes in v2:
> - Changed to handle MIPS32r3+, which can also have a WG bit to allow
>    bits 31:30 to be written. The feature provided is now just the
>    presence of the WG bit rather than the extension of CP0_EBase to
>    64-bits (which is implied if WG is present on MIPS64).
> ---
>   arch/mips/include/asm/cpu-features.h |  4 ++++
>   arch/mips/include/asm/cpu.h          |  1 +
>   arch/mips/include/asm/mipsregs.h     |  3 +++
>   arch/mips/kernel/cpu-probe.c         | 35 +++++++++++++++++++++++++++++++++++
>   4 files changed, 43 insertions(+)
>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index da92d513a395..3d82a4043e80 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -432,4 +432,8 @@
>   #define cpu_has_nan_2008	(cpu_data[0].options & MIPS_CPU_NAN_2008)
>   #endif
>   
> +#ifndef cpu_has_ebase_wg
> +# define cpu_has_ebase_wg	(cpu_data[0].options & MIPS_CPU_EBASE_WG)
> +#endif
> +
>   #endif /* __ASM_CPU_FEATURES_H */
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 79ce9ae0a3c7..379beefefb5c 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -403,6 +403,7 @@ enum cpu_type_enum {
>   #define MIPS_CPU_NAN_2008	MBIT_ULL(39)	/* 2008 NaN implemented */
>   #define MIPS_CPU_VP		MBIT_ULL(40)	/* MIPSr6 Virtual Processors (multi-threading) */
>   #define MIPS_CPU_LDPTE		MBIT_ULL(41)	 /* CPU has ldpte/lddir instructions */
> +#define MIPS_CPU_EBASE_WG	MBIT_ULL(42)	/* CPU has EBase.WG */
>   
>   /*
>    * CPU ASE encodings
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 57d72f2bf745..4e8ad9d6038a 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1458,6 +1458,9 @@ do {									\
>   #define read_c0_ebase()		__read_32bit_c0_register($15, 1)
>   #define write_c0_ebase(val)	__write_32bit_c0_register($15, 1, val)
>   
> +#define read_c0_ebase_64()	__read_64bit_c0_register($15, 1)
> +#define write_c0_ebase_64(val)	__write_64bit_c0_register($15, 1, val)
> +
>   #define read_c0_cdmmbase()	__read_ulong_c0_register($15, 2)
>   #define write_c0_cdmmbase(val)	__write_ulong_c0_register($15, 2, val)
>   
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index a6ce1db191aa..c4795568c1f2 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -858,6 +858,41 @@ static void decode_configs(struct cpuinfo_mips *c)
>   	if (ok)
>   		ok = decode_config5(c);
>   
> +	/* Probe the EBase.WG bit */
> +	if (cpu_has_mips_r2_r6) {
> +		u64 ebase;
> +		unsigned int status;
> +
> +		/* {read,write}_c0_ebase_64() may be UNDEFINED prior to r6 */
> +		ebase = cpu_has_mips64r6 ? read_c0_ebase_64()
> +					 : (s32)read_c0_ebase();
> +		if (ebase & MIPS_EBASE_WG) {
> +			/* WG bit already set, we can avoid the clumsy probe */
> +			c->options |= MIPS_CPU_EBASE_WG;
> +		} else {
> +			/* Its UNDEFINED to change EBase while BEV=0 */
> +			status = read_c0_status();
> +			write_c0_status(status | ST0_BEV);
> +			irq_enable_hazard();
> +			/*
> +			 * On pre-r6 cores, this may well clobber the upper bits
> +			 * of EBase. This is hard to avoid without potentially
> +			 * hitting UNDEFINED dm*c0 behaviour if EBase is 32-bit.
> +			 */
> +			if (cpu_has_mips64r6)
> +				write_c0_ebase_64(ebase | MIPS_EBASE_WG);
> +			else
> +				write_c0_ebase(ebase | MIPS_EBASE_WG);
> +			back_to_back_c0_hazard();
> +			/* Restore BEV */
> +			write_c0_status(status);
> +			if (read_c0_ebase() & MIPS_EBASE_WG) {
> +				c->options |= MIPS_CPU_EBASE_WG;
> +				write_c0_ebase(ebase);
> +			}
> +		}
> +	}
> +
>   	mips_probe_watch_registers(c);
>   
>   #ifndef CONFIG_MIPS_CPS

With this change the kernel correctly detects presence of the WG bit on 
32bit Interaptiv.

Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>
