Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 20:59:00 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:56133 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024749AbZEMT6x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 May 2009 20:58:53 +0100
Received: from [128.224.146.65] (yow-pgortmak-d1.ottawa.windriver.com [128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n4DJwhca009132;
	Wed, 13 May 2009 12:58:44 -0700 (PDT)
Message-ID: <4A0B2670.9070600@windriver.com>
Date:	Wed, 13 May 2009 15:58:40 -0400
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/3] mips:powertv: Base files for Cisco Powertv platform
 (resend)
References: <20090504225616.GA22321@cuplxvomd02.corp.sa.net>
In-Reply-To: <20090504225616.GA22321@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paul.gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> Adds the C and header source files for the Cisco PowerTV platform.
>   

I'll try and put in some feedback inline that will hopefully be useful
in terms of steering this in the direction I think mainline would expect.

I'm not a low level MIPS arch guru, so I'm probably not going to see
subtle bugs that require deep level MIPS knowledge.

Some comments have global applicability, but I'm not going to flag
every instance of the item when there are possibly hundreds.

Out of curiosity, is there more information about this platform
somewhere, like what the bootloader is, what the end user availability
is, how to bootstrap it etc?   The kernel support files on their own is
only one part of the puzzle...   If it turns out that this board is not
something that you can buy/find/steal, then that may influence
its chances of being merged too (see the voyageur thread between
Ingo and James recently, as an example).  That, and what the long
term maintenance you foresee for the codebase may also have
an impact on whether it makes sense to merge it or not.

Anyway, hope you find the feedback useful.

Paul.

> History
> v2	Check clocksource function to correspond to changed prototype.
> v1	First release
>
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/include/asm/mach-powertv/asic.h          |  124 +
>  arch/mips/include/asm/mach-powertv/asic_regs.h     |  136 +
>  arch/mips/include/asm/mach-powertv/dma-coherence.h |  123 +
>  arch/mips/include/asm/mach-powertv/interrupts.h    |  234 ++
>  arch/mips/include/asm/mach-powertv/war.h           |   27 +
>  arch/mips/powertv/Kconfig                          |   17 +
>  arch/mips/powertv/Makefile                         |   37 +
>  arch/mips/powertv/asic/Kconfig                     |   24 +
>  arch/mips/powertv/asic/Makefile                    |   24 +
>  arch/mips/powertv/asic/asic_devices.c              | 2902 +++++++++++++++++++
>  arch/mips/powertv/asic/asic_int.c                  |  146 +
>  arch/mips/powertv/asic/irq_asic.c                  |  115 +
>  arch/mips/powertv/cevt-powertv.c                   |  247 ++
>  arch/mips/powertv/cmdline.c                        |   51 +
>  arch/mips/powertv/csrc-powertv.c                   |   84 +
>  arch/mips/powertv/init.c                           |  127 +
>  arch/mips/powertv/init.h                           |   10 +
>  arch/mips/powertv/memory.c                         |  183 ++
>  arch/mips/powertv/pci/Makefile                     |   26 +
>  arch/mips/powertv/pci/fixup-powertv.c              |   14 +
>  arch/mips/powertv/pci/pci.c                        |   35 +
>  arch/mips/powertv/pci/pciemod.c                    | 2921 ++++++++++++++++++++
>  arch/mips/powertv/pci/pcieregs.h                   |  333 +++
>  arch/mips/powertv/pci/powertv-pci.h                |   12 +
>  arch/mips/powertv/powertv-clock.h                  |   10 +
>  arch/mips/powertv/powertv_setup.c                  |  351 +++
>  arch/mips/powertv/reset.c                          |   69 +
>  arch/mips/powertv/reset.h                          |    8 +
>  arch/mips/powertv/time.c                           |   47 +
>   

I don't know enough about this platform to know what are critical
and non critical support items, but a general suggestion is to start
with just the core board support plus serial console and ethernet
(i.e. so you can boot and NFS root) and use that as your baseline
commit, and then look to adding in additional features in separate
commits (i.e. say the asic and pcie support in this case?)

It helps to make things somewhat more digestible chunks, as when
things come out in one giant chunk you probably loose out on
review feedback (i.e. people get scared off).

>  29 files changed, 8437 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
> new file mode 100644
> index 0000000..4240e4e
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-powertv/asic.h
> @@ -0,0 +1,124 @@
> +#ifndef _ASM_ASIC_H
> +#define _ASM_ASIC_H
>   
_ASM_MACH_POWERTV_ASIC_H

at least that seems to be the norm used by other platforms.

> +
> +#include <asm/mach-powertv/asic_regs.h>
> +
> +#define DVR_CAPABLE     (1<<0)
> +#define PCIE_CAPABLE    (1<<1)
> +#define FFS_CAPABLE     (1<<2)
> +#define DISPLAY_CAPABLE (1<<3)
>   

align with tabs, not spaces?

> +
> +/* Platform Family types
> + * For compitability, the new value must be added in the end */
> +enum tFamilyType {
>   

Is the leading "t" prefix relevant?   You'll probably get less grief
from kernel community folks if you remove it.

> +	FAMILY_8500,
> +	FAMILY_8500RNG,
> +	FAMILY_4500,
> +	FAMILY_1500,
> +	FAMILY_8600,
> +	FAMILY_4600,
> +	FAMILY_4600VZA,
> +	FAMILY_8600VZB,
> +	FAMILY_1500VZE,
> +	FAMILY_1500VZF,
> +	FAMILIES
> +};
> +
> +extern void powertv_platform_init(void);
> +extern void platform_alloc_bootmem(void);
> +extern enum tAsicType platform_get_asic(void);
> +extern enum tFamilyType platform_get_family(void);
>   

Aside from the magic "t" again, I think it would really be a win
for you in terms of acceptance if you could get rid of all the
CamelCase from the variable names.  When people see that as
they are reviewing, it puts them off on the wrong foot immediately.

> +extern int platform_supports_dvr(void);
> +extern int platform_supports_ffs(void);
> +extern int platform_supports_pcie(void);
> +extern int platform_supports_display(void);
> +extern void configure_platform(void);
> +extern void platform_configure_usb_ehci(void);
> +extern void platform_unconfigure_usb_ehci(void);
> +extern void platform_configure_usb_ohci(void);
> +extern void platform_unconfigure_usb_ohci(void);
> +
> +/*
> + * The bus addresses are different than the physical addresses that
> + * the processor sees by an offset. This offset varies by ASIC
> + * version. Define a variable to hold the offset and some macros to
> + * make the conversion simpler. */
> +extern unsigned long gPhysToBusOffset;
>   

Leading "g" here like the "t" above?

> +
> +#ifdef CONFIG_HIGHMEM
> +/*
> + * TODO: We will use the hard code for conversion between physical and
> + * bus until the bootloader releases their device tree to us.
> + */
> +#define phys_to_bus(x) (((x) < 0x20000000) ? ((x) + gPhysToBusOffset) : (x))
> +#define bus_to_phys(x) (((x) < 0x60000000) ? ((x) - gPhysToBusOffset) : (x))
> +#else
> +#define phys_to_bus(x) ((x) + gPhysToBusOffset)
> +#define bus_to_phys(x) ((x) - gPhysToBusOffset)
> +#endif
> +
> +/*
> + * Determine whether the address we are given is for an ASIC device
> + * Params:  addr    Address to check
> + * Returns: Zero if the address is not for ASIC devices, non-zero
> + *      if it is.
> + */
> +static inline int asic_is_device_addr(phys_t addr)
> +{
> +	return !((phys_t)addr & (phys_t) ~0x1fffffffULL);
> +}
> +
> +/*
> + * Determine whether the address we are given is external RAM mappable
> + * into KSEG1.
> + * Params:  addr    Address to check
> + * Returns: Zero if the address is not for external RAM and
> + */
> +static inline int asic_is_lowmem_ram_addr(phys_t addr)
> +{
> +	/*
> +	 * The RAM always starts at the following address in the processor's
> +	 * physical address space
> +	 */
> +	static const phys_t phys_ram_base = 0x10000000;
>   

Could probably bury all the magic constants for the board in one
header file.  POWERTV_RAM_BASE or similar.

> +	phys_t bus_ram_base;
> +
> +	bus_ram_base = gPhysToBusOffset + phys_ram_base;
> +
> +	return addr >= bus_ram_base &&
> +		addr < (bus_ram_base + 256 * 1024 * 1024);
> +}
> +
> +/* Platform Resources */
> +#define ASIC_RESOURCE_GET_EXISTS 1
>   

Defined but  never used?

> +extern struct resource *asic_resource_get(const char *name);
> +extern void platform_release_memory(void *baddr, int size);
> +
> +/* Reboot Cause */
> +extern void set_reboot_cause(char code, unsigned int data, unsigned int data2);
> +extern void set_locked_reboot_cause(char code, unsigned int data,
> +	unsigned int data2);
> +
> +enum eSys_RebootType {
> +	kSys_UnknownReboot          = 0x00,	/* Unknown reboot cause */
> +	kSys_DavicChange            = 0x01,	/* Reboot due to change in DAVIC
> +						* mode */
> +	kSys_UserReboot             = 0x02,	/* Reboot initiated by user */
> +	kSys_SystemReboot           = 0x03,	/* Reboot initiated by OS */
> +	kSys_TrapReboot             = 0x04,	/* Reboot due to a CPU trap */
> +	kSys_SilentReboot           = 0x05,	/* Silent reboot */
> +	kSys_BootLdrReboot          = 0x06,	/* Bootloader reboot */
> +	kSys_PowerUpReboot          = 0x07,	/* Power on bootup.  Older
> +						 * drivers may report as
> +						 * userReboot. */
> +	kSys_CodeChange             = 0x08,	/* Reboot to take code change.
> +						 * Older drivers may report as
> +						 * userReboot. */
> +	kSys_HardwareReset          = 0x09,	/* HW Watchdog or front-panel
> +						 * reset button reset.  Older
> +						 * drivers may report as
> +						 * userReboot. */
> +	kSys_WatchdogInterrupt      = 0x0A	/* Pre-watchdog interrupt */
> +};
>   

The "e" prefix and the "k" prefix (and the CamelCase) don't help
the readability here either.

> +
> +#endif /* _ASM_ASIC_H */
> diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
> new file mode 100644
> index 0000000..8bdbec2
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
> @@ -0,0 +1,136 @@
> +
> +#ifndef __ASIC_H_
> +#define __ASIC_H_
>   

_MACH_POWERTV_ASIC_REGS_H or similar

> +#include <linux/io.h>
> +
> +/* ASIC types */
> +enum tAsicType {
> +	ASIC_UNKNOWN,
> +	ASIC_ZEUS,
> +	ASIC_CALLIOPE,
> +	ASIC_CRONUS,
> +	ASIC_CRONUSLITE,
> +	ASICS
> +};
> +
> +/* hardcoded values read from Chip Version registers */
> +#define CRONUS_10           0x0B4C1C20
> +#define CRONUS_11           0x0B4C1C21
> +#define CRONUSLITE_10       0x0B4C1C40
> +
> +#define NAND_FLASH_BASE     0x03000000
> +#define ZEUS_IO_BASE        0x09000000
> +#define CALLIOPE_IO_BASE    0x08000000
> +#define CRONUS_IO_BASE      0x09000000
> +#define ASIC_IO_SIZE        0x01000000
> +
> +/* ASIC register enumeration */
> +struct tRegisterMap {          /* ==ZEUS==  ==CALLIOPE== */
> +	int EIC_SLOW0_STRT_ADD;
> +	int EIC_CFG_BITS;
> +	int EIC_READY_STATUS;   /* 0x00004c    0x80004c */
> +
> +	int CHIPVER3;       /* 0x280800    0xA00800 */
> +	int CHIPVER2;       /* 0x280804    0xA00804 */
> +	int CHIPVER1;       /* 0x280808    0xA00808 */
> +	int CHIPVER0;       /* 0x28080c    0xA0080c */
> +
> +	int UART1_INTSTAT;   /* 0x281800    0xA01800 */
> +	int UART1_INTEN;     /* 0x281804    0xA01804 */
> +	int UART1_CONFIG1;   /* 0x281808    0xA01808 */
> +	int UART1_CONFIG2;   /* 0x28180C    0xA0180C */
> +	int UART1_DIVISORHI; /* 0x281810    0xA01810 */
> +	int UART1_DIVISORLO; /* 0x281814    0xA01814 */
> +	int UART1_DATA;      /* 0x281818    0xA01818 */
> +	int UART1_STATUS;    /* 0x28181C    0xA0181C */
>   

This is kind of worse than the normal CamelCase; in that when I
see "UART1_STATUS" written in code somewhere, I'm going to
assume it is a macro and not a variable.

Also, since this is a register map, it would probably be better to
explicitly specify/use the actual register size u32 or whatever
instead of "int'.

> +
> +	int Int_Stat_3;     /* 0x282800    0xA02800 */
> +	int Int_Stat_2;     /* 0x282804    0xA02804 */
> +	int Int_Stat_1;     /* 0x282808    0xA02808 */
> +	int Int_Stat_0;     /* 0x28280c    0xA0280c */
> +	int Int_Config;     /* 0x282810    0xA02810 */
> +	int Int_Int_Scan;   /* 0x282818    0xA02818 */
> +	int Ien_Int_3;      /* 0x282830    0xA02830 */
> +	int Ien_Int_2;      /* 0x282834    0xA02834 */
> +	int Ien_Int_1;      /* 0x282838    0xA02838 */
> +	int Ien_Int_0;      /* 0x28283c    0xA0283c */
> +	int Int_Level_3_3;      /* 0x282880    0xA02880 */
> +	int Int_Level_3_2;      /* 0x282884    0xA02884 */
> +	int Int_Level_3_1;      /* 0x282888    0xA02888 */
> +	int Int_Level_3_0;      /* 0x28288c    0xA0288c */
> +	int Int_Level_2_3;      /* 0x282890    0xA02890 */
> +	int Int_Level_2_2;      /* 0x282894    0xA02894 */
> +	int Int_Level_2_1;      /* 0x282898    0xA02898 */
> +	int Int_Level_2_0;      /* 0x28289c    0xA0289c */
> +	int Int_Level_1_3;      /* 0x2828a0    0xA028a0 */
> +	int Int_Level_1_2;      /* 0x2828a4    0xA028a4 */
> +	int Int_Level_1_1;      /* 0x2828a8    0xA028a8 */
> +	int Int_Level_1_0;      /* 0x2828ac    0xA028ac */
> +	int Int_Level_0_3;      /* 0x2828b0    0xA028b0 */
> +	int Int_Level_0_2;      /* 0x2828b4    0xA028b4 */
> +	int Int_Level_0_1;      /* 0x2828b8    0xA028b8 */
> +	int Int_Level_0_0;      /* 0x2828bc    0xA028bc */
> +	int Int_Docsis_En;      /* 0x2828F4    0xA028F4 */
> +
> +	int MIPS_PLL_SETUP;     /* 0x1a0000    0x980000 */
> +	int USB_FS;         /* 0x1a0018    0x980030 */
> +	int Test_Bus;       /* 0x1a0238    0x9800CC */
> +	int USB2_OHCI_IntMask;  /* 0x1e000c    0x9A000c */
> +	int USB2_Strap;     /* 0x1e0014    0x9A0014 */
>   

Whitespace in this section seems mangled; best to have it all use
hard tabs probably.

> +	int EHCI_HCAPBASE;         /* 0x1FFE00    0x9BFE00 */
> +	int OHCI_HcRevision;       /* 0x1FFC00    0x9BFC00 */
> +	int BCM1_BS_LMI_STEER;     /* 0x2C0008    0x9E0004 */
> +	int USB2_Control;          /* 0x2c01a0    0x9E0054 */
> +	int USB2_STBUS_OBC;        /* 0x1FFF00    0x9BFF00 */
> +	int USB2_STBUS_MESS_SIZE;  /* 0x1FFF04    0x9BFF04 */
> +	int USB2_STBUS_CHUNK_SIZE; /* 0x1FFF08    0x9BFF08 */
> +
> +	int PCIe_Regs;      /* 0x200000    0x000000 */
> +	int Free_Running_Ctr_Hi;    /* 0x282C10    0xA02C10 */
> +	int Free_Running_Ctr_Lo;    /* 0x282C14    0xA02C14 */
> +	int GPIO_DOUT;      /* 0x282c20    0xA02c20 */
> +	int GPIO_DIN;       /* 0x282c24    0xA02c24 */
> +	int GPIO_DIR;       /* 0x282c2c    0xA02c2c */
> +	int Watchdog;       /* 0x282c30    0xA02c30 */
> +	int Front_Panel;        /* 0x283800    0x000000 */
> +
> +	int REGISTER_MAPS;
> +};
> +
> +extern enum tAsicType        gAsic;
> +extern const struct tRegisterMap   *gRegisterMap;
> +extern unsigned long        gAsicPhyBase;   /* Physical address of ASIC */
> +extern unsigned long        pAsicBase;  /* Virtual address of ASIC */
>   

Again, cosmetic, but it makes for better readability if you choose a style
and stick with it.   I'd not put tabs between the types and the variable
names, but tab aligning the comments is common.

> +
> +/*
> + * Macros to interface to registers through their ioremapped address
> + * asic_reg_offset	Returns the offset of a given register from the start
> + *			of the ASIC address space
> + * asic_reg_phys_addr	Returns the physical address of the given register
> + * asic_reg_addr	Returns the iomapped virtual address of the given
> + *			register.
> + */
> +#define asic_reg_offset(x)  (gRegisterMap->x)
> +#define asic_reg_phys_addr(x)   (gAsicPhyBase + asic_reg_offset(x))
> +#define asic_reg_addr(x)    ((unsigned int *) (pAsicBase + asic_reg_offset(x)))
>   

Semi random whitespace usage in these three lines too.

> +
> +/*
> + * The asic_reg macro is gone. It should be replaced by either asic_read or
> + * asic_write, as appropriate.
> + */
> +
> +#define	asic_read(x)		_asic_read(asic_reg_addr(x))
> +#define	asic_write(v, x)	_asic_write(v, asic_reg_addr(x))
>   

Same for macros, I think you'll find mostly no tabs between the
define and the name in existing kernel code, if you are aiming
for consistency

> +
> +static inline unsigned int _asic_read(unsigned int *addr)
> +{
> +	return readl(addr);
> +}
> +
> +static inline void _asic_write(unsigned int value, unsigned int *addr)
> +{
> +	writel(value, addr);
> +}
>   

if the asic_read and write ops will never need some sort of wrapper, then
why the asic_read --> _asic_read --> readl  indirection?   Sure, the 
compiler
will probably clean it up in the generated code, but if it isn't used....

> +
> +extern void asic_irq_init(void);
> +#endif
> diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
> new file mode 100644
> index 0000000..b39f945
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
> @@ -0,0 +1,123 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>   

You probably want to stick your name/copyright in here, and then...

> + *
> + * Version from mach-generic modified to support PowerTV port
>   

..a comment here like  "Original generic version was"

> + *
> + * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
>   

...otherwise it kind of appears like Ralf made *this file* back in
2006.

> + *
> + */
> +#ifndef __ASM_MACH_GENERIC_DMA_COHERENCE_H
> +#define __ASM_MACH_GENERIC_DMA_COHERENCE_H
>   

not MACH_GENERIC anymore, but MACH_POWERTV

> +
> +#include <linux/sched.h>
> +#include <linux/version.h>
> +#include <asm/mach-powertv/asic.h>
> +
> +struct device;
>   

Probably should just go and suck in the proper include header for
struct device rather than do that.

> +
> +
> +static inline bool is_kseg2(void *addr)
> +{
> +	return (unsigned long)addr >= KSEG2;
> +}
> +
> +static inline unsigned long virt_to_phys_from_pte(void *addr)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *ptep, pte;
> +
> +	unsigned long virt_addr = (unsigned long)addr;
> +	unsigned long phys_addr = 0UL;
> +
> +	/* get the page global directory. */
> +	pgd = pgd_offset_k(virt_addr);
> +
> +	if (!pgd_none(*pgd)) {
> +		/* get the page upper directory */
> +		pud = pud_offset(pgd, virt_addr);
> +		if (!pud_none(*pud)) {
> +			/* get the page middle directory */
> +			pmd = pmd_offset(pud, virt_addr);
> +			if (!pmd_none(*pmd)) {
> +				/* get a pointer to the page table entry */
> +				ptep = pte_offset(pmd, virt_addr);
> +				pte = *ptep;
> +				/* check for a valid page */
> +				if (pte_present(pte)) {
> +					/* get the physical address the page is
> +					 * refering to */
> +					phys_addr = (unsigned long)
> +						page_to_phys(pte_page(pte));
> +					/* add the offset within the page */
> +					phys_addr |= (virt_addr & ~PAGE_MASK);
> +				}
> +			}
> +		}
> +	}
>   

I'm not sure why something like the above (which doesn't really
appear board specific in any way) needs to be in a board specific
file.  Maybe some comments about what is going on and what
the board requirements are would help here.  If nothing else,
it might help people better in the know to suggest an alternate
solution using existing kernel functionality.

