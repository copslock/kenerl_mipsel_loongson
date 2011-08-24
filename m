Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 10:50:15 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3695 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1493625Ab1HXIuH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 10:50:07 +0200
X-TM-IMSS-Message-ID: <61046a550000e794@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 61046a550000e794 ; Wed, 24 Aug 2011 01:48:08 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Aug 2011 01:50:37 -0700
Date:   Wed, 24 Aug 2011 14:24:04 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/4] MIPS: Netlogic: Platform files for XLP processors.
Message-ID: <20110824085403.GA2820@jayachandranc.netlogicmicro.com>
References: <cover.1312024106.git.jayachandranc@netlogicmicro.com>
 <c43db1356ef9bca8e38c3b093255630c36216f73.1312024108.git.jayachandranc@netlogicmicro.com>
 <20110823164125.GB20817@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110823164125.GB20817@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 24 Aug 2011 08:50:38.0185 (UTC) FILETIME=[E5517D90:01CC623A]
X-archive-position: 30974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17662

On Tue, Aug 23, 2011 at 06:41:25PM +0200, Ralf Baechle wrote:

Thanks for reviewing this.

The xlp-hal directory was imported from our FreeBSD codebase, and I think
some of the comments below are due to that.  I will do another pass so
that the some of the BSD-isms don't spill into the common files. And on
BSD we support o32/n32/n64, I have not removed the code for Linux. But
most of this are restricted to xlp-hal/mmio.h and xlp-hal/cop2.h

> On Sat, Jul 30, 2011 at 06:58:26PM +0530, Jayachandran C wrote:
> 
> > +#define BRIDGE_GIO_WEIGHT		0x2cb
> > +#define BRIDGE_FLASH_WEIGHT		0x2cc
> > +
> > +#if !defined(LOCORE) && !defined(__ASSEMBLY__)
> 
> I don't see a definition for LOCORE anywhere.

LOCORE is is FreeBSD equivalent for __ASSEMBLY__ 

> > +#define nlm_write_bridge_reg(b, r, v)	nlm_write_reg(b, r, v)
> > +#define	nlm_get_bridge_pcibase(node)	\
> > +				nlm_pcicfg_base(XLP_IO_BRIDGE_OFFSET(node))
> > +#define	nlm_get_bridge_regbase(node)	\
> > +				(nlm_pcibase_bridge(node) + XLP_IO_PCI_HDRSZ)
> > +
> > +#endif
> > +#endif
[...]
> > +
> > +#define NLM_DEFINE_COP2_ACCESSORS32(name, reg, sel)		\
> > +static inline uint32_t nlm_read_c2_##name(void)			\
> > +{								\
> > +	uint32_t __rv;						\
> > +	__asm__ __volatile__ (					\
> > +	".set	push\n"						\
> > +	".set	noreorder\n"					\
> > +	".set	mips64\n"					\
> > +	"mfc2	%0, $%1, %2\n"					\
> > +	".set	pop\n"						\
> > +	: "=r" (__rv)						\
> > +	: "i" (reg), "i" (sel));				\
> > +	return __rv;						\
> > +}								\
> > +								\
> > +static inline void nlm_write_c2_##name(uint32_t val)		\
> > +{								\
> > +	__asm__ __volatile__(					\
> > +	".set	push\n"						\
> > +	".set	noreorder\n"					\
> > +	".set	mips64\n"					\
> > +	"mtc2	%0, $%1, %2\n"					\
> > +	".set	pop\n"						\
> > +	: : "r" (val), "i" (reg), "i" (sel));			\
> > +} struct __hack
> 
> What is the purpose of struct __hack, to ensure a compile error if the
> macro invocation is not followed by a semicolon?

It is to make the macro invocation look slightly better, with 
struct __hack, you can add a ';' at the end of macro invocation.

