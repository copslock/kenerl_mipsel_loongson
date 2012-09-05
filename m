Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 22:48:48 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:44188 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903404Ab2IEUsm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 22:48:42 +0200
Received: by dajq27 with SMTP id q27so611590daj.36
        for <multiple recipients>; Wed, 05 Sep 2012 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1PbUfoENGIwd0SofdNoQtEwzY3evpqLfU+Qx6Qypgjw=;
        b=yN4dHj86acMK332Zeq7WWrDhSgs12N2QUs33KER3OqcSO8JJgDGdE/9Dc9qq6x8D0S
         t8mwIqLg5CZSWTsV6v3q4sa5mFCBFzQf5g7UbRvYOckEjtJOwt9V7XYS9ekDjLy9DCE8
         AHUROamE7KJY//ovJZC5bsaX5toOEHDhGAzB/GvoTWJ+cQGyzCUKox+wpkrpWqd8B97X
         E7iaA8dD2r8KnVPS1hjTJVj6KSDDYsl/1D5Af09xkfnVHOavdT1SKogNzP7kSa6WpdkL
         BtjDi5AcCNrptNTC+1Exu8OwU5SLL4jxaVmNi3eb1nII7vEpSmxmGOPDTfFnUrzeLtGQ
         pm0Q==
Received: by 10.66.79.38 with SMTP id g6mr51376857pax.40.1346878115978;
        Wed, 05 Sep 2012 13:48:35 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id y11sm113427pbv.66.2012.09.05.13.48.33
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 13:48:34 -0700 (PDT)
Message-ID: <5047BAA0.1010602@gmail.com>
Date:   Wed, 05 Sep 2012 13:48:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: Add base architecture support for RI and XI.
References: <1346876878-25965-1-git-send-email-sjhill@mips.com> <1346876878-25965-2-git-send-email-sjhill@mips.com>
In-Reply-To: <1346876878-25965-2-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 01:27 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Originally both Read Inhibit (RI) and Execute Inhibit (XI) were
> supported by the TLB only for a SmartMIPS core. The MIPSr3(TM)
> Architecture now defines an optional feature to implement these
> TLB bits separately. Support for one or both features can be
> checked by looking at the Config3.RXI bit.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

This particular patch seems fine.

Acked-by: David Daney <david.daney@cavium.com>


However in order not to break things there has to be a follow-on patch 
that is applied before any of the subsequent patches that sets 
cpu_has_ri and cpu_has_xi to the proper values for OCTEON.

David Daney


> ---
>   arch/mips/include/asm/cpu-features.h |    6 ++++++
>   arch/mips/include/asm/cpu.h          |    2 ++
>   arch/mips/include/asm/mipsregs.h     |    1 +
>   arch/mips/kernel/cpu-probe.c         |   12 +++++++++++-
>   4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 080edd8..c78a77b 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -98,6 +98,12 @@
>   #ifndef kernel_uses_smartmips_rixi
>   #define kernel_uses_smartmips_rixi 0
>   #endif
> +#ifndef cpu_has_ri
> +#define cpu_has_ri		(cpu_data[0].options & MIPS_CPU_RI)
> +#endif
> +#ifndef cpu_has_xi
> +#define cpu_has_xi		(cpu_data[0].options & MIPS_CPU_XI)
> +#endif
>   #ifndef cpu_has_mmips
>   #define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
>   #endif
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 4889fae..1b928ed 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -323,6 +323,8 @@ enum cpu_type_enum {
>   #define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
>   #define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
>   #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
> +#define MIPS_CPU_RI		0x02000000 /* CPU has TLB Read Inhibit */
> +#define MIPS_CPU_XI		0x04000000 /* CPU has TLB Execute Inhibit */
>
>   /*
>    * CPU ASE encodings
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index cdb9c87..19430fb 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -591,6 +591,7 @@
>   #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
>   #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
>   #define MIPS_CONF3_DSP2P	(_ULCAST_(1) << 11)
> +#define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
>   #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
>   #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
>   #define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 009fc13..e85d732 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -422,8 +422,18 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
>
>   	config3 = read_c0_config3();
>
> -	if (config3 & MIPS_CONF3_SM)
> +	if (config3 & MIPS_CONF3_SM) {
>   		c->ases |= MIPS_ASE_SMARTMIPS;
> +		c->options |= MIPS_CPU_RI;
> +		c->options |= MIPS_CPU_XI;
> +	}
> +	if (config3 & MIPS_CONF3_RXI) {
> +		write_c0_pagegrain(read_c0_pagegrain() | PG_RIE | PG_XIE);
> +		if (read_c0_pagegrain() & PG_RIE)
> +			c->options |= MIPS_CPU_RI;
> +		if (read_c0_pagegrain() & PG_XIE)
> +			c->options |= MIPS_CPU_XI;
> +	}
>   	if (config3 & MIPS_CONF3_DSP)
>   		c->ases |= MIPS_ASE_DSP;
>   	if (config3 & MIPS_CONF3_DSP2P)
>