> +
> +	return phys_addr;
> +}
> +
> +static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
> +	size_t size)
> +{
> +	if (is_kseg2(addr))
> +		return phys_to_bus(virt_to_phys_from_pte(addr));
> +	else
> +		return phys_to_bus(virt_to_phys(addr));
> +}
> +
> +static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
> +	struct page *page)
> +{
> +	return phys_to_bus(page_to_phys(page));
> +}
> +
> +static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
> +{
> +	return bus_to_phys(dma_addr);
> +}
> +
> +static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
> +{
> +}
> +
> +static inline int plat_dma_supported(struct device *dev, u64 mask)
> +{
> +	/*
> +	 * we fall back to GFP_DMA when the mask isn't all 1s,
> +	 * so we can't guarantee allocations that must be
> +	 * within a tighter range than GFP_DMA..
> +	 */
> +	if (mask < DMA_BIT_MASK(24))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static inline void plat_extra_sync_for_device(struct device *dev)
> +{
> +	return;
> +}
> +
> +static inline int plat_dma_mapping_error(struct device *dev,
> +					 dma_addr_t dma_addr)
> +{
> +	return 0;
> +}
> +
> +static inline int plat_device_is_coherent(struct device *dev)
> +{
> +#ifdef CONFIG_DMA_COHERENT
> +	return 1;
> +#endif
> +#ifdef CONFIG_DMA_NONCOHERENT
> +	return 0;
> +#endif
> +}
> +
> +#endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
>   

Fix this one too (!GENERIC anymore)

> diff --git a/arch/mips/include/asm/mach-powertv/interrupts.h b/arch/mips/include/asm/mach-powertv/interrupts.h
> new file mode 100644
> index 0000000..c37df64
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-powertv/interrupts.h
> @@ -0,0 +1,234 @@
> +#ifndef	_INTERRUPTS_H_
> +#define	_INTERRUPTS_H_
>   

_MACH_POWERTV_

> +
> +
> +/*************************************************************
> + * \brief Defines for all of the interrupt lines
> + *************************************************************/
>   

The /**** may break kerneldoc ; it looks for /** to start embedded self
documentation; also the \brief or any other similar tagging specific to
something not used in the base kernel tree would have to go.

> +
> +#define kIBase 0
>   

Is this always zero? (I'll probably see myself later in the code).  But
maybe it is cleaner to just list the offsets here, and then add in the
kibase to the offset in the few places it is used (vs. the hundreds
of listings of it below).  Oh, and if the "k" is a magic prefix with no
external meaning, it should again go.

> +
> +/*------------- Register: Int_Stat_3 */
> +/* 126 unused (bit 31) */
> +#define kIrq_ASC2Video		(kIBase+126)	/* ASC 2 Video Interrupt */
> +#define kIrq_ASC1Video		(kIBase+125)	/* ASC 1 Video Interrupt */
> +#define kIrq_COMMS_BlockWd	(kIBase+124)	/* ASC 1 Video Interrupt */
> +#define kIrq_FDMA_Mailbox	(kIBase+123)	/* FDMA Mailbox Output */
> +#define kIrq_FDMA_GP		(kIBase+122)	/* FDMA GP Output */
> +#define kIrq_MipsPIC		(kIBase+121)	/* MIPS Performance Counter
> +						 * Interrupt */
> +#define kIrq_MipsTimer		(kIBase+120)	/* MIPS Timer Interrupt */
> +#define kIrq_Memory_Protect	(kIBase+119)	/* Memory Protection Interrupt
> +						 * -- Ored by glue logic inside
> +						 *  SPARC ILC (see
> +						 *  INT_MEM_PROT_STAT, below,
> +						 *  for individual interrupts)
> +						 */
> +/* 118 unused (bit 22) */
> +#define kIrq_SBAG		(kIBase+117)	/* SBAG Interrupt -- Ored by
> +						 * glue logic inside SPARC ILC
> +						 * (see INT_SBAG_STAT, below,
> +						 * for individual interrupts) */
> +#define kIrq_QamB_FEC		(kIBase+116)	/* QAM  B FEC Interrupt */
> +#define kIrq_QamA_FEC		(kIBase+115)	/* QAM A FEC Interrupt */
> +/* 114 unused 	(bit 18) */
> +#define kIrq_Mailbox		(kIBase+113)	/* Mailbox Debug Interrupt  --
> +						 * Ored by glue logic inside
> +						 * SPARC ILC (see
> +						 * INT_MAILBOX_STAT, below, for
> +						 * individual interrupts) */
> +#define kIrq_FuseStat1		(kIBase+112)	/* Fuse Status 1 */
> +#define kIrq_FuseStat2		(kIBase+111)	/* Fuse Status 2 */
> +#define kIrq_FuseStat3		(kIBase+110)	/* Blitter Interrupt / Fuse
> +						 * Status 3 */
> +#define kIrq_Blitter		(kIBase+110)	/* Blitter Interrupt / Fuse
> +						 * Status 3 */
> +#define kIrq_AVC1_PP0		(kIBase+109)	/* AVC Decoder #1 PP0
> +						 * Interrupt */
> +#define kIrq_AVC1_PP1		(kIBase+108)	/* AVC Decoder #1 PP1
> +						 * Interrupt */
> +#define kIrq_AVC1_MBE		(kIBase+107)	/* AVC Decoder #1 MBE
> +						 * Interrupt */
> +#define kIrq_AVC2_PP0		(kIBase+106)	/* AVC Decoder #2 PP0
> +						 * Interrupt */
> +#define kIrq_AVC2_PP1		(kIBase+105)	/* AVC Decoder #2 PP1
> +						 * Interrupt */
> +#define kIrq_AVC2_MBE		(kIBase+104)	/* AVC Decoder #2 MBE
> +						 * Interrupt */
> +#define kIrq_ZbugSpi		(kIBase+103)	/* Zbug SPI Slave Interrupt */
> +#define kIrq_QAM_MOD2		(kIBase+102)	/* QAM Modulator 2 DMA
> +						 * Interrupt */
> +#define kIrq_IrRx		(kIBase+101)	/* IR RX 2 Interrupt */
> +#define kIrq_AudDsp2		(kIBase+100)	/* Audio DSP #2 Interrupt */
> +#define kIrq_AudDsp1		(kIBase+99)	/* Audio DSP #1 Interrupt */
> +#define kIrq_Docsis		(kIBase+98)	/* DOCSIS Debug Interrupt */
> +#define kIrq_SdDVP1		(kIBase+97)	/* SD DVP #1 Interrupt */
> +#define kIrq_SdDVP2		(kIBase+96)	/* SD DVP #2 Interrupt */
> +/*------------- Register: Int_Stat_2 */
> +#define kIrq_HdDVP		(kIBase+95)	/* HD DVP Interrupt */
> +#define kIrq_PreWatchdog	(kIBase+94)	/* Watchdog Pre-Interrupt */
> +#define kIrq_Timer2		(kIBase+93)	/* Programmable Timer
> +						 * Interrupt 2 */
> +#define kIrq_1394		(kIBase+92)	/* 1394 Firewire Interrupt */
> +#define kIrq_USBOHCI		(kIBase+91)	/* USB 2.0 OHCI Interrupt */
> +#define kIrq_USBEHCI		(kIBase+90)	/* USB 2.0 EHCI Interrupt */
> +#define kIrq_PCIExp		(kIBase+89)	/* PCI Express 0 Interrupt */
> +#define kIrq_PCIExp0		(kIBase+89)	/* PCI Express 0 Interrupt */
> +#define kIrq_AFE1		(kIBase+88)	/* AFE 1 Interrupt */
> +#define kIrq_SATA		(kIBase+87)	/* SATA 1 Interrupt */
> +#define kIrq_SATA1		(kIBase+87)	/* SATA 1 Interrupt */
> +#define kIrq_DTCP		(kIBase+86)	/* DTCP Interrupt */
> +#define kIrq_PCIExp1		(kIBase+85)	/* PCI Express 1 Interrupt */
> +/* 84 unused 	(bit 20) */
> +/* 83 unused 	(bit 19) */
> +/* 82 unused 	(bit 18) */
>   

I'm somewhat confused by the "bit" references in all the
unused ones.  In fact, if the int_stat registers are all independent,
then why are they not listed in independent groups of 32 instead
of one large linearly ascending list?


> +#define kIrq_SATA2		(kIBase+81)	/* SATA2 Interrupt */
> +#define kIrq_Uart2		(kIBase+80)	/* UART2 Interrupt */
> +#define kIrq_LegacyUSB		(kIBase+79)	/* Legacy USB Host ISR (1.1
> +						 * Host module) */
> +#define kIrq_POD		(kIBase+78)	/* POD Interrupt */
> +#define kIrq_SlaveUSB		(kIBase+77)	/* Slave USB */
> +#define kIrq_Denc1		(kIBase+76)	/* DENC #1 VTG Interrupt */
> +#define kIrq_VbiVTG		(kIBase+75)	/* VBI VTG Interrupt */
> +#define kIrq_AFE2		(kIBase+74)	/* AFE 2 Interrupt */
> +#define kIrq_Denc2		(kIBase+73)	/* DENC #2 VTG Interrupt */
> +#define kIrq_ASC2		(kIBase+72)	/* ASC #2 Interrupt */
> +#define kIrq_ASC1		(kIBase+71)	/* ASC #1 Interrupt */
> +#define kIrq_ModDMA		(kIBase+70)	/* Modulator DMA Interrupt */
> +#define kIrq_ByteEng1		(kIBase+69)	/* Byte Engine Interrupt [1] */
> +#define kIrq_ByteEng0		(kIBase+68)	/* Byte Engine Interrupt [0] */
> +/* 67 unused 	(bit 03) */
> +/* 66 unused 	(bit 02) */
> +/* 65 unused 	(bit 01) */
> +/* 64 unused 	(bit 00) */
> +/*------------- Register: Int_Stat_1 */
> +/* 63 unused 	(bit 31) */
> +/* 62 unused 	(bit 30) */
> +/* 61 unused 	(bit 29) */
> +/* 60 unused 	(bit 28) */
> +/* 59 unused 	(bit 27) */
> +/* 58 unused 	(bit 26) */
> +/* 57 unused 	(bit 25) */
> +/* 56 unused 	(bit 24) */
>   

Something happened from here down; the whitespace went all to hell.
I think the variable names became longer than the initial indent...

> +#define kIrq_BufDMA_Mem2Mem	(kIBase+55)	/* BufDMA Memory to Memory
> +						 * Interrupt */
> +#define kIrq_BufDMA_USBTransmit	(kIBase+54)	/* BufDMA USB Transmit
> +						 * Interrupt */
> +#define kIrq_BufDMA_QPSKPODTransmit (kIBase+53)	/* BufDMA QPSK/POD Tramsit
> +						 * Interrupt */
> +#define kIrq_BufDMA_TransmitError (kIBase+52)	/* BufDMA Transmit Error
> +						 * Interrupt */
> +#define kIrq_BufDMA_USBRecv	(kIBase+51)	/* BufDMA USB Receive
> +						 * Interrupt */
> +#define kIrq_BufDMA_QPSKPODRecv	(kIBase+50)	/* BufDMA QPSK/POD Receive
> +						 * Interrupt */
> +#define kIrq_BufDMA_RecvError	(kIBase+49)	/* BufDMA Receive Error
> +						 * Interrupt */
> +#define kIrq_QAMDMA_TransmitPlay (kIBase+48)	/* QAMDMA Transmit/Play
> +						 * Interrupt */
> +#define kIrq_QAMDMA_TransmitError (kIBase+47)	/* QAMDMA Transmit Error
> +						 * Interrupt */
> +#define kIrq_QAMDMA_Recv2High	(kIBase+46)	/* QAMDMA Receive 2 High
> +						 * (Chans 63-32) */
> +#define kIrq_QAMDMA_Recv2Low	(kIBase+45)	/* QAMDMA Receive 2 Low
> +						 * (Chans 31-0) */
> +#define kIrq_QAMDMA_Recv1High	(kIBase+44)	/* QAMDMA Receive 1 High
> +						 * (Chans 63-32) */
> +#define kIrq_QAMDMA_Recv1Low	(kIBase+43)	/* QAMDMA Receive 1 Low
> +						 * (Chans 31-0) */
> +#define kIrq_QAMDMA_RecvError	(kIBase+42)	/* QAMDMA Receive Error
> +						 * Interrupt */
> +#define kIrq_MPEGSplice		(kIBase+41)	/* MPEG Splice Interrupt */
> +#define kIrq_DeinterlaceRdy	(kIBase+40)	/* Deinterlacer Frame Ready
> +						 * Interrupt */
> +#define kIrq_ExtIn0		(kIBase+39)	/* External Interrupt irq_in0 */
> +#define kIrq_Gpio3		(kIBase+38)	/* GP I/O IRQ 3 - From GP I/O
> +						 * Module */
> +#define kIrq_Gpio2		(kIBase+37)	/* GP I/O IRQ 2 - From GP I/O
> +						 * Module (ABE_intN) */
> +#define kIrq_PCRCmplt1		(kIBase+36)	/* PCR Capture Complete  or
> +						 * Discontinuity 1 */
> +#define kIrq_PCRCmplt2		(kIBase+35)	/* PCR Capture Complete or
> +						 * Discontinuity 2 */
> +#define kIrq_ParsePEIErr	(kIBase+34)	/* PID Parser Error Detect
> +						 * (PEI) */
> +#define kIrq_ParseContErr	(kIBase+33)	/* PID Parser continuity error
> +						 * detect */
> +#define kIrq_DS1Framer		(kIBase+32)	/* DS1 Framer Interrupt */
> +/*------------- Register: Int_Stat_0 */
> +#define kIrq_Gpio1		(kIBase+31)	/* GP I/O IRQ 1 - From GP I/O
> +						 * Module */
> +#define kIrq_Gpio0		(kIBase+30)	/* GP I/O IRQ 0 - From GP I/O
> +						 * Module */
> +#define kIrq_QpskOutAloha	(kIBase+29)	/* QPSK Output Slotted Aloha
> +						 * (chan 3) Transmission
> +						 * Completed OK */
> +#define kIrq_QpskOutTdma	(kIBase+28)	/* QPSK Output TDMA (chan 2)
> +						 * Transmission Completed OK */
> +#define kIrq_QpskOutReserve	(kIBase+27)	/* QPSK Output Reservation
> +						 * (chan 1) Transmission
> +						 * Completed OK */
> +#define kIrq_QpskOutAlohaErr	(kIBase+26)	/* QPSK Output Slotted Aloha
> +						 * (chan 3)Transmission
> +						 * completed with Errors. */
> +#define kIrq_QpskOutTdmaErr	(kIBase+25)	/* QPSK Output TDMA (chan 2)
> +						 * Transmission completed with
> +						 * Errors. */
> +#define kIrq_QpskOutRsrvErr	(kIBase+24)	/* QPSK Output Reservation
> +						 * (chan 1) Transmission
> +						 * completed with Errors */
> +#define kIrq_AlohaFail		(kIBase+23)	/* Unsuccessful Resend of Aloha
> +						 * for N times. Aloha retry
> +						 * timeout for channel 3. */
> +#define kIrq_Timer1		(kIBase+22)	/* Programmable Timer
> +						 * Interrupt */
> +#define kIrq_Keyboard		(kIBase+21)	/* Keyboard Module Interrupt */
> +#define kIrq_I2c		(kIBase+20)	/* I2C Module Interrupt */
> +#define kIrq_Spi		(kIBase+19)	/* SPI Module Interrupt */
> +#define kIrq_IRBlaster		(kIBase+18)	/* IR Blaster Interrupt */
> +#define kIrq_SpliceDetect	(kIBase+17)	/* PID Key Change Interrupt or
> +						 * Splice Detect Interrupt */
> +#define kIrq_SeMicro		(kIBase+16)	/* Secure Micro I/F Module
> +						 * Interrupt */
> +#define kIrq_Uart1		(kIBase+15)	/* UART Interrupt */
> +#define kIrq_IRrecv		(kIBase+14)	/* IR Receiver Interrupt */
> +#define kIrq_HostInt1		(kIBase+13)	/* Host-to-Host Interrupt 1 */
> +#define kIrq_HostInt0		(kIBase+12)	/* Host-to-Host Interrupt 0 */
> +#define kIrq_QpskHECErr		(kIBase+11)	/* QPSK HEC Error Interrupt */
> +#define kIrq_QpskCRCErr		(kIBase+10)	/* QPSK AAL-5 CRC Error
> +						 * Interrupt */
> +/* 9 unused 	(bit 09) */
> +/* 8 unused 	(bit 08) */
> +#define kIrq_PSICRCErr		(kIBase+7) 	/* QAM PSI CRC Error
> +						 * Interrupt */
> +#define kIrq_PSILengthErr	(kIBase+6) 	/* QAM PSI Length Error
> +						 * Interrupt */
> +#define kIrq_ESFForward		(kIBase+5) 	/* ESF Interrupt Mark From
> +						 * Forward Path Reference -
> +						 * every 3ms when forward Mbits
> +						 * and forward slot control
> +						 * bytes are updated. */
> +#define kIrq_ESFReverse		(kIBase+4) 	/* ESF Interrupt Mark from
> +						 * Reverse Path Reference -
> +						 * delayed from forward mark by
> +						 * the ranging delay plus a
> +						 * fixed amount. When reverse
> +						 * Mbits and reverse slot
> +						 * control bytes are updated.
> +						 * Occurs every 3ms for 3.0M and
> +						 * 1.554 M upstream rates and
> +						 * every 6 ms for 256K upstream
> +						 * rate. */
> +#define kIrq_AlohaTimeout	(kIBase+3) 	/* Slotted-Aloha timeout on
> +						 * Channel 1. */
> +#define kIrq_Reservation	(kIBase+2) 	/* Partial (or Incremental)
> +						 * Reservation Message Completed
> +						 * or Slotted aloha verify for
> +						 * channel 1. */
> +#define kIrq_Aloha3		(kIBase+1) 	/* Slotted-Aloha Message Verify
> +						 * Interrupt or Reservation
> +						 * increment completed for
> +						 * channel 3. */
> +#define kIrq_MpegD		(kIBase+0) 	/* MPEG Decoder Interrupt */
> +#endif	/* _INTERRUPTS_H_ */
>   

