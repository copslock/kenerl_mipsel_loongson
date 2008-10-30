Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 11:44:41 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:28907 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22723185AbYJ3Lo1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 11:44:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9UBiPFP012031;
	Thu, 30 Oct 2008 11:44:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9UBiPbl012029;
	Thu, 30 Oct 2008 11:44:25 GMT
Date:	Thu, 30 Oct 2008 11:44:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 17/36] cavium: Hook Cavium specifics into main
	arch/mips dir
Message-ID: <20081030114425.GG26256@linux-mips.org>
References: <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-16-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-17-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-17-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:49PM -0700, David Daney wrote:

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 28c55f6..0addc84 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -144,6 +144,7 @@ cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=r5000) \
>  cflags-$(CONFIG_CPU_R8000)	+= -march=r8000 -Wa,--trap
>  cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
>  			-Wa,--trap
> +cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -march=octeon -Wa,--trap

One if my standard requirements is that contributions must build and work
with a standard FSF toolchain.  Browny points for building with even older
tools chains - the oldest supported versions are gcc 3.2 for 32-bit and
gcc 3.3 for 64-bit.

Latest binutils 2.19 (releast on 2008-10-27) have added Cavium support but
gcc 4.3 doesn't have that yet.  So you can try something like:

cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += $(call cc-option,-march=octeon,-march=mips64r2) -Wa,--trap

> +core-$(CONFIG_CPU_CAVIUM_OCTEON)	+= arch/mips/cavium-octeon/executive/

-fkeep-ceo-inline ;-)

> +ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
> +load-$(CONFIG_CPU_CAVIUM_OCTEON)	+= 0xffffffff84100000
> +else
> +load-$(CONFIG_CPU_CAVIUM_OCTEON) 	+= 0xffffffff81100000
> +endif

I'm thinking about a more elegant solution for this.  PIC code sucks a blue
whale through a dialysis filter so I hope we can find something better.
Until then this is certainly acceptable.

> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index b1372c2..93ff9c4 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
>  obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
> +obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o

I guess you could just use the normal r4k_fpu.o r4k_switch.o here and handle
the rest of the Cavium bits like other non-standard architecture features
in switch_to() and finish_arch_switch:

#define switch_to(prev, next, last)                                     \
do {                                                                    \
        __mips_mt_fpaff_switch_to(prev);                                \
        if (cpu_has_dsp)                                                \
                __save_dsp(prev);                                       \
        if (cpu_has_cavium)                                             \
                __save_cavium_stuff(prev);                              \
        (last) = resume(prev, next, task_thread_info(next));            \
} while (0)

#define finish_arch_switch(prev)                                        \
do {                                                                    \
        if (cpu_has_cavium)                                             \
                __restore_cavium_stuff(prev);                           \
        if (cpu_has_dsp)                                                \
                __restore_dsp(current);                                 \
        if (cpu_has_userlocal)                                          \
                write_c0_userlocal(current_thread_info()->tp_value);    \
        __restore_watch();                                              \
} while (0)

?

> +CFLAGS_ptrace.o	= -I$(OCTEON_ROOT)/executive

Huh?

>  obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
>  obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
> +obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
>  
>  obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
>  obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
> @@ -34,3 +35,7 @@ obj-$(CONFIG_RM7000_CPU_SCACHE)	+= sc-rm7k.o
>  obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
>  
>  EXTRA_CFLAGS += -Werror
> +
> +OCTEON_ROOT = $(srctree)/arch/mips/cavium-octeon
> +CFLAGS_c-octeon.o	= -I$(OCTEON_ROOT)/executive

I've not noticed anything in c-octeon.c which would require this -I flag.

  Ralf
