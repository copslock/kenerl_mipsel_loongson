Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2017 07:18:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26891 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990773AbdIKFSlGa0MP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2017 07:18:41 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CC2C891B61DD5;
        Mon, 11 Sep 2017 06:18:31 +0100 (IST)
Received: from [10.20.78.11] (10.20.78.11) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 11 Sep 2017
 06:18:32 +0100
Date:   Mon, 11 Sep 2017 06:18:24 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170902141013.GB2602@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709091313150.4331@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain> <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk> <20170902141013.GB2602@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.11]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59983
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

 Thank you for the updated patch.

On Sat, 2 Sep 2017, Fredrik Noring wrote:

> Signed-off-by: Fredrik Noring <noring@nocrew.org>

 Please add at least a terse description of what the change actually does.

> Here is revised patch. I've added arch/mips/mm/c-r4k.c and I'm unsure about
> 
> 	c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;
> 
> but similar architectures have MIPS_CPU_CACHE_CDEX_P and R5900 has a PREF
> instruction.

 I'm assuming the R5900 is like the TX79 here.

 If adding the MIPS_CPU_PREFETCH flag, you also need to update 
`set_prefetch_parameters' (in arch/mips/mm/page.c) accordingly to have a 
case for the R5900 as it does not support the Pref_LoadStreamed and 
Pref_PrepareForStore operations the default case requires.  As this is an 
optimisation only I think the whole PREF support for the R5900 will best 
be deferred to a separate later patch.

 As to the MIPS_CPU_CACHE_CDEX_P, the manual is clear that the CPU does 
not support the Create Dirty Exclusive (Create_Dirty_Excl_D ak 0x0d) 
operation, and furthermore all the cache ops use encodings different from 
what the usual are.  So you'll have to refactor all the cache handling to 
take this into account.

> As indicated in the comment, it's not entirely clear why
> 
> 	if (c->dcache.waysize > PAGE_SIZE)
> 		c->dcache.flags |= MIPS_CACHE_ALIASES;
> 
> is necessary.

 Again, the manual is clear here:

"C790 Programming Note:

   Overlapping of the cache index bit range and PFN bit range causes the 
   "cache aliasing problem".  C790 does not have any hardware mechanisms 
   to detect the cache aliasing.  It is programmer's responsibility to 
   avoid the cache aliasing.  When a physical page is mapped on the 
   different virtual pages, VPN[13:12] have to be same in both virtual 
   address.  The conservative way to avoid this is that VPN[13:12] == 
   PFN[13:12] whenever a page is mapped."

so you need the flag indeed -- original R4000/R4400 hardware used a 
Virtual Coherency Exception Data/Instruction (VCED/VCEI) mechanism for 
alias resolution and some newer MIPS processor implementations have logic 
in hardware for that.  Obviously the TX79 (and presumably the R5900 as 
well) has neither.

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2828ecde133d..aec56966484b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1708,6 +1708,15 @@ config CPU_BMIPS
>  	help
>  	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
>  
> +config CPU_R5900
> +	bool "R5900"
> +	depends on SYS_HAS_CPU_R5900
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_64BIT_KERNEL

 I think it will make sense to defer 64-bit support until the oddities 
around it have been sorted out, see below.  So I suggest removing 
CPU_SUPPORTS_64BIT_KERNEL at first, and then suddenly you don't need to 
worry about stuff we know that will be broken until a further update.

> +	select IRQ_MIPS_CPU
> +	help
> +	  MIPS Technologies R5900 processor (Emotion Engine in Sony Playstation 2).

 Not Toshiba rather than MIPS Technologies?

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 02a1787c888c..e8e2805a05c4 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -171,6 +171,8 @@ cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \
>  			-Wa,--trap
>  cflags-$(CONFIG_CPU_R5500)	+= $(call cc-option,-march=r5500,-march=r5000) \
>  			-Wa,--trap
> +cflags-$(CONFIG_CPU_R5900)	+= -march=r5900 -mtune=r5900 \
> +			-Wa,--trap -mno-llsc

 First, `-mtune=' defaults to whatever has been used with `-march=', so 