MACH_POWERTV

> +
> diff --git a/arch/mips/include/asm/mach-powertv/war.h b/arch/mips/include/asm/mach-powertv/war.h
> new file mode 100644
> index 0000000..2f4a155
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-powertv/war.h
> @@ -0,0 +1,27 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
>   

Similar here as above, add your name in and distinguish it from the
original.

> + * This version for the PowerTV platform copied from the Malta version.
> + *
> + * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
> + */
> +#ifndef __ASM_MIPS_MACH_MIPS_WAR_H
> +#define __ASM_MIPS_MACH_MIPS_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR	0
> +#define R4600_V1_HIT_CACHEOP_WAR	0
> +#define R4600_V2_HIT_CACHEOP_WAR	0
> +#define R5432_CP0_INTERRUPT_WAR		0
> +#define BCM1250_M3_WAR			0
> +#define SIBYTE_1956_WAR			0
> +#define MIPS4K_ICACHE_REFILL_WAR	1
> +#define MIPS_CACHE_SYNC_WAR		1
> +#define TX49XX_ICACHE_INDEX_INV_WAR	0
> +#define RM9000_CDEX_SMP_WAR		0
> +#define ICACHE_REFILLS_WORKAROUND_WAR	1
> +#define R10000_LLSC_WAR			0
> +#define MIPS34K_MISSED_ITLB_WAR		0
> +
> +#endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
> diff --git a/arch/mips/powertv/Kconfig b/arch/mips/powertv/Kconfig
> new file mode 100644
> index 0000000..ada1732
> --- /dev/null
> +++ b/arch/mips/powertv/Kconfig
> @@ -0,0 +1,17 @@
> +source "arch/mips/powertv/asic/Kconfig"
> +
> +config BOOTLOADER_DRIVER
> +	bool "PowerTV Bootloader Driver Support"
> +	default n
> +	depends on POWERTV
> +	help
> +	  Use this option if you want to load bootloader driver.
> +
> +config BOOTLOADER_FAMILY
> +	string "POWERTV Bootloader Family string"
> +	default "85"
> +	depends on POWERTV && !BOOTLOADER_DRIVER
> +	help
> +	  This value should be specified when the bootloader driver is disabled
> +	  and must be exactly two characters long.
>   

Neither of these descriptions lend any useful information to
an end user who doesn't know intimate details of the platform.

> +
> diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
> new file mode 100644
> index 0000000..87886e0
> --- /dev/null
> +++ b/arch/mips/powertv/Makefile
> @@ -0,0 +1,37 @@
> +#
> +# Carsten Langgaard, carstenl@mips.com
> +# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
>   

Similar comment here; stick your name in and give reference to
the original source -- vs. inadvertently making it look like the
original authors wrote your file.

> +#
> +# Carsten Langgaard, carstenl@mips.com
> +# Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
> +#
> +# This program is free software; you can distribute it and/or modify it
> +# under the terms of the GNU General Public License (Version 2) as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> +#
> +# Makefile for the MIPS Malta specific kernel interface routines
> +# under Linux.
>   

Not malta anymore.

> +#
> +
> +obj-y	:=
> +
> +obj-$(CONFIG_POWERTV)	+=	cmdline.o \
> +				init.o \
> +				memory.o \
> +				reset.o \
> +				time.o \
> +				powertv_setup.o \
> +				asic/ \
> +				pci/
> +
> +obj-$(CONFIG_CEVT_POWERTV)	+=	cevt-powertv.o
> +obj-$(CONFIG_CSRC_POWERTV)	+=	csrc-powertv.o
> diff --git a/arch/mips/powertv/asic/Kconfig b/arch/mips/powertv/asic/Kconfig
> new file mode 100644
> index 0000000..48b85ea
> --- /dev/null
> +++ b/arch/mips/powertv/asic/Kconfig
> @@ -0,0 +1,24 @@
> +config MIN_RUNTIME_RESOURCES
> +	bool "Support for minimum runtime resources"
> +	depends on POWERTV
> +	help
> +	  Enables support for minimizing the number of (SA asic) runtime
> +	  resources that are preallocated by the kernel.
> +
> +config MIN_RUNTIME_DOCSIS
> +	bool "Support for minimum DOCSIS resource"
> +	depends on MIN_RUNTIME_RESOURCES
> +	help
> +	  Enables support for the preallocated DOCSIS resource.
> +
> +config MIN_RUNTIME_PMEM
> +	bool "Support for minimum PMEM resource"
> +	depends on MIN_RUNTIME_RESOURCES
> +	help
> +	  Enables support for the preallocated Memory resource.
>   

PMEM might be a bad name choice; I know it has been used for
"persistent mem" (i.e. preserved across reboots) in the past, etc.

> +
> +config MIN_RUNTIME_TFTP
> +	bool "Support for minimum TFTP resource"
> +	depends on MIN_RUNTIME_RESOURCES
> +	help
> +	  Enables support for the preallocated TFTP resource.
>   

Should any of the above items have defaults specified?  I wouldn't know
what to choose, aside from peeking at the defconfig.

> diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
> new file mode 100644
> index 0000000..52d4336
> --- /dev/null
> +++ b/arch/mips/powertv/asic/Makefile
> @@ -0,0 +1,24 @@
> +# *****************************************************************************
> +#                          Make file for PowerTV Asic related files
> +#
> +# Copyright (C) 2009  Scientific-Atlanta, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +# *****************************************************************************
> +
> +obj-y	:=
> +
> +obj-$(CONFIG_POWERTV)	+=	irq_asic.o asic_devices.o asic_int.o
> diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
> new file mode 100644
> index 0000000..2e67979
> --- /dev/null
> +++ b/arch/mips/powertv/asic/asic_devices.c
> @@ -0,0 +1,2902 @@
> +/****************************************************************************
> + *                   ASIC Device List Intialization
> + *
> + * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + *****************************************************************************
> + *
> + * File Name:    asic_devices.c
> + *
> + * See Also:
> + *
> + * Project:      SA explorer settops
> + *
> + * Compiler:
> + *
> + * Author:       Ken Eppinett
> + *               David Schleef <ds@schleef.org>
> + *
> + * Description:  Defines the platform resources for the SA settop.
> + *
> + * NOTE: The bootloader allocates persistent memory at an address which is
> + * 16 MiB below the end of the highest address in KSEG0. All fixed
> + * address memory reservations must avoid this region.
> + *
> + *****************************************************************************
> + * History:
> + * Rev Level     Date         Name       ECN#      Description
> + *----------------------------------------------------------------------------
> + * 1.0                     Eppinett                initial version
> + ****************************************************************************/
>   

You might want to consider stripping some of the cruft from
these, if you have the flexibility to do so.  Things like the
content free changelog above, or the redundant listing of the
file name, and the empty compiler tag.

> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/resource.h>
> +#include <linux/serial_reg.h>
> +#include <linux/io.h>
> +#include <linux/bootmem.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <asm/page.h>
> +#include <linux/swap.h>
> +#include <linux/highmem.h>
> +
> +#include <asm/mach-powertv/asic.h>
> +#include <asm/mach-powertv/asic_regs.h>
> +#include <asm/mach-powertv/interrupts.h>
> +
> +#ifdef CONFIG_BOOTLOADER_DRIVER
> +#include <asm/mach-powertv/kbldr.h>
> +#endif
> +
> +/******************************************************************************
> + * Forward Prototypes
> + *****************************************************************************/
> +static void pmem_setup_resource(void);
> +
> +/******************************************************************************
> + * Global Variables
> + *****************************************************************************/
> +enum tAsicType gAsic;
>   

The big banner messages for proto and global don't really add
any value -- if you don't need them for consistency with some
internal release, you could consider flushing them.

> +
> +unsigned int        gPlatformFeatures;
> +unsigned int        gPlatformFamily;
> +const struct tRegisterMap  *gRegisterMap;
> +EXPORT_SYMBOL(gRegisterMap);			/* Exported for testing */
> +unsigned long       gAsicPhyBase;
> +unsigned long       pAsicBase;
> +EXPORT_SYMBOL(pAsicBase);			/* Exported for testing */
> +struct resource     *gpResources;
> +static bool usb_configured;
>   

Similar comments, whitespace, and one letter mystery prefixes.

> +
> +/*
> + * Don't recommend to use it directly, it is usually used by kernel internally.
> + * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
> + */
> +unsigned long       gPhysToBusOffset;
> +EXPORT_SYMBOL(gPhysToBusOffset);
>   

If you wipe this out completely and compile, are there any offenders left
that can be easily swung over, thus allowing removal?

> +
> +static const struct tRegisterMap zeus_register_map = {
> +	.EIC_SLOW0_STRT_ADD = 0x000000,
> +	.EIC_CFG_BITS = 0x000038,
> +	.EIC_READY_STATUS = 0x00004c,
> +
> +	.CHIPVER3 = 0x280800,
> +	.CHIPVER2 = 0x280804,
> +	.CHIPVER1 = 0x280808,
> +	.CHIPVER0 = 0x28080c,
> +
> +	/* The registers of IRBlaster */
> +	.UART1_INTSTAT = 0x281800,
> +	.UART1_INTEN = 0x281804,
> +	.UART1_CONFIG1 = 0x281808,
> +	.UART1_CONFIG2 = 0x28180C,
> +	.UART1_DIVISORHI = 0x281810,
> +	.UART1_DIVISORLO = 0x281814,
> +	.UART1_DATA = 0x281818,
> +	.UART1_STATUS = 0x28181C,
>   

These all caps struct fields have to go.  Actually I think that you
might want to look at breaking the registermap struct into smaller
chunks (i.e. ver chunk, uart chunk, int chunk, usb chunk).   That,
and try and reuse what you can across boards by specifying a base
address and then add the offsets -- since at a glance, it appears that
is all that is really changing from one board to the next (the offset).

> +
> +	.Int_Stat_3 = 0x282800,
> +	.Int_Stat_2 = 0x282804,
> +	.Int_Stat_1 = 0x282808,
> +	.Int_Stat_0 = 0x28280c,
> +	.Int_Config = 0x282810,
> +	.Int_Int_Scan = 0x282818,
> +	.Ien_Int_3 = 0x282830,
> +	.Ien_Int_2 = 0x282834,
> +	.Ien_Int_1 = 0x282838,
> +	.Ien_Int_0 = 0x28283c,
> +	.Int_Level_3_3 = 0x282880,
> +	.Int_Level_3_2 = 0x282884,
> +	.Int_Level_3_1 = 0x282888,
> +	.Int_Level_3_0 = 0x28288c,
> +	.Int_Level_2_3 = 0x282890,
> +	.Int_Level_2_2 = 0x282894,
> +	.Int_Level_2_1 = 0x282898,
> +	.Int_Level_2_0 = 0x28289c,
> +	.Int_Level_1_3 = 0x2828a0,
> +	.Int_Level_1_2 = 0x2828a4,
> +	.Int_Level_1_1 = 0x2828a8,
> +	.Int_Level_1_0 = 0x2828ac,
> +	.Int_Level_0_3 = 0x2828b0,
> +	.Int_Level_0_2 = 0x2828b4,
> +	.Int_Level_0_1 = 0x2828b8,
> +	.Int_Level_0_0 = 0x2828bc,
> +	.Int_Docsis_En = 0x2828F4,
> +
> +	.MIPS_PLL_SETUP = 0x1a0000,
> +	.USB_FS = 0x1a0018,
> +	.Test_Bus = 0x1a0238,
> +	.USB2_OHCI_IntMask = 0x1e000c,
> +	.USB2_Strap = 0x1e0014,
> +	.EHCI_HCAPBASE = 0x1FFE00,
> +	.OHCI_HcRevision = 0x1FFC00,
> +	.BCM1_BS_LMI_STEER = 0x2C0008,
> +	.USB2_Control = 0x2c01a0,
> +	.USB2_STBUS_OBC = 0x1FFF00,
> +	.USB2_STBUS_MESS_SIZE = 0x1FFF04,
> +	.USB2_STBUS_CHUNK_SIZE = 0x1FFF08,
> +
> +	.PCIe_Regs = 0x200000,
> +	.Free_Running_Ctr_Hi = 0x282C10,
> +	.Free_Running_Ctr_Lo = 0x282C14,
> +	.GPIO_DOUT = 0x282c20,
> +	.GPIO_DIN = 0x282c24,
> +	.GPIO_DIR = 0x282c2C,
> +	.Watchdog = 0x282c30,
> +	.Front_Panel = 0x283800,
> +};
> +
> +static const struct tRegisterMap calliope_register_map = {
> +	.EIC_SLOW0_STRT_ADD = 0x800000,
> +	.EIC_CFG_BITS = 0x800038,
> +	.EIC_READY_STATUS = 0x80004c,
> +
> +	.CHIPVER3 = 0xA00800,
> +	.CHIPVER2 = 0xA00804,
> +	.CHIPVER1 = 0xA00808,
> +	.CHIPVER0 = 0xA0080c,
> +
> +	/* The registers of IRBlaster */
> +	.UART1_INTSTAT = 0xA01800,
> +	.UART1_INTEN = 0xA01804,
> +	.UART1_CONFIG1 = 0xA01808,
> +	.UART1_CONFIG2 = 0xA0180C,
> +	.UART1_DIVISORHI = 0xA01810,
> +	.UART1_DIVISORLO = 0xA01814,
> +	.UART1_DATA = 0xA01818,
> +	.UART1_STATUS = 0xA0181C,
> +
> +	.Int_Stat_3 = 0xA02800,
> +	.Int_Stat_2 = 0xA02804,
> +	.Int_Stat_1 = 0xA02808,
> +	.Int_Stat_0 = 0xA0280c,
> +	.Int_Config = 0xA02810,
> +	.Int_Int_Scan = 0xA02818,
> +	.Ien_Int_3 = 0xA02830,
> +	.Ien_Int_2 = 0xA02834,
> +	.Ien_Int_1 = 0xA02838,
> +	.Ien_Int_0 = 0xA0283c,
> +	.Int_Level_3_3 = 0xA02880,
> +	.Int_Level_3_2 = 0xA02884,
> +	.Int_Level_3_1 = 0xA02888,
> +	.Int_Level_3_0 = 0xA0288c,
> +	.Int_Level_2_3 = 0xA02890,
> +	.Int_Level_2_2 = 0xA02894,
> +	.Int_Level_2_1 = 0xA02898,
> +	.Int_Level_2_0 = 0xA0289c,
> +	.Int_Level_1_3 = 0xA028a0,
> +	.Int_Level_1_2 = 0xA028a4,
> +	.Int_Level_1_1 = 0xA028a8,
> +	.Int_Level_1_0 = 0xA028ac,
> +	.Int_Level_0_3 = 0xA028b0,
> +	.Int_Level_0_2 = 0xA028b4,
> +	.Int_Level_0_1 = 0xA028b8,
> +	.Int_Level_0_0 = 0xA028bc,
> +	.Int_Docsis_En = 0xA028F4,
> +
> +	.MIPS_PLL_SETUP = 0x980000,
> +	.USB_FS = 0x980030,     	/* -default 72800028- */
> +	.Test_Bus = 0x9800CC,
> +	.USB2_OHCI_IntMask = 0x9A000c,
> +	.USB2_Strap = 0x9A0014,
> +	.EHCI_HCAPBASE = 0x9BFE00,
> +	.OHCI_HcRevision = 0x9BFC00,
> +	.BCM1_BS_LMI_STEER = 0x9E0004,
> +	.USB2_Control = 0x9E0054,
> +	.USB2_STBUS_OBC = 0x9BFF00,
> +	.USB2_STBUS_MESS_SIZE = 0x9BFF04,
> +	.USB2_STBUS_CHUNK_SIZE = 0x9BFF08,
> +
> +	.PCIe_Regs = 0x000000,      	/* -doesn't exist- */
> +	.Free_Running_Ctr_Hi = 0xA02C10,
> +	.Free_Running_Ctr_Lo = 0xA02C14,
> +	.GPIO_DOUT = 0xA02c20,
> +	.GPIO_DIN = 0xA02c24,
> +	.GPIO_DIR = 0xA02c2C,
> +	.Watchdog = 0xA02c30,
> +	.Front_Panel = 0x000000,    	/* -not used- */
> +};
> +
> +static const struct tRegisterMap cronus_register_map = {
> +	.EIC_SLOW0_STRT_ADD = 0x000000,
> +	.EIC_CFG_BITS = 0x000038,
> +	.EIC_READY_STATUS = 0x00004C,
> +
> +	.CHIPVER3 = 0x2A0800,
> +	.CHIPVER2 = 0x2A0804,
> +	.CHIPVER1 = 0x2A0808,
> +	.CHIPVER0 = 0x2A080C,
> +
> +	/* The registers of IRBlaster */
> +	.UART1_INTSTAT = 0x2A1800,
> +	.UART1_INTEN = 0x2A1804,
> +	.UART1_CONFIG1 = 0x2A1808,
> +	.UART1_CONFIG2 = 0x2A180C,
> +	.UART1_DIVISORHI = 0x2A1810,
> +	.UART1_DIVISORLO = 0x2A1814,
> +	.UART1_DATA = 0x2A1818,
> +	.UART1_STATUS = 0x2A181C,
> +
> +	.Int_Stat_3 = 0x2A2800,
> +	.Int_Stat_2 = 0x2A2804,
> +	.Int_Stat_1 = 0x2A2808,
> +	.Int_Stat_0 = 0x2A280C,
> +	.Int_Config = 0x2A2810,
> +	.Int_Int_Scan = 0x2A2818,
> +	.Ien_Int_3 = 0x2A2830,
> +	.Ien_Int_2 = 0x2A2834,
> +	.Ien_Int_1 = 0x2A2838,
> +	.Ien_Int_0 = 0x2A283C,
> +	.Int_Level_3_3 = 0x2A2880,
> +	.Int_Level_3_2 = 0x2A2884,
> +	.Int_Level_3_1 = 0x2A2888,
> +	.Int_Level_3_0 = 0x2A288C,
> +	.Int_Level_2_3 = 0x2A2890,
> +	.Int_Level_2_2 = 0x2A2894,
> +	.Int_Level_2_1 = 0x2A2898,
> +	.Int_Level_2_0 = 0x2A289C,
> +	.Int_Level_1_3 = 0x2A28A0,
> +	.Int_Level_1_2 = 0x2A28A4,
> +	.Int_Level_1_1 = 0x2A28A8,
> +	.Int_Level_1_0 = 0x2A28AC,
> +	.Int_Level_0_3 = 0x2A28B0,
> +	.Int_Level_0_2 = 0x2A28B4,
> +	.Int_Level_0_1 = 0x2A28B8,
> +	.Int_Level_0_0 = 0x2A28BC,
> +	.Int_Docsis_En = 0x2A28F4,
> +
> +	.MIPS_PLL_SETUP = 0x1C0000,
> +	.USB_FS = 0x1C0018,
> +	.Test_Bus = 0x1C00CC,
> +	.USB2_OHCI_IntMask = 0x20000C,
> +	.USB2_Strap = 0x200014,
> +	.EHCI_HCAPBASE = 0x21FE00,
> +	.OHCI_HcRevision = 0x1E0000,
> +	.BCM1_BS_LMI_STEER = 0x2E0008,
> +	.USB2_Control = 0x2E004C,
> +	.USB2_STBUS_OBC = 0x21FF00,
> +	.USB2_STBUS_MESS_SIZE = 0x21FF04,
> +	.USB2_STBUS_CHUNK_SIZE = 0x21FF08,
> +
> +	.PCIe_Regs = 0x220000,
> +	.Free_Running_Ctr_Hi = 0x2A2C10,
> +	.Free_Running_Ctr_Lo = 0x2A2C14,
> +	.GPIO_DOUT = 0x2A2C20,
> +	.GPIO_DIN = 0x2A2C24,
> +	.GPIO_DIR = 0x2A2C2C,
> +	.Watchdog = 0x2A2C30,
> +	.Front_Panel = 0x2A3800,
> +};
>   

