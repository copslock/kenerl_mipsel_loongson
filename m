Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 19:24:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13697 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492221Ab0ELRYO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 19:24:14 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4beae44d0000>; Wed, 12 May 2010 10:24:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 12 May 2010 10:24:09 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 12 May 2010 10:24:08 -0700
Message-ID: <4BEAE438.7080303@caviumnetworks.com>
Date:   Wed, 12 May 2010 10:24:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
CC:     linux-mips@linux-mips.org,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        "Tony Colclough (colclot)" <colclot@cisco.com>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/2] The Device Tree Patch for MIPS
References: <7A9214B0DEB2074FBCA688B30B04400DC64136@XMB-RCD-208.cisco.com>
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400DC64136@XMB-RCD-208.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2010 17:24:08.0922 (UTC) FILETIME=[EE361BA0:01CAF1F7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/10/2010 02:34 PM, Dezhong Diao (dediao) wrote:
> Add common device tree support for MIPS.
>

You are missing a 'Signed-off-by:' here.


>
> ---
>   arch/mips/Kconfig                   |   20 ++++
>   arch/mips/include/asm/of_device.h   |    3 +
>   arch/mips/include/asm/of_platform.h |    9 ++
>   arch/mips/include/asm/prom.h        |   64 ++++++++++++++
>   arch/mips/kernel/Makefile           |    2 +
>   arch/mips/kernel/prom.c             |  164
> +++++++++++++++++++++++++++++++++++
>   arch/mips/kernel/setup.c            |    2 +
>   7 files changed, 264 insertions(+), 0 deletions(-)  create mode 100644
> arch/mips/include/asm/of_device.h  create mode 100644
> arch/mips/include/asm/of_platform.h
>   create mode 100644 arch/mips/include/asm/prom.h  create mode 100644
> arch/mips/kernel/prom.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig index
> 29e8692..55d8331 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2052,6 +2052,26 @@ config SECCOMP
>
>   	  If unsure, say Y. Only embedded should say N here.
>
> +config OF
> +	bool "Device tree support"
> +	select OF_FLATTREE
> +	help
> +	  Support for OpenFirmware-style device trees
> +
> +config PROC_DEVICETREE
> +	bool "Support for device tree in /proc"
> +	depends on PROC_FS&&  OF
> +	help
> +	  This option adds a device-tree directory under /proc which
> contains
> +	  an image of the device tree that the kernel copies from Open
> +	  Firmware or other boot firmware. If unsure, say Y here.
> +
> +config ARCH_HAS_DEVTREE_MEM
> +	bool "Support user-defined memory scan function in device tree"
> +	depends on OF
> +	help
> +	  The user has a customized function to parse memory nodes.
> +
>   endmenu
>
>   config LOCKDEP_SUPPORT
> diff --git a/arch/mips/include/asm/of_device.h
> b/arch/mips/include/asm/of_device.h
> new file mode 100644
> index 0000000..7a83477
> --- /dev/null
> +++ b/arch/mips/include/asm/of_device.h
> @@ -0,0 +1,3 @@
> +#ifndef _ASM_MIPS_OF_DEVICE_H
> +#define _ASM_MIPS_OF_DEVICE_H
> +#endif /* _ASM_MIPS_OF_DEVICE_H */
> diff --git a/arch/mips/include/asm/of_platform.h
> b/arch/mips/include/asm/of_platform.h
> new file mode 100644
> index 0000000..7a33827
> --- /dev/null
> +++ b/arch/mips/include/asm/of_platform.h
> @@ -0,0 +1,9 @@
> +#ifndef _ASM_MIPS_OF_PLATFORM_H
> +#define _ASM_MIPS_OF_PLATFORM_H
> +
> +static inline void of_device_make_bus_id(struct device *dev) {
> +	__of_device_make_bus_id(dev);
> +}
> +
> +#endif /* _ASM_MIPS_OF_PLATFORM_H */
> diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
> new file mode 100644 index 0000000..e72b0df
> --- /dev/null
> +++ b/arch/mips/include/asm/prom.h
> @@ -0,0 +1,64 @@
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
> +/* _ALIGN expects upwards alignment */
> +#define _ALIGN(addr, size)	(((addr) + ((size) - 1))&  (~((size) -
> 1)))
> +
> +/* which is compatible with the flattened device tree (FDT) */ #define
> +cmd_line arcs_cmdline


What is this #define floating in space?




> +
> +/*
> + * Use this value to indicate lack of interrupt
> + * capability
> + */
> +#ifndef NO_IRQ
> +#define NO_IRQ  ((unsigned int)(-1))
> +#endif



