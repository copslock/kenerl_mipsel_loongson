Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 16:23:27 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:59065 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeBQPXT3Xaqj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Feb 2018 16:23:19 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 15:23:10 +0000
Received: from [10.20.78.31] (10.20.78.31) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018 07:18:38 -0800
Date:   Sat, 17 Feb 2018 15:18:29 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC] MIPS: R5900: Workaround for saving and restoring FPU
 registers
In-Reply-To: <20180217144346.GC2496@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802171504320.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180217144346.GC2496@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-BESS-ID: 1518880990-452060-19047-64434-6
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190127
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

> Would you be able to elaborate on the following change with a workaround for
> saving and restoring R5900 FPU registers? Is this problem documented in your
> copy of Sony's Linux Toolkit Restriction manual?
>     
>     Fixed saving and restoring of FPU registers. Odd FPU registers were
>     lost on exceptions and when simulating 64 bit FPU. Debian 5.0 mipsel
>     uses MOV.D to move FPU registers. This is not supported by R5900 and
>     failed in the simulation because of the bug above.

 I thought we agreed the R5900 FPU is unusable for regular Linux software 
and decided to go for full FPU emulation unconditionally.

 We could add a special R5900 mode, denoted with a dedicated 
Tag_GNU_MIPS_ABI_FP attribute and MIPS ABI Flags FP ABI setting, which 
would then enable hardware FPU for the selected task, but I suggest we 
defer any actual code proposals until we have all the design details 
settled.

> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index 8d1e30b94c2d..a67ef7964bc1 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -141,6 +141,52 @@
>  	.set	pop
>  	.endm
>  
> +#ifdef CONFIG_CPU_R5900
> +	/*
> +	 * Kernel expects that floating point registers are saved as 64-bit
> +	 * with the sdc1 instruction, but this is not working with R5900.
> +	 * The 64-bit write is simulated as two 32-bit writes.
> +	 */
> +	.macro fpu_save_double thread status tmp1=t0
> +	.set push
> +	SET_HARDFLOAT
> +	cfc1	\tmp1,  fcr31
> +	swc1	$f0,  THREAD_FPR0(\thread)
> +	swc1	$f1,  (THREAD_FPR0 + 4)(\thread)
> +	swc1	$f2,  THREAD_FPR2(\thread)
> +	swc1	$f3,  (THREAD_FPR2 + 4)(\thread)

 Etc. -- can you reuse MIPS I code here, i.e. use S.D?  GAS should be 
doing the right thing with `-march=r5900' (if not, then it has a bug).

> @@ -200,6 +247,52 @@
>  	.set	pop
>  	.endm
>  
> +#ifdef CONFIG_CPU_R5900
> +	/*
> +	 * Kernel expects that floating point registers are read as 64-bit
> +	 * with the ldc1 instruction, but this is not working with R5900.
> +	 * The 64-bit read is simulated as two 32-bit reads.
> +	 */
> +	.macro	fpu_restore_double thread status tmp=t0
> +	.set push
> +	SET_HARDFLOAT
> +	lw	\tmp, THREAD_FCR31(\thread)
> +	lwc1	$f0,  THREAD_FPR0(\thread)
> +	lwc1	$f1,  (THREAD_FPR0 + 4)(\thread)
> +	lwc1	$f2,  THREAD_FPR2(\thread)
> +	lwc1	$f3,  (THREAD_FPR2 + 4)(\thread)

 Likewise L.D.

> diff --git a/arch/mips/kernel/r5900_fpu.S b/arch/mips/kernel/r5900_fpu.S
> new file mode 100644
> index 000000000000..d4fdc823444d
> --- /dev/null
> +++ b/arch/mips/kernel/r5900_fpu.S
> @@ -0,0 +1,389 @@
> +/*
> + * FPU handling on MIPS r5900. Copied from r4k_fpu.c.
> + *
> + * Copyright (C) 2010-2013 Jürgen Urban
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/errno.h>
> +#include <asm/fpregdef.h>
> +#include <asm/mipsregs.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/regdef.h>
> +
> +	.macro	EX insn, reg, src
> +	.set	push
> +	SET_HARDFLOAT
> +	.set	nomacro
> +	/* In an error exception handler the user space could be uncached. */
> +	sync.l
> +.ex\@:	\insn	\reg, \src
> +	.set	pop
> +	.section __ex_table,"a"
> +	PTR	.ex\@, fault
> +	.previous
> +	.endm
> +
> +	.set	noreorder
> +	.set	arch=r5900
> +
> +/*
> + * Save a thread's fp context.
> + */
> +LEAF(_save_fp)
> +	fpu_save_double a0 t0 t1		# clobbers t1
> +	jr	ra
> +	END(_save_fp)
> +
> +/*
> + * Restore a thread's fp context.
> + */
> +LEAF(_restore_fp)
> +	fpu_restore_double a0 t0 t1		# clobbers t1
> +	jr	ra
> +	END(_restore_fp)
> +
> +LEAF(_save_fp_context)
> +	.set	push
> +	SET_HARDFLOAT
> +	cfc1	t1, fcr31
> +	.set	pop
> +
> +	/* Store the 32 32-bit registers */
> +	EX	swc1 $f0, SC_FPREGS+0(a0)
> +	EX	swc1 $f1, SC_FPREGS+4(a0)
> +	EX	swc1 $f2, SC_FPREGS+16(a0)
> +	EX	swc1 $f3, SC_FPREGS+20(a0)

 Likewise.

> +/*
> + * Restore FPU state:
> + *  - fp gp registers
> + *  - cp1 status/control register
> + */
> +LEAF(_restore_fp_context)
> +	EX	lw t0, SC_FPC_CSR(a0)
> +	EX	lwc1 $f0, SC_FPREGS+0(a0)
> +	EX	lwc1 $f1, SC_FPREGS+4(a0)
> +	EX	lwc1 $f2, SC_FPREGS+16(a0)
> +	EX	lwc1 $f3, SC_FPREGS+20(a0)

 Likewise.

> +#if defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6)
> +	.set    push
> +	.set    MIPS_ISA_LEVEL_RAW
> +	.set	fp=64
> +	sll     t0, t0, 5			# is Status.FR set?
> +	bgez    t0, 1f				# no: skip setting upper 32b
> +
> +	mthc1   t1, $f0
> +	mthc1   t1, $f1
> +	mthc1   t1, $f2
> +	mthc1   t1, $f3

 You surely do not want all this MIPS32r2 stuff, or do you?

  Maciej
