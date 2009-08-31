Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 02:12:42 +0200 (CEST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:56364 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493293AbZHaAMg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2009 02:12:36 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAKaymkqrR7MV/2dsb2JhbAC+e4hBAY4kBYQagVo
X-IronPort-AV: E=Sophos;i="4.44,301,1249257600"; 
   d="scan'208";a="235027626"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-1.cisco.com with ESMTP; 31 Aug 2009 00:12:22 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n7V0CMN1019009;
	Sun, 30 Aug 2009 17:12:22 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id n7V0CMYW002911;
	Mon, 31 Aug 2009 00:12:22 GMT
Date:	Sun, 30 Aug 2009 17:12:22 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] mips:powertv: Base files for Cisco Powertv
	platform, v3
Message-ID: <20090831001222.GA8101@cuplxvomd02.corp.sa.net>
References: <20090529183037.GA12464@cuplxvomd02.corp.sa.net> <20090828170654.GA30518@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090828170654.GA30518@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=17664; t=1251677542; x=1252541542;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=201/3]=20mips=3Apowertv=3A=20Bas
	e=20files=20for=20Cisco=20Powertv=0A=09platform,=20v3
	|Sender:=20;
	bh=D32dMY3dXM19u7B9pS/sxwb4pV1ELhD5JQuIX7Ni2C0=;
	b=lQOEPnBB+hRVicyDfgfg09HsDhcJUwgeUnSYz8bkoLr0cSAZze7U0qSR5y
	OBlxMMcjZMqqZtBsfdwotd0B0+5ymHHe0ObCIOwF6LPp8I4YLUQNrBFNrooq
	+AKYA93rzaJM8Jvilqw1LAAFtpYKHCQRoPJg4CMflKbjNcuoeIBVo=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Aug 28, 2009 at 06:06:54PM +0100, Ralf Baechle wrote:
> Old but goldie ...  Appologies for needing all eternity to come back
> to you on this patch.

This is by far the biggest chunk. I'll follow this message with a posting that
combines this chunk with the two smaller pieces.

I appreciate the time you spent on reviewing this. My response are in-line.