Assuming that you can't collapse all of the above by some sort of
sharing and listing of a board specific offset, you might instead
consider adding <boardname>.h which has all the settings instead
of having them cluttering up the main source file.

> +
> +/******************************************************************************
> + * DVR_CAPABLE RESOURCES
> + *****************************************************************************/
> +struct resource dvr_zeus_resources[] =
> +{
>
>   

[...]

> +
> +/******************************************************************************
> + * NON_DVR_CAPABLE ZEUS RESOURCES
> + *****************************************************************************/
> +struct resource non_dvr_zeus_resources[] =
> +{
> +	/**********************************************************************
> +	 * VIDEO1 / LX1
> +	 *********************************************************************/
> +	{
> +		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
> +		.start  = 0x20000000,
> +		.end    = 0x201FFFFF,		/* 2MiB */
> +		.flags  = IORESOURCE_IO,
> +	},
>
>   

[...]

All these resource items might also be good candidates to shuffle off
to a board specific header too.  That would also lend itself better to
being able to select/enable just one of the board variants should you
decide to go that route someday.

> +	/**********************************************************************
> +	 * Add other resources here
> +	 */
> +	/*
> +	 * End of Resource marker
> +	 *********************************************************************/
> +	{
> +		.flags  = 0,
> +	},
> +};
> +
> +
> +/*
> + * NOTES:
> + *
> + * There are two things to be done on CRONUS platforms when we try to reserve
> + * the space of HIGHMEM for a specific device.
> + *
> + * 1. "IORESOURCE_MEM" flag can't be used anymore, it should be changed to
> + *    "IORESOURCE_IO".
> + *
> + * 2. For the kernel with HIGHMEM support, we have to do some work in the
> + *    memory configuration (in memory.c) since we don't make any actual
> + *    reservation which has "IORESOURCE_IO" flag through bootmem allocator.
> + *
> + * TODO: Find a solution to make it working easily.
> + */
> +
> +static struct resource non_dvr_vze_calliope_resources[] __initdata =
> +{
> +	/**********************************************************************
> +	 * VIDEO / LX1
> +	 *********************************************************************/
> +	{
>
>   

[...same with the ~1000 lines that were here...]

Actually these resources might be good candidates in the context of
my earlier comment, about keeping it simple for the initial commit,
i.e. basic serial and ethernet;  leave out all these for the initial board
commits.

> +
> +/*
> + *
> + * IO Resource Definition
> + *
> + */
> +
> +struct resource asic_resource = {
> +	.name  = "ASIC Resource",
> +	.start = 0,
> +	.end   = ASIC_IO_SIZE,
> +	.flags = IORESOURCE_MEM,
> +};
> +
> +/*
> + *
> + * USB Host Resource Definition
> + *
> + */
> +
> +static struct resource ehci_resources[] = {
> +	{
> +		.parent = &asic_resource,
> +		.start  = 0,
> +		.end    = 0xff,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	{
> +		.start  = kIrq_USBEHCI,
> +		.end    = kIrq_USBEHCI,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 ehci_dmamask = 0xffffffffULL;
> +
> +static struct platform_device ehci_device = {
> +	.name = "powertv-ehci",
> +	.id = 0,
> +	.num_resources = 2,
> +	.resource = ehci_resources,
> +	.dev = {
> +		.dma_mask = &ehci_dmamask,
> +		.coherent_dma_mask = 0xffffffff,
> +	},
> +};
> +
> +static struct resource ohci_resources[] = {
> +	{
> +		.parent = &asic_resource,
> +		.start  = 0,
> +		.end    = 0xff,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	{
> +		.start  = kIrq_USBOHCI,
> +		.end    = kIrq_USBOHCI,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 ohci_dmamask = 0xffffffffULL;
> +
> +static struct platform_device ohci_device = {
> +	.name = "powertv-ohci",
> +	.id = 0,
> +	.num_resources = 2,
> +	.resource = ohci_resources,
> +	.dev = {
> +		.dma_mask = &ohci_dmamask,
> +		.coherent_dma_mask = 0xffffffff,
> +	},
> +};
> +
> +static struct platform_device *platform_devices[] = {
> +	&ehci_device,
> +	&ohci_device,
>   

The USB support is probably something you can keep within the
core set of commits, but it could still be a separate commit
within that group if it helps scale down the size of the patch
chunks.
 
> +};
> +
> +/*
> + *
> + * Platform Configuration and Device Initialization
> + *
> + */
> +static void __init fs_update(int pe, int md, int sdiv, int disable_div_by_3)
> +{
> +	int en_prg, byp, pwr, nsb, val;
> +	int sout;
> +
> +	sout = 1;
> +	en_prg = 1;
> +	byp = 0;
> +	nsb = 1;
> +	pwr = 1;
> +
> +	val = ((sdiv << 29) | (md << 24) | (pe<<8) | (sout<<3) | (byp<<2) |
> +		(nsb<<1) | (disable_div_by_3<<5));
>   

Nobody has any hope of knowing what the above does, or if
there is a bug in it.  A platform that is unmaintainable is less
likely to be merged.

> +
> +	asic_write(val, USB_FS);
> +	asic_write(val | (en_prg<<4), USB_FS);
> +	asic_write(val | (en_prg<<4) | pwr, USB_FS);
> +}
> +
> +/*
> + * \brief platform_get_family() determine major platform family type.
> + *
> + * \param     none
> + *
> + * \return    family type; -1 if none
>   

Backslash tags would have to go.

> + *
> + */
> +enum tFamilyType platform_get_family(void)
> +{
> +#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
>   

Group all the defines at the top just after the header includes?

> +
> +	unsigned short bootldrFamily;
> +	static enum tFamilyType family = -1;
> +	static int firstTime = 1;
> +
> +	if (firstTime) {
> +		firstTime = 0;
> +
> +#ifdef CONFIG_BOOTLOADER_DRIVER
> +		bootldrFamily = (unsigned short) kbldr_GetSWFamily();
> +#else
> +#if defined(CONFIG_BOOTLOADER_FAMILY)
> +		bootldrFamily = (unsigned short) BOOTLDRFAMILY(
>   

I'm not sure if checkpatch.pl warns about spaces between casts and
the names they operate on.

> +			CONFIG_BOOTLOADER_FAMILY[0],
> +			CONFIG_BOOTLOADER_FAMILY[1]);
> +#else
> +#error "Unknown Bootloader Family"
> +#endif
> +#endif
> +
> +		pr_info("Bootloader Family = 0x%04X\n", bootldrFamily);
> +
> +		switch (bootldrFamily) {
> +		case BOOTLDRFAMILY('R', '1'):
> +			family = FAMILY_1500;
> +			break;
> +		case BOOTLDRFAMILY('4', '4'):
> +			family = FAMILY_4500;
> +			break;
> +		case BOOTLDRFAMILY('4', '6'):
> +			family = FAMILY_4600;
> +			break;
> +		case BOOTLDRFAMILY('A', '1'):
> +			family = FAMILY_4600VZA;
> +			break;
> +		case BOOTLDRFAMILY('8', '5'):
> +			family = FAMILY_8500;
> +			break;
> +		case BOOTLDRFAMILY('R', '2'):
> +			family = FAMILY_8500RNG;
> +			break;
> +		case BOOTLDRFAMILY('8', '6'):
> +			family = FAMILY_8600;
> +			break;
> +		case BOOTLDRFAMILY('B', '1'):
> +			family = FAMILY_8600VZB;
> +			break;
> +		case BOOTLDRFAMILY('E', '1'):
> +			family = FAMILY_1500VZE;
> +			break;
> +		case BOOTLDRFAMILY('F', '1'):
> +			family = FAMILY_1500VZF;
> +			break;
> +		default:
> +			family = -1;
> +		}
> +	}
> +
> +	return family;
> +
> +#undef BOOTLDRFAMILY
>   

No undef needed.

> +}
> +EXPORT_SYMBOL(platform_get_family);
> +
> +/*
> + * \brief platform_get_asic() determine the ASIC type.
> + *
> + * \param     none
> + *
> + * \return    ASIC type; ASIC_UNKNOWN if none
>   

tags

> + *
> + */
> +enum tAsicType platform_get_asic(void)
> +{
> +	return gAsic;
> +}
> +EXPORT_SYMBOL(platform_get_asic);
> +
> +/*
> + * \brief platform_configure_usb() usb configuration based on platform type.
> + *
> + * \param     int divide_by_3 divide clock setting by 3
> + *
> + * \return    none
>   

More backslash tags.  I'll stop flagging them from here on, you get
the idea by now, I'm sure.

> + *
> + */
> +static void platform_configure_usb(void)
> +{
> +	int divide_by_3;
>   

A little comment on what this magic constant controls would
be a good idea.

> +
> +	if (usb_configured)
> +		return;
> +
> +	switch (gAsic) {
> +	case ASIC_ZEUS:
> +	case ASIC_CRONUS:
> +	case ASIC_CRONUSLITE:
> +		divide_by_3 = 0;
> +		break;
> +
> +	case ASIC_CALLIOPE:
> +		divide_by_3 = 1;
> +		break;
> +
> +	default:
> +		pr_err("Unknown ASIC type: %d\n", gAsic);
> +		divide_by_3 = 0;
> +		break;
> +	}
> +
> +	/* Set up PLL for USB */
> +	fs_update(0x0000, 0x11, 0x02, divide_by_3);
> +	/* turn on USB power */
> +	asic_write(0, USB2_Strap);
> +	/* Enable all OHCI interrupts */
> +	asic_write(0x00000803, USB2_Control);
> +	/* USB2_STBUS_OBC store32/load32 */
> +	asic_write(3, USB2_STBUS_OBC);
> +	/* USB2_STBUS_MESS_SIZE 2 packets */
> +	asic_write(1, USB2_STBUS_MESS_SIZE);
> +	/* USB2_STBUS_CHUNK_SIZE 2 packets */
> +	asic_write(1, USB2_STBUS_CHUNK_SIZE);
> +
> +	usb_configured = true;
> +}
> +
> +/*
> + * Set up the USB EHCI interface
> + */
> +void platform_configure_usb_ehci()
> +{	platform_configure_usb();
> +}
> +
> +/*
> + * Set up the USB OHCI interface
> + */
> +void platform_configure_usb_ohci()
> +{	platform_configure_usb();
> +}
> +
> +/*
> + * Shut the USB EHCI interface down--currently a NOP
> + */
> +void platform_unconfigure_usb_ehci()
> +{
> +}
> +
> +/*
> + * Shut the USB OHCI interface down--currently a NOP
> + */
> +void platform_unconfigure_usb_ohci()
> +{
> +}
> +
> +/*
> + * \brief configure_platform() configuration based on platform type.
> + *
> + * \param     none
> + *
> + * \return    none
> + *
> + */
> +void __init configure_platform(void)
> +{
> +	gPlatformFamily = platform_get_family();
> +
> +	switch (gPlatformFamily) {
> +	case FAMILY_1500:
> +	case FAMILY_1500VZE:
> +	case FAMILY_1500VZF:
> +		gPlatformFeatures = FFS_CAPABLE;
> +		gAsic = ASIC_CALLIOPE;
> +		gAsicPhyBase = CALLIOPE_IO_BASE;
> +		gRegisterMap = &calliope_register_map;
> +		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
> +			ASIC_IO_SIZE);
> +
> +		if (gPlatformFamily == FAMILY_1500VZE) {
> +			gpResources = non_dvr_vze_calliope_resources;
> +			pr_info("Platform: 1500/Vz Class E - "
> +				"CALLIOPE, NON_DVR_CAPABLE\n");
> +		} else if (gPlatformFamily == FAMILY_1500VZF) {
> +			gpResources = non_dvr_vzf_calliope_resources;
> +			pr_info("Platform: 1500/Vz Class F - "
> +				"CALLIOPE, NON_DVR_CAPABLE\n");
> +		} else {
> +			gpResources = non_dvr_calliope_resources;
> +			pr_info("Platform: 1500/RNG100 - CALLIOPE, "
> +				"NON_DVR_CAPABLE\n");
> +		}
> +		break;
> +
> +	case FAMILY_4500:
> +		gPlatformFeatures = FFS_CAPABLE | PCIE_CAPABLE |
> +			DISPLAY_CAPABLE;
> +		gAsic = ASIC_ZEUS;
> +		gAsicPhyBase = ZEUS_IO_BASE;
> +		gRegisterMap = &zeus_register_map;
> +		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
> +			ASIC_IO_SIZE);
> +		gpResources = non_dvr_zeus_resources;
> +
> +		pr_info("Platform: 4500 - ZEUS, NON_DVR_CAPABLE\n");
> +		break;
> +
> +	case FAMILY_4600:
> +	{
> +		unsigned int chipversion = 0;
> +
> +		/* The settop has PCIE but it isn't used, so don't advertise
> +		 * it*/
> +		gPlatformFeatures = FFS_CAPABLE | DISPLAY_CAPABLE;
> +		gAsicPhyBase = CRONUS_IO_BASE;   /* same as Cronus */
> +		gRegisterMap = &cronus_register_map;   /* same as Cronus */
> +		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
> +			ASIC_IO_SIZE);
> +		gpResources = non_dvr_cronuslite_resources;
> +
> +		/* ASIC version will determine if this is a real CronusLite or
> +		 * Castrati(Cronus) */
> +		chipversion  = asic_read(CHIPVER3) << 24;
> +		chipversion |= asic_read(CHIPVER2) << 16;
> +		chipversion |= asic_read(CHIPVER1) << 8;
> +		chipversion |= asic_read(CHIPVER0);
> +
> +		if ((chipversion == CRONUS_10) || (chipversion == CRONUS_11))
> +			gAsic = ASIC_CRONUS;
> +		else
> +			gAsic = ASIC_CRONUSLITE;
> +
> +		pr_info("Platform: 4600 - %s, NON_DVR_CAPABLE, "
> +			"chipversion=0x%08X\n",
> +			(gAsic == ASIC_CRONUS) ? "CRONUS" : "CRONUS LITE",
> +			chipversion);
> +		break;
> +	}
> +	case FAMILY_4600VZA:
> +		gPlatformFeatures = FFS_CAPABLE | DISPLAY_CAPABLE;
> +		gAsic = ASIC_CRONUS;
> +		gAsicPhyBase = CRONUS_IO_BASE;
> +		gRegisterMap = &cronus_register_map;
> +		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
> +			ASIC_IO_SIZE);
> +		gpResources = non_dvr_cronus_resources;
> +
> +		pr_info("Platform: Vz Class A - CRONUS, NON_DVR_CAPABLE\n");
> +		break;
> +
> +	case FAMILY_8500:
> +	case FAMILY_8500RNG:
> +		gPlatformFeatures = DVR_CAPABLE | PCIE_CAPABLE |
> +			DISPLAY_CAPABLE;
> +		gAsic = ASIC_ZEUS;
> +		gAsicPhyBase = ZEUS_IO_BASE;
> +		gRegisterMap = &zeus_register_map;
> +		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
> +			ASIC_IO_SIZE);
> +		gpResources = dvr_zeus_resources;
> +		break;
> +
> +	case FAMILY_8600:
> +	case FAMILY_8600VZB:
> +		gPlatformFeatures = DVR_CAPABLE | PCIE_CAPABLE |
> +			DISPLAY_CAPABLE;
> +		gAsic = ASIC_CRONUS;
> +		gAsicPhyBase = CRONUS_IO_BASE;
> +		gRegisterMap = &cronus_register_map;
> +		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
> +			ASIC_IO_SIZE);
> +		gpResources = dvr_cronus_resources;
> +
> +		pr_info("Platform: 8600/Vz Class B - CRONUS, "
> +			"DVR_CAPABLE\n");
> +		break;
> +
> +	default:
> +		gPlatformFeatures = 0;
> +		gAsic = ASIC_UNKNOWN;
> +		gAsicPhyBase = 0;
> +		gRegisterMap = NULL;
> +		gpResources = NULL;
> +
> +		pr_crit("Platform:  UNKNOWN PLATFORM\n");
> +		break;
> +	}
> +
> +	platform_configure_usb();
> +
> +	switch (gAsic) {
> +	case ASIC_ZEUS:
> +		gPhysToBusOffset = 0x30000000;
> +		break;
> +	case ASIC_CALLIOPE:
> +		gPhysToBusOffset = 0x10000000;
> +		break;
> +	case ASIC_CRONUSLITE:
> +		/* Fall through */
> +	case ASIC_CRONUS:
> +		/*
> +		 * TODO: We suppose 0x10000000 aliases into 0x20000000-
> +		 * 0x2XXXXXXX. If 0x10000000 aliases into 0x60000000-
> +		 * 0x6XXXXXXX, the offset should be 0x50000000, not 0x10000000.
> +		 */
> +		gPhysToBusOffset = 0x10000000;
> +		break;
> +	default:
> +		gPhysToBusOffset = 0x00000000;
> +		break;
> +	}
> +}
> +
> +/*
> + * \brief platform_devices_init() sets up USB device resourse.
> + *
> + * \param     none
> + *
> + * \return    none
> + *
> + */
> +static int __init platform_devices_init(void)
> +{
> +	pr_crit("%s: ----- Initializing USB resources -----\n", __func__);
>   

Presumably pr_crit maps onto KERN_CRIT -- but message is more
informational than critical.

> +
> +	asic_resource.start = gAsicPhyBase;
> +	asic_resource.end += asic_resource.start;
> +
> +	ehci_resources[0].start = asic_reg_phys_addr(EHCI_HCAPBASE);
> +	ehci_resources[0].end += ehci_resources[0].start;
> +
> +	ohci_resources[0].start = asic_reg_phys_addr(OHCI_HcRevision);
> +	ohci_resources[0].end += ohci_resources[0].start;
> +
> +	set_io_port_base(0);
> +
> +	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
> +
> +	return 0;
> +}
> +
> +arch_initcall(platform_devices_init);
> +
> +/*
> + *
> + * BOOTMEM ALLOCATION
> + *
> + */
> +/*
> + * Allocates/reserves the Platform memory resources early in the boot process.
> + * This ignores any resources that are designated IORESOURCE_IO
> + */
> +void __init platform_alloc_bootmem(void)
> +{
> +	int i;
> +	int total = 0;
> +
> +	/* Get persistent memory data from command line before allocating
> +	 * resources. This need to happen before normal command line parsing
> +	 * has been done */
> +	pmem_setup_resource();
> +
> +	/* Loop through looking for resources that want a particular address */
> +	for (i = 0; gpResources[i].flags != 0; i++) {
> +		int size = gpResources[i].end - gpResources[i].start + 1;
> +		if ((gpResources[i].start != 0) &&
> +			((gpResources[i].flags & IORESOURCE_MEM) != 0)) {
> +			reserve_bootmem(bus_to_phys(gpResources[i].start),
> +				size, 0);
> +			total += gpResources[i].end - gpResources[i].start + 1;
> +			pr_info("reserve resource %s at %08x (%u bytes)\n",
> +				gpResources[i].name, gpResources[i].start,
> +				gpResources[i].end - gpResources[i].start + 1);
> +		}
> +	}
> +
> +	/* Loop through assigning addresses for those that are left */
> +	for (i = 0; gpResources[i].flags != 0; i++) {
> +		int size = gpResources[i].end - gpResources[i].start + 1;
> +		if ((gpResources[i].start == 0) &&
> +			((gpResources[i].flags & IORESOURCE_MEM) != 0)) {
> +			void *mem = alloc_bootmem_pages(size);
> +
> +			if (mem == NULL)
> +				pr_err("Unable to allocate bootmem pages "
> +					"for %s\n", gpResources[i].name);
> +
> +			else {
> +				gpResources[i].start =
> +					phys_to_bus(virt_to_phys(mem));
> +				gpResources[i].end =
> +					gpResources[i].start + size - 1;
> +				total += size;
> +				pr_info("allocate resource %s at %08x "
> +						"(%u bytes)\n",
> +					gpResources[i].name,
> +					gpResources[i].start, size);
> +			}
> +		}
> +	}
> +
> +	pr_info("Total Platform driver memory allocation: 0x%08x\n", total);
> +
> +	/* indicate resources that are platform I/O related */
> +	for (i = 0; gpResources[i].flags != 0; i++) {
> +		if ((gpResources[i].start != 0) &&
> +			((gpResources[i].flags & IORESOURCE_IO) != 0)) {
> +			pr_info("reserved platform resource %s at %08x\n",
> +				gpResources[i].name, gpResources[i].start);
> +		}
> +	}
> +}
> +
> +/*
> + *
> + * PERSISTENT MEMORY (PMEM) CONFIGURATION
>   

OK, so PMEM does mean persistent.  I forget what it said that
the "P" was for above...

> + *
> + */
> +static unsigned long pmemaddr __initdata;
> +
> +static int __init early_param_pmemaddr(char *p)
> +{
> +	pmemaddr = (unsigned long)simple_strtoul(p, NULL, 0);
> +	return 0;
> +}
> +early_param("pmemaddr", early_param_pmemaddr);
> +
> +static long pmemlen __initdata;
> +
> +static int __init early_param_pmemlen(char *p)
> +{
> +/* TODO: we can use this code when and if the bootloader ever changes this */
> +#if 0
> +	pmemlen = (unsigned long)simple_strtoul(p, NULL, 0);
> +#else
> +	pmemlen = 0x20000;
> +#endif
> +	return 0;
> +}
> +early_param("pmemlen", early_param_pmemlen);
> +
> +/*
> + * Set up persistent memory. If we were given values, we patch the array of
> + * resources. Otherwise, persistent memory may be allocated anywhere at all.
> + */
> +static void __init pmem_setup_resource(void)
> +{
> +	struct resource *resource;
> +	resource = asic_resource_get("DiagPersistentMemory");
> +
> +	if (resource && pmemaddr && pmemlen) {
> +		/* The address provided by bootloader is in kseg0. Convert to
> +		 * a bus address. */
> +		resource->start = phys_to_bus(pmemaddr - 0x80000000);
> +		resource->end = resource->start + pmemlen - 1;
> +
> +		pr_info("persistent memory: start=0x%x  end=0x%x\n",
> +			resource->start, resource->end);
> +	}
> +}
> +
> +/*
> + *
> + * RESOURCE ACCESS FUNCTIONS
> + *
> + */
> +
> +/*
> + * \brief asic_resource_get() retreives parameters used for allocating
> + * a platform resource.
> + *
> + * \param name - string to match resource
> + *
> + * \return    resource ptr
> + *
> + * CANNOT BE NAMED platform_resource_get is this function name is already
> + * declared
> + */
> +struct resource *asic_resource_get(const char *name)
> +{
> +	int i;
> +
> +	for (i = 0; gpResources[i].flags != 0; i++) {
> +		if (strcmp(gpResources[i].name, name) == 0)
> +			return &gpResources[i];
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(asic_resource_get);
> +
> +/*
> + * \brief platform_release_memory() .
> + *
> + * \param ptr -  pointer to resource
> + * \param size - size of resource
> + *
> + * \return    resource ptr
> + *
> + */
> +void platform_release_memory(void *ptr, int size)
> +{
> +	unsigned long addr;
> +	unsigned long end;
> +
> +	addr = ((unsigned long)ptr + (PAGE_SIZE - 1)) & PAGE_MASK;
> +	end = ((unsigned long)ptr + size) & PAGE_MASK;
> +
> +	for (; addr < end; addr += PAGE_SIZE) {
> +		ClearPageReserved(virt_to_page(__va(addr)));
> +		init_page_count(virt_to_page(__va(addr)));
> +		free_page((unsigned long)__va(addr));
> +	}
> +}
> +EXPORT_SYMBOL(platform_release_memory);
> +
> +/*
> + *
> + * FEATURE AVAILABILITY FUNCTIONS
> + *
> + */
> +int platform_supports_dvr(void)
> +{
> +	return (gPlatformFeatures & DVR_CAPABLE) != 0;
> +}
> +
> +int platform_supports_ffs(void)
> +{
> +	return (gPlatformFeatures & FFS_CAPABLE) != 0;
> +}
> +
> +int platform_supports_pcie(void)
> +{
> +	return (gPlatformFeatures & PCIE_CAPABLE) != 0;
> +}
> +
> +int platform_supports_display(void)
> +{
> +	return (gPlatformFeatures & DISPLAY_CAPABLE) != 0;
> +}
> diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
> new file mode 100644
> index 0000000..94b6ca9
> --- /dev/null
> +++ b/arch/mips/powertv/asic/asic_int.c
> @@ -0,0 +1,146 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
> + * Copyright (C) 2001 Ralf Baechle
>   

I'm guessing the attribution here also needs a cleanup.

> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * Routines for generic manipulation of the interrupts found on the MIPS
> + * Malta board.
> + * The interrupt controller is located in the South Bridge a PIIX4 device
> + * with two internal 82C95 interrupt controllers.
>   

Chances are that this Malta description has no bearing whatsoever
anymore either.

> + */
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/kernel.h>
> +#include <linux/random.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <linux/io.h>
> +#include <asm/irq_regs.h>
> +#include <asm/mips-boards/generic.h>
> +
> +#include <asm/mach-powertv/asic_regs.h>
> +
> +static DEFINE_SPINLOCK(mips_irq_lock);
>   

asic_irq_lock?

> +
> +static inline int get_int(void)
> +{
> +	unsigned long flags;
> +	int irq;
> +
> +	spin_lock_irqsave(&mips_irq_lock, flags);
> +
> +	irq = (asic_read(Int_Int_Scan) >> 4) - 1;
> +
> +	if (irq == 0 || irq >= NR_IRQS)
> +		irq = -1;
> +
> +	spin_unlock_irqrestore(&mips_irq_lock, flags);
> +
> +	return irq;
> +}
> +
> +static void asic_irqdispatch(void)
> +{
> +	int irq;
> +
> +	irq = get_int();
> +	if (irq < 0)
> +		return;  /* interrupt has already been cleared */
> +
> +	do_IRQ(irq);
> +}
> +
> +static inline int clz(unsigned long x)
> +{
> +	__asm__(
> +	"	.set	push					\n"
> +	"	.set	mips32					\n"
> +	"	clz	%0, %1					\n"
> +	"	.set	pop					\n"
> +	: "=r" (x)
> +	: "r" (x));
> +
> +	return x;
> +}
> +
> +/*
> + * Version of ffs that only looks at bits 12..15.
> + */
> +static inline unsigned int irq_ffs(unsigned int pending)
> +{
> +#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
>   

Won't the CPU_MIPS32 always be true, hence making the else
clause just useless dead code?

> +	return -clz(pending) + 31 - CAUSEB_IP;
> +#else
> +	unsigned int a0 = 7;
> +	unsigned int t0;
> +
> +	t0 = pending & 0xf000;
> +	t0 = t0 < 1;
> +	t0 = t0 << 2;
> +	a0 = a0 - t0;
> +	pending = pending << t0;
> +
> +	t0 = pending & 0xc000;
> +	t0 = t0 < 1;
> +	t0 = t0 << 1;
> +	a0 = a0 - t0;
> +	pending = pending << t0;
> +
> +	t0 = pending & 0x8000;
> +	t0 = t0 < 1;
> +	a0 = a0 - t0;
> +
> +	return a0;
> +#endif
> +}
> +
> +/*
> + * TODO: check how it works under EIC mode.
> + */
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
> +	int irq;
> +
> +	irq = irq_ffs(pending);
> +
> +	if (irq == CAUSEF_IP3)
> +		asic_irqdispatch();
> +	else if (irq >= 0)
> +		do_IRQ(irq);
> +	else
> +		spurious_interrupt();
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +	int i;
> +
> +	asic_irq_init();
> +
> +	/*
> +	 * Initialize interrupt exception vectors.
> +	 */
> +	if (cpu_has_veic || cpu_has_vint) {
> +		int nvec = cpu_has_veic ? 64 : 8;
> +		for (i = 0; i < nvec; i++)
> +			set_vi_handler(i, asic_irqdispatch);
> +	}
> +}
> diff --git a/arch/mips/powertv/asic/irq_asic.c b/arch/mips/powertv/asic/irq_asic.c
> new file mode 100644
> index 0000000..693abab
> --- /dev/null
> +++ b/arch/mips/powertv/asic/irq_asic.c
> @@ -0,0 +1,115 @@
> +/*
> + * Copyright (C) 2005 Scientific Atlanta
> + *
> + * Modified from arch/mips/kernel/irq-rm7000.c:
>   

I'd just add "which was" to the end of the above line for clarity.

> + * Copyright (C) 2003 Ralf Baechle
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/mipsregs.h>
> +#include <asm/system.h>
> +
> +#include <asm/mach-powertv/asic_regs.h>
> +
> +static inline void unmask_asic_irq(unsigned int irq)
> +{
> +	unsigned long enable_bit;
> +
> +	enable_bit = (1 << (irq & 0x1f));
> +
> +	switch (irq >> 5) {
> +	case 0:
> +		asic_write(asic_read(Ien_Int_0) | enable_bit, Ien_Int_0);
> +		break;
> +	case 1:
> +		asic_write(asic_read(Ien_Int_1) | enable_bit, Ien_Int_1);
> +		break;
> +	case 2:
> +		asic_write(asic_read(Ien_Int_2) | enable_bit, Ien_Int_2);
> +		break;
> +	case 3:
> +		asic_write(asic_read(Ien_Int_3) | enable_bit, Ien_Int_3);
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +
> +static inline void mask_asic_irq(unsigned int irq)
> +{
> +	unsigned long disable_mask;
> +
> +	disable_mask = ~(1 << (irq & 0x1f));
> +
> +	switch (irq >> 5) {
> +	case 0:
> +		asic_write(asic_read(Ien_Int_0) & disable_mask, Ien_Int_0);
> +		break;
> +	case 1:
> +		asic_write(asic_read(Ien_Int_1) & disable_mask, Ien_Int_1);
> +		break;
> +	case 2:
> +		asic_write(asic_read(Ien_Int_2) & disable_mask, Ien_Int_2);
> +		break;
> +	case 3:
> +		asic_write(asic_read(Ien_Int_3) & disable_mask, Ien_Int_3);
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +
> +static struct irq_chip asic_irq_chip = {
> +	.name = "ASIC Level",
> +	.ack = mask_asic_irq,
> +	.mask = mask_asic_irq,
> +	.mask_ack = mask_asic_irq,
> +	.unmask = unmask_asic_irq,
> +	.eoi = unmask_asic_irq,
> +};
> +
> +void __init asic_irq_init(void)
> +{
> +	int i;
> +
> +	/* set priority to 0 */
> +	write_c0_status(read_c0_status() & ~(0x0000fc00));
> +
> +	asic_write(0, Ien_Int_0);
> +	asic_write(0, Ien_Int_1);
> +	asic_write(0, Ien_Int_2);
> +	asic_write(0, Ien_Int_3);
> +
> +	asic_write(0x0fffffff, Int_Level_3_3);
> +	asic_write(0xffffffff, Int_Level_3_2);
> +	asic_write(0xffffffff, Int_Level_3_1);
> +	asic_write(0xffffffff, Int_Level_3_0);
> +	asic_write(0xffffffff, Int_Level_2_3);
> +	asic_write(0xffffffff, Int_Level_2_2);
> +	asic_write(0xffffffff, Int_Level_2_1);
> +	asic_write(0xffffffff, Int_Level_2_0);
> +	asic_write(0xffffffff, Int_Level_1_3);
> +	asic_write(0xffffffff, Int_Level_1_2);
> +	asic_write(0xffffffff, Int_Level_1_1);
> +	asic_write(0xffffffff, Int_Level_1_0);
> +	asic_write(0xffffffff, Int_Level_0_3);
> +	asic_write(0xffffffff, Int_Level_0_2);
> +	asic_write(0xffffffff, Int_Level_0_1);
> +	asic_write(0xffffffff, Int_Level_0_0);
> +
> +	asic_write(0xf, Int_Int_Scan);
> +
> +	/*
> +	 * Initialize interrupt handlers.
> +	 */
> +	for (i = 0; i < NR_IRQS; i++)
> +		set_irq_chip_and_handler(i, &asic_irq_chip, handle_level_irq);
> +}
> diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
> new file mode 100644
> index 0000000..cecbf40
> --- /dev/null
> +++ b/arch/mips/powertv/cevt-powertv.c
> @@ -0,0 +1,247 @@
> +/*
> + * Copyright (C) 2008 Scientific-Atlanta, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +/*
> + * The file comes from kernel/cevt-r4k.c
>   

It would be good to know why this file had to fork off its own
copy (i.e. what was lacking in the original).  Some small comment
here to that effect would be useful.

> + */
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/percpu.h>
> +#include <linux/version.h>
> +
> +#include <asm/smtc_ipi.h>
> +#include <asm/time.h>			/* Not included in linux/time.h */
> +
> +#include <asm/mach-powertv/interrupts.h>
> +#include "powertv-clock.h"
> +
> +static int mips_next_event(unsigned long delta,
> +	struct clock_event_device *evt)
> +{
> +	unsigned int cnt;
> +	int res;
> +
> +#ifdef CONFIG_MIPS_MT_SMTC
>   

If you've forked the file to be board specific, and if you are never
going to select MT_SMTC then you should purge the stuff that you
are never going to use/enable  (here, and in the additional cases
below).

> +	{
> +	unsigned long flags, vpflags;
> +	local_irq_save(flags);
> +	vpflags = dvpe();
> +#endif
> +	cnt = read_c0_count();
> +	cnt += delta;
> +	write_c0_compare(cnt);
> +	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	evpe(vpflags);
> +	local_irq_restore(flags);
> +	}
> +#endif
> +	return res;
> +}
> +
> +static void mips_set_mode(enum clock_event_mode mode,
> +	struct clock_event_device *evt)
> +{
> +	/* Nothing to do ...  */
> +}
> +
> +static DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
> +static int cp0_timer_irq_installed;
> +
> +/*
> + * Timer ack for an R4k-compatible timer of a known frequency.
> + */
> +static void c0_timer_ack(void)
> +{
> +	write_c0_compare(read_c0_compare());
> +}
> +
> +#ifndef CONFIG_SEPARATE_PCI_TI
> +/*
> + * Possibly handle a performance counter interrupt.
> + * Return true if the timer interrupt should not be checked
> + */
> +static inline int handle_perf_irq(int r2)
> +{
> +	/*
> +	 * The performance counter overflow interrupt may be shared with the
> +	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
> +	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
> +	 * and we can't reliably determine if a counter interrupt has also
> +	 * happened (!r2) then don't check for a timer interrupt.
> +	 */
> +	return (cp0_perfcount_irq < 0) &&
> +		perf_irq() == IRQ_HANDLED &&
> +		!r2;
> +}
> +#endif
> +
> +static irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
> +{
> +	const int r2 = cpu_has_mips_r2;
> +	struct clock_event_device *cd;
> +	int cpu = smp_processor_id();
> +
> +#ifndef CONFIG_SEPARATE_PCI_TI
> +	/*
> +	 * Suckage alert:
> +	 * Before R2 of the architecture there was no way to see if a
> +	 * performance counter interrupt was pending, so we have to run
> +	 * the performance counter interrupt handler anyway.
> +	 */
> +	if (handle_perf_irq(r2))
> +		return IRQ_HANDLED;
> +#endif
> +
> +	/*
> +	 * The same applies to performance counter interrupts.  But with the
> +	 * above we now know that the reason we got here must be a timer
> +	 * interrupt.  Being the paranoiacs we are we check anyway.
> +	 */
> +	if (!r2 || (read_c0_cause() & (1 << 30))) {
> +		c0_timer_ack();
> +#ifdef CONFIG_MIPS_MT_SMTC
> +		if (cpu_data[cpu].vpe_id)
> +			return IRQ_HANDLED;
> +		cpu = 0;
> +#endif
> +		cd = &per_cpu(mips_clockevent_device, cpu);
> +		cd->event_handler(cd);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction c0_compare_irqaction = {
> +	.handler = c0_compare_interrupt,
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	.flags = IRQF_DISABLED,
> +#else
> +	.flags = IRQF_DISABLED | IRQF_PERCPU,
> +#endif
> +	.name = "timer",
> +};
> +
> +#ifdef CONFIG_MIPS_MT_SMTC
> +DEFINE_PER_CPU(struct clock_event_device, smtc_dummy_clockevent_device);
> +
> +static void smtc_set_mode(enum clock_event_mode mode,
> +	struct clock_event_device *evt)
> +{
> +}
> +
> +static void mips_broadcast(cpumask_t mask)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu_mask(cpu, mask)
> +		smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
> +}
> +
> +static void setup_smtc_dummy_clockevent_device(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct clock_event_device *cd;
> +
> +	cd = &per_cpu(smtc_dummy_clockevent_device, cpu);
> +
> +	cd->name		= "SMTC";
> +	cd->features		= CLOCK_EVT_FEAT_DUMMY;
> +
> +	/* Calculate the min / max delta */
> +	cd->mult		= 0;
> +	cd->shift		= 0;
> +	cd->max_delta_ns	= 0;
> +	cd->min_delta_ns	= 0;
> +
> +	cd->rating		= 200;
> +	cd->irq			= 17;
> +	cd->cpumask		= cpumask_of_cpu(cpu);
> +
> +	cd->set_mode		= smtc_set_mode;
> +
> +	cd->broadcast		= mips_broadcast;
> +
> +	clockevents_register_device(cd);
> +}
> +#endif
> +
> +static void mips_event_handler(struct clock_event_device *dev)
> +{
> +}
> +
> +int __cpuinit powertv_clockevent_init(void)
> +{
> +	uint64_t mips_freq = mips_hpt_frequency;
> +	unsigned int cpu = smp_processor_id();
> +	struct clock_event_device *cd;
> +	unsigned int irq;
> +
> +	if (!cpu_has_counter || !mips_hpt_frequency)
> +		return -ENXIO;
> +
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	setup_smtc_dummy_clockevent_device();
> +
> +	/*
> +	 * On SMTC we only register VPE0's compare interrupt as clockevent
> +	 * device.
> +	 */
> +	if (cpu)
> +		return 0;
> +#endif
> +
> +	irq = kIrq_MipsTimer;
> +
> +	cd = &per_cpu(mips_clockevent_device, cpu);
> +
> +	cd->name		= "MIPS";
> +	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
> +
> +	/* Calculate the min / max delta */
> +	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
> +	cd->shift		= 32;
> +	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
> +	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
> +
> +	cd->rating		= 300;
> +	cd->irq			= irq;
> +#ifdef CONFIG_MIPS_MT_SMTC
> +	cd->cpumask		= CPU_MASK_ALL;
> +#else
> +	cd->cpumask		= get_cpu_mask(cpu);
> +#endif
> +	cd->set_next_event	= mips_next_event;
> +	cd->set_mode		= mips_set_mode;
> +	cd->event_handler	= mips_event_handler;
> +
> +	clockevents_register_device(cd);
> +
> +	if (cp0_timer_irq_installed)
> +		return 0;
> +
> +	cp0_timer_irq_installed = 1;
> +
> +#ifdef CONFIG_MIPS_MT_SMTC
> +#define CPUCTR_IMASKBIT (0x100 << cp0_compare_irq)
> +	setup_irq_smtc(irq, &c0_compare_irqaction, CPUCTR_IMASKBIT);
> +#else
> +	setup_irq(irq, &c0_compare_irqaction);
> +#endif
> +
> +	return 0;
> +}
> diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
> new file mode 100644
> index 0000000..ee570a1
> --- /dev/null
> +++ b/arch/mips/powertv/cmdline.c
> @@ -0,0 +1,51 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
>   

Looks like an attribution update is needed here too.

> + *
> + * This program is free software; you can distribute it and/or modify it
> + * under the terms of the GNU General Public License (Version 2) as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + * for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * Kernel command line creation using the prom monitor (YAMON) argc/argv.
> + */
> +#include <linux/init.h>
> +#include <linux/string.h>
> +
> +#include <asm/bootinfo.h>
> +
> +#include "init.h"
> +
> +/*
> + * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
> + * This macro take care of sign extension.
> + */
> +#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
> +
> +char * __init prom_getcmdline(void)
> +{
> +	return &(arcs_cmdline[0]);
> +}
> +
> +void  __init prom_init_cmdline(void)
> +{
> +	int len;
> +
> +	if (prom_argc != 1)
> +		return;
> +
> +	len = strlen(arcs_cmdline);
> +
> +	arcs_cmdline[len] = ' ';
> +
> +	strlcpy(arcs_cmdline + len + 1, (char *)_prom_argv,
> +		COMMAND_LINE_SIZE - len - 1);
> +}
> diff --git a/arch/mips/powertv/csrc-powertv.c b/arch/mips/powertv/csrc-powertv.c
> new file mode 100644
> index 0000000..c032660
> --- /dev/null
> +++ b/arch/mips/powertv/csrc-powertv.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (C) 2008 Scientific-Atlanta, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +/*
> + * The file comes from kernel/csrc-r4k.c
>   

Same here, a comment covering the deviation would be good.

> + */
> +#include <linux/clocksource.h>
> +#include <linux/init.h>
> +
> +#include <asm/time.h>			/* Not included in linux/time.h */
> +
> +#include <asm/mach-powertv/asic_regs.h>
> +#include "powertv-clock.h"
> +
> +/* MIPS PLL Register Definitions */
> +#define PLL_GET_M(x)		(((x) >> 8) & 0x000000FF)
> +#define PLL_GET_N(x)		(((x) >> 16) & 0x000000FF)
> +#define PLL_GET_P(x)		(((x) >> 24) & 0x00000007)
> +
> +/*
> + * returns:  Clock frequency in kHz
> + */
> +unsigned int __init mips_get_pll_freq(void)
> +{
> +	unsigned int pll_reg, m, n, p;
> +	unsigned int fin = 54000; /* Base frequency in kHz */
> +	unsigned int fout;
> +
> +	/* Read PLL register setting */
> +	pll_reg = asic_read(MIPS_PLL_SETUP);
> +	m = PLL_GET_M(pll_reg);
> +	n = PLL_GET_N(pll_reg);
> +	p = PLL_GET_P(pll_reg);
> +	pr_info("MIPS PLL Register:0x%x  M=%d  N=%d  P=%d\n", pll_reg, m, n, p);
> +
> +	/* Calculate clock frequency = (2 * N * 54MHz) / (M * (2**P)) */
> +	fout = ((2 * n * fin) / (m * (0x01 << p)));
> +
> +	pr_info("MIPS Clock Freq=%d kHz\n", fout);
> +
> +	return fout;
> +}
> +
> +static cycle_t c0_hpt_read(struct clocksource *cs)
> +{
> +	return read_c0_count();
> +}
> +
> +static struct clocksource clocksource_mips = {
> +	.name		= "powertv-counter",
> +	.read		= c0_hpt_read,
> +	.mask		= CLOCKSOURCE_MASK(32),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +void __init powertv_clocksource_init(void)
> +{
> +	unsigned int pll_freq = mips_get_pll_freq();
> +
> +	pr_info("CPU frequency %d.%02d MHz\n", pll_freq / 1000,
> +		(pll_freq % 1000) * 100 / 1000);
> +
> +	mips_hpt_frequency = pll_freq / 2 * 1000;
> +
> +	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
> +
> +	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
> +
> +	clocksource_register(&clocksource_mips);
> +}
> diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
> new file mode 100644
> index 0000000..6d7b229
> --- /dev/null
> +++ b/arch/mips/powertv/init.c
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
> + *	All rights reserved.
> + *	Authors: Carsten Langgaard <carstenl@mips.com>
> + *		 Maciej W. Rozycki <macro@mips.com>
>   

Attribution update.

> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * PROM library initialisation code.
> + */
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/bootinfo.h>
> +#include <linux/io.h>
> +#include <asm/system.h>
> +#include <asm/cacheflush.h>
> +#include <asm/traps.h>
> +
> +#include <asm/mips-boards/prom.h>
> +#include <asm/mips-boards/generic.h>
> +#include <asm/mach-powertv/asic.h>
> +
> +#include "init.h"
> +
> +int prom_argc;
> +int *_prom_argv, *_prom_envp;
> +unsigned long _prom_memsize;
> +
> +/*
> + * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
> + * This macro take care of sign extension, if running in 64-bit mode.
> + */
> +#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
> +
> +char *prom_getenv(char *envname)
> +{
> +	char *result = NULL;
> +
> +	if (_prom_envp != NULL) {
> +		/*
> +		 * Return a pointer to the given environment variable.
> +		 * In 64-bit mode: we're using 64-bit pointers, but all pointers
> +		 * in the PROM structures are only 32-bit, so we need some
> +		 * workarounds, if we are running in 64-bit mode.
> +		 */
> +		int i, index = 0;
> +
> +		i = strlen(envname);
> +
> +		while (prom_envp(index)) {
> +			if (strncmp(envname, prom_envp(index), i) == 0) {
> +				result = prom_envp(index + 1);
> +				break;
> +			}
> +			index += 2;
> +		}
> +	}
> +
> +	return result;
> +}
> +
> +/* TODO: Verify on linux-mips mailing list that the following two  */
> +/* functions are correct                                           */
> +/* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
> +/* BootROM exception vectors. Flush their cache entries. test it.  */
> +
> +static void __init mips_nmi_setup(void)
> +{
> +	void *base;
> +#if defined(CONFIG_CPU_MIPS32_R1)
> +	base = cpu_has_veic ?
> +		(void *)(CAC_BASE + 0xa80) :
> +		(void *)(CAC_BASE + 0x380);
> +#elif defined(CONFIG_CPU_MIPS32_R2)
> +	base = (void *)0xbfc00000;
> +#else
> +#error NMI exception handler address not defined
> +#endif
> +}
> +
> +static void __init mips_ejtag_setup(void)
> +{
> +	void *base;
> +
> +#if defined(CONFIG_CPU_MIPS32_R1)
> +	base = cpu_has_veic ?
> +		(void *)(CAC_BASE + 0xa00) :
> +		(void *)(CAC_BASE + 0x300);
> +#elif defined(CONFIG_CPU_MIPS32_R2)
> +	base = (void *)0xbfc00480;
> +#else
> +#error EJTAG exception handler address not defined
> +#endif
> +}
> +
> +void __init prom_init(void)
> +{
> +	prom_argc = fw_arg0;
> +	_prom_argv = (int *) fw_arg1;
> +	_prom_envp = (int *) fw_arg2;
> +	_prom_memsize = (unsigned long) fw_arg3;
> +
> +	board_nmi_handler_setup = mips_nmi_setup;
> +	board_ejtag_handler_setup = mips_ejtag_setup;
> +
> +	pr_info("\nLINUX started...\n");
> +	prom_init_cmdline();
> +	configure_platform();
> +	prom_meminit();
> +
> +#ifndef CONFIG_BOOTLOADER_DRIVER
> +	pr_info("\nBootloader driver isn't loaded...\n");
> +#endif
> +}
> diff --git a/arch/mips/powertv/init.h b/arch/mips/powertv/init.h
> new file mode 100644
> index 0000000..763472e
> --- /dev/null
> +++ b/arch/mips/powertv/init.h
> @@ -0,0 +1,10 @@
> +/*
> + * Definitions from powertv init.c file
> + */
>   

OK, it is a small file, but you probably want to stick some header
on it regardless.

> +
> +#ifndef _POWERTV_INIT_H
> +#define _POWERTV_INIT_H
> +extern int prom_argc;
> +extern int *_prom_argv;
> +extern unsigned long _prom_memsize;
> +#endif
> diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
> new file mode 100644
> index 0000000..a57972f
> --- /dev/null
> +++ b/arch/mips/powertv/memory.c
> @@ -0,0 +1,183 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
>   

This too should be updated and reference the original file
path/location that it was based on, and cover how it was
changed.

> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * PROM library functions for acquiring/using memory descriptors given to
> + * us from the YAMON.
> + */
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/bootmem.h>
> +#include <linux/pfn.h>
> +#include <linux/string.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/page.h>
> +#include <asm/sections.h>
> +
> +#include <asm/mips-boards/prom.h>
> +
> +#include "init.h"
> +
> +/* Memory constants */
> +#define	KIBIBYTE(n)		((n) * 1024)	/* Number of kibibytes */
> +#define	MEBIBYTE(n)		((n) * KIBIBYTE(1024)) /* Number of mebibytes */
> +#define	DEFAULT_MEMSIZE		MEBIBYTE(256)	/* If no memsize provided */
> +#define	LOW_MEM_MAX		MEBIBYTE(252)	/* Max usable low mem */
> +#define	RES_BOOTLDR_MEMSIZE	MEBIBYTE(1)	/* Memory reserved for bldr */
> +#define	BOOT_MEM_SIZE		KIBIBYTE(256)	/* Memory reserved for bldr */
> +#define	PHYS_MEM_START		0x10000000	/* Start of physical memory */
> +
> +unsigned long ptv_memsize;
> +
> +void __init prom_meminit(void)
> +{
> +	char *memsize_str;
> +	unsigned long memsize = 0;
> +	unsigned int physend;
> +	char cmdline[CL_SIZE], *ptr;
> +	int low_mem;
> +	int high_mem;
> +
> +	/* Check the command line first for a memsize directive */
> +	strcpy(cmdline, arcs_cmdline);
> +	ptr = strstr(cmdline, "memsize=");
> +	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
> +		ptr = strstr(ptr, " memsize=");
> +
> +	if (ptr) {
> +		memsize = memparse(ptr + 8, &ptr);
> +	} else {
> +		/* otherwise look in the environment */
> +		memsize_str = prom_getenv("memsize");
> +
> +		if (memsize_str != NULL) {
> +			pr_info("prom memsize = %s\n", memsize_str);
> +			memsize = simple_strtol(memsize_str, NULL, 0);
> +		}
> +
> +		if (memsize == 0) {
> +			if (_prom_memsize != 0) {
> +				memsize = _prom_memsize;
> +				pr_info("_prom_memsize = 0x%lx\n", memsize);
> +				/* add in memory that the bootloader doesn't
> +				 * report */
> +				memsize += BOOT_MEM_SIZE;
> +			} else {
> +				memsize = DEFAULT_MEMSIZE;
> +				pr_info("Memsize not passed by bootloader, "
> +					"defaulting to 0x%lx\n", memsize);
> +			}
> +		}
> +	}
> +
> +	/* Store memsize for diagnostic purposes */
> +	ptv_memsize = memsize;
> +
> +	physend = PFN_ALIGN(&_end) - 0x80000000;
> +	if (memsize > LOW_MEM_MAX) {
> +		low_mem = LOW_MEM_MAX;
> +		high_mem = memsize - low_mem;
> +	} else {
> +		low_mem = memsize;
> +		high_mem = 0;
> +	}
> +
> +/*
> + * TODO: We will use the hard code for memory configuration until
> + * the bootloader releases their device tree to us.
> + */
> +	/*
> +	 * Add the memory reserved for use by the bootloader to the
> +	 * memory map.
> +	 */
> +	add_memory_region(PHYS_MEM_START, RES_BOOTLDR_MEMSIZE,
> +		BOOT_MEM_RESERVED);
> +#ifdef CONFIG_HIGHMEM_256_128
>   

Do these options even exist in a Kconfig?  I don't recall seeing them.
Maybe that is part of the TODO as well.

> +	/*
> +	 * Add memory in low for general use by the kernel and its friends
> +	 * (like drivers, applications, etc).
> +	 */
> +	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
> +		LOW_MEM_MAX - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
> +	/*
> +	 * Add the memory reserved for reset vector.
> +	 */
> +	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
> +	/*
> +	 * Add the memory reserved.
> +	 */
> +	add_memory_region(0x20000000, MEBIBYTE(1024 + 75), BOOT_MEM_RESERVED);
> +	/*
> +	 * Add memory in high for general use by the kernel and its friends
> +	 * (like drivers, applications, etc).
> +	 *
> +	 * 75MB is reserved for devices which are using the memory in high.
> +	 */
> +	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
> +		BOOT_MEM_RAM);
> +#elif defined CONFIG_HIGHMEM_128_128
> +	/*
> +	 * Add memory in low for general use by the kernel and its friends
> +	 * (like drivers, applications, etc).
> +	 */
> +	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
> +		MEBIBYTE(128) - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
> +	/*
> +	 * Add the memory reserved.
> +	 */
> +	add_memory_region(PHYS_MEM_START + MEBIBYTE(128),
> +		MEBIBYTE(128 + 1024 + 75), BOOT_MEM_RESERVED);
> +	/*
> +	 * Add memory in high for general use by the kernel and its friends
> +	 * (like drivers, applications, etc).
> +	 *
> +	 * 75MB is reserved for devices which are using the memory in high.
> +	 */
> +	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
> +		BOOT_MEM_RAM);
> +#else
> +	/* Add low memory regions for either:
> +	 *   - no-highmemory configuration case -OR-
> +	 *   - highmemory "HIGHMEM_LOWBANK_ONLY" case
> +	 */
> +	/*
> +	 * Add memory for general use by the kernel and its friends
> +	 * (like drivers, applications, etc).
> +	 */
> +	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
> +		low_mem - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
> +	/*
> +	 * Add the memory reserved for reset vector.
> +	 */
> +	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
> +#endif
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +	unsigned long addr;
> +	int i;
> +
> +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> +		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
> +			continue;
> +
> +		addr = boot_mem_map.map[i].addr;
> +		free_init_pages("prom memory",
> +				addr, addr + boot_mem_map.map[i].size);
> +	}
> +}
> diff --git a/arch/mips/powertv/pci/Makefile b/arch/mips/powertv/pci/Makefile
> new file mode 100644
> index 0000000..7bf9f8c
> --- /dev/null
> +++ b/arch/mips/powertv/pci/Makefile
> @@ -0,0 +1,26 @@
> +# *****************************************************************************
> +#                          Make file for PowerTV PCI driver
>   

minor nit  --  Makefile

> +#
> +# Copyright (C) 2009  Scientific-Atlanta, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +# *****************************************************************************
> +
> +obj-y	:=
> +
> +obj-$(CONFIG_PCI)	+= pci.o fixup-powertv.o pciemod.o
> +
> +
> diff --git a/arch/mips/powertv/pci/fixup-powertv.c b/arch/mips/powertv/pci/fixup-powertv.c
> new file mode 100644
> index 0000000..a75a9ab
> --- /dev/null
> +++ b/arch/mips/powertv/pci/fixup-powertv.c
> @@ -0,0 +1,14 @@
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include "powertv-pci.h"
> +
> +int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	return asic_pcie_map_irq(dev, slot, pin);
> +}
> +
> +/* Do platform specific device initialization at pci_enable_device() time */
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> diff --git a/arch/mips/powertv/pci/pci.c b/arch/mips/powertv/pci/pci.c
> new file mode 100644
> index 0000000..3358b5f
> --- /dev/null
> +++ b/arch/mips/powertv/pci/pci.c
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
> + *	All rights reserved.
> + *	Authors: Carsten Langgaard <carstenl@mips.com>
> + *		 Maciej W. Rozycki <macro@mips.com>
> + *
> + * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
>   

Update attribution, reference original, mention deltas for this
specific platform.

> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * MIPS boards specific PCI support.
> + */
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <asm/mips-boards/generic.h>
> +#include "powertv-pci.h"
> +
> +void __init mips_pcibios_init(void)
> +{
> +	asic_pcie_init();
> +}
>   

Now that I see the file in its entirety, I wonder if this can't just
be rolled into another appropriate source file....

> diff --git a/arch/mips/powertv/pci/pciemod.c b/arch/mips/powertv/pci/pciemod.c
> new file mode 100644
> index 0000000..f152fc5
> --- /dev/null
> +++ b/arch/mips/powertv/pci/pciemod.c
> @@ -0,0 +1,2921 @@
> +/* -----------------------------------------------------------------------------
> + *                            PCIE Module
> + *
> + * Copyright (C) 2000-2009 Scientific-Atlanta, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + *
> + * -----------------------------------------------------------------------------
> + *
> + * File Name:    pciemod.c
> + *
> + * Project:      NGP
> + *
> + * Compiler:     gnu C (gcc)
> + *
> + * Author(s):    Tom Haman
> + *
> + * Description:  Routines implementing kernel PCIE Module.
> + *
> + * Documents:    PCIE Software Design Document
> + *
> + * NOTES:
> + *
> + * -----------------------------------------------------------------------------
> + * History:
> + * Rev Level    Date    Name         ECN#    Description
> + * -----------------------------------------------------------------------------
> + * 1.00       03/27/06  Tom Haman    ---    Initial version for NGP (Zeus)
> + * -----------------------------------------------------------------------------
>   

Project,  compiler, and changelog etc can go as per prev.
comments.

> + */
> +
> +
> +/*platform and compile/usage definitions */
> +#define DEBUG         1
> +#define LOADABLE      0
> +
> +#ifndef SA8KG5
> +#define SA8KG5        1
> +#endif
> +
> +#ifndef qDebug
> +#define qDebug        DEBUG
> +#endif
> +
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/proc_fs.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +#include <linux/errno.h>
> +#include <linux/pci.h>
> +
> +/* SA includes */
> +#include <asm/mach-powertv/asic.h>
> +#include <asm/mach-powertv/asic_regs.h>
> +#include <asm/mach-powertv/interrupts.h>
> +
> +#include "pcieregs.h"
> +
> +
> +
> +/******************************************************************************
> + ******************************************************************************
> + * these items would normally be in SA driver include files but since we are
> + * in the low level Kernel, they are defined here
> + ******************************************************************************
> + ******************************************************************************
> + * FROM "SAKernel.h"
> + */
> +enum {
> +	SA_OFF,
> +	SA_FATAL,
> +	SA_SEVERE,
> +	SA_INFO,
> +	SA_NOISE
> +} eSa_LogLevels;
> +
> +#define SA_LOG_TO_PRINT  1
> +
> +#if ((defined(DEBUG) && DEBUG) || (defined(qDebug) && qDebug))
> +#define SAPRINT(level, destflags, fmt...) do {	\
> +		if ((level <= LogLevel) && ((destflags) & SA_LOG_TO_PRINT)) \
> +			printk(fmt); \
> +	} while (0)
> +#else
> +#define SAPRINT(level, destflags, fmt...) do {} while (0)
> +#endif
> +
> +MODULE_AUTHOR("Tom Haman");
> +MODULE_DESCRIPTION("PCIE Module");
> +MODULE_LICENSE("GPL");
> +
> +/* File ID info  (DO NOT EDIT) */
> +const char PCIE_ident[] = "SA-Drv-Ident %name: %, %version: %, "
> +	"%instance: %, %date_created: %, %created_by: %";
> +
> +/*******************************************************************************
> + *******************************************************************************
> + *   LOADABLE Elements
> + *******************************************************************************
> + ******************************************************************************/
> +#if LOADABLE
> +/*Module Parameters */
> +module_param(LogLevel, int, S_IRUGO);
> +MODULE_PARM_DESC(LogLevel, "Module debug log level");
> +#endif /*LOADABLE */
> +
> +/*******************************************************************************
> + *******************************************************************************
> + *   KERNEL Elements
> + *******************************************************************************
> + ******************************************************************************/
>   

