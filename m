Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 03:32:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37498 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2EFBcC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 03:32:02 +0200
Date:   Sun, 6 May 2012 02:32:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2,4/9] MIPS: Add microMIPS versions of breakpoints, BUG,
 etc.
In-Reply-To: <1334867225-12486-1-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.00.1205060150570.19691@eddie.linux-mips.org>
References: <1334867225-12486-1-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 19 Apr 2012, Steven J. Hill wrote:

> Add breakpoints, BUG() functions, DSP instruction masks, and
> debug messages for microMIPS. Also add '.insn' directive to
> a number of files that must assemble correctly when using the
> microMIPS or MIPS16e instruction sets.

 Erm, you do not build the kernel as a MIPS16 binary, do you?  I suggest 
that you remove the reference to the MIPS16 ASE to avoid confusion.

> diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
> index 9161e68..56758eb 100644
> --- a/arch/mips/include/asm/break.h
> +++ b/arch/mips/include/asm/break.h
> @@ -27,6 +27,14 @@
>  #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
>  #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
>  #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
> +
> +/* microMIPS definitions */
> +#define MM_BRK_BUG	12	/* Used by BUG() */
> +#define MM_BRK_KDB	13	/* Used in KDB_ENTER() */
> +#define MM_BRK_MEMU	14	/* Used by FPU emulator */
> +#define MM_BRK_MULOVF	15	/* Multiply overflow */
> +
> +/* MIPS32/64 definitions */

 Hmm, "Standard MIPS..." perhaps, these bits date back to the MIPS I ISA 
that predates the invention of the MIPS32 and MIPS64 architectures by some 
15 years...

>  #define BRK_BUG		512	/* Used by BUG() */
>  #define BRK_KDB		513	/* Used in KDB_ENTER() */
>  #define BRK_MEMU	514	/* Used by FPU emulator */

 Hmm, not necessarily a problem with your change, but what exactly is 
BRK_MULOVF used by?  GAS certainly does not produce it, it uses the 
standard code of 6 for run-time multiplication overflow checks.  Do we 
need to reserve this code at all?

> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 540c98a..7afa2e5 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -10,7 +10,11 @@
>  
>  static inline void __noreturn BUG(void)
>  {
> +#ifdef CONFIG_CPU_MICROMIPS
> +	__asm__ __volatile__("break %0" : : "i" (MM_BRK_BUG));
> +#else
>  	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
> +#endif
>  	unreachable();
>  }
>  

 Ugh, please factor it out to a single macro, don't chop function bodies 
with #ifdef.

> @@ -27,7 +31,11 @@ static inline void  __BUG_ON(unsigned long condition)
>  			return;
>  	}
>  	__asm__ __volatile__("tne $0, %0, %1"
> +#ifdef CONFIG_CPU_MICROMIPS
> +			     : : "r" (condition), "i" (MM_BRK_BUG));
> +#else
>  			     : : "r" (condition), "i" (BRK_BUG));
> +#endif
>  }
>  
>  #define BUG_ON(C) __BUG_ON((unsigned long)(C))

 Likewise.

