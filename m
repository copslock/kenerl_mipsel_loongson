Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 20:35:52 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:5126 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024645AbZE2Tfb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 20:35:31 +0100
X-IronPort-AV: E=Sophos;i="4.41,272,1241395200"; 
   d="scan'208";a="170551787"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-2.cisco.com with ESMTP; 29 May 2009 19:35:11 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n4TJZALF013509;
	Fri, 29 May 2009 12:35:10 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n4TJZAgo005089;
	Fri, 29 May 2009 19:35:10 GMT
Date:	Fri, 29 May 2009 12:35:10 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	paul.gortmaker@windriver.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/3] mips:powertv: Base files for Cisco Powertv
	platform (resend)
Message-ID: <20090529193510.GA19552@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=51578; t=1243625710; x=1244489710;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=201/3]=20mips=3Apowertv=3A=20Bas
	e=20files=20for=20Cisco=20Powertv=0A=09platform=20(resend)
	|Sender:=20;
	bh=QkOM20dgozT5DUTeHdC1j3DjPFwx6gvs2b/3kWJy+9E=;
	b=K8LRuZEfJZvp/jayeBStd3W8NYb+8NXFSP1tZXQVuNX0In0RTDThasrSaM
	pTXNWDcGG1NJGyHnvWKqlKI5EgLCJJ0urnp2EW3FPbz1ks4lOsGDTKcTNQaj
	bv2VjMVfEx;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

It's taken me forever to get back to this, but let me say first, wow, loads
of comments!

> David VomLehn wrote:
> 
>     Adds the C and header source files for the Cisco PowerTV platform.
> 
> Out of curiosity, is there more information about this platform
> somewhere, like what the bootloader is, what the end user availability
> is, how to bootstrap it etc?   The kernel support files on their own is
> only one part of the puzzle...   If it turns out that this board is not
> something that you can buy/find/steal, then that may influence
> its chances of being merged too (see the voyageur thread between
> Ingo and James recently, as an example).  That, and what the long
> term maintenance you foresee for the codebase may also have
> an impact on whether it makes sense to merge it or not.

This is for a series of cable settop boxes, which is one of those much
derided locked-down platforms. So, they are only sold in large quantities
directly to cable companies. On the other hand, there will be hundreds of
thousands of them, so they will be maintained for quite some time to come.

> Anyway, hope you find the feedback useful.

Yes, lots of useful things here. See replies in-line.

> Paul.

>     ---
>      arch/mips/include/asm/mach-powertv/asic.h          |  124 +
>      arch/mips/include/asm/mach-powertv/asic_regs.h     |  136 +
>      arch/mips/include/asm/mach-powertv/dma-coherence.h |  123 +
>      arch/mips/include/asm/mach-powertv/interrupts.h    |  234 ++
>      arch/mips/include/asm/mach-powertv/war.h           |   27 +
>      arch/mips/powertv/Kconfig                          |   17 +
>      arch/mips/powertv/Makefile                         |   37 +
>      arch/mips/powertv/asic/Kconfig                     |   24 +
>      arch/mips/powertv/asic/Makefile                    |   24 +
>      arch/mips/powertv/asic/asic_devices.c              | 2902 +++++++++++++++++++
>      arch/mips/powertv/asic/asic_int.c                  |  146 +
>      arch/mips/powertv/asic/irq_asic.c                  |  115 +
>      arch/mips/powertv/cevt-powertv.c                   |  247 ++
>      arch/mips/powertv/cmdline.c                        |   51 +
>      arch/mips/powertv/csrc-powertv.c                   |   84 +
>      arch/mips/powertv/init.c                           |  127 +
>      arch/mips/powertv/init.h                           |   10 +
>      arch/mips/powertv/memory.c                         |  183 ++
>      arch/mips/powertv/pci/Makefile                     |   26 +
>      arch/mips/powertv/pci/fixup-powertv.c              |   14 +
>      arch/mips/powertv/pci/pci.c                        |   35 +
>      arch/mips/powertv/pci/pciemod.c                    | 2921 ++++++++++++++++++++
>      arch/mips/powertv/pci/pcieregs.h                   |  333 +++
>      arch/mips/powertv/pci/powertv-pci.h                |   12 +
>      arch/mips/powertv/powertv-clock.h                  |   10 +
>      arch/mips/powertv/powertv_setup.c                  |  351 +++
>      arch/mips/powertv/reset.c                          |   69 +
>      arch/mips/powertv/reset.h                          |    8 +
>      arch/mips/powertv/time.c                           |   47 +
> 
> I don't know enough about this platform to know what are critical
> and non critical support items, but a general suggestion is to start
> with just the core board support plus serial console and ethernet
> (i.e. so you can boot and NFS root) and use that as your baseline
> commit, and then look to adding in additional features in separate
> commits (i.e. say the asic and pcie support in this case?)

I'm going to drop PCI support for this patchset since it's currently unused.
The asic stuff is important for setting up the system but I'm going to
break asic_devices.c up. I've been wanting to do this anyway, now I have
a reason to do it immediately.

> It helps to make things somewhat more digestible chunks, as when
> things come out in one giant chunk you probably loose out on
> review feedback (i.e. people get scared off).

I agree. Reviewing is hard enough as it is.

>     diff --git a/arch/mips/include/asm/mach-powertv/asic.h 
>     b/arch/mips/include/asm/mach-powertv/asic.h
>     new file mode 100644
>     index 0000000..4240e4e
>     --- /dev/null
>     +++ b/arch/mips/include/asm/mach-powertv/asic.h
>     @@ -0,0 +1,124 @@
>     +#ifndef _ASM_ASIC_H
>     +#define _ASM_ASIC_H
> 
> _ASM_MACH_POWERTV_ASIC_H
> 
> at least that seems to be the norm used by other platforms.

Sounds good.

>     +#include <asm/mach-powertv/asic_regs.h>
>     +
>     +#define DVR_CAPABLE     (1<<0)
>     +#define PCIE_CAPABLE    (1<<1)
>     +#define FFS_CAPABLE     (1<<2)
>     +#define DISPLAY_CAPABLE (1<<3)
> 
> align with tabs, not spaces?

Definitely. Much of this stuff was originally written to a very different
coding standard which uses spaces for lining things up. It's pretty hard to
do this automatically, so I've missed some things.

