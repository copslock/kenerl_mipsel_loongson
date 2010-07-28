Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 20:54:53 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:38165 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492189Ab0G1Sys convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jul 2010 20:54:48 +0200
Received: by ywe9 with SMTP id 9so1193927ywe.36
        for <multiple recipients>; Wed, 28 Jul 2010 11:54:41 -0700 (PDT)
Received: by 10.151.21.16 with SMTP id y16mr13562813ybi.232.1280343281315; 
        Wed, 28 Jul 2010 11:54:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.84.4 with HTTP; Wed, 28 Jul 2010 11:54:21 -0700 (PDT)
In-Reply-To: <20100727214948.GA29241@dediao-lnx2.corp.sa.net>
References: <20100727214948.GA29241@dediao-lnx2.corp.sa.net>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 28 Jul 2010 12:54:21 -0600
X-Google-Sender-Auth: 0RKsLFVmW44dqhANvRgbyOLTDZ4
Message-ID: <AANLkTi=a=tGURpMKo7g+32LMcFovx4GJk2Wid6vmvQt8@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
To:     Dezhong Diao <dediao@cisco.com>
Cc:     devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, dvomlehn@cisco.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

Hi Dezhong,

Thanks for the patches.  Do you want me to carry these in my test tree
for a while?  I won't be able to test them, but I'll be able to rework
as I make changes to the drivers/of core code.  I'm still making
changes to reduce the number of symbols that architectures need to
implement in order to bring up CONFIG_OF support.

Comments below.

On Tue, Jul 27, 2010 at 3:49 PM, Dezhong Diao <dediao@cisco.com> wrote:
> V2:
>    Synchronize with test-devicetree branch of device tree.
>
> V1:
>    Add common code to support device tree on MIPS.
>
> Signed-off-by: Dezhong Diao <dediao@cisco.com>
> ---
>  arch/mips/Kconfig            |   13 ++++
>  arch/mips/include/asm/prom.h |   61 ++++++++++++++++
>  arch/mips/kernel/Makefile    |    2 +
>  arch/mips/kernel/prom.c      |  158 ++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/setup.c     |    2 +
>  5 files changed, 236 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/prom.h
>  create mode 100644 arch/mips/kernel/prom.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index cdaae94..d85e8fb 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2083,6 +2083,19 @@ config SECCOMP
>
>          If unsure, say Y. Only embedded should say N here.
>
> +config USE_OF
> +       bool "Flattened Device Tree support"
> +       select OF
> +       select OF_FLATTREE
> +       help
> +         Include support for flattened device tree machine descriptions.
> +
> +config ARCH_HAS_DEVTREE_MEM
> +       bool "Support user-defined memory scan function in device tree"
> +       depends on OF
> +       help
> +         The user has a customized function to parse memory nodes.
> +

Hmm, This is a little ugly.  I should rework the memory functions
override code to not require this config symbol.  I'll look into that.

>  endmenu
>
>  config LOCKDEP_SUPPORT
> diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
> new file mode 100644
> index 0000000..b798b19
> --- /dev/null
> +++ b/arch/mips/include/asm/prom.h
> @@ -0,0 +1,61 @@
> +/*
> + *  arch/mips/include/asm/prom.h
> + *
> + *  Copyright (C) 2010 Cisco Systems Inc. <dediao@cisco.com>
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
> +#include <linux/init.h>
> +
> +#include <asm/setup.h>
> +#include <asm/irq.h>
> +#include <asm/bootinfo.h>
> +
> +/* which is compatible with the flattened device tree (FDT) */
> +#define cmd_line arcs_cmdline
> +
> +/*
> + * Use this value to indicate lack of interrupt
> + * capability
> + */
> +#ifndef NO_IRQ
> +#define NO_IRQ  ((unsigned int)(-1))
> +#endif
> +
> +static inline unsigned long pci_address_to_pio(phys_addr_t address)
> +{
> +       return (unsigned long)-1;
> +}
> +
> +struct device_node;
> +
> +static inline int of_node_to_nid(struct device_node *device)
> +{
> +       return 0;
> +}

This should no longer be necessary in the current test-devicetree branch.