please remove it (I think we used to had both in the old days, but that 
stuff is now gone, so please follow the current rules).  If you feel 
pedantic, then to double-check you may compare binaries built with and w/o 
`-mtune=' to make sure the're the same, however TBH I think it would be a 
waste of time (especially if it turns out that GCC stores its command-line 
options somewhere in the binary produced).

 Second, given that the R5900 has no LL/SC instructions, I would expect 
`-march=r5900' to already imply it, so `-mno-llsc' should not be needed.  
Unless you want to support building with an older compiler, in which case:

cflags-$(CONFIG_CPU_R5900)	+= $(call cc-option,-march=r5900,-march=r4600 -mno-llsc) \
			-Wa,--trap

perhaps?  I.e. does the code you are going to introduce use any of the 
unusual processor-specific instructions, such as DI/EI (which have 
encodings and semantics different from their later MIPSr2 counterparts)?

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 1aba27786bd5..c9431900d11f 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -1383,6 +1383,17 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  			     MIPS_CPU_WATCH | MIPS_CPU_LLSC;
>  		c->tlbsize = 48;
>  		break;
> +	case PRID_IMP_R5900:
> +		c->cputype = CPU_R5900;
> +		__cpu_name[cpu] = "R5900";
> +		c->isa_level = MIPS_CPU_ISA_III;
> +		c->fpu_msk31 |= FPU_CSR_CONDX;
> +		c->options = MIPS_CPU_TLB | MIPS_CPU_4K_CACHE |
> +			     MIPS_CPU_4KEX | MIPS_CPU_DIVEC |
> +			     MIPS_CPU_FPU | MIPS_CPU_32FPR |
> +			     MIPS_CPU_COUNTER;

 As (MIPS_CPU_TLB | MIPS_CPU_4K_CACHE | MIPS_CPU_4KEX | MIPS_CPU_COUNTER)
can be shortened to R4K_OPTS, please do so.

 More importantly, I think MIPS_CPU_32FPR is not right, as it's defined 
as: "32 dbl. prec. FP registers" whereas the R5900 AFAIK only supports 
single floats, so as far as the layout of the register file is concerned 
it is similar to a MIPS32r1 FPU.

 I do hope the R5900 implements the FPU in a sane way such as the R4650 
does, that is it still implements CP0.Status.FR, to flip between 16 and 32 
single FGRs, and all the double CP1 operations, i.e. LDC1/SDC1, 
DMTC1/DMFC1, and all the double arithmetics, such as MOV.D, ADD.D, etc. 
cause an Unimplemented Operation FPE exception, which we can then emulate.  

 Of course for the kernel as far as the instruction list is concerned only 
the lack of LDC1/SDC1 will matter in that it requires special attention 
for FP context switching.  All the user stuff will be handled 
automagically by our emulator.

 NB I find it is interesting that neither MIPS_CPU_32FPR nor its 
associated `cpu_has_32fpr' predicate is actually used anywhere.  So while 
it serves a CPU feature documentation purpose (for information that can be 
hard to chase sometimes), it actually is not used at the run time.

 Also the processor is unusual in that although it's a legacy architecture 
implementation it does use a distinct vector for the Interrupt exception.  
However its use is hardwired and there is no CP0.Cause.IV bit to control 
it, with its CP0.Cause.23 location fixed at 0.  So I think it would make 
sense to arrange for `configure_exception_vector' not to try flipping it, 
as a microoptimisation, but more importantly to have the code express that 
we know what we're doing here.

 So I think an update along the line of this:

	if (cpu_has_divec) {
		if (cpu_has_mipsmt) {
			/* ... */
		} else if (current_cpu_type() != CPU_R5900) {
			/*
			 * The R5900 has no Cause.IV bit and always uses
			 * the dedicated interrupt exception vector.
			 */
			set_c0_cause(CAUSEF_IV);
		}
	}

would be appropriate as a part of this patch.

 Finally, you'll need an option to indicate this is a processor that only 
