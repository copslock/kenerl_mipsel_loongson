Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 22:51:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9610 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491867Ab0JRUu7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 22:50:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cbcb3540000>; Mon, 18 Oct 2010 13:51:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Oct 2010 13:51:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Oct 2010 13:51:15 -0700
Message-ID: <4CBCB330.4090205@caviumnetworks.com>
Date:   Mon, 18 Oct 2010 13:50:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>, dediao@cisco.com
CC:     benh@kernel.crashing.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, monstr@monstr.eu, dvomlehn@cisco.com,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/2 RFC] of/mips: Add device tree support to MIPS
References: <20101013064352.2743.80378.stgit@localhost6.localdomain6> <20101013064416.2743.42892.stgit@localhost6.localdomain6>
In-Reply-To: <20101013064416.2743.42892.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2010 20:51:15.0747 (UTC) FILETIME=[34DB5F30:01CB6F06]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Although I tested this patch, and it compiles, I have a few more 
comments now that I have studied it.

Basically, it looks like most of the code in arch/mips/kernel/prom.c is 
not generic to MIPS, but instead highly specific to some platform 
(perhaps PowerTV).

On 10/12/2010 11:48 PM, Grant Likely wrote:
> From: Dezhong Diao<dediao@cisco.com>
>
> Add the ability to enable CONFIG_OF on the MIPS architecture.
>
> Signed-off-by: Dezhong Diao<dediao@cisco.com>
> [grant.likely@secretlab.ca: cleared out obsolete hooks,
> 	removed ARCH_HAS_DEVTREE_MEM from being manually selected,
> 	remove __init tags from header file]
> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney<ddaney@caviumnetworks.com>
> Cc: David VomLehn<dvomlehn@cisco.com>
> ---
>
> I've not tested this on anything, but I picked up the MIPS device tree
> patch written by Dezhong and updated it to match the changes in
> mainline.  I also half-heartedly tried to rebase the powertv support
> patch, didn't get very far due to the refactoring in
> arch/mips/powertv/memory.c
>
> Anyway, please take a look and give it a spin.  If it looks good, then
> I can add it into my -next branch.
>
> g.
>
>   arch/mips/Kconfig            |   13 ++++
>   arch/mips/include/asm/prom.h |   35 +++++++++++
>   arch/mips/kernel/Makefile    |    2 +
>   arch/mips/kernel/prom.c      |  135 ++++++++++++++++++++++++++++++++++++++++++
>   arch/mips/kernel/setup.c     |    2 +
>   5 files changed, 187 insertions(+), 0 deletions(-)
>   create mode 100644 arch/mips/include/asm/prom.h
>   create mode 100644 arch/mips/kernel/prom.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3ad59dd..15e364d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2107,6 +2107,19 @@ config SECCOMP
>
>   	  If unsure, say Y. Only embedded should say N here.
>
> +config USE_OF
> +	bool "Flattened Device Tree support"
> +	select OF
> +	select OF_FLATTREE
> +	help
> +	  Include support for flattened device tree machine descriptions.
> +
> +config ARCH_HAS_DEVTREE_MEM
> +	bool
> +	depends on OF
> +	help
> +	  The user has a customized function to parse memory nodes.
> +
>   endmenu
>

These Kconfig items should only be selectable if OF is truly supported. 
  Hardwiring  ARCH_HAS_DEVTREE_MEM to USE_OF at this global level 
doesn't seem quite right either.  I think it is conceivable that we 
would want USE_OF without ARCH_HAS_DEVTREE_MEM.