>     +/* Platform Family types
>     + * For compitability, the new value must be added in the end */
>     +enum tFamilyType {
> 
> Is the leading "t" prefix relevant?   You'll probably get less grief
> from kernel community folks if you remove it.

Yeah, this is that other coding standard thing. Consider it gone.

>     +extern enum tAsicType platform_get_asic(void);
>     +extern enum tFamilyType platform_get_family(void);
> 
> Aside from the magic "t" again, I think it would really be a win
> for you in terms of acceptance if you could get rid of all the
> CamelCase from the variable names.  When people see that as
> they are reviewing, it puts them off on the wrong foot immediately.

It's outta here. This you can actually automate pretty well.

>     +extern unsigned long gPhysToBusOffset;
> 
> Leading "g" here like the "t" above?

Gone.

>     +#ifdef CONFIG_HIGHMEM
>     +/*
>     + * TODO: We will use the hard code for conversion between physical and
>     + * bus until the bootloader releases their device tree to us.
>     + */
>     +#define phys_to_bus(x) (((x) < 0x20000000) ? ((x) + gPhysToBusOffset) : (x))
>     +#define bus_to_phys(x) (((x) < 0x60000000) ? ((x) - gPhysToBusOffset) : (x))
>     +#else
>     +#define phys_to_bus(x) ((x) + gPhysToBusOffset)
>     +#define bus_to_phys(x) ((x) - gPhysToBusOffset)
>     +#endif
>     +
>     +/*
>     + * Determine whether the address we are given is for an ASIC device
>     + * Params:  addr    Address to check
>     + * Returns: Zero if the address is not for ASIC devices, non-zero
>     + *      if it is.
>     + */
>     +static inline int asic_is_device_addr(phys_t addr)
>     +{
>     +       return !((phys_t)addr & (phys_t) ~0x1fffffffULL);
>     +}
>     +
>     +/*
>     + * Determine whether the address we are given is external RAM mappable
>     + * into KSEG1.
>     + * Params:  addr    Address to check
>     + * Returns: Zero if the address is not for external RAM and
>     + */
>     +static inline int asic_is_lowmem_ram_addr(phys_t addr)
>     +{
>     +       /*
>     +        * The RAM always starts at the following address in the processor's
>     +        * physical address space
>     +        */
>     +       static const phys_t phys_ram_base = 0x10000000;
> 
> Could probably bury all the magic constants for the board in one
> header file.  POWERTV_RAM_BASE or similar.

Agreed. This should help make the code more understandable.

>     +#define ASIC_RESOURCE_GET_EXISTS 1
> 
> Defined but  never used?

This is used by loadable kernel modules to determine whether it can use
asic_resource_get(). This allows the same source to be used for 2.6.14,
which doesn't have this function, and 2.6.24, which does.

>     +enum eSys_RebootType {
>     +       kSys_UnknownReboot          = 0x00,     /* Unknown reboot cause */
>     +       kSys_DavicChange            = 0x01,     /* Reboot due to change in DAVIC
...
>     +                                                * drivers may report as
>     +                                                * userReboot. */
>     +       kSys_WatchdogInterrupt      = 0x0A      /* Pre-watchdog interrupt */
>     +};
> 
> The "e" prefix and the "k" prefix (and the CamelCase) don't help
> the readability here either.

Gone.

>     diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h 
>     b/arch/mips/include/asm/mach-powertv/asic_regs.h
>     new file mode 100644
>     index 0000000..8bdbec2
>     --- /dev/null
>     +++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
>     @@ -0,0 +1,136 @@
>     +
>     +#ifndef __ASIC_H_
>     +#define __ASIC_H_
> 
> _MACH_POWERTV_ASIC_REGS_H or similar

Yup.

>     +/* ASIC register enumeration */
>     +struct tRegisterMap {          /* ==ZEUS==  ==CALLIOPE== */
>     +       int EIC_SLOW0_STRT_ADD;
...
>     +       int UART1_DATA;      /* 0x281818    0xA01818 */
>     +       int UART1_STATUS;    /* 0x28181C    0xA0181C */
> 
> This is kind of worse than the normal CamelCase; in that when I
> see "UART1_STATUS" written in code somewhere, I'm going to
> assume it is a macro and not a variable.

Makes sense.

> Also, since this is a register map, it would probably be better to
> explicitly specify/use the actual register size u32 or whatever
> instead of "int'.

Good suggestion.

>     +       int MIPS_PLL_SETUP;     /* 0x1a0000    0x980000 */
>     +       int USB_FS;         /* 0x1a0018    0x980030 */
>     +       int Test_Bus;       /* 0x1a0238    0x9800CC */
>     +       int USB2_OHCI_IntMask;  /* 0x1e000c    0x9A000c */
>     +       int USB2_Strap;     /* 0x1e0014    0x9A0014 */
> 
> Whitespace in this section seems mangled; best to have it all use
> hard tabs probably.

Actually, those comments are not ammended for new versions of the box
and the values are assigned elsewhere, so it really doesn't make sense to
keep them.  Out of date documentation can be worse than none at all.

>     +extern enum tAsicType        gAsic;
>     +extern const struct tRegisterMap   *gRegisterMap;
>     +extern unsigned long        gAsicPhyBase;   /* Physical address of ASIC */
>     +extern unsigned long        pAsicBase;  /* Virtual address of ASIC */
> 
> Again, cosmetic, but it makes for better readability if you choose a style
> and stick with it.   I'd not put tabs between the types and the variable
> names, but tab aligning the comments is common.

This is within the bounds of the kernel coding style, but I agree that tab
aligning the comments is helpful.

>     +#define asic_reg_offset(x)  (gRegisterMap->x)
>     +#define asic_reg_phys_addr(x)   (gAsicPhyBase + asic_reg_offset(x))
>     +#define asic_reg_addr(x)    ((unsigned int *) (pAsicBase + asic_reg_offset(x)))
> 
> Semi random whitespace usage in these three lines too.

Yup. Better if aligned.

>     +#define        asic_read(x)            _asic_read(asic_reg_addr(x))
>     +#define        asic_write(v, x)        _asic_write(v, asic_reg_addr(x))
> 
> Same for macros, I think you'll find mostly no tabs between the
> define and the name in existing kernel code, if you are aiming
> for consistency

Old habits die hard, especially when it looks the same whether you use a tab
or a space. But it should be consistent and everyone uses a space.

>     +
>     +static inline unsigned int _asic_read(unsigned int *addr)
>     +{
>     +       return readl(addr);
>     +}
>     +
>     +static inline void _asic_write(unsigned int value, unsigned int *addr)
>     +{
>     +       writel(value, addr);
>     +}
> 
> if the asic_read and write ops will never need some sort of wrapper, then
> 
> why the asic_read --> _asic_read --> readl indirection? Sure, the compiler
> 
> will probably clean it up in the generated code, but if it isn't used....

There was, once upon a time, a reason for this, but now it's cleaner as you
suggest.

>     diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h 
>     b/arch/mips/include/asm/mach-powertv/dma-coherence.h
>     new file mode 100644
>     index 0000000..b39f945
>     --- /dev/null
>     +++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
>     @@ -0,0 +1,123 @@
>     +/*
>     + * This file is subject to the terms and conditions of the GNU General Public
>     + * License.  See the file "COPYING" in the main directory of this archive
>     + * for more details.
> 
> You probably want to stick your name/copyright in here, and then...
> 
> 
>     + *
>     + * Version from mach-generic modified to support PowerTV port
> 
> ..a comment here like  "Original generic version was"
> 
> 
>     + *
>     + * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
> 
> ...otherwise it kind of appears like Ralf made *this file* back in
> 2006.

Legally, I think Ralf's copyright even extends to the parts of this file
that have not been changed, so it applies to both files. Only the new
stuff can be copyright by Cisco, so I need to leave Ralf's copyright
notice in. But, IANAL.

>     +#ifndef __ASM_MACH_GENERIC_DMA_COHERENCE_H
>     +#define __ASM_MACH_GENERIC_DMA_COHERENCE_H
> 
> not MACH_GENERIC anymore, but MACH_POWERTV

Yup.

>     +struct device;
> 
> Probably should just go and suck in the proper include header for
> struct device rather than do that.

This file was just copied from mach-generic/dma-coherence.h and I never noticed
this. Perhaps we should change the mach-generic version, too, but that would
be another patch, another day.

>     +static inline bool is_kseg2(void *addr)
>     +{
>     +       return (unsigned long)addr >= KSEG2;
>     +}
>     +
>     +static inline unsigned long virt_to_phys_from_pte(void *addr)
>     +{
>     +       pgd_t *pgd;
>     +       pud_t *pud;
>     +       pmd_t *pmd;
>     +       pte_t *ptep, pte;
>     +
>     +       unsigned long virt_addr = (unsigned long)addr;
>     +       unsigned long phys_addr = 0UL;
>     +
>     +       /* get the page global directory. */
>     +       pgd = pgd_offset_k(virt_addr);
>     +
>     +       if (!pgd_none(*pgd)) {
>     +               /* get the page upper directory */
>     +               pud = pud_offset(pgd, virt_addr);
>     +               if (!pud_none(*pud)) {
>     +                       /* get the page middle directory */
>     +                       pmd = pmd_offset(pud, virt_addr);
>     +                       if (!pmd_none(*pmd)) {
>     +                               /* get a pointer to the page table entry */
>     +                               ptep = pte_offset(pmd, virt_addr);
>     +                               pte = *ptep;
>     +                               /* check for a valid page */
>     +                               if (pte_present(pte)) {
>     +                                       /* get the physical address the page is
>     +                                        * refering to */
>     +                                       phys_addr = (unsigned long)
>     +                                               page_to_phys(pte_page(pte));
>     +                                       /* add the offset within the page */
>     +                                       phys_addr |= (virt_addr & ~PAGE_MASK);
>     +                               }
>     +                       }
>     +               }
>     +       }
> 
> I'm not sure why something like the above (which doesn't really
> appear board specific in any way) needs to be in a board specific
> file.  Maybe some comments about what is going on and what
> the board requirements are would help here.  If nothing else,
> it might help people better in the know to suggest an alternate
> solution using existing kernel functionality.

This is definitely not board-specific and I would be quite interested in
knowing if there is a better way to do this.

>     +static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
>     +       size_t size)
>     +{
>     +       if (is_kseg2(addr))
>     +               return phys_to_bus(virt_to_phys_from_pte(addr));
>     +       else
>     +               return phys_to_bus(virt_to_phys(addr));
>     +}

This is where the function in question is called. We have a virtual address
in high memory and need to get the dma_addr_t for it. Is there any other
way than walking the page table?

>     +#endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
> 
> Fix this one too (!GENERIC anymore)

Yup.

>     diff --git a/arch/mips/include/asm/mach-powertv/interrupts.h 
>     b/arch/mips/include/asm/mach-powertv/interrupts.h
>     new file mode 100644
>     index 0000000..c37df64
>     --- /dev/null
>     +++ b/arch/mips/include/asm/mach-powertv/interrupts.h
>     @@ -0,0 +1,234 @@
>     +#ifndef        _INTERRUPTS_H_
>     +#define        _INTERRUPTS_H_
> 
> _MACH_POWERTV_

Yup.

>     +/*************************************************************
>     + * \brief Defines for all of the interrupt lines
>     + *************************************************************/
> 
> The /**** may break kerneldoc ; it looks for /** to start embedded self
> documentation; also the \brief or any other similar tagging specific to
> something not used in the base kernel tree would have to go.

I don't know whether /**** will break kerneldoc, but it makes sense to
get rid of it. The doxygen stuff is now converted to standard kernel-doc
annotations.

>     +#define kIBase 0
> 
> Is this always zero? (I'll probably see myself later in the code).  But
> maybe it is cleaner to just list the offsets here, and then add in the
> kibase to the offset in the few places it is used (vs. the hundreds
> of listings of it below).  Oh, and if the "k" is a magic prefix with no
> external meaning, it should again go.

I have to say that I have no idea what ibase is about. Sometimes, stuff you
inherit is just odd. And "k" is gone.

>     +/*------------- Register: Int_Stat_3 */
>     +/* 126 unused (bit 31) */
>     +#define kIrq_ASC2Video         (kIBase+126)    /* ASC 2 Video Interrupt */
...
>     +#define kIrq_SdDVP2            (kIBase+96)     /* SD DVP #2 Interrupt */
>     +/*------------- Register: Int_Stat_2 */
>     +#define kIrq_HdDVP             (kIBase+95)     /* HD DVP Interrupt */
...
>     +#define kIrq_DTCP              (kIBase+86)     /* DTCP Interrupt */
>     +#define kIrq_PCIExp1           (kIBase+85)     /* PCI Express 1 Interrupt */
>     +/* 84 unused   (bit 20) */
>     +/* 83 unused   (bit 19) */
>     +/* 82 unused   (bit 18) */
> 
> I'm somewhat confused by the "bit" references in all the
> unused ones.  In fact, if the int_stat registers are all independent,
> then why are they not listed in independent groups of 32 instead
> of one large linearly ascending list?

Tricky hardware folks. The int_stat registers are not independent. We have four
32-bit registers, i.e. 128 bits, for things like interrupt masking, status,
etc. The bit values refer to the bit within a given register. Things are
listed in descending order because they wanted everything to be big-endian.
Thus, the most significant bit of the 128-bit interrupt vector bit 31 of
the int_stat register at the lowest address.

>     +/*------------- Register: Int_Stat_1 */
>     +/* 63 unused   (bit 31) */
>     +/* 62 unused   (bit 30) */
>     +/* 61 unused   (bit 29) */
>     +/* 60 unused   (bit 28) */
>     +/* 59 unused   (bit 27) */
>     +/* 58 unused   (bit 26) */
>     +/* 57 unused   (bit 25) */
>     +/* 56 unused   (bit 24) */
> 
> Something happened from here down; the whitespace went all to hell.
> I think the variable names became longer than the initial indent...
> 
> 
>     +#define kIrq_BufDMA_Mem2Mem    (kIBase+55)     /* BufDMA Memory to Memory
>     +                                                * Interrupt */
>     +#define kIrq_BufDMA_USBTransmit        (kIBase+54)     /* BufDMA USB Transmit
>     +                                                * Interrupt */
>     +#define kIrq_BufDMA_QPSKPODTransmit (kIBase+53)        /* BufDMA QPSK/POD 
Fixed.

>     diff --git a/arch/mips/include/asm/mach-powertv/war.h 
>     b/arch/mips/include/asm/mach-powertv/war.h
>     new file mode 100644
>     index 0000000..2f4a155
>     --- /dev/null
>     +++ b/arch/mips/include/asm/mach-powertv/war.h
>     @@ -0,0 +1,27 @@
>     +/*
>     + * This file is subject to the terms and conditions of the GNU General Public
>     + * License.  See the file "COPYING" in the main directory of this archive
>     + * for more details.
>     + *
> 
> Similar here as above, add your name in and distinguish it from the
> original.

Yup.

>     +config BOOTLOADER_FAMILY
>     +       string "POWERTV Bootloader Family string"
>     +       default "85"
>     +       depends on POWERTV && !BOOTLOADER_DRIVER
>     +       help
>     +         This value should be specified when the bootloader driver is disabled
>     +         and must be exactly two characters long.
> 
> Neither of these descriptions lend any useful information to
> an end user who doesn't know intimate details of the platform.

I've added a bit more description, enough so that if you know your model you
should be able to figure out what to put here.

>     diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
>     new file mode 100644
>     index 0000000..87886e0
>     --- /dev/null
>     +++ b/arch/mips/powertv/Makefile
>     @@ -0,0 +1,37 @@
>     +#
>     +# Carsten Langgaard, carstenl@mips.com
>     +# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> 
> Similar comment here; stick your name in and give reference to
> the original source -- vs. inadvertently making it look like the
> original authors wrote your file.

Yup.

>     +# Makefile for the MIPS Malta specific kernel interface routines
>     +# under Linux.
> 
> Not malta anymore.

True.

>     diff --git a/arch/mips/powertv/asic/Kconfig b/arch/mips/powertv/asic/Kconfig
>     new file mode 100644
>     index 0000000..48b85ea
>     --- /dev/null
>     +++ b/arch/mips/powertv/asic/Kconfig
>     @@ -0,0 +1,24 @@
...
>     +config MIN_RUNTIME_PMEM
>     +       bool "Support for minimum PMEM resource"
>     +       depends on MIN_RUNTIME_RESOURCES
>     +       help
>     +         Enables support for the preallocated Memory resource.
> 
> PMEM might be a bad name choice; I know it has been used for
> "persistent mem" (i.e. preserved across reboots) in the past, etc.

You note later that this is exactly what PMEM is intended to stand for.

>     +config MIN_RUNTIME_TFTP
>     +       bool "Support for minimum TFTP resource"
>     +       depends on MIN_RUNTIME_RESOURCES
>     +       help
>     +         Enables support for the preallocated TFTP resource.
> 
> Should any of the above items have defaults specified?  I wouldn't know
> what to choose, aside from peeking at the defconfig.

Yes, they certainly should. And now they do :-)

>     diff --git a/arch/mips/powertv/asic/asic_devices.c 
>     b/arch/mips/powertv/asic/asic_devices.c
>     new file mode 100644
>     index 0000000..2e67979
>     --- /dev/null
>     +++ b/arch/mips/powertv/asic/asic_devices.c
>     @@ -0,0 +1,2902 @@
...
>     + *
>     + * File Name:    asic_devices.c
>     + *
>     + * See Also:
>     + *
>     + * Project:      SA explorer settops
>     + *
>     + * Compiler:
>     + *
>     + * Author:       Ken Eppinett
>     + *               David Schleef <ds@schleef.org>
>     + *
>     + * Description:  Defines the platform resources for the SA settop.
>     + *
>     + * NOTE: The bootloader allocates persistent memory at an address which is
>     + * 16 MiB below the end of the highest address in KSEG0. All fixed
>     + * address memory reservations must avoid this region.
>     + *
>     + *****************************************************************************
>     + * History:
>     + * Rev Level     Date         Name       ECN#      Description
>     + *----------------------------------------------------------------------------
>     + * 1.0                     Eppinett                initial version
>     + ****************************************************************************/
> 
> You might want to consider stripping some of the cruft from
> these, if you have the flexibility to do so.  Things like the
> content free changelog above, or the redundant listing of the
> file name, and the empty compiler tag.

Yup.

>     +/******************************************************************************
>     + * Forward Prototypes
>     + *****************************************************************************/
>     +static void pmem_setup_resource(void);
>     +
>     +/******************************************************************************
>     + * Global Variables
>     + *****************************************************************************/
>     +enum tAsicType gAsic;
> 
> The big banner messages for proto and global don't really add
> any value -- if you don't need them for consistency with some
> internal release, you could consider flushing them.

They are from the other coding style I referred to earlier. I don't see that
they actually add value; they've been made less obtrusive.

>     +unsigned int        gPlatformFeatures;
>     +unsigned int        gPlatformFamily;
>     +const struct tRegisterMap  *gRegisterMap;
>     +EXPORT_SYMBOL(gRegisterMap);                   /* Exported for testing */
>     +unsigned long       gAsicPhyBase;
>     +unsigned long       pAsicBase;
>     +EXPORT_SYMBOL(pAsicBase);                      /* Exported for testing */
>     +struct resource     *gpResources;
>     +static bool usb_configured;
> 
> Similar comments, whitespace, and one letter mystery prefixes.

Yup.

>     +/*
>     + * Don't recommend to use it directly, it is usually used by kernel internally.
>     + * Portable code should be using interfaces such as ioremp, dma_map_single, 
>     etc.
>     + */
>     +unsigned long       gPhysToBusOffset;
>     +EXPORT_SYMBOL(gPhysToBusOffset);
> 
> If you wipe this out completely and compile, are there any offenders left
> that can be easily swung over, thus allowing removal?

I'm not completely sure what you're saying, but I think you are thinking this
symbol could be eliminated because it's not used much. The symbol is also used
by loadable drivers, so it's not possible to do away with it.

>     +static const struct tRegisterMap zeus_register_map = {
>     +       .EIC_SLOW0_STRT_ADD = 0x000000,
>     +       .EIC_CFG_BITS = 0x000038,
>     +       .EIC_READY_STATUS = 0x00004c,
>     +
>     +       .CHIPVER3 = 0x280800,
>     +       .CHIPVER2 = 0x280804,
>     +       .CHIPVER1 = 0x280808,
>     +       .CHIPVER0 = 0x28080c,
>     +
>     +       /* The registers of IRBlaster */
>     +       .UART1_INTSTAT = 0x281800,
>     +       .UART1_INTEN = 0x281804,
>     +       .UART1_CONFIG1 = 0x281808,
>     +       .UART1_CONFIG2 = 0x28180C,
>     +       .UART1_DIVISORHI = 0x281810,
>     +       .UART1_DIVISORLO = 0x281814,
>     +       .UART1_DATA = 0x281818,
>     +       .UART1_STATUS = 0x28181C,
> 
> These all caps struct fields have to go.  Actually I think that you
> might want to look at breaking the registermap struct into smaller
> chunks (i.e. ver chunk, uart chunk, int chunk, usb chunk).   That,
> and try and reuse what you can across boards by specifying a base
> address and then add the offsets -- since at a glance, it appears that
> is all that is really changing from one board to the next (the offset).

Would that it were that simple. Offsets from one block of device registers
vary from one revision of the ASIC to the next. However, the offsets within
register blocks for a particular device do remain the same and we are slowly
transitioning away from this style of accessing things to something based
on offsets within structures defined for particular devices. Oh, the all caps
names are gone.

...
>     +       .Watchdog = 0x282c30,
>     +       .Front_Panel = 0x283800,
>     +};
>     +
>     +static const struct tRegisterMap calliope_register_map = {
>     +       .EIC_SLOW0_STRT_ADD = 0x800000,
>     +       .EIC_CFG_BITS = 0x800038,
...
>     +       .Watchdog = 0xA02c30,
>     +       .Front_Panel = 0x000000,        /* -not used- */
>     +};
>     +
>     +static const struct tRegisterMap cronus_register_map = {
>     +       .EIC_SLOW0_STRT_ADD = 0x000000,
>     +       .EIC_CFG_BITS = 0x000038,
...
>     +       .Watchdog = 0x2A2C30,
>     +       .Front_Panel = 0x2A3800,
>     +};
> 
> Assuming that you can't collapse all of the above by some sort of
> sharing and listing of a board specific offset, you might instead
> consider adding <boardname>.h which has all the settings instead
> of having them cluttering up the main source file.

I've broken these into independent files in a subdirectory.

>     +/******************************************************************************
>     + * DVR_CAPABLE RESOURCES
>     + *****************************************************************************/
>     +struct resource dvr_zeus_resources[] =
>     +{
> 
> 
> [...]
> 
> 
>     +
>     +/******************************************************************************
>     + * NON_DVR_CAPABLE ZEUS RESOURCES
>     + *****************************************************************************/
>     +struct resource non_dvr_zeus_resources[] =
>     +{
>     +       /**********************************************************************
>     +        * VIDEO1 / LX1
>     +        *********************************************************************/
>     +       {
>     +               .name   = "ST231aImage",      /* Delta-Mu 1 image and ram */
>     +               .start  = 0x20000000,
>     +               .end    = 0x201FFFFF,           /* 2MiB */
>     +               .flags  = IORESOURCE_IO,
>     +       },
> 
> 
> [...]
> 
> All these resource items might also be good candidates to shuffle off
> to a board specific header too.  That would also lend itself better to
> being able to select/enable just one of the board variants should you
> decide to go that route someday.

These, too, have been broken into independent files in a subdirectory. I've
been wanting to do this for a long time and just needed an excuse.

> [...same with the ~1000 lines that were here...]
> 
> Actually these resources might be good candidates in the context of
> my earlier comment, about keeping it simple for the initial commit,
> i.e. basic serial and ethernet;  leave out all these for the initial board
> commits.

Actually, this patchset is a much simplified version of what we are using. My
goal is to transition everything I can from our "hidden" source tree to
the mainline kernel. To get to this point, I've been able to excise large
chunks, but doing much more munging around with this will make it much
harder to merge new code in because the changes will be a few lines here and
a few lines there.

>     +/*
>     + *
>     + * USB Host Resource Definition
>     + *
>     + */
...
>     +static struct platform_device *platform_devices[] = {
>     +       &ehci_device,
>     +       &ohci_device,
> 
> The USB support is probably something you can keep within the
> core set of commits, but it could still be a separate commit
> within that group if it helps scale down the size of the patch
> chunks.

We use USB for the console and for the network device. It has to be a part
of the base patchset.

>     +static void __init fs_update(int pe, int md, int sdiv, int disable_div_by_3)
>     +{
>     +       int en_prg, byp, pwr, nsb, val;
>     +       int sout;
>     +
>     +       sout = 1;
>     +       en_prg = 1;
>     +       byp = 0;
>     +       nsb = 1;
>     +       pwr = 1;
>     +
>     +       val = ((sdiv << 29) | (md << 24) | (pe<<8) | (sout<<3) | (byp<<2) |
>     +               (nsb<<1) | (disable_div_by_3<<5));
> 
> Nobody has any hope of knowing what the above does, or if
> there is a bug in it.  A platform that is unmaintainable is less
> likely to be merged.

Honestly, it's magic, taken from the hardware documentation. The names
correspond to the names from that documentation and the computation comes
from there, too. I'm not quite sure what to add. A comment like RTFHM isn't
going to help.

>     +/*
>     + * \brief platform_get_family() determine major platform family type.
>     + *
>     + * \param     none
>     + *
>     + * \return    family type; -1 if none
> 
> Backslash tags would have to go.

Gone.

>     +enum tFamilyType platform_get_family(void)
>     +{
>     +#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
> 
> Group all the defines at the top just after the header includes?

Done.

> 
> 
>     +
>     +       unsigned short bootldrFamily;
>     +       static enum tFamilyType family = -1;
>     +       static int firstTime = 1;
>     +
>     +       if (firstTime) {
>     +               firstTime = 0;
>     +
>     +#ifdef CONFIG_BOOTLOADER_DRIVER
>     +               bootldrFamily = (unsigned short) kbldr_GetSWFamily();
>     +#else
>     +#if defined(CONFIG_BOOTLOADER_FAMILY)
>     +               bootldrFamily = (unsigned short) BOOTLDRFAMILY(
> 
> I'm not sure if checkpatch.pl warns about spaces between casts and
> the names they operate on.

Checkpatch didn't complain about this and I don't know of a particular
convention.  Usage seems to vary in the kernel code.

>     +#undef BOOTLDRFAMILY
> 
> No undef needed.

Gone.

>     +/*
>     + * \brief platform_get_asic() determine the ASIC type.
>     + *
>     + * \param     none
>     + *
>     + * \return    ASIC type; ASIC_UNKNOWN if none
> 
> tags

Gone.

>     + * \brief platform_configure_usb() usb configuration based on platform type.
>     + *
>     + * \param     int divide_by_3 divide clock setting by 3
>     + *
>     + * \return    none
> 
> More backslash tags.  I'll stop flagging them from here on, you get
> the idea by now, I'm sure.

Sure do.

>     +static void platform_configure_usb(void)
>     +{
>     +       int divide_by_3;
> 
> A little comment on what this magic constant controls would
> be a good idea.

It's more hardware magic.

>     +static int __init platform_devices_init(void)
>     +{
>     +       pr_crit("%s: ----- Initializing USB resources -----\n", __func__);
> 
> Presumably pr_crit maps onto KERN_CRIT -- but message is more
> informational than critical.

Yes, pr_crit() is in linux/kernel.h. But your point is well taken. This is
more like a KERN_NOTICE or KERN_INFO level of message.

>     + * PERSISTENT MEMORY (PMEM) CONFIGURATION
> 
> OK, so PMEM does mean persistent.  I forget what it said that
> the "P" was for above...

Yup.

>     diff --git a/arch/mips/powertv/asic/asic_int.c 
>     b/arch/mips/powertv/asic/asic_int.c
>     new file mode 100644
>     index 0000000..94b6ca9
>     --- /dev/null
>     +++ b/arch/mips/powertv/asic/asic_int.c
>     @@ -0,0 +1,146 @@
>     +/*
>     + * Carsten Langgaard, carstenl@mips.com
>     + * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
>     + * Copyright (C) 2001 Ralf Baechle
> 
> I'm guessing the attribution here also needs a cleanup.

Yes.

>     + * Routines for generic manipulation of the interrupts found on the MIPS
>     + * Malta board.
>     + * The interrupt controller is located in the South Bridge a PIIX4 device
>     + * with two internal 82C95 interrupt controllers.
> 
> Chances are that this Malta description has no bearing whatsoever
> anymore either.

That would be correct, sir!

>     +static DEFINE_SPINLOCK(mips_irq_lock);
> 
> asic_irq_lock?

Sure.

>     +/*
>     + * Version of ffs that only looks at bits 12..15.
>     + */
>     +static inline unsigned int irq_ffs(unsigned int pending)
>     +{
>     +#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
> 
> Won't the CPU_MIPS32 always be true, hence making the else
> clause just useless dead code?

True.

>     diff --git a/arch/mips/powertv/asic/irq_asic.c 
>     b/arch/mips/powertv/asic/irq_asic.c
>     new file mode 100644
>     index 0000000..693abab
>     --- /dev/null
>     +++ b/arch/mips/powertv/asic/irq_asic.c
>     @@ -0,0 +1,115 @@
>     +/*
>     + * Copyright (C) 2005 Scientific Atlanta
>     + *
>     + * Modified from arch/mips/kernel/irq-rm7000.c:
> 
> I'd just add "which was" to the end of the above line for clarity.

See previous comments.

>     diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
>     new file mode 100644
>     index 0000000..cecbf40
>     --- /dev/null
>     +++ b/arch/mips/powertv/cevt-powertv.c
...
>     + * The file comes from kernel/cevt-r4k.c
> 
> It would be good to know why this file had to fork off its own
> copy (i.e. what was lacking in the original).  Some small comment
> here to that effect would be useful.

Good question. But the contractors who did the initial port are gone and I
don't know the answer. I did attempt to drop in cevt-r4k.c but it didn't work.
Unless anyone thinks this is a blocker for acceptance, I'd rather defer this
question until later. If I can use the standard arch/mips/kernel files, I
would rather do so.

>     +#ifdef CONFIG_MIPS_MT_SMTC
> 
> If you've forked the file to be board specific, and if you are never
> going to select MT_SMTC then you should purge the stuff that you
> are never going to use/enable  (here, and in the additional cases
> below).

Yes, this just makes it harder to read and I don't seeing us needing this.

>     diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
>     new file mode 100644
>     index 0000000..ee570a1
>     --- /dev/null
>     +++ b/arch/mips/powertv/cmdline.c
>     @@ -0,0 +1,51 @@
>     +/*
>     + * Carsten Langgaard, carstenl@mips.com
>     + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> 
> Looks like an attribution update is needed here too.

Yup.

>     diff --git a/arch/mips/powertv/csrc-powertv.c b/arch/mips/powertv/csrc-powertv.c
>     new file mode 100644
>     index 0000000..c032660
>     --- /dev/null
>     +++ b/arch/mips/powertv/csrc-powertv.c
...
>     + * The file comes from kernel/csrc-r4k.c
> 
> Same here, a comment covering the deviation would be good.

Same answer as above: who knows?

>     diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
>     new file mode 100644
>     index 0000000..6d7b229
>     --- /dev/null
>     +++ b/arch/mips/powertv/init.c
>     @@ -0,0 +1,127 @@
>     +/*
>     + * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
>     + *     All rights reserved.
>     + *     Authors: Carsten Langgaard <carstenl@mips.com>
>     + *              Maciej W. Rozycki <macro@mips.com>
> 
> Attribution update.

>     diff --git a/arch/mips/powertv/init.h b/arch/mips/powertv/init.h
>     new file mode 100644
>     index 0000000..763472e
>     --- /dev/null
>     +++ b/arch/mips/powertv/init.h
>     @@ -0,0 +1,10 @@
>     +/*
>     + * Definitions from powertv init.c file
>     + */
> 
> OK, it is a small file, but you probably want to stick some header
> on it regardless.

It doesn't hurt...

>     diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
>     new file mode 100644
>     index 0000000..a57972f
>     --- /dev/null
>     +++ b/arch/mips/powertv/memory.c
>     @@ -0,0 +1,183 @@
>     +/*
>     + * Carsten Langgaard, carstenl@mips.com
>     + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> 
> This too should be updated and reference the original file
> path/location that it was based on, and cover how it was
> changed.

Done.

>     +#ifdef CONFIG_HIGHMEM_256_128
> 
> Do these options even exist in a Kconfig?  I don't recall seeing them.
> Maybe that is part of the TODO as well.

No. That was part of the stripping down of the production kernel to get
something small enough to reasonably be reviewed.

>     diff --git a/arch/mips/powertv/pci/Makefile b/arch/mips/powertv/pci/Makefile
>     new file mode 100644
>     index 0000000..7bf9f8c
>     --- /dev/null
>     +++ b/arch/mips/powertv/pci/Makefile
>     @@ -0,0 +1,26 @@
>     +# *****************************************************************************
>     +#                          Make file for PowerTV PCI driver
> 
> minor nit  --  Makefile

Sort of. It is a file for the "make" command. Either seems reasonable.

>     diff --git a/arch/mips/powertv/pci/pci.c b/arch/mips/powertv/pci/pci.c
>     new file mode 100644
>     index 0000000..3358b5f
>     --- /dev/null
>     +++ b/arch/mips/powertv/pci/pci.c
>     @@ -0,0 +1,35 @@
>     +/*
>     + * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
>     + *     All rights reserved.
>     + *     Authors: Carsten Langgaard <carstenl@mips.com>
>     + *              Maciej W. Rozycki <macro@mips.com>
>     + *
>     + * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
> 
> Update attribution, reference original, mention deltas for this
> specific platform.

Yup.

>     +void __init mips_pcibios_init(void)
>     +{
>     +       asic_pcie_init();
>     +}
> 
> Now that I see the file in its entirety, I wonder if this can't just
> be rolled into another appropriate source file....

As previously mentioned, I'm just skipping PCI as much as possible since we
don't use it.

>     diff --git a/arch/mips/powertv/pci/pciemod.c b/arch/mips/powertv/pci/pciemod.c
>     new file mode 100644
>     index 0000000..f152fc5
>     --- /dev/null
>     +++ b/arch/mips/powertv/pci/pciemod.c
>     @@ -0,0 +1,2921 @@
...
>     + *
>     + * File Name:    pciemod.c
>     + *
>     + * Project:      NGP
>     + *
>     + * Compiler:     gnu C (gcc)
>     + *
>     + * Author(s):    Tom Haman
>     + *
>     + * Description:  Routines implementing kernel PCIE Module.
>     + *
>     + * Documents:    PCIE Software Design Document
>     + *
>     + * NOTES:
>     + *
>     + * 
>     -----------------------------------------------------------------------------
>     + * History:
>     + * Rev Level    Date    Name         ECN#    Description
>     + * 
>     -----------------------------------------------------------------------------
>     + * 1.00       03/27/06  Tom Haman    ---    Initial version for NGP (Zeus)
>     + * 
>     -----------------------------------------------------------------------------
> 
> Project,  compiler, and changelog etc can go as per prev.
> comments.

Yup.

>     + 
>     *******************************************************************************
>     + 
>     ******************************************************************************/
> 
> Drop the giant banners again?

Yeah, they're pretty gross.

>     +static struct proc_dir_entry *PCIE_pProc;      /* proc directory entry */
>     +static        int             LogLevel            = SA_INFO;
>     +static        struct tPCIERegs      *PCIE_RegsPtr;
>     +static        int             PCIE_irqrequest_pcie;
>     +static        u32             PCIE_initialized;
>     +static        u32            *timerptr;
>     +static        spinlock_t      PCIE_lock;
> 
> whitespace cleanup on the above?

Yup.

>     +static void pcie_delay(u32 ms);
>     +static int pcie_reset_ethernet(void) ;
>     +static void pcie_uSecDelay(u32 us);
> 
> I'm not sure why a delay is tied to a bus.  A delay is a delay, no?

Uh, when I look at this actual function, it becomes obvious that the author
was, umm, new to Linux. If we ever need PCI, this will need some clean up.
I've stuck an #error in there.

>     +static int pcie_WriteProc(struct file *pfile, const char __user *pbuff,
>     +       unsigned long bytecnt, void *data);
> 
> I haven't got to what these proc functions do yet, but just by
> looking at the name I'm thinking seq_file?

Yes.

>     +/*---------- Temporary Fixes ------------ */
> 
> Some sort of comment about what these workarounds are for would
> not go amiss.

No kiddin'. It looks like some address swizzling, but I don't know the
details. If we ever support PCI...

>     +#ifdef PCIE_PLL_FIX
>     +
>     +       static struct tTBRegs  *TB_RegsPtr;
>     +       static unsigned int scr_data_in[kSCR_DEPTH];
> 
> Don't indent here.

I won't!

>     *******************************************************************************
>     + *   PCIE General Interface
>     + 
>     *******************************************************************************
>     + 
>     *******************************************************************************
>     + 
>     *******************************************************************************
> 
> Mega banner.  Might as well just adopt proper kerndoc format
> and let it make use of the info below.

Done.

> I've snipped the largish pcie code block from here; having that
> support as a separate commit would really help the digestibility
> of the board support -- even I didn't have it in me to go over it now.

I completely understand. I've incorporated all of your comments so that if
we do decide to support PCI again at a later date, we'll start from a better
place.

>     diff --git a/arch/mips/powertv/pci/powertv-pci.h 
>     b/arch/mips/powertv/pci/powertv-pci.h
>     new file mode 100644
>     index 0000000..98c087e
>     --- /dev/null
>     +++ b/arch/mips/powertv/pci/powertv-pci.h
>     @@ -0,0 +1,12 @@
>     +/*
>     + * Local definitions for the powertv PCI code
>     + */
>     +
>     +#ifndef        _POWERTV_PCI_H_
>     +#define        _POWERTV_PCI_H_
> 
> Header on the file and no extraneous tabs?

Yup.

>     +extern int LogLevel;
> 
> Is this a separate loglevel from the normal one used by dmesg?
> If so, then why?

Yes, this is different. I think the one you are thinking of is
console_loglevel. This variable is module-specific and used to control
the volume of debugging messages. This is different than console_loglevel.

>     +#endif
>     diff --git a/arch/mips/powertv/powertv-clock.h 
>     b/arch/mips/powertv/powertv-clock.h
>     new file mode 100644
>     index 0000000..6f8c17b
>     --- /dev/null
>     +++ b/arch/mips/powertv/powertv-clock.h
>     +/*
>     + * Carsten Langgaard, carstenl@mips.com
>     + * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
> 
> Attribution updates.

Yup.

>     +#ifdef CONFIG_64BIT
>     +#warning TODO: 64-bit code needs to be verified
>     +#define PTR_LA         "dla       "
>     +#define LONG_S         "sd        "
>     +#define        LONG_L          "ld        "
>     +#define        PTR_ADDIU       "daddiu    "
>     +#define        REG_SIZE        "8"           /* In bytes */
>     +#endif
>     +
>     +#ifdef CONFIG_32BIT
>     +#define PTR_LA         "la        "
>     +#define LONG_S         "sw        "
>     +#define        LONG_L          "lw        "
>     +#define        PTR_ADDIU       "addiu     "
>     +#define        REG_SIZE        "4"           /* In bytes */
>     +#endif
> 
> You've got tabs after the defines in the above two blocks.

Fixed.

>     +static int panic_handler (struct notifier_block *notifier_block,
> 
> Inconsistent coding style --- foo ()  vs.  foo()  -- probably will get
> nagged by checkpatch.

This is odd. All this code has been through checkpatch but it didn't complain.
It's fixed, anyway.

>     +#ifdef CONFIG_DIAGNOSTICS
>     +       failure_report((char *) cause_string,
>     +               have_die_regs ? &die_regs : &my_regs);
>     +       have_die_regs = false;
>     +#else
>     +       pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
>     +               "zzzz... \n");
> 
> You probably want a hint of what the real problem is printed
> when this message goes to the console.  Unless a prev. message
> will have printed that already.

This is a panic notifier, which will only be called after panic() has printed
the message. We normally run with CONFIG_DIAGNOSTICS but that was one of the
things that I'll pick up in a following patchset.

>     +void platform_random_ether_addr(u8 addr[ETH_ALEN])
>     +{
>     +#define        NUM_RANDOM_BYTES                2
>     +#define        NON_SCIATL_OUI_BITS             0xc0u
>     +#define        MAC_ADDR_LOCALLY_MANAGED        (1 << 1)
> 
> whitespace

Yup.

>     +#undef NON_RANDOM_BYTES
>     +#undef NON_SCIATL_OUI_BITS
>     +#undef MAC_ADDR_LOCALLY_MANAGED
> 
> This is the end of a C file, no need for undef

Yup.

>     diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
>     new file mode 100644
>     index 0000000..9756090
>     --- /dev/null
>     +++ b/arch/mips/powertv/reset.c
>     @@ -0,0 +1,69 @@
>     +/*
>     + * Carsten Langgaard, carstenl@mips.com
>     + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> 
> Attribution updates?

Yup.

>     diff --git a/arch/mips/powertv/reset.h b/arch/mips/powertv/reset.h
>     new file mode 100644
>     index 0000000..79211ce
>     --- /dev/null
>     +++ b/arch/mips/powertv/reset.h
>     @@ -0,0 +1,8 @@
>     +/*
>     + * Definitions from powertv reset.c file
> 
> GPL header?

It's in there, now.

>     +#include <linux/types.h>
>     +#include <linux/init.h>
>     +#include <linux/kernel_stat.h>
>     +#include <linux/sched.h>
>     +#include <linux/spinlock.h>
>     +#include <linux/interrupt.h>
>     +#include <linux/time.h>
>     +#include <linux/timex.h>
>     +
>     +#include <asm/mipsregs.h>
>     +#include <asm/mipsmtregs.h>
>     +#include <linux/hardirq.h>
>     +#include <asm/irq.h>
>     +#include <asm/div64.h>
>     +#include <linux/cpu.h>
>     +#include <linux/time.h>
>     +
>     +#include <asm/mips-boards/generic.h>
>     +#include <asm/mips-boards/prom.h>
>     +
>     +#include "powertv-clock.h"
...
> A file this simple can't possibly need all those header files
> included.  And as such, the original attributions from whatever
> file it was originally cloned from are probably not relevant
> whatsoever (unless this file was actually written for this
> platform back in 1999!)

And it doesn't. I dropped 16 of the original 18.

> Paul.

I don't know if anyone will read down this far, but I wanted to repeat my
appreciation for Paul's comments. This was a lot of work on his part and
my code is the better for it.

David VL
