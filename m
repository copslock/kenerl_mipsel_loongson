Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 02:43:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40304 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903603Ab2EFAm6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 02:42:58 +0200
Date:   Sun, 6 May 2012 01:42:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2,3/9] MIPS: Add support for the M14KE core.
In-Reply-To: <1334867214-12451-1-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.00.1205060137490.19691@eddie.linux-mips.org>
References: <1334867214-12451-1-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 19 Apr 2012, Steven J. Hill wrote:

> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 556afa2..3b50744 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -98,6 +98,9 @@
>  #ifndef kernel_uses_smartmips_rixi
>  #define kernel_uses_smartmips_rixi 0
>  #endif
> +#ifndef cpu_has_mmips
> +#define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
> +#endif
>  #ifndef cpu_has_vtag_icache
>  #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
>  #endif

 I think this has crept in here from the microMIPS change, right?  This 
patch doesn't make any use of this macro.

> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 00e5adf..242a401 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -96,6 +96,7 @@
>  #define PRID_IMP_1004K		0x9900
>  #define PRID_IMP_1074K		0x9a00
>  #define PRID_IMP_14K		0x9c00
> +#define PRID_IMP_14KE		0x9e00
>  
>  /*
>   * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE

 Like with the M14Kc this should be PRID_IMP_M14KEC here and throughout 
(spelled out as M14KEc -- with a small "c" -- where applicable).  There's 
another processor called M14KE that is different.

  Maciej