> +
> +static inline unsigned long pci_address_to_pio(phys_addr_t address) {
> +	return (unsigned long)-1;
> +}
> +
> +struct device_node;
> +
> +static inline int of_node_to_nid(struct device_node *device) {
> +	return 0;
> +}
> +
> +static inline void __init early_init_dt_scan_chosen_arch(unsigned long
> node)
> +{
> +}
> +
> +extern int __init early_init_dt_scan_memory_arch(unsigned long node,
> +	const char *uname, int depth, void *data);
> +
> +extern int __init reserve_mem_mach(unsigned long addr, unsigned long
> size);
> +extern void __init free_mem_mach(unsigned long addr, unsigned long
> size);
> +
> +extern void __init device_tree_init(void); #else /* CONFIG_OF */ static
>
> +inline void __init device_tree_init(void) { } #endif /* CONFIG_OF */
> +
> +#endif /* _ASM_MIPS_PROM_H */
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile index
> ef20957..4b10545 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -95,6 +95,8 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o
> relocate_kernel.o
>   obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>   obj-$(CONFIG_SPINLOCK_TEST)	+= spinlock_test.o
>
> +obj-$(CONFIG_OF)		+= prom.o
> +
>   CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi
> -c -o /dev/null -xc /dev/null>/dev/null 2>&1; then echo
> "-DHAVE_AS_SET_DADDI"; fi)
>
>   obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c new file
> mode 100644 index 0000000..2cbd43f
> --- /dev/null
> +++ b/arch/mips/kernel/prom.c
> @@ -0,0 +1,164 @@
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
> +/*
> + * The list of OF IDs below is used for matching bus types in the
> + * system whose devices are to be exposed as of_platform_devices.
> + *
> + * This is the default list valid for most platforms. This file
> provides
> + * functions who can take an explicit list if necessary though
> + *
> + * The search is always performed recursively looking for children of
> + * the provided device_node and recursively if such a children matches
> + * a bus type in the list
> + */
> +const struct of_device_id of_default_bus_ids[] = {
> +	{},
> +};
> +
> +#ifndef CONFIG_ARCH_HAS_DEVTREE_MEM
> +int __init early_init_dt_scan_memory_arch(unsigned long node,
> +					  const char *uname, int depth,
> +					  void *data)
> +{
> +	return early_init_dt_scan_memory(node, uname, depth, data); }
> +
> +void __init early_init_dt_add_memory_arch(u64 base, u64 size) {
> +	return add_memory_region(base, size, BOOT_MEM_RAM); }
> +
> +int __init reserve_mem_mach(unsigned long addr, unsigned long size) {
> +	return reserve_bootmem(addr, size, BOOTMEM_DEFAULT); }
> +
> +void __init free_mem_mach(unsigned long addr, unsigned long size) {
> +	return free_bootmem(addr, size);
> +}
> +#endif
> +
> +u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align) {
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
> + * Interrupt remapper
> + */
> +struct device_node *of_irq_find_parent_by_phandle(phandle p) {
> +	return of_find_node_by_phandle(p);
> +}
> +
> +int of_irq_map_one(struct device_node *device,
> +		   int index, struct of_irq *out_irq) {
> +	return __of_irq_map_one(device, index, out_irq); }
> +EXPORT_SYMBOL_GPL(of_irq_map_one);
> +
> +/*
> + * irq_create_of_mapping - Hook to resolve OF irq specifier into a
> Linux irq#
> + *
> + * Currently the mapping mechanism is trivial; simple flat hwirq
> numbers are
> + * mapped 1:1 onto Linux irq numbers.  Cascaded irq controllers are not
> + * supported.
> + */
> +unsigned int irq_create_of_mapping(struct device_node *controller,
> +				   const u32 *intspec, unsigned int
> intsize)
> +{
> +	return intspec[0];
> +}
> +EXPORT_SYMBOL_GPL(irq_create_of_mapping);
> +
> +void __init early_init_devtree(void *params) {
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
> +	of_scan_flat_dt(early_init_dt_scan_memory_arch, NULL); }
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
> +#if defined(CONFIG_DEBUG_FS)&&  defined(DEBUG) static struct
> +debugfs_blob_wrapper flat_dt_blob;
> +

This looks fubar as well.



Please make sure that it for the most part passes checkpatch.pl, and 
test your patch mailing procedure so that things don't get mangled.

Other than that, I would like to say thanks for working on this.  It has 
been needed for quite some time.

Thanks,
David Daney