> diff --git a/arch/mips/include/asm/dsp.h b/arch/mips/include/asm/dsp.h
> index e9bfc08..3149b30 100644
> --- a/arch/mips/include/asm/dsp.h
> +++ b/arch/mips/include/asm/dsp.h
> @@ -16,7 +16,11 @@
>  #include <asm/mipsregs.h>
>  
>  #define DSP_DEFAULT	0x00000000
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define DSP_MASK	0x7f
> +#else
>  #define DSP_MASK	0x3ff
> +#endif
>  
>  #define __enable_dsp_hazard()						\
>  do {									\

 Where's the corresponding change to rddsp() and wrdsp() to encode the 
respective instructions correctly in the microMIPS mode?  The bit patterns 
are not exactly the same.

 Also I think we should simply remove DSP_MASK and instead define 
rddsp_all() and wrdsp_all() macros that use the full mask by default 
(corresponding to single-argument assembly instructions; we'll be able to 
use them once we've decided to move away from the current hacks).  

 Interestingly enough bits 9:6 of the mask aren't used in the MIPS32/64 
variation of these instructions anyway, but I think it's safer to keep 
them as ones for future compatibility.

> diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
> index 6ebf173..007adca 100644
> --- a/arch/mips/include/asm/futex.h
> +++ b/arch/mips/include/asm/futex.h
> @@ -31,6 +31,7 @@
>  		"	beqzl	$1, 1b				\n"	\
>  		__WEAK_LLSC_MB						\
>  		"3:						\n"	\
> +		"	.insn					\n"	\
>  		"	.set	pop				\n"	\
>  		"	.set	mips0				\n"	\
>  		"	.section .fixup,\"ax\"			\n"	\

 Ugh, that looks like a bug in GAS, although it may be difficult to fix.  
The assembler should note the section switch and annotate "3" 
appropriately according to what happens when the current section is 
restored.

 Meanwhile this is a reasonable workaround, thanks.  Likewise elsewhere.  
I suggest to make all .insn additions a separate change though.

> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index e309665..2c0f781 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -41,29 +41,30 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  	seq_printf(m, "processor\t\t: %ld\n", n);
>  	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
> -	        cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
> +		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
>  	seq_printf(m, fmt, __cpu_name[n],
> -	                           (version >> 4) & 0x0f, version & 0x0f,
> -	                           (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
> +		      (version >> 4) & 0x0f, version & 0x0f,
> +		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
>  	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
> -	              cpu_data[n].udelay_val / (500000/HZ),
> -	              (cpu_data[n].udelay_val / (5000/HZ)) % 100);
> +		      cpu_data[n].udelay_val / (500000/HZ),
> +		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
>  	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
>  	seq_printf(m, "microsecond timers\t: %s\n",
> -	              cpu_has_counter ? "yes" : "no");
> +		      cpu_has_counter ? "yes" : "no");
>  	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
>  	seq_printf(m, "extra interrupt vector\t: %s\n",
> -	              cpu_has_divec ? "yes" : "no");
> +		      cpu_has_divec ? "yes" : "no");
>  	seq_printf(m, "hardware watchpoint\t: %s",
> -		   cpu_has_watch ? "yes, " : "no\n");
> +		      cpu_has_watch ? "yes, " : "no\n");
>  	if (cpu_has_watch) {
>  		seq_printf(m, "count: %d, address/irw mask: [",
> -			   cpu_data[n].watch_reg_count);
> +		      cpu_data[n].watch_reg_count);
>  		for (i = 0; i < cpu_data[n].watch_reg_count; i++)
>  			seq_printf(m, "%s0x%04x", i ? ", " : "" ,
> -				   cpu_data[n].watch_reg_masks[i]);
> +				cpu_data[n].watch_reg_masks[i]);
>  		seq_printf(m, "]\n");
>  	}
> +	seq_printf(m, "microMIPS\t\t: %s\n", cpu_has_mmips ? "yes" : "no");
>  	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
>  		      cpu_has_mips16 ? " mips16" : "",
>  		      cpu_has_mdmx ? " mdmx" : "",

 I suggest that you submit formatting fixes as a separate change.

> @@ -73,13 +74,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		      cpu_has_mipsmt ? " mt" : ""
>  		);
>  	seq_printf(m, "shadow register sets\t: %d\n",
> -		       cpu_data[n].srsets);
> +		      cpu_data[n].srsets);
>  	seq_printf(m, "kscratch registers\t: %d\n",
> -		   hweight8(cpu_data[n].kscratch_mask));
> +		      hweight8(cpu_data[n].kscratch_mask));
>  	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
>  
>  	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
> -	        cpu_has_vce ? "%u" : "not available");
> +		      cpu_has_vce ? "%u" : "not available");
>  	seq_printf(m, fmt, 'D', vced_count);
>  	seq_printf(m, fmt, 'I', vcei_count);
>  	seq_printf(m, "\n");

 Likewise.  This doesn't even look valid to me.

> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 7c24c29..4b4bbc0 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -364,6 +364,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  			preempt_enable();
>  			break;
>  		}
> +#ifndef CONFIG_CPU_MICROMIPS
>  		case DSP_BASE ... DSP_BASE + 5: {
>  			dspreg_t *dregs;
>  
> @@ -384,6 +385,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  			}
>  			tmp = child->thread.dsp.dspcontrol;
>  			break;
> +#endif
>  		default:
>  			tmp = 0;
>  			ret = -EIO;
> @@ -453,6 +455,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  		case FPC_CSR:
>  			child->thread.fpu.fcr31 = data;
>  			break;
> +#ifndef CONFIG_CPU_MICROMIPS
>  		case DSP_BASE ... DSP_BASE + 5: {
>  			dspreg_t *dregs;
>  
> @@ -472,6 +475,7 @@ long arch_ptrace(struct task_struct *child, long request,
>  			}
>  			child->thread.dsp.dspcontrol = data;
>  			break;
> +#endif
>  		default:
>  			/* The rest are not allowed. */
>  			ret = -EIO;

 This looks bogus to me, there's nothing stopping one from poking at DSP 
registers if the kernel has been built as a microMIPS binary.

> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index c14f6df..bae32a7 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -25,6 +25,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/ptrace.h>
>  #include <asm/highmem.h>		/* For VMALLOC_END */
> +#include <asm/tlbdebug.h>
>  #include <linux/kdebug.h>
>  
>  /*
> @@ -231,6 +232,7 @@ no_context:
>  	       "virtual address %0*lx, epc == %0*lx, ra == %0*lx\n",
>  	       raw_smp_processor_id(), field, address, field, regs->cp0_epc,
>  	       field,  regs->regs[31]);
> +	dump_tlb_all();
>  	die("Oops", regs);
>  
>  out_of_memory:

 That does not appear relevant.  Please submit separately and explain the 
purpose.

  Maciej