...
> > diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
> > new file mode 100644
> > index 0000000..da31ffb
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
> > @@ -0,0 +1,124 @@
> > +/*
> > + *				dma-coherence.h
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Version from mach-generic modified to support PowerTV port
> > + * Portions Copyright (C) 2009  Cisco Systems, Inc.
> > + * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
> > + *
> > + */
> > +
> > +#ifndef __ASM_MACH_POWERTV_DMA_COHERENCE_H
> > +#define __ASM_MACH_POWERTV_DMA_COHERENCE_H
> > +
> > +#include <linux/sched.h>
> > +#include <linux/version.h>
> > +#include <linux/device.h>
> > +#include <asm/mach-powertv/asic.h>
> > +
> > +static inline bool is_kseg2(void *addr)
> > +{
> > +	return (unsigned long)addr >= KSEG2;
> > +}
> > +
> > +static inline unsigned long virt_to_phys_from_pte(void *addr)
> > +{
> > +	pgd_t *pgd;
> > +	pud_t *pud;
> > +	pmd_t *pmd;
> > +	pte_t *ptep, pte;
> > +
> > +	unsigned long virt_addr = (unsigned long)addr;
> > +	unsigned long phys_addr = 0UL;
> > +
> > +	/* get the page global directory. */
> > +	pgd = pgd_offset_k(virt_addr);
> > +
> > +	if (!pgd_none(*pgd)) {
> > +		/* get the page upper directory */
> > +		pud = pud_offset(pgd, virt_addr);
> > +		if (!pud_none(*pud)) {
> > +			/* get the page middle directory */
> > +			pmd = pmd_offset(pud, virt_addr);
> > +			if (!pmd_none(*pmd)) {
> > +				/* get a pointer to the page table entry */
> > +				ptep = pte_offset(pmd, virt_addr);
> > +				pte = *ptep;
> > +				/* check for a valid page */
> > +				if (pte_present(pte)) {
> > +					/* get the physical address the page is
> > +					 * refering to */
> > +					phys_addr = (unsigned long)
> > +						page_to_phys(pte_page(pte));
> > +					/* add the offset within the page */
> > +					phys_addr |= (virt_addr & ~PAGE_MASK);
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	return phys_addr;
> > +}
> 
> Ouch.  What is the point of walking ptes here?  DMA to vmalloc'ed memory?
> The layer that invokes the dma_* mappings functions should do the
> vmalloc to physical address translation, see for example blk_rq_map_kern
> in the block layer.

No, not for vmalloced memory. As I recall, the primary use is for kmap_atomic()
pages, which don't go through the DMA subsystem.  I have high memory working
for 2.6.24, but it breaks on 2.6.25 or 2.6.26, so I don't have any patches for it,
yet. Once this gets into the tree, I'll more time to figure out what broken
there.

> > +static inline int plat_device_is_coherent(struct device *dev)
> > +{
> > +#ifdef CONFIG_DMA_COHERENT
> > +	return 1;
> > +#endif
> > +#ifdef CONFIG_DMA_NONCOHERENT
> > +	return 0;
> > +#endif
> 
> Do you have multiple system controllers or why do you offer both coherent
> and non-coherent DMA here?

No, it's always non-coherent. This is what kind of crud builds up when you don't
synch up with the kernel tree. I'll fix this.

...
> > diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
> > new file mode 100644
> > index 0000000..842e2fc
> > --- /dev/null
> > +++ b/arch/mips/powertv/asic/asic_devices.c
> > @@ -0,0 +1,713 @@
> > +/*
> > + *                   ASIC Device List Intialization
> > + *
...
> > +static u64 ehci_dmamask = 0xffffffffULL;
> 
> Use DMA_BIT_MASK(32)

Fixed.

> > +static struct platform_device ehci_device = {
> > +	.name = "powertv-ehci",
> > +	.id = 0,
> > +	.num_resources = 2,
> > +	.resource = ehci_resources,
> > +	.dev = {
> > +		.dma_mask = &ehci_dmamask,
> > +		.coherent_dma_mask = 0xffffffff,
> 
> Use DMA_BIT_MASK(32)

Fixed.

> > +static u64 ohci_dmamask = 0xffffffffULL;
> 
> Use DMA_BIT_MASK(32)

Fixed.

> > +static struct platform_device ohci_device = {
> > +	.name = "powertv-ohci",
> > +	.id = 0,
> > +	.num_resources = 2,
> > +	.resource = ohci_resources,
> > +	.dev = {
> > +		.dma_mask = &ohci_dmamask,
> > +		.coherent_dma_mask = 0xffffffff,
> 
> Use DMA_BIT_MASK(32)

Fixed.

> > +/*
> > + * Set up the USB EHCI interface
> > + */
> > +void platform_configure_usb_ehci()
> 
> Not a valid C prototype - add void.

Not intended as a prototype, prototype in arch/mips/include/asm/mach-powertv/asic.h

> > +/*
> > + * Set up the USB OHCI interface
> > + */
> > +void platform_configure_usb_ohci()
> 
> Not a valid C prototype - add void.

Not intended as a prototype, prototype in arch/mips/include/asm/mach-powertv/asic.h

> > +/*
> > + * Shut the USB EHCI interface down--currently a NOP
> > + */
> > +void platform_unconfigure_usb_ehci()
> 
> Not a valid C prototype - add void.

Not intended as a prototype, prototype in arch/mips/include/asm/mach-powertv/asic.h

> > +/*
> > + * Shut the USB OHCI interface down--currently a NOP
> > + */
> > +void platform_unconfigure_usb_ohci()
> 
> Not a valid C prototype - add void.

Not intended as a prototype, prototype in arch/mips/include/asm/mach-powertv/asic.h

...
> > +static int __init early_param_pmemlen(char *p)
> > +{
> > +/* TODO: we can use this code when and if the bootloader ever changes this */
> > +#if 0
> > +	pmemlen = (unsigned long)simple_strtoul(p, NULL, 0);
> 
> if this code is useless enough to be #if 0'ed out, consider deleting it?

It's there as a reminder to the kernel team to keep bugging the bootloader team
to address this. I think they came close earlier this year...

...
> > diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
> > new file mode 100644
> > index 0000000..ba60bd6
> > --- /dev/null
> > +++ b/arch/mips/powertv/asic/asic_int.c
> > @@ -0,0 +1,125 @@
...
> > +static inline unsigned int irq_ffs(unsigned int pending)
> > +{
> > +	return -clz(pending) + 31 - CAUSEB_IP;
> > +}
> 
> Please use fls() from <linux/bitops.h> instead and get rid of clz().  For
> MIPS32 processors fls() is implemented using CLZ.

Fixed.

> > diff --git a/arch/mips/powertv/asic/prealloc-calliope.c b/arch/mips/powertv/asic/prealloc-calliope.c
> > new file mode 100644
> > index 0000000..6823c4c
> > --- /dev/null
> > +++ b/arch/mips/powertv/asic/prealloc-calliope.c
...
> > +	/*
> > +	 * Add other resources here
> > +	 *
> > +	 */
> > +	/*
> > +	 * End of Resource marker
> > +	 */
> 
> Some comments just don't deserve to exist ...

Agreed. Fixed.

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed.

> Some comments just don't deserve to exist ...

Fixed.

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed.

> > +	/*
> > +	 * End of Resource marker
> > +	 */
> 
> Some comments just don't deserve to exist ...

Fixed.

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed.

> > +	/*
> > +	 * End of Resource marker
> > +	 */
> 
> Some comments just don't deserve to exist ...

Fixed.

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed.

> > diff --git a/arch/mips/powertv/asic/prealloc-cronus.c b/arch/mips/powertv/asic/prealloc-cronus.c
> > new file mode 100644
> > index 0000000..b433efd
> > --- /dev/null
> > +++ b/arch/mips/powertv/asic/prealloc-cronus.c
...
> > +	/*
> > +	 * End of Resource marker
> > +	 *
> > +	 */
> 
> Some comments just don't deserve to exist ...

Fixed

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed

> > +/*
> > + * NON_DVR_CAPABLE CRONUS RESOURCES
> > + */
> > +struct resource non_dvr_cronus_resources[] __initdata =
...
> Some comments just don't deserve to exist ...

Fixed

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed

> > diff --git a/arch/mips/powertv/asic/prealloc-cronuslite.c b/arch/mips/powertv/asic/prealloc-cronuslite.c
> > new file mode 100644
> > index 0000000..5bba999
> > --- /dev/null
> > +++ b/arch/mips/powertv/asic/prealloc-cronuslite.c
...
> > +	/*
> > +	 * End of Resource marker
> > +	 *
> > +	 */
> 
> Some comments just don't deserve to exist ...

Fixed

> > +	{
> > +		.flags  = 0,
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed

> > diff --git a/arch/mips/powertv/asic/prealloc-zeus.c b/arch/mips/powertv/asic/prealloc-zeus.c
> > new file mode 100644
> > index 0000000..3205954
> > --- /dev/null
> > +++ b/arch/mips/powertv/asic/prealloc-zeus.c
...
> > +	/*
> > +	 * End of Resource marker
> > +	 *
> > +	 */
> 
> Some comments just don't deserve to exist ...

Fixed

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed

...
> > +/*
> > + * NON_DVR_CAPABLE ZEUS RESOURCES
> > + */
> > +struct resource non_dvr_zeus_resources[] __initdata =
...
> > +	/*
> > +	 * Add other resources here
> > +	 *
> > +	 * End of Resource marker
> > +	 */
> 
> Some comments just don't deserve to exist ...

Fixed

> > +	{
> > +		.flags  = 0,
> 
> No need to explicitly initialize a member of the end marker; just {} will do
> fine.

Fixed

> > diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
> > new file mode 100644
> > index 0000000..ef7768d
> > --- /dev/null
> > +++ b/arch/mips/powertv/cevt-powertv.c
...
> > +/*
> > + * The file comes from kernel/cevt-r4k.c
> > + */
> 
> Do you really need this file which to a significant degree is a clone of
> cevt-r4k.c?  Maybe you can get away with a wrapper around cevt-r4k.c.  If
> not, please move this file to arch/mips/kernel/

I've switched to using cevt-r4k.c.  We get our IRQ numbers from an external
source, so we need to use the MIPSR2-supported TI bit in the CP0 Cause register
to determine whether a timer interrupt happens. This change is included
in the new patch. We also need to implement a get_c0_compare_int() function,
which is all that will be left in the cevt-powertv.c file.

> > diff --git a/arch/mips/powertv/csrc-powertv.c b/arch/mips/powertv/csrc-powertv.c
> > new file mode 100644
> > index 0000000..a27c16c
> > --- /dev/null
> > +++ b/arch/mips/powertv/csrc-powertv.c
...
> > + * The file comes from kernel/csrc-r4k.c
> 
> So why not simply using csrc-r4k.c?  Set mips_hpt_frequency before
> init_r4k_clocksource() is initialized and voila.

Done. Voila.

> > + */
> > +#include <linux/clocksource.h>
> > +#include <linux/init.h>
> > +
> > +#include <asm/time.h>			/* Not included in linux/time.h */
> 
> Which makes checkpatch.pl emit bogus warnings.  I guess I should rename
> asm/time.h and a few other headers affected by this issue for clarity and
> fixup all the references.

That's way I have that comment in there; it's hard to remember which things
can be linux/xyz.h and which must be asm/xyz.h. Renaming would be appreciated.

> > +
> > +static cycle_t tim_c_read(struct clocksource *cs)
> > +{
> > +	unsigned int hi;
> > +	unsigned int next_hi;
> > +	unsigned int lo;
> > +
> > +	hi = readl(&tim_c->hi);
> > +
> > +	for (;;) {
> > +		lo = readl(&tim_c->lo);
> > +		next_hi = readl(&tim_c->hi);
> > +		if (next_hi == hi)
> > +			break;
> > +		hi = next_hi;
> > +	}
> > +
> > +pr_crit("%s: read %llx\n", __func__, ((u64) hi << 32) | lo);
> 
> Debugging crap in a function that might be called frequently or well, is
> clocksource_tim_c being used at all?

The debugging crap is fixed. As far as to whether clocksource_tim_c is being
use at all, the answer is, not in this code, but it is in a pending patch. As
I've mentioned previously, there are a number of patches waiting for the base
Powertv code to go into the MIPS tree.

> > diff --git a/arch/mips/powertv/pci/fixup-powertv.c b/arch/mips/powertv/pci/fixup-powertv.c
> > new file mode 100644
> > index 0000000..726bc2e
> > --- /dev/null
> > +++ b/arch/mips/powertv/pci/fixup-powertv.c
...
> > +int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > +{
> > +	return irq_pciexp;
> > +}
> > +EXPORT_SYMBOL(asic_pcie_map_irq);
> 
> I don't see a module user of asic_pcie_map_irq()?

EXPORT dropped.

> > diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
> > new file mode 100644
> > index 0000000..bd8ebf1
> > --- /dev/null
> > +++ b/arch/mips/powertv/powertv_setup.c
> > @@ -0,0 +1,351 @@
...
> > +static void register_panic_notifier(void);
> > +static int panic_handler(struct notifier_block *notifier_block,
> > +	unsigned long event, void *cause_string);
> 
> If you reorder the functions in this file you can get away without
> prototypes.

Fixed.

> > +
> > +const char *get_system_type(void)
> > +{
> > +	return "PowerTV";
> > +}
> > +
> > +void __init plat_mem_setup(void)
> > +{
> > +	panic_on_oops = 1;
> > +	register_panic_notifier();
> > +
> > +#if 0
> > +	mips_pcibios_init();
> > +#endif
> 
> Dead code to be deleted?

Sure looks like it to me, fixed.

> > +static void register_panic_notifier()
> > +{
> > +	static struct notifier_block panic_notifier = {
> > +		.notifier_call = panic_handler,
> > +		.next = NULL,
> 
> No need to initialize .next.

Fixed

> > +#ifdef CONFIG_DIAGNOSTICS
> > +	failure_report((char *) cause_string,
> > +		have_die_regs ? &die_regs : &my_regs);
> > +	have_die_regs = false;
> > +#else
> > +	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
> > +		"zzzz... \n");
> > +#endif
> 
> What is the point of all this?  Almost all registers have likely been
> modified since panic() was invoked so there is little point in taking a
> register snapshot?

It depends. There is code, for a later patch, that registers a notifier called
from do_trap_or_bp. The notifier function copies the pt_regs, so that a stack
backtrace can be done from that point. If panic() was called directly, we still
want a backtrace and need a good set of register saved. You must save the $pc,
$sp, and $s0-$s8 to do a backtrace by the rules. You could skip the rest of the
registers, but saving all of them is fast, takes little code, and would be nice
to have if the backtrace rules ever change.

> > +void platform_random_ether_addr(u8 addr[ETH_ALEN])
> 
> No caller for this function nor exported to a module.

Used in a patch to be released later.

> > +{
> > +	const int num_random_bytes = 2;
> > +	const unsigned char non_sciatl_oui_bits = 0xc0u;
> > +	const unsigned char mac_addr_locally_managed = (1 << 1);
> > +
> > +	if (!have_rfmac) {
> > +		pr_warning("rfmac not available on command line; "
> > +			"generating random MAC address\n");
> > +		random_ether_addr(addr);
> > +	}
> > +
> > +	else {
> 
> Please make that } else {

I mail all patches with a script that runs checkpatch every time, so it looks
like checkpatch has a small bug. This problem is fixed.

> > +		int	i;
> > +
> > +		/* Set the first byte to something that won't match a Scientific
> > +		 * Atlanta OUI, is locally managed, and isn't a multicast
> > +		 * address */
> > +		addr[0] = non_sciatl_oui_bits | mac_addr_locally_managed;
> > +
> > +		/* Get some bytes of random address information */
> > +		get_random_bytes(&addr[1], num_random_bytes);
> 
> This is probably meant to be called during early bootup when there is very
> little entropy available and depending on the exact details maybe even
> duplicate addresses.  Can be hairy to solve for some systems.

Tell me about it. There are tons of entropy later, since we funnel many video and
audio streams through the box, but at boot time we are begging for random bits.

> > diff --git a/arch/mips/powertv/reset.h b/arch/mips/powertv/reset.h
> > new file mode 100644
> > index 0000000..93d58b9
> > --- /dev/null
> > +++ b/arch/mips/powertv/reset.h
...
> > +#ifndef _POWERTV_POWERTV_RESET_H
> > +#define _POWERTV_POWERTV_RESET_H
> > +extern void mips_reboot_setup(void);
> > +#endif
> 
> This header file seems to only exist to eleminate checkpatch.pl's often
> bogus warning about prototypes in C files.  I suggest to remove this
> headerfile and invoke mips_reboot_setup via some initcall, like
> arch_initcall().

Would that it made even that much sense. It's just that there was one tiny
function in a little file that need to be called from one other place. So,
I consolidated the files. Easy. Fixed.

> When re-sending, please feel free to merge patches 2/3 and 3/3 into this
> first one.  Splitting doesn't really make much sense in this case.

I'm happy to combine them.

>   Ralf

David VL