Drop the giant banners again?

> +/*---------- Defines ------------ */
> +#define pcieModule_Name         "pcie"
> +
> +/*---------- Variables ------------ */
> +static struct proc_dir_entry *PCIE_pProc;	/* proc directory entry */
> +static        int             LogLevel            = SA_INFO;
> +static        struct tPCIERegs      *PCIE_RegsPtr;
> +static        int             PCIE_irqrequest_pcie;
> +static        u32             PCIE_initialized;
> +static        u32            *timerptr;
> +static        spinlock_t      PCIE_lock;
>   

whitespace cleanup on the above?

> +
> +/*---------- Non Private Module Prototypes ------------ */
> +static int  __init pcie_Init(void);
> +static void __exit pcie_Finalize(void);
> +static int asic_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
> +	int where, int size, u32 *val);
> +static int asic_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
> +	int where, int size, u32 val);
> +
> +/*---------- Private Module Prototypes ------------ */
> +static irqreturn_t asic_pcie_process_interrupt(int irq, void *dev_id);
> +static u32 pcie_rc_cfg_read32(u32 type, u32 busnum, u32 devnum, u32 func_num,
> +	u32 reg_num, u32 *dataptr);
> +static u32 pcie_rc_cfg_write32(u32 type, u32 busnum, u32 devnum, u32 func_num,
> +	u32 reg_num, u32 *dataptr);
> +static void pcie_DumpRegs(void);
> +static int pcie_dumpcapability(int busnumber, int dev, int fn, int ptr);
> +static int pcie_dumpextendedcapability(int busnumber, int dev, int fn, int ptr);
> +static void pcie_delay(u32 ms);
> +static int pcie_reset_ethernet(void) ;
> +static void pcie_uSecDelay(u32 us);
>   