> +
> +static inline void __init early_init_dt_scan_chosen_arch(unsigned long node)
> +{
> +}
> +
> +extern int __init early_init_dt_scan_memory_arch(unsigned long node,
> +       const char *uname, int depth, void *data);
> +
> +extern int __init reserve_mem_mach(unsigned long addr, unsigned long size);
> +extern void __init free_mem_mach(unsigned long addr, unsigned long size);
> +
> +extern void __init device_tree_init(void);
> +#else /* CONFIG_OF */
> +static inline void __init device_tree_init(void)
> +{
> +}
> +#endif /* CONFIG_OF */
> +
> +#endif /* _ASM_MIPS_PROM_H */
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 7a6ac50..4d4ceb1 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -95,6 +95,8 @@ obj-$(CONFIG_KEXEC)           += machine_kexec.o relocate_kernel.o
>  obj-$(CONFIG_EARLY_PRINTK)     += early_printk.o
>  obj-$(CONFIG_SPINLOCK_TEST)    += spinlock_test.o
>
> +obj-$(CONFIG_OF)               += prom.o
> +
>  CFLAGS_cpu-bugs64.o    = $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
>
>  obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)  += 8250-platform.o
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> new file mode 100644
> index 0000000..fb4adc2
> --- /dev/null
> +++ b/arch/mips/kernel/prom.c
> @@ -0,0 +1,158 @@
> +/*
> + *  linux/arch/mips/kernel/prom.c
> + *
> + *  Copyright (C) 2010 Cisco Systems Inc. <dediao@cisco.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/bootmem.h>
> +#include <linux/initrd.h>
> +#include <linux/debugfs.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/page.h>
> +#include <asm/prom.h>
> +
> +/*
> + * The list of OF IDs below is used for matching bus types in the
> + * system whose devices are to be exposed as of_platform_devices.
> + *
> + * This is the default list valid for most platforms. This file provides
> + * functions who can take an explicit list if necessary though
> + *
> + * The search is always performed recursively looking for children of
> + * the provided device_node and recursively if such a children matches
> + * a bus type in the list
> + */
> +const struct of_device_id of_default_bus_ids[] = {
> +       {},
> +};

You can also remove this symbol now.

> +
> +#ifndef CONFIG_ARCH_HAS_DEVTREE_MEM
> +int __init early_init_dt_scan_memory_arch(unsigned long node,
> +                                         const char *uname, int depth,
> +                                         void *data)
> +{
> +       return early_init_dt_scan_memory(node, uname, depth, data);
> +}
> +
> +void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> +{
> +       return add_memory_region(base, size, BOOT_MEM_RAM);
> +}
> +
> +int __init reserve_mem_mach(unsigned long addr, unsigned long size)
> +{
> +       return reserve_bootmem(addr, size, BOOTMEM_DEFAULT);
> +}
> +
> +void __init free_mem_mach(unsigned long addr, unsigned long size)
> +{
> +       return free_bootmem(addr, size);
> +}
> +#endif
> +
> +u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> +{
> +       return virt_to_phys(
> +               __alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS))
> +               );
> +}
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +void __init early_init_dt_setup_initrd_arch(unsigned long start,
> +                                           unsigned long end)
> +{
> +       initrd_start = (unsigned long)__va(start);
> +       initrd_end = (unsigned long)__va(end);
> +       initrd_below_start_ok = 1;
> +}
> +#endif
> +
> +/*
> + * Interrupt remapper
> + */
> +struct device_node *of_irq_find_parent_by_phandle(phandle p)
> +{
> +       return of_find_node_by_phandle(p);
> +}

Also can be removed.

> +
> +/*
> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a Linux irq#
> + *
> + * Currently the mapping mechanism is trivial; simple flat hwirq numbers are
> + * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
> + * supported.
> + */
> +unsigned int irq_create_of_mapping(struct device_node *controller,
> +                                  const u32 *intspec, unsigned int intsize)
> +{
> +       return intspec[0];
> +}
> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
> +
> +void __init early_init_devtree(void *params)
> +{
> +       /* Setup flat device-tree pointer */
> +       initial_boot_params = params;
> +
> +       /* Retrieve various informations from the /chosen node of the
> +        * device-tree, including the platform type, initrd location and
> +        * size, and more ...
> +        */
> +       of_scan_flat_dt(early_init_dt_scan_chosen, NULL);
> +
> +       /* Scan memory nodes */
> +       of_scan_flat_dt(early_init_dt_scan_root, NULL);
> +       of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL);
> +}
> +
> +void __init device_tree_init(void)
> +{
> +       unsigned long base, size;
> +
> +       if (!initial_boot_params)
> +               return;
> +
> +       base = virt_to_phys((void *)initial_boot_params);
> +       size = initial_boot_params->totalsize;
> +
> +       /* Before we do anything, lets reserve the dt blob */
> +       reserve_mem_mach(base, size);
> +
> +       unflatten_device_tree();
> +
> +       /* free the space reserved for the dt blob */
> +       free_mem_mach(base, size);
> +}
> +
> +#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
> +static struct dentry *of_debugfs_root;
> +static struct debugfs_blob_wrapper flat_dt_blob;
> +
> +static int __init export_flat_device_tree(void)
> +{
> +       struct dentry *d;
> +
> +       flat_dt_blob.data = initial_boot_params;
> +       flat_dt_blob.size = initial_boot_params->totalsize;
> +
> +       d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
> +                               of_debugfs_root, &flat_dt_blob);
> +       if (!d)
> +               return 1;
> +
> +       return 0;
> +}
> +device_initcall(export_flat_device_tree);
> +#endif

I'm probably also going to move the debugfs file into common code
(unless someone beats me to it).  :-)

> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 85aef3f..a6b900f 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -31,6 +31,7 @@
>  #include <asm/setup.h>
>  #include <asm/smp-ops.h>
>  #include <asm/system.h>
> +#include <asm/prom.h>
>
>  struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
>
> @@ -487,6 +488,7 @@ static void __init arch_mem_init(char **cmdline_p)
>        }
>
>        bootmem_init();
> +       device_tree_init();
>        sparse_init();
>        paging_init();
>  }

Very nice clean patch, thanks!  How/when would you like to see MIPS OF
support go into mainline?

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
