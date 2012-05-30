Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 19:42:15 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9117 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2E3RmI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 19:42:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fc6580c0000>; Wed, 30 May 2012 10:25:37 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 10:23:30 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 10:23:30 -0700
Message-ID: <4FC65792.1060906@cavium.com>
Date:   Wed, 30 May 2012 10:23:30 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: Add microMIPS breakpoints and DSP support.
References: <1337892366-24210-1-git-send-email-sjhill@mips.com> <1337892366-24210-2-git-send-email-sjhill@mips.com>
In-Reply-To: <1337892366-24210-2-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2012 17:23:30.0318 (UTC) FILETIME=[EE9A5AE0:01CD3E88]
X-archive-position: 33486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

On 05/24/2012 01:45 PM, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/include/asm/break.h |   11 +++++++++--
>   arch/mips/include/asm/dsp.h   |    4 ++++
>   arch/mips/kernel/proc.c       |    9 +++++++--
>   3 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
> index 9161e68..4e4dc87 100644
> --- a/arch/mips/include/asm/break.h
> +++ b/arch/mips/include/asm/break.h
> @@ -3,8 +3,9 @@
>    * License.  See the file "COPYING" in the main directory of this archive
>    * for more details.
>    *
> - * Copyright (C) 1995, 2003 by Ralf Baechle
>    * Copyright (C) 1999 Silicon Graphics, Inc.
> + * Copyright (C) 1995, 2003 by Ralf Baechle

I don't understand the need to rewrite existing copyright messages.

> + * Copyright (C) 2011, 2012 MIPS Technologies, Inc.
>    */
>   #ifndef __ASM_BREAK_H
>   #define __ASM_BREAK_H
> @@ -27,11 +28,17 @@
>   #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
>   #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
>   #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
> +
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define BRK_BUG		12	/* Used by BUG() */
> +#define BRK_KDB		13	/* Used in KDB_ENTER() */
> +#else
>   #define BRK_BUG		512	/* Used by BUG() */
>   #define BRK_KDB		513	/* Used in KDB_ENTER() */
> +#endif
> +#define MM_BRK_MEMU	14	/* Used by FPU emulator (microMIPS) */
>   #define BRK_MEMU	514	/* Used by FPU emulator */
>   #define BRK_KPROBE_BP	515	/* Kprobe break */
>   #define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
> -#define BRK_MULOVF	1023	/* Multiply overflow */

Why remove BRK_MULOVF?  Is it required by microMIPS?

>
>   #endif /* __ASM_BREAK_H */
> diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
> index e9bfc08..3149b30 100644
> --- a/arch/mips/include/asm/dsp.h
> +++ b/arch/mips/include/asm/dsp.h
> @@ -16,7 +16,11 @@
>   #include<asm/mipsregs.h>
>
>   #define DSP_DEFAULT	0x00000000
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define DSP_MASK	0x7f
> +#else
>   #define DSP_MASK	0x3ff
> +#endif
>
>   #define __enable_dsp_hazard()						\
>   do {									\
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 5542817..c5e97d4 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -64,14 +64,19 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   				cpu_data[n].watch_reg_masks[i]);
>   		seq_printf(m, "]\n");
>   	}
> -	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
> +	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s%s\n",

This looks like neither a breakpoint nor DSP related change.

>   		      cpu_has_mips16 ? " mips16" : "",
>   		      cpu_has_mdmx ? " mdmx" : "",
>   		      cpu_has_mips3d ? " mips3d" : "",
>   		      cpu_has_smartmips ? " smartmips" : "",
>   		      cpu_has_dsp ? " dsp" : "",
> -		      cpu_has_mipsmt ? " mt" : ""
> +		      cpu_has_mipsmt ? " mt" : "",
> +		      cpu_has_mmips ? " micromips" : ""
>   		);
> +	if (cpu_has_mmips) {
> +		seq_printf(m, "micromips kernel\t: %s\n",
> +			(read_c0_config3()&  MIPS_CONF3_ISA_OE) ? "yes" : "no");
> +	}
>   	seq_printf(m, "shadow register sets\t: %d\n",
>   		      cpu_data[n].srsets);
>   	seq_printf(m, "kscratch registers\t: %d\n",