I'm not sure why a delay is tied to a bus.  A delay is a delay, no?

> +
> +/*proc */
> +static int pcie_WriteProc(struct file *pfile, const char __user *pbuff,
> +	unsigned long bytecnt, void *data);
>   

I haven't got to what these proc functions do yet, but just by
looking at the name I'm thinking seq_file?

> +static int pcie_ReadProc(char *page, char **start, off_t off, int pageSize,
> +	int *eof, void *data);
> +
> +/*interrupt */
> +static u32 intdata[4];
> +static int intcountslow[32], intcountshigh[32];
> +
> +/*---------- Structures ----------- */
> +static struct pci_ops asic_pci_ops = {
> +	.read  = asic_pcie_read_config,
> +	.write = asic_pcie_write_config
> +};
> +
> +static struct resource asic_mem_resource = {
> +	.name	      = "ZEUS PCI MEM",
> +	.flags	    = IORESOURCE_MEM,
> +	.start      = 0x08000000UL,
> +	.end        = 0x083FFFFFUL,
> +
> +};
> +
> +static struct resource asic_io_resource = {
> +	.name	  = "ASIC PCI I/O",
> +	.start  = 0x08400000UL,
> +	.end    = 0x087FFFFFUL,
> +	.flags	= IORESOURCE_IO,
> +};
> +
> +struct pci_controller asic_controller = {
> +	.pci_ops	    = &asic_pci_ops,
> +	.io_resource	= &asic_io_resource,
> +	.mem_resource	= &asic_mem_resource,
> +	.io_offset	  = 0x00000000UL,
> +	.mem_offset   = 0x00000000UL
> +};
> +
> +
> +/* VFD-SPI registers */
> +struct tFPanel_regs {
> +	u32   rSVFDControl;        /* control register */
> +	u32   rSVFDStart;          /* start register */
> +	u32   rSVFDFifo;           /* Fifo register */
> +	u32   rSVFDKeyData;        /* key data register */
> +	u32   rSVFDManReadData;    /* manual read data register */
> +	u32   rSVFDReadCmd;        /* read command register */
> +	u32   rSVFDStatus;         /* status register */
> +	u32   rSVFDIntStat;        /* interrupt status register */
> +	u32   rSVFDIntEnable;      /* interrupt enable register */
> +};
> +
> +/*---------- Constants ------------ */
> +
> +/*---------- Externals ------------ */
> +
> +/*---------- Temporary Fixes ------------ */
>   