>   config LOCKDEP_SUPPORT
> diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
> new file mode 100644
> index 0000000..23f8237
> --- /dev/null
> +++ b/arch/mips/include/asm/prom.h
> @@ -0,0 +1,35 @@
> +/*
> + *  arch/mips/include/asm/prom.h
> + *
> + *  Copyright (C) 2010 Cisco Systems Inc.<dediao@cisco.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#ifndef __ASM_MIPS_PROM_H
> +#define __ASM_MIPS_PROM_H
> +
> +#ifdef CONFIG_OF
> +#include<linux/init.h>
> +
> +#include<asm/setup.h>
> +#include<asm/irq.h>
> +#include<asm/bootinfo.h>
> +
> +/* which is compatible with the flattened device tree (FDT) */
> +#define cmd_line arcs_cmdline
> +
> +extern int early_init_dt_scan_memory_arch(unsigned long node,
> +	const char *uname, int depth, void *data);
> +
> +extern int reserve_mem_mach(unsigned long addr, unsigned long size);
> +extern void free_mem_mach(unsigned long addr, unsigned long size);
> +
> +extern void __init device_tree_init(void);
> +#else /* CONFIG_OF */
> +static inline void __init device_tree_init(void) { }
> +#endif /* CONFIG_OF */
> +
> +#endif /* _ASM_MIPS_PROM_H */
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 06f8482..8088498 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -96,6 +96,8 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
>   obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>   obj-$(CONFIG_SPINLOCK_TEST)	+= spinlock_test.o
>
> +obj-$(CONFIG_OF)		+= prom.o
> +
>   CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null>/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
>
>   obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> new file mode 100644
> index 0000000..6378834
> --- /dev/null
> +++ b/arch/mips/kernel/prom.c
> @@ -0,0 +1,135 @@
> +/*
> + *  linux/arch/mips/kernel/prom.c
> + *
> + *  Copyright (C) 2010 Cisco Systems Inc.<dediao@cisco.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include<linux/init.h>
> +#include<linux/module.h>
> +#include<linux/errno.h>
> +#include<linux/types.h>
> +#include<linux/bootmem.h>
> +#include<linux/initrd.h>
> +#include<linux/debugfs.h>
> +#include<linux/of.h>
> +#include<linux/of_fdt.h>
> +#include<linux/of_irq.h>
> +#include<linux/of_platform.h>
> +
> +#include<asm/page.h>
> +#include<asm/prom.h>
> +
> +#ifndef CONFIG_ARCH_HAS_DEVTREE_MEM
> +int __init early_init_dt_scan_memory_arch(unsigned long node,
> +					  const char *uname, int depth,
> +					  void *data)
> +{
> +	return early_init_dt_scan_memory(node, uname, depth, data);
> +}
> +
> +void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> +{
> +	return add_memory_region(base, size, BOOT_MEM_RAM);
> +}
> +
> +int __init reserve_mem_mach(unsigned long addr, unsigned long size)
> +{
> +	return reserve_bootmem(addr, size, BOOTMEM_DEFAULT);
> +}
> +
> +void __init free_mem_mach(unsigned long addr, unsigned long size)
> +{
> +	return free_bootmem(addr, size);
> +}
> +#endif
> +
> +u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> +{
> +	return virt_to_phys(
> +		__alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS))
> +		);
> +}
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +void __init early_init_dt_setup_initrd_arch(unsigned long start,
> +					    unsigned long end)
> +{
> +	initrd_start = (unsigned long)__va(start);
> +	initrd_end = (unsigned long)__va(end);
> +	initrd_below_start_ok = 1;
> +}
> +#endif
> +
> +/*
> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
> + *
> + * Currently the mapping mechanism is trivial; simple flat hwirq numbers are
> + * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
> + * supported.
> + */
> +unsigned int irq_create_of_mapping(struct device_node *controller,
> +				   const u32 *intspec, unsigned int intsize)
> +{
> +	return intspec[0];
> +}
> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
> +

This mapping function depends on the interrupt controller architecture. 
  It is not at all a good fit for what I want to do on Octeon.  We have 
a hierarchy of interrupt mapping that is best described by a two level 
tree, so has '#interrupt-cells = <2>;'.  We definitely need a different 
implementation than this.

> +void __init early_init_devtree(void *params)
> +{
> +	/* Setup flat device-tree pointer */
> +	initial_boot_params = params;
> +
> +	/* Retrieve various informations from the /chosen node of the
> +	 * device-tree, including the platform type, initrd location and
> +	 * size, and more ...
> +	 */
> +	of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
> +
> +	/* Scan memory nodes */
> +	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> +	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
> +}
> +
> +void __init device_tree_init(void)
> +{
> +	unsigned long base, size;
> +
> +	if (!initial_boot_params)
> +		return;
> +
> +	base = virt_to_phys((void *)initial_boot_params);
> +	size = initial_boot_params->totalsize;
> +
> +	/* Before we do anything, lets reserve the dt blob */
> +	reserve_mem_mach(base, size);
> +
> +	unflatten_device_tree();
> +
> +	/* free the space reserved for the dt blob */
> +	free_mem_mach(base, size);
> +}
> +
> +#if defined(CONFIG_DEBUG_FS)&&  defined(DEBUG)
> +static struct dentry *of_debugfs_root;
> +static struct debugfs_blob_wrapper flat_dt_blob;
> +
> +static int __init export_flat_device_tree(void)
> +{
> +	struct dentry *d;
> +
> +	flat_dt_blob.data = initial_boot_params;
> +	flat_dt_blob.size = initial_boot_params->totalsize;
> +
> +	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
> +				of_debugfs_root,&flat_dt_blob);
> +	if (!d)
> +		return 1;
> +
> +	return 0;
> +}
> +device_initcall(export_flat_device_tree);

This debugfs bit will fail.  of_debugfs_root is never initialized that I 
can see.


> +#endif
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 85aef3f..a6b900f 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -31,6 +31,7 @@
>   #include<asm/setup.h>
>   #include<asm/smp-ops.h>
>   #include<asm/system.h>
> +#include<asm/prom.h>
>
>   struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
>
> @@ -487,6 +488,7 @@ static void __init arch_mem_init(char **cmdline_p)
>   	}
>
>   	bootmem_init();
> +	device_tree_init();
>   	sparse_init();
>   	paging_init();
>   }
>
>
