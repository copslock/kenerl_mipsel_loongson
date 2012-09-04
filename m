Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2012 19:36:56 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58730 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903381Ab2IDRgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2012 19:36:48 +0200
Received: by pbbrq8 with SMTP id rq8so10283121pbb.36
        for <multiple recipients>; Tue, 04 Sep 2012 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BcoBhfFlmUgtgJ1tv1OGK1FxRin17phIJVebDkyOOg8=;
        b=Jqpy1MdkLtNSzVgY5AiOIvwZXqA72e+dxvHagHgO6z0ZG9LelMc1b3DazHNTJ1gxDO
         bvfuksqnA6qYPKHXxr3GroHa/q39rBSdNRZU/ZgJ5PKVi8f5veATYiOnXuBF+aU1hCwJ
         yaXlT+FqmDrGiKDtu9IidlHxbTLclZwgmi/mTml3r8PebyrGVnIZZ/vv9L5yNdGoks9B
         PIz8VXItagDaVH/pxYDxvqWnJbfHMZSjtKc6rMCeAGxHXwIQzSETdxihPensBfIuTLlX
         MPbmjRbXvNePhhYt185id3H0wDAa/ShBChGUm8nnWklB8FGzLZmSvBCi0nvsu2Zqb4wW
         wxaw==
Received: by 10.68.242.42 with SMTP id wn10mr36815992pbc.105.1346780201768;
        Tue, 04 Sep 2012 10:36:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id uj3sm12616798pbc.39.2012.09.04.10.36.40
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 10:36:41 -0700 (PDT)
Message-ID: <50463C27.9070201@gmail.com>
Date:   Tue, 04 Sep 2012 10:36:39 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Jim Quinlan <jim2101024@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org, cernekee@gmail.com
Subject: Re: [PATCH V3 2/2] MIPS: make funcs preempt-safe for non-mipsr2 cpus
References: <y> <1346709137-3448-1-git-send-email-jim2101024@gmail.com> <1346709137-3448-2-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1346709137-3448-2-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34416
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

On 09/03/2012 02:52 PM, Jim Quinlan wrote:
> For non MIPSr2 processors, such as the BMIPS 5000, calls to
> arch_local_irq_disable() and others may be preempted, and in doing
> so a stale value may be restored to c0_status.  This fix disables
> preemption for such processors prior to the call and enables it
> after the call.
>
> Those functions that needed this fix have been "outlined" to
> mips-atomic.c, as they are no longer good candidates for inlining.
>
> This bug was observed in a BMIPS 5000, occuring once every few hours
> in a continuous reboot test.  It was traced to the write_lock_irq()
> function which was being invoked in release_task() in exit.c.
> By placing a number of "nops" inbetween the mfc0/mtc0 pair in
> arch_local_irq_disable(), which is called by write_lock_irq(), we
> were able to greatly increase the occurance of this bug.  Similarly,
> the application of this commit silenced the bug.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

This one seems better too...

[...]
> diff --git a/arch/mips/lib/mips-atomic.c b/arch/mips/lib/mips-atomic.c
> new file mode 100644
> index 0000000..546eb25
> --- /dev/null
> +++ b/arch/mips/lib/mips-atomic.c
> @@ -0,0 +1,179 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 1994, 95, 96, 97, 98, 99, 2003 by Ralf Baechle
> + * Copyright (C) 1996 by Paul M. Antoine
> + * Copyright (C) 1999 Silicon Graphics
> + * Copyright (C) 2000 MIPS Technologies, Inc.
> + */
> +#include <asm/irqflags.h>
> +#include <asm/hazards.h>
> +#include <linux/compiler.h>
> +#include <linux/preempt.h>
> +
> +#if !defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_MIPS_MT_SMTC)
> +
> +#if defined(CONFIG_PREEMPT)
> +#define arch_local_preempt_enable() preempt_enable()
> +#define arch_local_preempt_disable() preempt_disable()
> +#else
> +#define arch_local_preempt_enable()
> +#define arch_local_preempt_disable()
> +#endif
> +
> +
> +/*
> + * For cli() we have to insert nops to make sure that the new value
> + * has actually arrived in the status register before the end of this
> + * macro.
> + * R4000/R4400 need three nops, the R4600 two nops and the R10000 needs
> + * no nops at all.
> + */
> +/*
> + * For TX49, operating only IE bit is not enough.
> + *
> + * If mfc0 $12 follows store and the mfc0 is last instruction of a
> + * page and fetching the next instruction causes TLB miss, the result
> + * of the mfc0 might wrongly contain EXL bit.
> + *
> + * ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
> + *
> + * Workaround: mask EXL bit of the result or place a nop before mfc0.
> + */
> +__asm__(
> +	"	.macro	arch_local_irq_disable\n"
> +	"	.set	push						\n"
> +	"	.set	noat						\n"
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	"	mfc0	$1, $2, 1					\n"
> +	"	ori	$1, 0x400					\n"
> +	"	.set	noreorder					\n"
> +	"	mtc0	$1, $2, 1					\n"
> +#elif defined(CONFIG_CPU_MIPSR2)
> +	/* see irqflags.h for inline function */
> +#else
> +	"	mfc0	$1,$12						\n"
> +	"	ori	$1,0x1f						\n"
> +	"	xori	$1,0x1f						\n"
> +	"	.set	noreorder					\n"
> +	"	mtc0	$1,$12						\n"
> +#endif
> +	"	irq_disable_hazard					\n"
> +	"	.set	pop						\n"
> +	"	.endm							\n");
> +
> +void arch_local_irq_disable(void)
> +{
> +	arch_local_preempt_disable();
> +	__asm__ __volatile__(
> +		"arch_local_irq_disable"
> +		: /* no outputs */
> +		: /* no inputs */
> +		: "memory");
> +	arch_local_preempt_enable();
> +}

I think this function must be EXPORT_SYMBOL() too.

David Daney