Some sort of comment about what these workarounds are for would
not go amiss.

> +static inline u8 fix_readb(u8 *addr)
> +{
> +	u32 temp = (u32)addr ^ 3;
> +	u8 *ptr;
> +	ptr = (u8 *)temp;
> +	return readb(ptr);
> +}
> +static inline u16 fix_readw(u16 *addr)
> +{
> +	u32 temp = (u32)addr ^ 2;
> +	u16 *ptr;
> +	ptr = (u16 *)temp;
> +	return readw(ptr);
> +}
> +static inline u32 fix_readl(u32 *addr)
> +{
> +	return readl(addr);
> +}
> +
> +static inline void fix_writeb(u8 val, u8 *addr)
> +{
> +	u32 temp = (u32)addr ^ 3;
> +	u8 *ptr;
> +	ptr = (u8 *)temp;
> +	writeb(val, ptr);
> +}
> +static inline void fix_writew(u16 val, u16 *addr)
> +{
> +	u32 temp = (u32)addr ^ 2;
> +	u16 *ptr;
> +	ptr = (u16 *)temp;
> +	writew(val, ptr);
> +}
> +static inline void fix_writel(u32 val, u32 *addr)
> +{
> +	writel(val, addr);
> +}
> +
> +/* Convenience functions for performing logical operations on device
> + * registers */
> +static void writel_or(u32 v, u32 *addr)
> +{
> +	writel(readl(addr) | v, addr);
> +}
> +
> +static void writel_and(u32 v, u32 *addr)
> +{
> +	writel(readl(addr) & v, addr);
> +}
> +
> +
> +#ifdef PCIE_PLL_FIX
> +
> +	static struct tTBRegs  *TB_RegsPtr;
> +	static unsigned int scr_data_in[kSCR_DEPTH];
>   

Don't indent here.