does 32-bit addressing.  So o32 and n32 binaries will work, but n64 ones 
will not.  Well, not in the general case, as `-msym32' will, but that's a 
matter for the n64 ELF loader to sort out, by checking the VMA ranges 
requested (there's no MSYM32 ELF annotation yet, even though it's been 
discussed over and over again), which it currently does not.  Also for 
64-bit binaries to work correctly LLD/SCD emulation will be required.

 So as I noted above I think it will make sense if you remove 
CPU_SUPPORTS_64BIT_KERNEL above and only include it with the patch that 
adds support for running 64-bit binaries in the 32-bit addressing mode 
(effectively the same as contemporary MIPS architecture's CP0.Status.PX=1
mode) and the complementing unusual CP0.Status.FR handling, along with a 
flag like MIPS_CPU_FR to denote the presence of the CP0.Status.FR bit, but 
not 64-bit FGRs.

 That leaves us with o32 support only, which still I suspect will not 
handle the FPU correctly, due to the lack of LDC1/SDC1 instructions, 
currently expected by our code to exist for any but MIPS I processors, and 
missing odd-numbered FGRs in the CP0.Status.FR=0 mode in the first place.

 So perhaps again let's defer that feature and start with the MIPS_CPU_FPU 
flag removed, and then add it along with proper FPU support in a later 
patch?  That patch will presumably add FP context switching support using 
LWC1/SWC1 and anything else to handle R5900's FPU peculiarities.

 Until that further patch has been applied the R5900 would then operate in 
the fully-emulated FP mode only, i.e. as if `nofpu' has been 
unconditionally selected.

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 3fe99cb271a9..0420ce8fb086 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1192,6 +1192,20 @@ static void probe_pcache(void)
>  		c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;
>  		break;
>  
> +	case CPU_R5900:
> +		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
> +		c->icache.linesz = 64;
> +		c->icache.ways = 2;
> +		c->icache.waybit = 0;
> +
> +		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
> +		c->dcache.linesz = 64;
> +		c->dcache.ways = 2;
> +		c->dcache.waybit = 0;
> +
> +		c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;

 The cache parameters appear correct to me and I have discussed the 
options earlier on.

> @@ -1465,6 +1479,17 @@ static void probe_pcache(void)
>  	case CPU_R16000:
>  		break;
>  
> +	case CPU_R5900:
> +		if (c->icache.waysize > PAGE_SIZE)
> +			c->dcache.flags |= MIPS_CACHE_ALIASES;
> +		/*
> +		 * There seems to be a missing d-cache flush which is fixed
> +		 * with MIPS_CACHE_ALIASES.
> +		 */
> +		if (c->dcache.waysize > PAGE_SIZE)
> +			c->dcache.flags |= MIPS_CACHE_ALIASES;
> +		break;

 Duplicate code here; otherwise OK, as noted above.  You may wish to 
update the comment though.

 Ralf may yet want to chime in, but overall I think that the way to move 
forward with your submission is to:

1. Make the adjustments to this patch I have outlined above; dropping FPU 
   and 64-bit support for the time being in particular.

2. Update cache handlers to use the correct R5900-specific cache op 
   encodings, presumably within the same patch.

3. As Ralf has already reqested, add basic board support for the PS2 
   platform, including essential drivers that are required to boot, e.g. 
   serial, network; fancy stuff can be added gradually later on.

4. Post the whole set of changes collected so far, properly split into 
   functionally self-contained changes, i.e. ones that build and can run
   successfully run on actual hardware, for a reasonable definition of 
   success, e.g. patch #1 is this one, patch #2 is base board setup
   infrastructure, patch #3 is interrupt support, patch #4 is timer 
   support, patch #5 is the serial driver, patch #6 is the network 
   driver, or suchlike.

We can then integrate these to have basic hardware support already working 
and only then continue with more complicated features, especially ones 
such as the FPU and 64-bit support which will require considerable updates 
to generic architecture code.

 NB if CP1.FCSR.FS indeed turns out hardwired to 1, then having this FPU 
hardware handled will be a more complex task, involving adding AT_FPUCW 
support to our MIPS port of the kernel and adjusting glibc appropriately 
before we are able to proceed.  So if this is indeed the case, then I 
think it'll be the most reasonable if we just ignore the issue of 
CP1.FCSR.FS for the time being, and have the emulated FP work with the bit 
flippable.

 Questions, comments?

  Maciej
