Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 19:01:37 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:60221 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816503AbaCVSBfAp3Dp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Mar 2014 19:01:35 +0100
Received: by mail-lb0-f171.google.com with SMTP id w7so2594927lbi.30
        for <multiple recipients>; Sat, 22 Mar 2014 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NJ1W9vQ7x4mGS3szzfyZ2L2ciipPMVevG3yDtqnwUr8=;
        b=OqamjiHXKZQolGSTG+1Ys8pl/AFYi1iCqZrRunNL0itF76cMNuknzIFshqVcpetD6H
         FNDdH49afdNKdFeNd5/9u7queGQdeJRqt0ZsdrY8Pon+tplvioYPmGKDy009+vcR/wED
         i08XLXWqwvP1FDOXGHe6Li35z46UJXfly6LMVpNF3Hhjn7hJ253yR1fAwtu+lf4E+0dz
         ulVGJEftmS7+2EZlLC/PwSPxe78vR175Kz0jyVbvCV7KQGBw4zkWUs297OO051W1hGml
         BhCABfj3KIqIifbDY4kRzkdA5kEzF4e02n2DyyU7pMVCYM+mZfkzWYshI92ijBmxyf6e
         fIFQ==
X-Received: by 10.152.7.97 with SMTP id i1mr725529laa.36.1395511289020;
        Sat, 22 Mar 2014 11:01:29 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id cr6sm5811393lbb.19.2014.03.22.11.01.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Mar 2014 11:01:28 -0700 (PDT)
Date:   Sat, 22 Mar 2014 22:11:09 +0400
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V20 04/12] MIPS: Loongson: Add UEFI-like firmware
 interface (LEFI) support
Message-Id: <20140322221109.aeea1ccec916498da6a5ce2d@gmail.com>
In-Reply-To: <1395398650-19292-5-git-send-email-chenhc@lemote.com>
References: <1395398650-19292-1-git-send-email-chenhc@lemote.com>
        <1395398650-19292-5-git-send-email-chenhc@lemote.com>
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.22; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Fri, 21 Mar 2014 18:44:02 +0800
Huacai Chen <chenhc@lemote.com> wrote:

> The new UEFI-like firmware interface (LEFI, i.e. Loongson Unified
> Firmware Interface) has 3 advantages:
> 
> 1, Firmware export a physical memory map which is similar to X86's
>    E820 map, so prom_init_memory() will be more elegant that #ifdef
>    clauses can be removed.
> 2, Firmware export a pci irq routing table, we no longer need pci
>    irq routing fixup in kernel's code.
> 3, Firmware has a built-in vga bios, and its address is exported,
>    the linux kernel no longer need an embedded blob.
> 
> With the LEFI interface, Loongson-3A/2G and all their successors can use
> a unified kernel. All Loongson-based machines support this new interface
> except 2E/2F series.

Do you really need to reinvent the wheel?

Why you can't just use existing Open Firmware Device Tree?


> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> Tested-by: Alex Smith <alex.smith@imgtec.com>
> Reviewed-by: Alex Smith <alex.smith@imgtec.com>
> ---
>  arch/mips/include/asm/mach-loongson/boot_param.h |  163 ++++++++++++++++++++++
>  arch/mips/include/asm/mach-loongson/loongson.h   |    4 +-
>  arch/mips/loongson/common/env.c                  |   67 +++++++--
>  arch/mips/loongson/common/init.c                 |    9 +-
>  arch/mips/loongson/common/mem.c                  |   42 ++++++
>  arch/mips/loongson/common/pci.c                  |    6 +-
>  arch/mips/loongson/common/reset.c                |   21 +++
>  7 files changed, 292 insertions(+), 20 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson/boot_param.h
> 
> diff --git a/arch/mips/include/asm/mach-loongson/boot_param.h b/arch/mips/include/asm/mach-loongson/boot_param.h
> new file mode 100644
> index 0000000..829a7ec
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/boot_param.h
> @@ -0,0 +1,163 @@
> +#ifndef __ASM_MACH_LOONGSON_BOOT_PARAM_H_
> +#define __ASM_MACH_LOONGSON_BOOT_PARAM_H_
> +
> +#define SYSTEM_RAM_LOW		1
> +#define SYSTEM_RAM_HIGH		2
> +#define MEM_RESERVED		3
> +#define PCI_IO			4
> +#define PCI_MEM			5
> +#define LOONGSON_CFG_REG	6
> +#define VIDEO_ROM		7
> +#define ADAPTER_ROM		8
> +#define ACPI_TABLE		9
> +#define MAX_MEMORY_TYPE		10
> +
> +#define LOONGSON3_BOOT_MEM_MAP_MAX 128
> +struct efi_memory_map_loongson {
> +	u16 vers;	/* version of efi_memory_map */
> +	u32 nr_map;	/* number of memory_maps */
> +	u32 mem_freq;	/* memory frequence */
> +	struct mem_map {
> +		u32 node_id;	/* node_id which memory attached to */
> +		u32 mem_type;	/* system memory, pci memory, pci io, etc. */
> +		u64 mem_start;	/* memory map start address */
> +		u32 mem_size;	/* each memory_map size, not the total size */
> +	} map[LOONGSON3_BOOT_MEM_MAP_MAX];
> +} __packed;
> +
> +enum loongson_cpu_type {
> +	Loongson_2E = 0,
> +	Loongson_2F = 1,
> +	Loongson_3A = 2,
> +	Loongson_3B = 3,
> +	Loongson_1A = 4,
> +	Loongson_1B = 5
> +};
> +
> +/*
> + * Capability and feature descriptor structure for MIPS CPU
> + */
> +struct efi_cpuinfo_loongson {
> +	u16 vers;     /* version of efi_cpuinfo_loongson */
> +	u32 processor_id; /* PRID, e.g. 6305, 6306 */
> +	u32 cputype;  /* Loongson_3A/3B, etc. */
> +	u32 total_node;   /* num of total numa nodes */
> +	u32 cpu_startup_core_id; /* Core id */
> +	u32 cpu_clock_freq; /* cpu_clock */
> +	u32 nr_cpus;
> +} __packed;
> +
> +struct system_loongson {
> +	u16 vers;     /* version of system_loongson */
> +	u32 ccnuma_smp; /* 0: no numa; 1: has numa */
> +	u32 sing_double_channel; /* 1:single; 2:double */
> +} __packed;
> +
> +struct irq_source_routing_table {
> +	u16 vers;
> +	u16 size;
> +	u16 rtr_bus;
> +	u16 rtr_devfn;
> +	u32 vendor;
> +	u32 device;
> +	u32 PIC_type;   /* conform use HT or PCI to route to CPU-PIC */
> +	u64 ht_int_bit; /* 3A: 1<<24; 3B: 1<<16 */
> +	u64 ht_enable;  /* irqs used in this PIC */
> +	u32 node_id;    /* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-3 */
> +	u64 pci_mem_start_addr;
> +	u64 pci_mem_end_addr;
> +	u64 pci_io_start_addr;
> +	u64 pci_io_end_addr;
> +	u64 pci_config_addr;
> +	u32 dma_mask_bits;
> +} __packed;
> +
> +struct interface_info {
> +	u16 vers; /* version of the specificition */
> +	u16 size;
> +	u8  flag;
> +	char description[64];
> +} __packed;
> +
> +#define MAX_RESOURCE_NUMBER 128
> +struct resource_loongson {
> +	u64 start; /* resource start address */
> +	u64 end;   /* resource end address */
> +	char name[64];
> +	u32 flags;
> +};
> +
> +struct archdev_data {};  /* arch specific additions */
> +
> +struct board_devices {
> +	char name[64];    /* hold the device name */
> +	u32 num_resources; /* number of device_resource */
> +	/* for each device's resource */
> +	struct resource_loongson resource[MAX_RESOURCE_NUMBER];
> +	/* arch specific additions */
> +	struct archdev_data archdata;
> +};
> +
> +struct loongson_special_attribute {
> +	u16 vers;     /* version of this special */
> +	char special_name[64]; /* special_atribute_name */
> +	u32 loongson_special_type; /* type of special device */
> +	/* for each device's resource */
> +	struct resource_loongson resource[MAX_RESOURCE_NUMBER];
> +};
> +
> +struct loongson_params {
> +	u64 memory_offset;	/* efi_memory_map_loongson struct offset */
> +	u64 cpu_offset;		/* efi_cpuinfo_loongson struct offset */
> +	u64 system_offset;	/* system_loongson struct offset */
> +	u64 irq_offset;		/* irq_source_routing_table struct offset */
> +	u64 interface_offset;	/* interface_info struct offset */
> +	u64 special_offset;	/* loongson_special_attribute struct offset */
> +	u64 boarddev_table_offset;  /* board_devices offset */
> +};
> +
> +struct smbios_tables {
> +	u16 vers;     /* version of smbios */
> +	u64 vga_bios; /* vga_bios address */
> +	struct loongson_params lp;
> +};
> +
> +struct efi_reset_system_t {
> +	u64 ResetCold;
> +	u64 ResetWarm;
> +	u64 ResetType;
> +	u64 Shutdown;
> +	u64 DoSuspend; /* NULL if not support */
> +};
> +
> +struct efi_loongson {
> +	u64 mps;	/* MPS table */
> +	u64 acpi;	/* ACPI table (IA64 ext 0.71) */
> +	u64 acpi20;	/* ACPI table (ACPI 2.0) */
> +	struct smbios_tables smbios;	/* SM BIOS table */
> +	u64 sal_systab;	/* SAL system table */
> +	u64 boot_info;	/* boot info table */
> +};
> +
> +struct boot_params {
> +	struct efi_loongson efi;
> +	struct efi_reset_system_t reset_system;
> +};
> +
> +struct loongson_system_configuration {
> +	u32 nr_cpus;
> +	enum loongson_cpu_type cputype;
> +	u64 ht_control_base;
> +	u64 pci_mem_start_addr;
> +	u64 pci_mem_end_addr;
> +	u64 pci_io_base;
> +	u64 restart_addr;
> +	u64 poweroff_addr;
> +	u64 suspend_addr;
> +	u64 vgabios_addr;
> +	u32 dma_mask_bits;
> +};
> +
> +extern struct efi_memory_map_loongson *loongson_memmap;
> +extern struct loongson_system_configuration loongson_sysconf;
> +#endif
> diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
> index b286534..5913ea0 100644
> --- a/arch/mips/include/asm/mach-loongson/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> @@ -24,8 +24,8 @@ extern void mach_prepare_reboot(void);
>  extern void mach_prepare_shutdown(void);
>  
>  /* environment arguments from bootloader */
> -extern unsigned long cpu_clock_freq;
> -extern unsigned long memsize, highmemsize;
> +extern u32 cpu_clock_freq;
> +extern u32 memsize, highmemsize;
>  
>  /* loongson-specific command line, env and memory initialization */
>  extern void __init prom_init_memory(void);
> diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
> index 0a18fcf..0c543ea 100644
> --- a/arch/mips/loongson/common/env.c
> +++ b/arch/mips/loongson/common/env.c
> @@ -18,29 +18,30 @@
>   * option) any later version.
>   */
>  #include <linux/module.h>
> -
>  #include <asm/bootinfo.h>
> -
>  #include <loongson.h>
> +#include <boot_param.h>
>  
> -unsigned long cpu_clock_freq;
> +u32 cpu_clock_freq;
>  EXPORT_SYMBOL(cpu_clock_freq);
> -unsigned long memsize, highmemsize;
> +struct efi_memory_map_loongson *loongson_memmap;
> +struct loongson_system_configuration loongson_sysconf;
>  
>  #define parse_even_earlier(res, option, p)				\
>  do {									\
>  	unsigned int tmp __maybe_unused;				\
>  									\
>  	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
> -		tmp = strict_strtol((char *)p + strlen(option"="), 10, &res); \
> +		tmp = kstrtou32((char *)p + strlen(option"="), 10, &res); \
>  } while (0)
>  
>  void __init prom_init_env(void)
>  {
>  	/* pmon passes arguments in 32bit pointers */
> -	int *_prom_envp;
> -	unsigned long bus_clock;
>  	unsigned int processor_id;
> +
> +#ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
> +	int *_prom_envp;
>  	long l;
>  
>  	/* firmware arguments are initialized in head.S */
> @@ -48,7 +49,6 @@ void __init prom_init_env(void)
>  
>  	l = (long)*_prom_envp;
>  	while (l != 0) {
> -		parse_even_earlier(bus_clock, "busclock", l);
>  		parse_even_earlier(cpu_clock_freq, "cpuclock", l);
>  		parse_even_earlier(memsize, "memsize", l);
>  		parse_even_earlier(highmemsize, "highmemsize", l);
> @@ -57,8 +57,48 @@ void __init prom_init_env(void)
>  	}
>  	if (memsize == 0)
>  		memsize = 256;
> -	if (bus_clock == 0)
> -		bus_clock = 66000000;
> +	pr_info("memsize=%u, highmemsize=%u\n", memsize, highmemsize);
> +#else
> +	struct boot_params *boot_p;
> +	struct loongson_params *loongson_p;
> +	struct efi_cpuinfo_loongson *ecpu;
> +	struct irq_source_routing_table *eirq_source;
> +
> +	/* firmware arguments are initialized in head.S */
> +	boot_p = (struct boot_params *)fw_arg2;
> +	loongson_p = &(boot_p->efi.smbios.lp);
> +
> +	ecpu = (struct efi_cpuinfo_loongson *)
> +		((u64)loongson_p + loongson_p->cpu_offset);
> +	eirq_source = (struct irq_source_routing_table *)
> +		((u64)loongson_p + loongson_p->irq_offset);
> +	loongson_memmap = (struct efi_memory_map_loongson *)
> +		((u64)loongson_p + loongson_p->memory_offset);
> +
> +	cpu_clock_freq = ecpu->cpu_clock_freq;
> +	loongson_sysconf.cputype = ecpu->cputype;
> +	loongson_sysconf.nr_cpus = ecpu->nr_cpus;
> +	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus == 0)
> +		loongson_sysconf.nr_cpus = NR_CPUS;
> +
> +	loongson_sysconf.pci_mem_start_addr = eirq_source->pci_mem_start_addr;
> +	loongson_sysconf.pci_mem_end_addr = eirq_source->pci_mem_end_addr;
> +	loongson_sysconf.pci_io_base = eirq_source->pci_io_start_addr;
> +	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
> +	if (loongson_sysconf.dma_mask_bits < 32 ||
> +		loongson_sysconf.dma_mask_bits > 64)
> +		loongson_sysconf.dma_mask_bits = 32;
> +
> +	loongson_sysconf.restart_addr = boot_p->reset_system.ResetWarm;
> +	loongson_sysconf.poweroff_addr = boot_p->reset_system.Shutdown;
> +	loongson_sysconf.suspend_addr = boot_p->reset_system.DoSuspend;
> +
> +	loongson_sysconf.ht_control_base = 0x90000EFDFB000000;
> +	loongson_sysconf.vgabios_addr = boot_p->efi.smbios.vga_bios;
> +	pr_debug("Shutdown Addr: %llx, Restart Addr: %llx, VBIOS Addr: %llx\n",
> +		loongson_sysconf.poweroff_addr, loongson_sysconf.restart_addr,
> +		loongson_sysconf.vgabios_addr);
> +#endif
>  	if (cpu_clock_freq == 0) {
>  		processor_id = (&current_cpu_data)->processor_id;
>  		switch (processor_id & PRID_REV_MASK) {
> @@ -68,12 +108,13 @@ void __init prom_init_env(void)
>  		case PRID_REV_LOONGSON2F:
>  			cpu_clock_freq = 797000000;
>  			break;
> +		case PRID_REV_LOONGSON3A:
> +			cpu_clock_freq = 900000000;
> +			break;
>  		default:
>  			cpu_clock_freq = 100000000;
>  			break;
>  		}
>  	}
> -
> -	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
> -		bus_clock, cpu_clock_freq, memsize, highmemsize);
> +	pr_info("CpuClock = %u\n", cpu_clock_freq);
>  }
> diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
> index ae7af1f..81ba3b4 100644
> --- a/arch/mips/loongson/common/init.c
> +++ b/arch/mips/loongson/common/init.c
> @@ -17,10 +17,6 @@ unsigned long __maybe_unused _loongson_addrwincfg_base;
>  
>  void __init prom_init(void)
>  {
> -	/* init base address of io space */
> -	set_io_port_base((unsigned long)
> -		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
> -
>  #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
>  	_loongson_addrwincfg_base = (unsigned long)
>  		ioremap(LOONGSON_ADDRWINCFG_BASE, LOONGSON_ADDRWINCFG_SIZE);
> @@ -28,6 +24,11 @@ void __init prom_init(void)
>  
>  	prom_init_cmdline();
>  	prom_init_env();
> +
> +	/* init base address of io space */
> +	set_io_port_base((unsigned long)
> +		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
> +
>  	prom_init_memory();
>  
>  	/*init the uart base address */
> diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
> index 8626a42..b01d524 100644
> --- a/arch/mips/loongson/common/mem.c
> +++ b/arch/mips/loongson/common/mem.c
> @@ -11,9 +11,14 @@
>  #include <asm/bootinfo.h>
>  
>  #include <loongson.h>
> +#include <boot_param.h>
>  #include <mem.h>
>  #include <pci.h>
>  
> +#ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
> +
> +u32 memsize, highmemsize;
> +
>  void __init prom_init_memory(void)
>  {
>  	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
> @@ -49,6 +54,43 @@ void __init prom_init_memory(void)
>  #endif /* !CONFIG_64BIT */
>  }
>  
> +#else /* CONFIG_LEFI_FIRMWARE_INTERFACE */
> +
> +void __init prom_init_memory(void)
> +{
> +	int i;
> +	u32 node_id;
> +	u32 mem_type;
> +
> +	/* parse memory information */
> +	for (i = 0; i < loongson_memmap->nr_map; i++) {
> +		node_id = loongson_memmap->map[i].node_id;
> +		mem_type = loongson_memmap->map[i].mem_type;
> +
> +		if (node_id == 0) {
> +			switch (mem_type) {
> +			case SYSTEM_RAM_LOW:
> +				add_memory_region(loongson_memmap->map[i].mem_start,
> +					(u64)loongson_memmap->map[i].mem_size << 20,
> +					BOOT_MEM_RAM);
> +				break;
> +			case SYSTEM_RAM_HIGH:
> +				add_memory_region(loongson_memmap->map[i].mem_start,
> +					(u64)loongson_memmap->map[i].mem_size << 20,
> +					BOOT_MEM_RAM);
> +				break;
> +			case MEM_RESERVED:
> +				add_memory_region(loongson_memmap->map[i].mem_start,
> +					(u64)loongson_memmap->map[i].mem_size << 20,
> +					BOOT_MEM_RESERVED);
> +				break;
> +			}
> +		}
> +	}
> +}
> +
> +#endif /* CONFIG_LEFI_FIRMWARE_INTERFACE */
> +
>  /* override of arch/mips/mm/cache.c: __uncached_access */
>  int __uncached_access(struct file *file, unsigned long addr)
>  {
> diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson/common/pci.c
> index fa77844..003ab4e 100644
> --- a/arch/mips/loongson/common/pci.c
> +++ b/arch/mips/loongson/common/pci.c
> @@ -11,6 +11,7 @@
>  
>  #include <pci.h>
>  #include <loongson.h>
> +#include <boot_param.h>
>  
>  static struct resource loongson_pci_mem_resource = {
>  	.name	= "pci memory space",
> @@ -82,7 +83,10 @@ static int __init pcibios_init(void)
>  	setup_pcimap();
>  
>  	loongson_pci_controller.io_map_base = mips_io_port_base;
> -
> +#ifdef CONFIG_LEFI_FIRMWARE_INTERFACE
> +	loongson_pci_mem_resource.start = loongson_sysconf.pci_mem_start_addr;
> +	loongson_pci_mem_resource.end = loongson_sysconf.pci_mem_end_addr;
> +#endif
>  	register_pci_controller(&loongson_pci_controller);
>  
>  	return 0;
> diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
> index 65bfbb5..a60715e 100644
> --- a/arch/mips/loongson/common/reset.c
> +++ b/arch/mips/loongson/common/reset.c
> @@ -16,6 +16,7 @@
>  #include <asm/reboot.h>
>  
>  #include <loongson.h>
> +#include <boot_param.h>
>  
>  static inline void loongson_reboot(void)
>  {
> @@ -37,17 +38,37 @@ static inline void loongson_reboot(void)
>  
>  static void loongson_restart(char *command)
>  {
> +#ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
>  	/* do preparation for reboot */
>  	mach_prepare_reboot();
>  
>  	/* reboot via jumping to boot base address */
>  	loongson_reboot();
> +#else
> +	void (*fw_restart)(void) = (void *)loongson_sysconf.restart_addr;
> +
> +	fw_restart();
> +	while (1) {
> +		if (cpu_wait)
> +			cpu_wait();
> +	}
> +#endif
>  }
>  
>  static void loongson_poweroff(void)
>  {
> +#ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
>  	mach_prepare_shutdown();
>  	unreachable();
> +#else
> +	void (*fw_poweroff)(void) = (void *)loongson_sysconf.poweroff_addr;
> +
> +	fw_poweroff();
> +	while (1) {
> +		if (cpu_wait)
> +			cpu_wait();
> +	}
> +#endif
>  }
>  
>  static void loongson_halt(void)
> -- 
> 1.7.7.3
> 
> 


-- 
-- 
Best regards,
  Antony Pavlov