> +
> +
> +/*******************************************************************************
> + * asic_pcie_reset
> + *
> + * If the box is a Zeus 1.0 box and the PHY layer's PLL has not acheived lock,
> + * then load the PLL with the correct value and then reset it. There is no way
> + * to reset the PHY layer by a conventional register command. Therefore, this
> + * backdoor method using the testbus to control the jtag port has been used.
> + * PCIe PHY layer to be reset after new PLL value has been loaded.
> + *
> + *
> + ******************************************************************************/
> +void asic_shift_clk(void)
> +{
> +	/* clock low */
> +	writel_and(0xFFFFFFFD, &TB_RegsPtr->TEST_BUS_GPIO);
> +	pcie_uSecDelay(20);
> +	/* clock high */
> +	writel_or(0x2, &TB_RegsPtr->TEST_BUS_GPIO);
> +	pcie_uSecDelay(20);
> +}
> +
> +
> +void asic_shift_in(void)
> +{
> +	int i;
> +
> +	writel_or(0x30, &TB_RegsPtr->TEST_BUS_GPIO); /* Set SCR_OPCODE to a 3 */
> +	for (i = kSCR_DEPTH-1; i >= 0; i--) {
> +		if (scr_data_in[i])
> +				/* Set SCR_IN high */
> +			writel_or(0x4, &TB_RegsPtr->TEST_BUS_GPIO);
> +		else
> +			/* Set SCR_IN lo */
> +			writel_and(0xFFFFFFFB, &TB_RegsPtr->TEST_BUS_GPIO);
> +		asic_shift_clk();
> +	}
> +	/* Set SCR_OPCODE to 2'b10 */
> +	writel_and(0xFFFFFFEF, &TB_RegsPtr->TEST_BUS_GPIO);
> +	asic_shift_clk();
> +	/* Set SCR_OPCODE to zero */
> +	writel_and(0xFFFFFFCF, &TB_RegsPtr->TEST_BUS_GPIO);
> +}
> +
> +void asic_phy_reset(void)
> +{
> +	int i;
> +
> +	/* Enable OEs  */
> +	writel_or(0x17 | 0x107F00, &TB_RegsPtr->TEST_BUS_GPIO_CTL);
> +	/* Set lower bits to zero */
> +	writel_and(0xFFFFF80, &TB_RegsPtr->TEST_BUS_GPIO);
> +	/* Set mode bit */
> +	writel_or(0x8, &TB_RegsPtr->TEST_BUS_GPIO);
> +
> +	for (i = kSCR_DEPTH-1; i >= 0; i--)
> +		scr_data_in[i] = 0;
> +
> +	scr_data_in[kSCR_DEPTH-93] = 1;
> +	scr_data_in[kSCR_DEPTH-94] = 1;
> +
> +	asic_shift_in();
> +
> +	/* Clear mode bit */
> +	writel_and(0xFFFFFFF7, &TB_RegsPtr->TEST_BUS_GPIO);
> +
> +}
> +
> +void asic_write_jtag(unsigned int tms, unsigned int tdi)
> +{
> +	/* drive bit 13 low (clk) */
> +	writel_and(0xFFFFDFFF, &TB_RegsPtr->TEST_BUS_GPIO);
> +
> +	if (tms)            /* set tms */
> +		writel_or(0x2, &TB_RegsPtr->TEST_BUS_GPIO);
> +	else     /* clear tms */
> +		writel_and(0xFFFFFFFD, &TB_RegsPtr->TEST_BUS_GPIO);
> +
> +	if (tdi)            /* set tdi */
> +		writel_or(0x4, &TB_RegsPtr->TEST_BUS_GPIO);
> +	else     /* clear tdi */
> +		writel_and(0xFFFFFFFB, &TB_RegsPtr->TEST_BUS_GPIO);
> +
> +	pcie_uSecDelay(20);
> +	/* drive bit 13 high (clk) */
> +	writel_or(0x00002000, &TB_RegsPtr->TEST_BUS_GPIO);
> +	pcie_uSecDelay(20);
> +}
> +
> +
> +void asic_setup_jtag(unsigned int value)
> +
> +{
> +	int i;
> +
> +	writel(0x17 | 0x300600, &TB_RegsPtr->TEST_BUS_GPIO_CTL);
> +
> +	/*Select Controller 0 */
> +	/* drive bit 12, 13, 1, 2 low */
> +	writel_and(0xFFFFCFF9, &TB_RegsPtr->TEST_BUS_GPIO);
> +	pcie_uSecDelay(20);
> +	writel_or(0x00000004, &TB_RegsPtr->TEST_BUS_GPIO);       /* tdI = 1 */
> +	pcie_uSecDelay(20);
> +	writel_or(0x00002000, &TB_RegsPtr->TEST_BUS_GPIO);       /* CLK = 1 */
> +	pcie_uSecDelay(20);
> +	writel_and(0xFFFFDFFF, &TB_RegsPtr->TEST_BUS_GPIO);      /* CLK = 0  */
> +	pcie_uSecDelay(20);
> +	writel_or(0x00001000, &TB_RegsPtr->TEST_BUS_GPIO);       /* trstn = 1 */
> +	writel_and(0xFFFFFFFB, &TB_RegsPtr->TEST_BUS_GPIO);      /* tdi = 0  */
> +	pcie_uSecDelay(20);
> +	writel_or(0x00002000, &TB_RegsPtr->TEST_BUS_GPIO);       /* CLK = 1 */
> +	pcie_uSecDelay(20);
> +	writel_and(0xFFFFDFFF, &TB_RegsPtr->TEST_BUS_GPIO);      /* CLK = 0  */
> +
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(0, 1);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(0, 0);
> +	asic_write_jtag(0, 0);
> +
> +	for (i = 0; i < 28 ; i++)
> +		asic_write_jtag(0, 0);
> +
> +	asic_write_jtag(0, value);
> +	for (i = 0; i < 75 ; i++)
> +		asic_write_jtag(0, 0);
> +
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(1, 0);
> +	asic_write_jtag(0, 0);
> +}
> +
> +void asic_pcie_reset(void)
> +{
> +	asic_setup_jtag(1);
> +	asic_phy_reset();
> +	asic_setup_jtag(0);
> +}
> +
> +#endif
> +
> +
> +/*******************************************************************************
> + *******************************************************************************
> + *   PCIE General Interface
> + *******************************************************************************
> + *******************************************************************************
> + *******************************************************************************
>   

Mega banner.  Might as well just adopt proper kerndoc format
and let it make use of the info below.


> + * asic_pcie_init
> + *
> + * This API is called at power up and therefore must be exposed to other
> + * modules.
> + *
> + * Parameters - None
> + *
> + * Return Value - 0 or error
> + *
> + * Description:
> + * asic_pcie_init initializes the ASIC' PCI Express registers, obtains an IRQ
> + * from the Linux Kernel and registers the controller with the PCI System
> + * Software.
> + ******************************************************************************/
> +int asic_pcie_init(void)
> +{
> +	unsigned int timeout_count;
> +	int i;
> +
>
>   

I've snipped the largish pcie code block from here; having that
support as a separate commit would really help the digestibility
of the board support -- even I didn't have it in me to go over it now.

> +
> +#endif	/* _PCIE_REGS_H_ */
> +
> diff --git a/arch/mips/powertv/pci/powertv-pci.h b/arch/mips/powertv/pci/powertv-pci.h
> new file mode 100644
> index 0000000..98c087e
> --- /dev/null
> +++ b/arch/mips/powertv/pci/powertv-pci.h
> @@ -0,0 +1,12 @@
> +/*
> + * Local definitions for the powertv PCI code
> + */
> +
> +#ifndef	_POWERTV_PCI_H_
> +#define	_POWERTV_PCI_H_
>   

Header on the file and no extraneous tabs?

> +extern int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> +extern int asic_pcie_init(void);
> +extern int asic_pcie_init(void);
> +
> +extern int LogLevel;
>   

Is this a separate loglevel from the normal one used by dmesg?
If so, then why?

> +#endif
> diff --git a/arch/mips/powertv/powertv-clock.h b/arch/mips/powertv/powertv-clock.h
> new file mode 100644
> index 0000000..6f8c17b
> --- /dev/null
> +++ b/arch/mips/powertv/powertv-clock.h
> @@ -0,0 +1,10 @@
> +/*
> + * Definitions for clocks
> + */
> +
> +#ifndef _POWERTV_CLOCK_H
> +#define _POWERTV_CLOCK_H
> +extern int powertv_clockevent_init(void);
> +extern void powertv_clocksource_init(void);
> +extern unsigned int mips_get_pll_freq(void);
> +#endif
> diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
> new file mode 100644
> index 0000000..f19f36f
> --- /dev/null
> +++ b/arch/mips/powertv/powertv_setup.c
> @@ -0,0 +1,351 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
>   

Attribution updates.

> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + */
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/screen_info.h>
> +#include <linux/notifier.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_ether.h>
> +#include <linux/ctype.h>
> +
> +#include <linux/cpu.h>
> +#include <asm/bootinfo.h>
> +#include <asm/irq.h>
> +#include <asm/mips-boards/generic.h>
> +#include <asm/mips-boards/prom.h>
> +#include <asm/dma.h>
> +#include <linux/time.h>
> +#include <asm/traps.h>
> +#include <asm/asm-offsets.h>
> +#include "reset.h"
> +
> +#define	VAL(n)		STR(n)
> +
> +/*
> + * Macros for loading addresses and storing registers:
> + * PTR_LA	Load the address into a register
> + * LONG_S	Store the full width of the given register.
> + * LONG_L	Load the full width of the given register
> + * PTR_ADDIU	Add a constant value to a register used as a pointer
> + * REG_SIZE	Number of 8-bit bytes in a full width register
> + */
> +#ifdef CONFIG_64BIT
> +#warning TODO: 64-bit code needs to be verified
> +#define PTR_LA		"dla	"
> +#define LONG_S		"sd	"
> +#define	LONG_L		"ld	"
> +#define	PTR_ADDIU	"daddiu	"
> +#define	REG_SIZE	"8"		/* In bytes */
> +#endif
> +
> +#ifdef CONFIG_32BIT
> +#define PTR_LA		"la	"
> +#define LONG_S		"sw	"
> +#define	LONG_L		"lw	"
> +#define	PTR_ADDIU	"addiu	"
> +#define	REG_SIZE	"4"		/* In bytes */
> +#endif
>   

You've got tabs after the defines in the above two blocks.

> +
> +static struct pt_regs die_regs;
> +static bool have_die_regs;
> +
> +static void register_panic_notifier(void);
> +static int panic_handler(struct notifier_block *notifier_block,
> +	unsigned long event, void *cause_string);
> +
> +const char *get_system_type(void)
> +{
> +	return "PowerTV";
> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +	panic_on_oops = 1;
> +	register_panic_notifier();
> +
> +	mips_pcibios_init();
> +	mips_reboot_setup();
> +}
> +
> +/*
> + * Install a panic notifier for platform-specific diagnostics
> + */
> +static void register_panic_notifier()
> +{
> +	static struct notifier_block panic_notifier = {
> +		.notifier_call = panic_handler,
> +		.next = NULL,
> +		.priority	= INT_MAX
> +	};
> +	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
> +}
> +
> +static int panic_handler (struct notifier_block *notifier_block,
>   

Inconsistent coding style --- foo ()  vs.  foo()  -- probably will get
nagged by checkpatch.

> +	unsigned long event, void *cause_string)
> +{
> +	struct pt_regs	my_regs;
> +
> +	/* Save all of the registers */
> +	{
> +		unsigned long	at, v0, v1; /* Must be on the stack */
> +
> +		/* Start by saving $at and v0 on the stack. We use $at
> +		 * ourselves, but it looks like the compiler may use v0 or v1
> +		 * to load the address of the pt_regs structure. We'll come
> +		 * back later to store the registers in the pt_regs
> +		 * structure. */
> +		__asm__ __volatile__ (
> +			".set	noat\n"
> +			LONG_S		"$at, %[at]\n"
> +			LONG_S		"$2, %[v0]\n"
> +			LONG_S		"$3, %[v1]\n"
> +		:
> +			[at] "=m" (at),
> +			[v0] "=m" (v0),
> +			[v1] "=m" (v1)
> +		:
> +		:	"at"
> +		);
> +
> +		__asm__ __volatile__ (
> +			".set	noat\n"
> +			"move		$at, %[pt_regs]\n"
> +
> +			/* Argument registers */
> +			LONG_S		"$4, " VAL(PT_R4) "($at)\n"
> +			LONG_S		"$5, " VAL(PT_R5) "($at)\n"
> +			LONG_S		"$6, " VAL(PT_R6) "($at)\n"
> +			LONG_S		"$7, " VAL(PT_R7) "($at)\n"
> +
> +			/* Temporary regs */
> +			LONG_S		"$8, " VAL(PT_R8) "($at)\n"
> +			LONG_S		"$9, " VAL(PT_R9) "($at)\n"
> +			LONG_S		"$10, " VAL(PT_R10) "($at)\n"
> +			LONG_S		"$11, " VAL(PT_R11) "($at)\n"
> +			LONG_S		"$12, " VAL(PT_R12) "($at)\n"
> +			LONG_S		"$13, " VAL(PT_R13) "($at)\n"
> +			LONG_S		"$14, " VAL(PT_R14) "($at)\n"
> +			LONG_S		"$15, " VAL(PT_R15) "($at)\n"
> +
> +			/* "Saved" registers */
> +			LONG_S		"$16, " VAL(PT_R16) "($at)\n"
> +			LONG_S		"$17, " VAL(PT_R17) "($at)\n"
> +			LONG_S		"$18, " VAL(PT_R18) "($at)\n"
> +			LONG_S		"$19, " VAL(PT_R19) "($at)\n"
> +			LONG_S		"$20, " VAL(PT_R20) "($at)\n"
> +			LONG_S		"$21, " VAL(PT_R21) "($at)\n"
> +			LONG_S		"$22, " VAL(PT_R22) "($at)\n"
> +			LONG_S		"$23, " VAL(PT_R23) "($at)\n"
> +
> +			/* Add'l temp regs */
> +			LONG_S		"$24, " VAL(PT_R24) "($at)\n"
> +			LONG_S		"$25, " VAL(PT_R25) "($at)\n"
> +
> +			/* Kernel temp regs */
> +			LONG_S		"$26, " VAL(PT_R26) "($at)\n"
> +			LONG_S		"$27, " VAL(PT_R27) "($at)\n"
> +
> +			/* Global pointer, stack pointer, frame pointer and
> +			 * return address */
> +			LONG_S		"$gp, " VAL(PT_R28) "($at)\n"
> +			LONG_S		"$sp, " VAL(PT_R29) "($at)\n"
> +			LONG_S		"$fp, " VAL(PT_R30) "($at)\n"
> +			LONG_S		"$ra, " VAL(PT_R31) "($at)\n"
> +
> +			/* Now we can get the $at and v0 registers back and
> +			 * store them */
> +			LONG_L		"$8, %[at]\n"
> +			LONG_S		"$8, " VAL(PT_R1) "($at)\n"
> +			LONG_L		"$8, %[v0]\n"
> +			LONG_S		"$8, " VAL(PT_R2) "($at)\n"
> +			LONG_L		"$8, %[v1]\n"
> +			LONG_S		"$8, " VAL(PT_R3) "($at)\n"
> +		:
> +		:
> +			[at] "m" (at),
> +			[v0] "m" (v0),
> +			[v1] "m" (v1),
> +			[pt_regs] "r" (&my_regs)
> +		:	"at", "t0"
> +		);
> +
> +		/* Set the current EPC value to be the current location in this
> +		 * function */
> +		__asm__ __volatile__ (
> +			".set	noat\n"
> +		"1:\n"
> +			PTR_LA		"$at, 1b\n"
> +			LONG_S		"$at, %[cp0_epc]\n"
> +		:
> +			[cp0_epc] "=m" (my_regs.cp0_epc)
> +		:
> +		:	"at"
> +		);
> +
> +		my_regs.cp0_cause = read_c0_cause();
> +		my_regs.cp0_status = read_c0_status();
> +	}
> +
> +#ifdef CONFIG_DIAGNOSTICS
> +	failure_report((char *) cause_string,
> +		have_die_regs ? &die_regs : &my_regs);
> +	have_die_regs = false;
> +#else
> +	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
> +		"zzzz... \n");
>   

You probably want a hint of what the real problem is printed
when this message goes to the console.  Unless a prev. message
will have printed that already.

> +#endif
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/**
> + * Platform-specific handling of oops
> + * @str:	Pointer to the oops string
> + * @regs:	Pointer to the oops registers
> + * All we do here is to save the registers for subsequent printing through
> + * the panic notifier.
> + */
> +void platform_die(const char *str, const struct pt_regs *regs)
> +{
> +	/* If we already have saved registers, don't overwrite them as they
> +	 * they apply to the initial fault */
> +
> +	if (!have_die_regs) {
> +		have_die_regs = true;
> +		die_regs = *regs;
> +	}
> +}
> +
> +/* Information about the RF MAC address, if one was supplied on the
> + * command line. */
> +static bool have_rfmac;
> +static u8 rfmac[ETH_ALEN];
> +
> +static int rfmac_param(char *p)
> +{
> +	u8	*q;
> +	bool	is_high_nibble;
> +	int	c;
> +
> +	/* Skip a leading "0x", if present */
> +	if (*p == '0' && *(p+1) == 'x')
> +		p += 2;
> +
> +	q = rfmac;
> +	is_high_nibble = true;
> +
> +	for (c = (unsigned char) *p++;
> +		isxdigit(c) && q - rfmac < ETH_ALEN;
> +		c = (unsigned char) *p++) {
> +		int	nibble;
> +
> +		nibble = (isdigit(c) ? (c - '0') :
> +			(isupper(c) ? c - 'A' + 10 : c - 'a' + 10));
> +
> +		if (is_high_nibble)
> +			*q = nibble << 4;
> +		else
> +			*q++ |= nibble;
> +
> +		is_high_nibble = !is_high_nibble;
> +	}
> +
> +	/* If we parsed all the way to the end of the parameter value and
> +	 * parsed all ETH_ALEN bytes, we have a usable RF MAC address */
> +	have_rfmac = (c == '\0' && q - rfmac == ETH_ALEN);
> +
> +	return 0;
> +}
> +
> +early_param("rfmac", rfmac_param);
> +
> +/*
> + * Generate an Ethernet MAC address that has a good chance of being unique.
> + * @addr:	Pointer to six-byte array containing the Ethernet address
> + * Generates an Ethernet MAC address that is highly likely to be unique for
> + * this particular system on a network with other systems of the same type.
> + *
> + * The problem we are solving is that, when random_ether_addr() is used to
> + * generate MAC addresses at startup, there isn't much entropy for the random
> + * number generator to use and the addresses it produces are fairly likely to
> + * be the same as those of other identical systems on the same local network.
> + * This is true even for relatively small numbers of systems (for the reason
> + * why, see the Wikipedia entry for "Birthday problem" at:
> + *	http://en.wikipedia.org/wiki/Birthday_problem
> + *
> + * The good news is that we already have a MAC address known to be unique, the
> + * RF MAC address. The bad news is that this address is already in use on the
> + * RF interface. Worse, the obvious trick, taking the RF MAC address and
> + * turning on the locally managed bit, has already been used for other devices.
> + * Still, this does give us something to work with.
> + *
> + * The approach we take is:
> + * 1.	If we can't get the RF MAC Address, just call random_ether_addr.
> + * 2.	Use the 24-bit NIC-specific bits of the RF MAC address as the last 24
> + *	bits of the new address. This is very likely to be unique, except for
> + *	the current box.
> + * 3.	To avoid using addresses already on the current box, we set the top
> + *	six bits of the address with a value different from any currently
> + *	registered Scientific Atlanta organizationally unique identifyer
> + *	(OUI). This avoids duplication with any addresses on the system that
> + *	were generated from valid Scientific Atlanta-registered address by
> + *	simply flipping the locally managed bit.
> + * 4.	We aren't generating a multicast address, so we leave the multicast
> + *	bit off. Since we aren't using a registered address, we have to set
> + *	the locally managed bit.
> + * 5.	We then randomly generate the remaining 16-bits. This does two
> + *	things:
> + *	a.	It allows us to call this function for more than one device
> + *		in this system
> + *	b.	It ensures that things will probably still work even if
> + *		some device on the device network has a locally managed
> + *		address that matches the top six bits from step 2.
> + */
> +void platform_random_ether_addr(u8 addr[ETH_ALEN])
> +{
> +#define	NUM_RANDOM_BYTES		2
> +#define	NON_SCIATL_OUI_BITS		0xc0u
> +#define	MAC_ADDR_LOCALLY_MANAGED	(1 << 1)
>   

whitespace

> +
> +	if (!have_rfmac) {
> +		pr_warning("rfmac not available on command line; "
> +			"generating random MAC address\n");
> +		random_ether_addr(addr);
> +	}
> +
> +	else {
> +		int	i;
> +
> +		/* Set the first byte to something that won't match a Scientific
> +		 * Atlanta OUI, is locally managed, and isn't a multicast
> +		 * address */
> +		addr[0] = NON_SCIATL_OUI_BITS | MAC_ADDR_LOCALLY_MANAGED;
> +
> +		/* Get some bytes of random address information */
> +		get_random_bytes(&addr[1], NUM_RANDOM_BYTES);
> +
> +		/* Copy over the NIC-specific bits of the RF MAC address */
> +		for (i = 1 + NUM_RANDOM_BYTES; i < ETH_ALEN; i++)
> +			addr[i] = rfmac[i];
> +	}
> +#undef	NON_RANDOM_BYTES
> +#undef	NON_SCIATL_OUI_BITS
> +#undef	MAC_ADDR_LOCALLY_MANAGED
>   

This is the end of a C file, no need for undef

> +}
> diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
> new file mode 100644
> index 0000000..9756090
> --- /dev/null
> +++ b/arch/mips/powertv/reset.c
> @@ -0,0 +1,69 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
>   

Attribution updates?

> + *
> + * ########################################################################
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * ########################################################################
> + *
> + */
> +#include <linux/pm.h>
> +
> +#include <linux/io.h>
> +#include <asm/reboot.h>			/* Not included by linux/reboot.h */
> +
> +#ifdef CONFIG_BOOTLOADER_DRIVER
> +#include <asm/mach-powertv/kbldr.h>
> +#endif
> +
> +#include <asm/mach-powertv/asic_regs.h>
> +#include "reset.h"
> +
> +static void mips_machine_restart(char *command);
> +static void mips_machine_halt(void);
> +
> +static void mips_machine_restart(char *command)
> +{
> +#ifdef CONFIG_BOOTLOADER_DRIVER
> +	/*
> +	 * Call the bootloader's reset function to ensure
> +	 * that persistent data is flushed before hard reset
> +	 */
> +	kbldr_SetCauseAndReset();
> +#else
> +	writel(0x1, asic_reg_addr(Watchdog));
> +#endif
> +}
> +
> +static void mips_machine_halt(void)
> +{
> +#ifdef CONFIG_BOOTLOADER_DRIVER
> +	/*
> +	 * Call the bootloader's reset function to ensure
> +	 * that persistent data is flushed before hard reset
> +	 */
> +	kbldr_SetCauseAndReset();
> +#else
> +	writel(0x1, asic_reg_addr(Watchdog));
> +#endif
> +}
> +
> +void mips_reboot_setup(void)
> +{
> +	_machine_restart = mips_machine_restart;
> +	_machine_halt = mips_machine_halt;
> +	pm_power_off = mips_machine_halt;
> +}
> diff --git a/arch/mips/powertv/reset.h b/arch/mips/powertv/reset.h
> new file mode 100644
> index 0000000..79211ce
> --- /dev/null
> +++ b/arch/mips/powertv/reset.h
> @@ -0,0 +1,8 @@
> +/*
> + * Definitions from powertv reset.c file
>   

GPL header?

> + */
> +
> +#ifndef _POWERTV_RESET_H
> +#define _POWERTV_RESET_H
> +extern void mips_reboot_setup(void);
> +#endif
> diff --git a/arch/mips/powertv/time.c b/arch/mips/powertv/time.c
> new file mode 100644
> index 0000000..b5806e5
> --- /dev/null
> +++ b/arch/mips/powertv/time.c
> @@ -0,0 +1,47 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * Setting up the clock on the MIPS boards.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/time.h>
> +#include <linux/timex.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/mipsmtregs.h>
> +#include <linux/hardirq.h>
> +#include <asm/irq.h>
> +#include <asm/div64.h>
> +#include <linux/cpu.h>
> +#include <linux/time.h>
> +
> +#include <asm/mips-boards/generic.h>
> +#include <asm/mips-boards/prom.h>
> +
> +#include "powertv-clock.h"
> +
> +void __init plat_time_init(void)
> +{
> +	powertv_clocksource_init();
> +	powertv_clockevent_init();
> +}
>   

A file this simple can't possibly need all those header files
included.  And as such, the original attributions from whatever
file it was originally cloned from are probably not relevant
whatsoever (unless this file was actually written for this
platform back in 1999!)

Paul.
