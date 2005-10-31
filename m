Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 08:34:11 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.196]:45469 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133462AbVJaIdt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 08:33:49 +0000
Received: by zproxy.gmail.com with SMTP id j2so830218nzf
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2005 00:34:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XnlZaCYB8zIwM4eowFxaNcmRkNXU1IhklmPpHVjrSVDWNIJ+fL73R23+5kVjSS/p4sxSJWS97KMQyrc8yYpxL1BE4Oh8cvb9IheD8chqvF2vyjuQ4Guc3b898NWTiC0uL6jDK4IHRPt2fhAJ/rXc4YcN6nIvg5jCEW2Lu0z8l+Y=
Received: by 10.37.14.40 with SMTP id r40mr1694089nzi;
        Mon, 31 Oct 2005 00:34:18 -0800 (PST)
Received: by 10.36.48.2 with HTTP; Mon, 31 Oct 2005 00:34:18 -0800 (PST)
Message-ID: <cda58cb80510310034k60b273dfm@mail.gmail.com>
Date:	Mon, 31 Oct 2005 09:34:18 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [RFC] Add 4KSx support (try 2)
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This is the second try for submitting this patch. Hope it will get
more feedbacks...

Thanks

                 Franck

2005/10/25, Franck <vagabon.xyz@gmail.com>:
> Hi,
>
> I'm sending a new patch that adds support for both 4ksc, 4ksd cpus and
> smartmips extension. It doesn't add support for SmartMIPS MMU (another
> patch may be sent in future) though. I tried to take into account
> Maciej Rozycki and Kevin Kissel first feedbacks.
>
> Thanks
> --
>                Franck
>
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/Kconfig
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/Kconfig
> --- linux-2.6.14-rc2-mipscvs/arch/mips/Kconfig  2005-09-23
> 22:02:44.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/Kconfig     2005-10-24
> 16:42:11.000000000 +0200
> @@ -1123,6 +1123,20 @@ config CPU_SB1
>         select CPU_SUPPORTS_64BIT_KERNEL
>         select CPU_SUPPORTS_HIGHMEM
>
> +config CPU_4KSC
> +       bool "4KSC"
> +       select CPU_SUPPORTS_32BIT_KERNEL
> +       select CPU_HAS_PREFETCH
> +       help
> +         MIPS Technologies 4KSc-series processors.
> +
> +config CPU_4KSD
> +       bool "4KSD"
> +       select CPU_SUPPORTS_32BIT_KERNEL
> +       select CPU_HAS_PREFETCH
> +       help
> +         MIPS Technologies 4KSd-series processors.
> +
>  endchoice
>
>  endmenu
> @@ -1337,6 +1351,14 @@ config CPU_HAS_WB
>           machines which require flushing of write buffers in software.  Saying
>           Y is the safe option; N may result in kernel malfunction and crashes.
>
> +config CPU_HAS_SMARTMIPS
> +       bool "SmartMIPS extension available" if CPU_ADVANCED
> +       default y if !CPU_ADVANCED && (CPU_4KSC || CPU_4KSD)
> +       help
> +         Say Y here if your CPU supports Smartmips ASE. The SmartMIPS ASE
> +         includes a set of features that form a cryptographic extension to
> +         the MIPS32 architecture.
> +
>  menu "MIPSR2 Interrupt handling"
>         depends on CPU_MIPSR2 && CPU_ADVANCED
>
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/kernel/asm-offsets.c
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/asm-offsets.c
> --- linux-2.6.14-rc2-mipscvs/arch/mips/kernel/asm-offsets.c     2005-09-15
> 10:53:13.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/asm-offsets.c        2005-10-25
> 13:02:30.000000000 +0200
> @@ -65,6 +65,7 @@ void output_ptreg_defines(void)
>         offset("#define PT_R31    ", struct pt_regs, regs[31]);
>         offset("#define PT_LO     ", struct pt_regs, lo);
>         offset("#define PT_HI     ", struct pt_regs, hi);
> +       offset("#define PT_ACX    ", struct pt_regs, acx);
>         offset("#define PT_EPC    ", struct pt_regs, cp0_epc);
>         offset("#define PT_BVADDR ", struct pt_regs, cp0_badvaddr);
>         offset("#define PT_STATUS ", struct pt_regs, cp0_status);
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/kernel/cpu-probe.c
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/cpu-probe.c
> --- linux-2.6.14-rc2-mipscvs/arch/mips/kernel/cpu-probe.c       2005-08-16
> 19:50:43.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/cpu-probe.c  2005-10-04
> 09:41:42.000000000 +0200
> @@ -552,6 +552,7 @@ static inline void cpu_probe_mips(struct
>                 c->cputype = CPU_4KEC;
>                 break;
>         case PRID_IMP_4KSC:
> +       case PRID_IMP_4KSD:
>                 c->cputype = CPU_4KSC;
>                 break;
>         case PRID_IMP_5KC:
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/kernel/Makefile
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/Makefile
> --- linux-2.6.14-rc2-mipscvs/arch/mips/kernel/Makefile  2005-09-01
> 22:42:46.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/Makefile     2005-10-04
> 09:30:29.000000000 +0200
> @@ -31,6 +31,8 @@ obj-$(CONFIG_CPU_SB1)         += r4k_fpu.o r4k_
>  obj-$(CONFIG_CPU_MIPS32_R1)    += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_MIPS64_R1)    += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_R6000)                += r6000_fpu.o r4k_switch.o
> +obj-$(CONFIG_CPU_4KSC)         += r4k_switch.o
> +obj-$(CONFIG_CPU_4KSD)         += r4k_switch.o
>
>  obj-$(CONFIG_SMP)              += smp.o
>
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/kernel/ptrace32.c
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/ptrace32.c
> --- linux-2.6.14-rc2-mipscvs/arch/mips/kernel/ptrace32.c        2005-05-31
> 13:49:19.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/ptrace32.c   2005-10-25
> 13:08:41.000000000 +0200
> @@ -144,6 +144,11 @@ asmlinkage int sys32_ptrace(int request,
>                 case MMLO:
>                         tmp = regs->lo;
>                         break;
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               case ACX:
> +                       tmp = regs->acx;
> +                       break;
> +#endif
>                 case FPC_CSR:
>                         if (cpu_has_fpu)
>                                 tmp = child->thread.fpu.hard.fcr31;
> @@ -246,6 +251,11 @@ asmlinkage int sys32_ptrace(int request,
>                 case MMLO:
>                         regs->lo = data;
>                         break;
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               case ACX:
> +                       regs->acx = data;
> +                       break;
> +#endif
>                 case FPC_CSR:
>                         if (cpu_has_fpu)
>                                 child->thread.fpu.hard.fcr31 = data;
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/kernel/ptrace.c
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/ptrace.c
> --- linux-2.6.14-rc2-mipscvs/arch/mips/kernel/ptrace.c  2005-07-14
> 14:05:05.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/kernel/ptrace.c     2005-10-25
> 13:09:52.000000000 +0200
> @@ -159,6 +159,11 @@ asmlinkage int sys_ptrace(long request,
>                 case MMLO:
>                         tmp = regs->lo;
>                         break;
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               case ACX:
> +                       tmp = regs->acx;
> +                       break;
> +#endif
>                 case FPC_CSR:
>                         if (cpu_has_fpu)
>                                 tmp = child->thread.fpu.hard.fcr31;
> @@ -267,6 +272,11 @@ asmlinkage int sys_ptrace(long request,
>                 case MMLO:
>                         regs->lo = data;
>                         break;
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               case ACX:
> +                       regs->acx = data;
> +                       break;
> +#endif
>                 case FPC_CSR:
>                         if (cpu_has_fpu)
>                                 child->thread.fpu.hard.fcr31 = data;
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/lib-32/Makefile
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/lib-32/Makefile
> --- linux-2.6.14-rc2-mipscvs/arch/mips/lib-32/Makefile  2005-07-11
> 12:03:27.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/lib-32/Makefile     2005-10-04
> 09:44:09.000000000 +0200
> @@ -21,5 +21,7 @@ obj-$(CONFIG_CPU_SB1)         += dump_tlb.o
>  obj-$(CONFIG_CPU_TX39XX)       += r3k_dump_tlb.o
>  obj-$(CONFIG_CPU_TX49XX)       += dump_tlb.o
>  obj-$(CONFIG_CPU_VR41XX)       += dump_tlb.o
> +obj-$(CONFIG_CPU_4KSC)         += dump_tlb.o
> +obj-$(CONFIG_CPU_4KSD)         += dump_tlb.o
>
>  EXTRA_AFLAGS := $(CFLAGS)
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/Makefile
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/Makefile
> --- linux-2.6.14-rc2-mipscvs/arch/mips/Makefile 2005-09-15
> 10:53:10.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/Makefile    2005-10-24
> 16:19:15.000000000 +0200
> @@ -237,6 +237,14 @@ cflags-$(CONFIG_CPU_R10000)        += \
>                         $(call set_gccflags,r10000,mips4,r8000,mips4,mips2) \
>                         -Wa,--trap
>
> +cflags-$(CONFIG_CPU_4KSC)      += \
> +                       $(call set_gccflags,4ksc,mips32,4kc,mips32) \
> +                       -msmartmips -Wa,--trap
> +
> +cflags-$(CONFIG_CPU_4KSD)      += \
> +                       $(call set_gccflags,4ksd,mips32r2,4kec,mips32r2) \
> +                       -msmartmips -Wa,--trap
> +
>  ifdef CONFIG_CPU_SB1
>  ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
>  MODFLAGS       += -msb1-pass1-workarounds
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/mm/cache.c
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/mm/cache.c
> --- linux-2.6.14-rc2-mipscvs/arch/mips/mm/cache.c       2005-07-06
> 14:08:14.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/mm/cache.c  2005-10-04
> 09:46:56.000000000 +0200
> @@ -120,7 +120,8 @@ void __init cpu_cache_init(void)
>      defined(CONFIG_CPU_NEVADA) || defined(CONFIG_CPU_R5432)  || \
>      defined(CONFIG_CPU_R5500)  || defined(CONFIG_CPU_MIPS32_R1) || \
>      defined(CONFIG_CPU_MIPS64_R1) || defined(CONFIG_CPU_TX49XX) || \
> -    defined(CONFIG_CPU_RM7000) || defined(CONFIG_CPU_RM9000)
> +    defined(CONFIG_CPU_RM7000) || defined(CONFIG_CPU_RM9000) || \
> +    defined(CONFIG_CPU_4KSC)   || defined(CONFIG_CPU_4KSD)
>                 ld_mmu_r4xx0();
>  #endif
>         } else switch (current_cpu_data.cputype) {
> diff -Nurp linux-2.6.14-rc2-mipscvs/arch/mips/mm/Makefile
> linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/mm/Makefile
> --- linux-2.6.14-rc2-mipscvs/arch/mips/mm/Makefile      2005-07-14
> 14:05:06.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/arch/mips/mm/Makefile 2005-10-04
> 09:45:17.000000000 +0200
> @@ -26,6 +26,8 @@ obj-$(CONFIG_CPU_SB1)         += c-sb1.o cerr-s
>  obj-$(CONFIG_CPU_TX39XX)       += c-tx39.o pg-r4k.o tlb-r3k.o
>  obj-$(CONFIG_CPU_TX49XX)       += c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
>  obj-$(CONFIG_CPU_VR41XX)       += c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
> +obj-$(CONFIG_CPU_4KSC)         += c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
> +obj-$(CONFIG_CPU_4KSD)         += c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
>
>  obj-$(CONFIG_IP22_CPU_SCACHE)  += sc-ip22.o
>  obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
> diff -Nurp linux-2.6.14-rc2-mipscvs/include/asm-mips/module.h
> linux-2.6.14-rc2-mipscvs-4KSx/include/asm-mips/module.h
> --- linux-2.6.14-rc2-mipscvs/include/asm-mips/module.h  2005-09-14
> 12:35:37.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/include/asm-mips/module.h     2005-10-04
> 09:55:34.000000000 +0200
> @@ -113,7 +113,11 @@ search_module_dbetables(unsigned long ad
>  #define MODULE_PROC_FAMILY "RM9000"
>  #elif defined CONFIG_CPU_SB1
>  #define MODULE_PROC_FAMILY "SB1"
> -#elif
> +#elif defined CONFIG_CPU_4KSC
> +#define MODULE_PROC_FAMILY "4KSC"
> +#elif defined CONFIG_CPU_4KSD
> +#define MODULE_PROC_FAMILY "4KSD"
> +#else
>  #error MODULE_PROC_FAMILY undefined for your processor configuration
>  #endif
>
> diff -Nurp linux-2.6.14-rc2-mipscvs/include/asm-mips/ptrace.h
> linux-2.6.14-rc2-mipscvs-4KSx/include/asm-mips/ptrace.h
> --- linux-2.6.14-rc2-mipscvs/include/asm-mips/ptrace.h  2005-07-14
> 14:05:09.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/include/asm-mips/ptrace.h     2005-10-25
> 13:07:04.000000000 +0200
> @@ -24,6 +24,7 @@
>  #define FPC_EIR                70
>  #define DSP_BASE       71              /* 3 more hi / lo register pairs */
>  #define DSP_CONTROL    77
> +#define ACX            78
>
>  /*
>   * This struct defines the way the registers are stored on the stack during a
> @@ -42,6 +43,9 @@ struct pt_regs {
>         unsigned long cp0_status;
>         unsigned long hi;
>         unsigned long lo;
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +       unsigned long acx;
> +#endif
>         unsigned long cp0_badvaddr;
>         unsigned long cp0_cause;
>         unsigned long cp0_epc;
> diff -Nurp linux-2.6.14-rc2-mipscvs/include/asm-mips/stackframe.h
> linux-2.6.14-rc2-mipscvs-4KSx/include/asm-mips/stackframe.h
> --- linux-2.6.14-rc2-mipscvs/include/asm-mips/stackframe.h      2005-09-15
> 10:56:06.000000000 +0200
> +++ linux-2.6.14-rc2-mipscvs-4KSx/include/asm-mips/stackframe.h 2005-10-25
> 14:35:56.000000000 +0200
> @@ -25,16 +25,25 @@
>                 .endm
>
>                 .macro  SAVE_TEMP
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               mflhxu  v1
> +               LONG_S  v1, PT_LO(sp)
> +               mflhxu  v1
> +               LONG_S  v1, PT_HI(sp)
> +               mflhxu  v1
> +               LONG_S  v1, PT_ACX(sp)
> +#else
>                 mfhi    v1
> +               LONG_S  v1, PT_HI(sp)
> +               mflo    v1
> +               LONG_S  v1, PT_LO(sp)
> +#endif
>  #ifdef CONFIG_32BIT
>                 LONG_S  $8, PT_R8(sp)
>                 LONG_S  $9, PT_R9(sp)
>  #endif
> -               LONG_S  v1, PT_HI(sp)
> -               mflo    v1
>                 LONG_S  $10, PT_R10(sp)
>                 LONG_S  $11, PT_R11(sp)
> -               LONG_S  v1,  PT_LO(sp)
>                 LONG_S  $12, PT_R12(sp)
>                 LONG_S  $13, PT_R13(sp)
>                 LONG_S  $14, PT_R14(sp)
> @@ -175,16 +184,25 @@
>                 .endm
>
>                 .macro  RESTORE_TEMP
> +#ifdef CONFIG_CPU_HAS_SMARTMIPS
> +               LONG_L  $24, PT_ACX(sp)
> +               mtlhx   $24
> +               LONG_L  $24, PT_HI(sp)
> +               mtlhx   $24
>                 LONG_L  $24, PT_LO(sp)
> +               mtlhx   $24
> +#else
> +               LONG_L  $24, PT_LO(sp)
> +               mtlo    $24
> +               LONG_L  $24, PT_HI(sp)
> +               mthi    $24
> +#endif
>  #ifdef CONFIG_32BIT
>                 LONG_L  $8, PT_R8(sp)
>                 LONG_L  $9, PT_R9(sp)
>  #endif
> -               mtlo    $24
> -               LONG_L  $24, PT_HI(sp)
>                 LONG_L  $10, PT_R10(sp)
>                 LONG_L  $11, PT_R11(sp)
> -               mthi    $24
>                 LONG_L  $12, PT_R12(sp)
>                 LONG_L  $13, PT_R13(sp)
>                 LONG_L  $14, PT_R14(sp)
>