> > +#define NLM_DEFINE_COP2_ACCESSORS64(name, reg, sel)		\
> > +static inline uint64_t nlm_read_c2_##name(void)			\
> > +{								\
> > +	uint32_t __high, __low;					\
> > +	__asm__ __volatile__ (					\
> > +	".set	push\n"						\
> > +	".set	noreorder\n"					\
> > +	".set	mips64\n"					\
> > +	"dmfc2	$8, $%2, %3\n"					\
> 
> On 32-bit kernels this will fail spectacularly if the kernel takes an
> interrupt while the registers contain values that are no properly
> sign-extended to 64-bit.
 
The COP2 accessors are to be called only with local interrupts disabled.
The 64bit access is one reason, the other reason is that we don't save or
restore the COP2 registers during interrupt or context switch.
I will add a comment in the code.

> > +NLM_DEFINE_COP2_ACCESSORS32(txmsgstatus, COP2_TXMSGSTATUS, 0);
> > +NLM_DEFINE_COP2_ACCESSORS32(rxmsgstatus, COP2_RXMSGSTATUS, 0);
> > +NLM_DEFINE_COP2_ACCESSORS32(msgstatus1, COP2_MSGSTATUS1, 0);
> > +NLM_DEFINE_COP2_ACCESSORS32(msgconfig, COP2_MSGCONFIG, 0);
> > +NLM_DEFINE_COP2_ACCESSORS32(msgconfig1, COP2_MSGCONFIG1, 0);
> 
> Generally I'd prefer if these cop2 accessors were defined by extending
> the cop0 macros in <asm/mipsregs.h>.

> > +/* successful completion returns 1, else 0 */
> > +static inline int
> > +nlm_msgsend(int val)
> > +{
> > +	int result;
> > +	__asm__ volatile (
> > +		".set push\n"
> > +		".set noreorder\n"
> > +		".set mips64\n"
> > +		"move	$8, %1\n"
> > +		"sync\n"
> > +		"/* msgsnds	$9, $8 */\n"
> > +		".word	0x4a084801\n"
> > +		"move	%0, $9\n"
> > +		".set pop\n"
> > +		: "=r" (result)
> > +		: "r" (val)
> > +		: "$8", "$9");
> 
> Some versions of gas may do bad things with explicitly named registers.
> It's a long time since I last dealt with this but something like
> 
> static inline int nlm_msgsend(int val)
> {
> 	int result;
> 
> 	__asm__ volatile (
> 	"	.set push						\n"
> 	"	.set noreorder						\n"
> 	"	.set noat						\n"
> 	"	sync							\n"
> 	"	move	$1, %[in]					\n"
> 	"	.word	0x4a084801		# msgsnds $1, $1	\n"
> 	"	move	%[out], $1					\n"
> 	"	.set	pop						\n"
> 	: [out] "=r" (result)
> 	: [in] "0" (val));
> 
> 	return result;
> }
> 
> also has the advantage of using the otherwise most likely not live register
> $1.

Using 'at' is a better idea here, I will make this change.

Ideally I would have liked to generate the opcode with whatever registers the 
compiler assigns to the variables:
	.word 0x4a000001 | (%1  << 16) | (%0 << 11)
but I have not figured out a way to remove the $ prefix.

> > +
> > +static inline int
> > +nlm_msgld(int vc)
> > +{
> > +	int val;
> > +	__asm__ volatile (
> > +		".set push\n"
> > +		".set noreorder\n"
> > +		".set mips64\n"
> > +		"move	$8, %1\n"
> > +		"/* msgld	$9, $8 */\n"
> > +		".word 0x4a084802\n"
> > +		"move	%0, $9\n"
> > +		".set pop\n"
> > +		: "=r" (val)
> > +		: "r" (vc)
> > +		: "$8", "$9");
> > +	return val;
> > +}
> > +
> > +static inline void
> > +nlm_msgwait(int vc)
> > +{
> > +	__asm__ volatile (
> > +		".set push\n"
> > +		".set noreorder\n"
> > +		".set mips64\n"
> > +		"move	$8, %0\n"
> > +		"/* msgwait	$8 */\n"
> > +		".word 0x4a080003\n"
> > +		".set pop\n"
> > +		: : "r" (vc)
> > +		: "$8");
> > +}
> > +
> > +/* TODO this is not needed in n32 and n64 */
> > +static inline uint32_t
> > +nlm_fmn_saveflags(void)
> > +{
> > +	uint32_t sr = mips_rd_status();
> 
> I don't see a definition for mips_rd_status() but anyway, this appears to
> duplicate read_c0_status() from <asm/mipsregs.h>.

This came from the BSD side, will fix this. 

> > +
> > +	mips_wr_status((sr & ~MIPS_SR_INT_IE) | MIPS_SR_COP_2_BIT);
> 
> And mips_wr_status seems to duplicate write_c0_status(); again I can't find
> a definition anywhere.
> 
> clear_c0_status(MIPS_SR_INT_IE | MIPS_SR_COP_2_BIT);
> 
> > +	return sr;
> > +}
> 
> Using <asm/mipsregs.h> this could be rewritten as:
> 
> static inline uint32_t nlm_fmn_saveflags(void)
> {
> 	return clear_c0_status(MIPS_SR_INT_IE | MIPS_SR_COP_2_BIT);
> }
> 
> > +
> > +static inline void
> > +nlm_fmn_restoreflags(uint32_t sr)
> > +{
> > +
> > +	mips_wr_status(sr);
> > +}
> 
> static inline void nlm_fmn_restoreflags(uint32_t sr)
> {
> 	write_c0_status(sr);
> }
> 
> Be very careful when manipulating interrupts in c0_status directly.
> local_irq_{disable,enable,restore} inform lockdep about the interrupt
> status so it can function correctly.  Your homebrew functions don't ...
 
I think I will resolve this by moving this to a OS dependent header, so
that linux will use <asm/mipsregs.h> instead of re-implementing things
here.

> > +#ifndef __NLM_HAL_MMIO_H__
> > +#define __NLM_HAL_MMIO_H__
> > +
> > +/*
> > + * This file contains platform specific memory mapped IO implementation
> > + * and will provide a way to read 32/64 bit memory mapped registers in
> > + * all ABIs
> > + */
> > +#if !defined(__mips_n32) && !defined(__mips_n64)
> 
> The Linux compiler defines neither __mips_n32 nor __mips_n64 for the
> respective ABIs.
> 

This will be fixed, I use only 64 bit in Linux now, the 32 bit stuff only
works on BSD.

> > +/*
> > + * For o32 compilation, we have to disable interrupts and enable KX bit to
> > + * access 64 bit addresses or data.
> > + *
> > + * We need to disable interrupts because we save just the lower 32 bits of
> > + * registers in  interrupt handling. So if we get hit by an interrupt while
> > + * using the upper 32 bits of a register, we lose.
> > + */
> > +static inline uint32_t nlm_enable_kx(void)
> > +{
> > +	uint32_t sr;
> > +
> > +	__asm__ __volatile__(
> > +		"mfc0	%0, $12\n\t"		/* read status reg */
> > +		"move	$8, %0\n\t"
> > +		"ori	$8, $8, 0x81\n\t"	/* set KX, and IE */
> > +		"xori	$8, $8, 0x1\n\t"	/* flip IE */
> > +		"mtc0	$8, $12\n\t"		/* update status reg */
> > +		: "=r"(sr)
> > +		: : "$8");
> > +
> > +	return sr;
> > +}
> 
> static inline uint32_t nlm_enable_kx(void)
> {
> 	return change_c0_status(ST0_KX | ST0_IE, ST0_KX);
> }
> 
> > +
> > +static inline void nlm_restore_kx(uint32_t sr)
> > +{
> > +	__asm__ __volatile__("mtc0	%0, $12" : : "r"(sr));
> > +}
> > +#endif
> 
> 
> static inline void nlm_restore_kx(uint32_t sr)
> {
> 	write_c0_status(sr);
> }
> 
> > +
> > +static inline uint32_t
> > +nlm_load_word(uint64_t addr)
> > +{
> > +	volatile uint32_t *p = (volatile uint32_t *)(long)addr;
> > +
> > +	return *p;
> > +}
> > +
> > +static inline void
> > +nlm_store_word(uint64_t addr, uint32_t val)
> > +{
> > +	volatile uint32_t *p = (volatile uint32_t *)(long)addr;
> > +
> > +	*p = val;
> > +}
> > +
> > +#if defined(__mips_n64) || defined(__mips_n32)
> > +static inline uint64_t
> > +nlm_load_dword(volatile uint64_t addr)
> > +{
> > +	volatile uint64_t *p = (volatile uint64_t *)(long)addr;
> > +
> > +	return *p;
> > +}
> > +
> > +static inline void
> > +nlm_store_dword(volatile uint64_t addr, uint64_t val)
> > +{
> > +	volatile uint64_t *p = (volatile uint64_t *)(long)addr;
> > +
> > +	*p = val;
> > +}
> > +
> > +#else /* o32 */
> > +static inline uint64_t
> > +nlm_load_dword(uint64_t addr)
> > +{
> > +	volatile uint64_t *p = (volatile uint64_t *)(long)addr;
> > +	uint32_t valhi, vallo, sr;
> > +
> > +	sr = nlm_enable_kx();
> > +	__asm__ __volatile__(
> > +		".set	push\n\t"
> > +		".set	mips64\n\t"
> > +		"ld	$8, 0(%2)\n\t"
> > +		"dsra32	%0, $8, 0\n\t"
> > +		"sll	%1, $8, 0\n\t"
> > +		".set	pop\n"
> > +		: "=r"(valhi), "=r"(vallo)
> > +		: "r"(p)
> > +		: "$8");
> > +	nlm_restore_kx(sr);
> > +
> > +	return ((uint64_t)valhi << 32) | vallo;
> > +}
> 
> Makes me wonder if there is really a point in supporting a 32-bit kernel -
> you don't have to if it's too painful.  We've dropped 32-bit support for
> other MIPS platforms before.
> 
> And the Linux community in general would like 32-bit support to be taken
> out and shot anyway ;-)

There has been few customers who like to do 32-bit on XLP, even though
it might be slower. Some blocks like the XLP PIC has 64 bit registers and 
need this kind of read.

> > +
> > +static inline void
> > +nlm_store_dword_daddr(uint64_t addr, uint64_t val)
> > +{
> > +	volatile uint64_t *p = (volatile uint64_t *)(long)addr;
> > +
> > +	*p = val;
> > +}
> > +
> > +#elif defined(__mips_n32)
> 
> Linux doesn't compile the kernel as N32 though a -msym32 is sort of similar
> except that it still retains the full 64-bit addressing capability, so
> consumes more memory.
> 
> So far nobody has shown interest in N32 kernels when I asked a few people
> a while ago.

> > +static inline uint64_t
> > +nlm_load_word_daddr(uint64_t addr)
> > +{
> > +	uint32_t val;
> > +
> > +	__asm__ __volatile__(
> > +		".set	push\n\t"
> > +		".set	mips64\n\t"
> > +		"lw		%0, 0(%1)\n\t"
> > +		".set	pop\n"
> > +		: "=r"(val)
> > +		: "r"(addr));
> > +
> > +	return val;
> > +}
> 
> Could be done in C.
> 
> > +static inline void
> > +nlm_store_word_daddr(uint64_t addr, uint32_t val)
> > +{
> > +	__asm__ __volatile__(
> > +		".set	push\n\t"
> > +		".set	mips64\n\t"
> > +		"sw		%0, 0(%1)\n\t"
> > +		".set	pop\n"
> > +		: : "r"(val), "r"(addr)
> > +		: "memory");
> > +}
> 
> Ditto.
> 
> > +static inline uint64_t
> > +nlm_load_dword_daddr(uint64_t addr)
> > +{
> > +	uint64_t val;
> > +
> > +	__asm__ __volatile__(
> > +		".set	push\n\t"
> > +		".set	mips64\n\t"
> > +		"ld		%0, 0(%1)\n\t"
> > +		".set	pop\n"
> > +		: "=r"(val)
> > +		: "r"(addr));
> > +	return val;
> 
> Ditto.
> 
> > +static inline void
> > +nlm_store_dword_daddr(uint64_t addr, uint64_t val)
> > +{
> > +	__asm__ __volatile__(
> > +		".set	push\n\t"
> > +		".set	mips64\n\t"
> > +		"sd		%0, 0(%1)\n\t"
> > +		".set	pop\n"
> > +		: : "r"(val), "r"(addr)
> > +		: "memory");
> 
> Ditto.
> 

On n32, we need to do assembly to load from a 64 bit pointer (e.g. when using
XKPHYS). 

[...]
> > new file mode 100644
> > index 0000000..d1023e0
> > --- /dev/null
> > +++ b/arch/mips/netlogic/xlp/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-y		= setup.o platform.o irq.o setup.o time.o nlm_hal.o
> > +obj-$(CONFIG_EARLY_PRINTK) += xlp_console.o
> > +
> > +EXTRA_CFLAGS	+= -Werror
> 
> This EXTRA_CFLAG assignment is redundant - all of MIPS is being built with
> -Werror.

Will fix this.

JC.
