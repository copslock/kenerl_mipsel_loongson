Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jan 2014 18:05:57 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:43302 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825606AbaAERFwDO79S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Jan 2014 18:05:52 +0100
Received: from [2001:470:d4ed:0:ea11:32ff:fea1:831a] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr91-0006GR-6r; Sun, 05 Jan 2014 18:05:47 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr8z-0004Ro-0Z; Sun, 05 Jan 2014 18:05:45 +0100
Date:   Sun, 5 Jan 2014 18:05:44 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 04/12] MIPS: Loongson: Add UEFI-like firmware
 interface support
Message-ID: <20140105170544.GA14542@ohm.rr44.fr>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-5-git-send-email-chenhc@lemote.com>
 <20140104222345.GA20706@hall.aurel32.net>
 <CAAhV-H5CPNwgFD595hc0RBV2ETa1xGRdhns2sU37+=2+x9foxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H5CPNwgFD595hc0RBV2ETa1xGRdhns2sU37+=2+x9foxQ@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Jan 05, 2014 at 04:38:57PM +0800, Huacai Chen wrote:
> On Sun, Jan 5, 2014 at 6:23 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> 
> > On Sun, Dec 15, 2013 at 08:14:28PM +0800, Huacai Chen wrote:
> > > The new UEFI-like firmware interface has 3 advantages:
> > >
> > > 1, Firmware export a physical memory map which is similar to X86's
> > >    E820 map, so prom_init_memory() will be more elegant that #ifdef
> > >    clauses can be removed.
> > > 2, Firmware export a pci irq routing table, we no longer need pci
> > >    irq routing fixup in kernel's code.
> > > 3, Firmware has a built-in vga bios, and its address is exported,
> > >    the linux kernel no longer need an embedded blob.
> > >
> > > With the new interface, Loongson-3A/2G and all their successors can use
> > > a unified kernel. All Loongson-based machines support this new interface
> > > except 2E/2F series.
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
> > > Signed-off-by: Hua Yan <yanh@lemote.com>
> > > ---
> > >  arch/mips/include/asm/mach-loongson/boot_param.h |  151
> > ++++++++++++++++++++++
> > >  arch/mips/include/asm/mach-loongson/loongson.h   |    4 +-
> > >  arch/mips/loongson/common/env.c                  |   67 ++++++++--
> > >  arch/mips/loongson/common/init.c                 |    9 +-
> > >  arch/mips/loongson/common/mem.c                  |   42 ++++++
> > >  arch/mips/loongson/common/pci.c                  |    6 +-
> > >  arch/mips/loongson/common/reset.c                |   16 +++
> > >  7 files changed, 275 insertions(+), 20 deletions(-)
> > >  create mode 100644 arch/mips/include/asm/mach-loongson/boot_param.h
> > >
> > > diff --git a/arch/mips/include/asm/mach-loongson/boot_param.h
> > b/arch/mips/include/asm/mach-loongson/boot_param.h
> > > new file mode 100644
> > > index 0000000..4c5a1ba
> > > --- /dev/null
> > > +++ b/arch/mips/include/asm/mach-loongson/boot_param.h
> > > @@ -0,0 +1,151 @@
> > > +#ifndef __ASM_MACH_LOONGSON_BOOT_PARAM_H_
> > > +#define __ASM_MACH_LOONGSON_BOOT_PARAM_H_
> > > +
> > > +#define SYSTEM_RAM_LOW               1
> > > +#define SYSTEM_RAM_HIGH              2
> > > +#define MEM_RESERVED         3
> > > +#define PCI_IO                       4
> > > +#define PCI_MEM                      5
> > > +#define LOONGSON_CFG_REG     6
> > > +#define VIDEO_ROM            7
> > > +#define ADAPTER_ROM          8
> > > +#define ACPI_TABLE           9
> > > +#define MAX_MEMORY_TYPE              10
> > > +
> > > +#define LOONGSON3_BOOT_MEM_MAP_MAX 128
> > > +struct efi_memory_map_loongson{
> > > +     u16 vers;       /* version of efi_memory_map */
> > > +     u32 nr_map;     /* number of memory_maps */
> > > +     u32 mem_freq;   /* memory frequence */
> > > +     struct mem_map{
> > > +             u32 node_id;    /* node_id which memory attached to */
> > > +             u32 mem_type;   /* system memory, pci memory, pci io, etc.
> > */
> > > +             u64 mem_start;  /* memory map start address */
> > > +             u32 mem_size;   /* each memory_map size, not the total
> > size */
> > > +     }map[LOONGSON3_BOOT_MEM_MAP_MAX];
> > > +}__attribute__((packed));
> > > +
> > > +enum loongson_cpu_type
> > > +{
> > > +     Loongson_2E,
> > > +     Loongson_2F,
> > > +     Loongson_3A,
> > > +     Loongson_3B,
> > > +     Loongson_1A,
> > > +     Loongson_1B
> > > +};
> >
> > Given it's an interface, you should probably number the different member
> > of the enum:
> >
> >         Loongson_2E = 0,
> >         Loongson_2F = 1,
> >         ...
> >
> > > +/*
> > > + * Capability and feature descriptor structure for MIPS CPU
> > > + */
> > > +struct efi_cpuinfo_loongson {
> > > +     u16 vers;     /* version of efi_cpuinfo_loongson */
> > > +     u32 processor_id; /* PRID, e.g. 6305, 6306 */
> > > +     enum loongson_cpu_type cputype; /* 3A, 3B, etc. */
> >
> > Actually I am not sure using an enum here is a good idea. An enum is
> > guaranteed to accept at least an int value, but the compiler is free
> > to reduce it to a shorter type if it knows all the values can fit.
> > While it might work now, it might not work in a future.
> >
> > I think the correct size here is u32, you should probably use that
> > instead.
> >
> > I will follow your suggestion here.
> 
> 
> > > +     u32 total_node;   /* num of total numa nodes */
> > > +     u32 cpu_startup_core_id; /* Core id */
> > > +     u32 cpu_clock_freq; /* cpu_clock */
> > > +     u32 nr_cpus;
> > > +}__attribute__((packed));
> > > +
> > > +struct system_loongson{
> > > +     u16 vers;     /* version of system_loongson */
> > > +     u32 ccnuma_smp; /* 0: no numa; 1: has numa */
> > > +     u32 sing_double_channel; /* 1:single; 2:double */
> > > +}__attribute__((packed));
> > > +
> > > +struct irq_source_routing_table {
> > > +     u16 vers;
> > > +     u16 size;
> > > +     u16 rtr_bus;
> > > +     u16 rtr_devfn;
> > > +     u32 vendor;
> > > +     u32 device;
> > > +     u32 PIC_type;   /* conform use HT or PCI to route to CPU-PIC */
> > > +     u64 ht_int_bit; /* 3A: 1<<24; 3B: 1<<16 */
> > > +     u64 ht_enable;  /* irqs used in this PIC */
> > > +     u32 node_id;    /* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-3 */
> > > +     u64 pci_mem_start_addr;
> > > +     u64 pci_mem_end_addr;
> > > +     u64 pci_io_start_addr;
> > > +     u64 pci_io_end_addr;
> > > +     u64 pci_config_addr;
> > > +}__attribute__((packed));
> > > +
> > > +struct interface_info{
> > > +     u16 vers; /* version of the specificition */
> > > +     u16 size;
> > > +     u8  flag;
> > > +     char description[64];
> > > +}__attribute__((packed));
> > > +
> > > +#define MAX_RESOURCE_NUMBER 128
> > > +struct resource_loongson {
> > > +     u64 start; /* resource start address */
> > > +     u64 end;   /* resource end address */
> > > +     char name[64];
> > > +     u32 flags;
> > > +};
> > > +
> > > +struct archdev_data {};  /* arch specific additions */
> > > +
> > > +struct board_devices{
> > > +     char name[64];    /* hold the device name */
> > > +     u32 num_resources; /* number of device_resource */
> > > +     struct resource_loongson resource[MAX_RESOURCE_NUMBER]; /* for
> > each device's resource */
> > > +     /* arch specific additions */
> > > +     struct archdev_data archdata;
> > > +};
> > > +
> > > +struct loongson_special_attribute{
> > > +     u16 vers;     /* version of this special */
> > > +     char special_name[64]; /* special_atribute_name */
> > > +     u32 loongson_special_type; /* type of special device */
> > > +     struct resource_loongson resource[MAX_RESOURCE_NUMBER]; /* for
> > each device's resource */
> > > +};
> > > +
> > > +struct loongson_params{
> > > +     u64 memory_offset;      /* efi_memory_map_loongson struct offset */
> > > +     u64 cpu_offset;         /* efi_cpuinfo_loongson struct offset */
> > > +     u64 system_offset;      /* system_loongson struct offset */
> > > +     u64 irq_offset;         /* irq_source_routing_table struct offset
> > */
> > > +     u64 interface_offset;   /* interface_info struct offset */
> > > +     u64 special_offset;     /* loongson_special_attribute struct
> > offset */
> > > +     u64 boarddev_table_offset;  /* board_devices offset */
> > > +};
> > > +
> > > +struct smbios_tables {
> > > +     u16 vers;     /* version of smbios */
> > > +     u64 vga_bios; /* vga_bios address */
> > > +     struct loongson_params lp;
> > > +};
> > > +
> > > +struct efi_reset_system_t{
> > > +     u64 ResetCold;
> > > +     u64 ResetWarm;
> > > +     u64 ResetType;
> > > +     u64 Shutdown;
> > > +};
> > > +
> > > +struct efi_loongson {
> > > +     u64 mps;        /* MPS table */
> > > +     u64 acpi;       /* ACPI table (IA64 ext 0.71) */
> > > +     u64 acpi20;     /* ACPI table (ACPI 2.0) */
> > > +     struct smbios_tables smbios;    /* SM BIOS table */
> > > +     u64 sal_systab; /* SAL system table */
> > > +     u64 boot_info;  /* boot info table */
> > > +};
> > > +
> > > +struct boot_params{
> > > +     struct efi_loongson efi;
> > > +     struct efi_reset_system_t reset_system;
> > > +};
> > > +
> > > +extern u32 nr_cpus_loongson;
> > > +extern enum loongson_cpu_type cputype;
> > > +extern struct efi_memory_map_loongson *emap;
> > > +extern u64 ht_control_base;
> > > +extern u64 pci_mem_start_addr, pci_mem_end_addr;
> > > +extern u64 loongson_pciio_base;
> > > +extern u64 vgabios_addr;
> > > +#endif
> >
> > That's a lot of external variables. What about using a big struct
> > containing all the struct above instead? That will also give access
> > to some values that are currently not exported.
> >
> > > diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
> > b/arch/mips/include/asm/mach-loongson/loongson.h
> > > index b286534..5913ea0 100644
> > > --- a/arch/mips/include/asm/mach-loongson/loongson.h
> > > +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> > > @@ -24,8 +24,8 @@ extern void mach_prepare_reboot(void);
> > >  extern void mach_prepare_shutdown(void);
> > >
> > >  /* environment arguments from bootloader */
> > > -extern unsigned long cpu_clock_freq;
> > > -extern unsigned long memsize, highmemsize;
> > > +extern u32 cpu_clock_freq;
> > > +extern u32 memsize, highmemsize;
> > >
> > >  /* loongson-specific command line, env and memory initialization */
> > >  extern void __init prom_init_memory(void);
> > > diff --git a/arch/mips/loongson/common/env.c
> > b/arch/mips/loongson/common/env.c
> > > index 0a18fcf..dad9f0c 100644
> > > --- a/arch/mips/loongson/common/env.c
> > > +++ b/arch/mips/loongson/common/env.c
> > > @@ -18,37 +18,53 @@
> > >   * option) any later version.
> > >   */
> > >  #include <linux/module.h>
> > > -
> > >  #include <asm/bootinfo.h>
> > > -
> > >  #include <loongson.h>
> > > +#include <boot_param.h>
> > > +
> > > +struct boot_params *boot_p;
> > > +struct loongson_params *loongson_p;
> > > +
> > > +struct efi_cpuinfo_loongson *ecpu;
> > > +struct efi_memory_map_loongson *emap;
> > > +struct system_loongson *esys;
> > > +struct irq_source_routing_table *eirq_source;
> > > +
> > > +u64 ht_control_base;
> > > +u64 pci_mem_start_addr, pci_mem_end_addr;
> > > +u64 loongson_pciio_base;
> > > +u64 vgabios_addr;
> > > +u64 poweroff_addr, restart_addr;
> > >
> > > -unsigned long cpu_clock_freq;
> > > +enum loongson_cpu_type cputype;
> > > +unsigned int nr_cpus_loongson = NR_CPUS;
> > > +
> > > +u32 cpu_clock_freq;
> > >  EXPORT_SYMBOL(cpu_clock_freq);
> > > -unsigned long memsize, highmemsize;
> > >
> > >  #define parse_even_earlier(res, option, p)                           \
> > >  do {                                                                 \
> > >       unsigned int tmp __maybe_unused;                                \
> > >                                                                       \
> > >       if (strncmp(option, (char *)p, strlen(option)) == 0)            \
> > > -             tmp = strict_strtol((char *)p + strlen(option"="), 10,
> > &res); \
> > > +             tmp = kstrtou32((char *)p + strlen(option"="), 10, &res); \
> > >  } while (0)
> > >
> > >  void __init prom_init_env(void)
> > >  {
> > >       /* pmon passes arguments in 32bit pointers */
> > > -     int *_prom_envp;
> > > -     unsigned long bus_clock;
> > >       unsigned int processor_id;
> > > +
> > > +#ifndef CONFIG_UEFI_FIRMWARE_INTERFACE
> >
> > While "UEFI like" is probably a good idea to describe what is this
> > interface, it's clearly not an UEFI interface, so using UEFI is
> > misleading. Does this interface has a name? Could it be called
> > CONFIG_PMON_FIRMWARE_INTERFACE for example?
> >
> PMON can use both old and new interface, so this has nothing to do with
> PMON.

Ok, then maybe another name. But UEFI is also wrong there, as it is
clearly not a UEFI interface, even if it is like it. If it is really
UEFI, you should use code from drivers/firmware/efi/efi.c to access the
interface.
 
> > Also if you have a #if #else #endif sequence, it's probably better to
> > start with #ifdef instead of #ifndef.
> >
> Why some others tell me that prefer #ifndef to #ifdef?

If some others already told you to reverse that to #ifndef #else #endif,
don't touch at that. But, *personally*, I find #ifdef #else #endif
easier to understand.

> > > +     int *_prom_envp;
> > >       long l;
> > > +     extern u32 memsize, highmemsize;
> > >
> > >       /* firmware arguments are initialized in head.S */
> > >       _prom_envp = (int *)fw_arg2;
> > >
> > >       l = (long)*_prom_envp;
> > >       while (l != 0) {
> > > -             parse_even_earlier(bus_clock, "busclock", l);
> > >               parse_even_earlier(cpu_clock_freq, "cpuclock", l);
> > >               parse_even_earlier(memsize, "memsize", l);
> > >               parse_even_earlier(highmemsize, "highmemsize", l);
> > > @@ -57,8 +73,32 @@ void __init prom_init_env(void)
> > >       }
> > >       if (memsize == 0)
> > >               memsize = 256;
> > > -     if (bus_clock == 0)
> > > -             bus_clock = 66000000;
> >
> > I guess you removed bus_clock because it's only used for display,
> > correct?
> >
> Yes, you are right.
> >
> > > +#else
> > > +     /* firmware arguments are initialized in head.S */
> > > +     boot_p = (struct boot_params *)fw_arg2;
> > > +     loongson_p = &(boot_p->efi.smbios.lp);
> > > +
> > > +     ecpu    = (struct efi_cpuinfo_loongson *)((u64)loongson_p +
> > loongson_p->cpu_offset);
> > > +     emap    = (struct efi_memory_map_loongson *)((u64)loongson_p +
> > loongson_p->memory_offset);
> > > +     eirq_source = (struct irq_source_routing_table *)((u64)loongson_p
> > + loongson_p->irq_offset);
> > > +
> > > +     cputype = ecpu->cputype;
> > > +     nr_cpus_loongson = ecpu->nr_cpus;
> > > +     cpu_clock_freq = ecpu->cpu_clock_freq;
> > > +     if (nr_cpus_loongson > NR_CPUS || nr_cpus_loongson == 0)
> > > +             nr_cpus_loongson = NR_CPUS;
> > > +
> > > +     pci_mem_start_addr = eirq_source->pci_mem_start_addr;
> > > +     pci_mem_end_addr = eirq_source->pci_mem_end_addr;
> > > +     loongson_pciio_base = eirq_source->pci_io_start_addr;
> >
> > Instead of using intermediate variables, wouldn't it be possible to use
> > eirq_source directly?
> >
> We use  intermediate variables because the memory region which store
> the "big structure" may be overwritten by kernel.

Indeed your are correct that this structure is lost while the kernel is
booted. My point is that if you use a big structure to hold all the
variables currently defined as external as said above, this structure
can be used directly.

> > > +
> > > +     poweroff_addr = boot_p->reset_system.Shutdown;
> > > +     restart_addr = boot_p->reset_system.ResetWarm;
> >
> > Same there.
> >
> > > +     pr_info("Shutdown Addr: %llx Reset Addr: %llx\n", poweroff_addr,
> > restart_addr);
> >
> > Hmm, this looks like debugging info which should probably be removed.
> >
> > > +
> > > +     ht_control_base = 0x90000EFDFB000000; /* has no interface now */
> > > +     vgabios_addr = boot_p->efi.smbios.vga_bios;
> > > +#endif
> > >       if (cpu_clock_freq == 0) {
> > >               processor_id = (&current_cpu_data)->processor_id;
> > >               switch (processor_id & PRID_REV_MASK) {
> > > @@ -68,12 +108,13 @@ void __init prom_init_env(void)
> > >               case PRID_REV_LOONGSON2F:
> > >                       cpu_clock_freq = 797000000;
> > >                       break;
> > > +             case PRID_REV_LOONGSON3A:
> > > +                     cpu_clock_freq = 900000000;
> > > +                     break;
> > >               default:
> > >                       cpu_clock_freq = 100000000;
> > >                       break;
> > >               }
> > >       }
> > > -
> > > -     pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld,
> > highmemsize=%ld\n",
> > > -             bus_clock, cpu_clock_freq, memsize, highmemsize);
> > > +     pr_info("CpuClock = %u\n", cpu_clock_freq);
> >
> > Why removing memsize and highmemsize? That can be actually quite useful.
> >
> Because UEFI-like interface doesn't have memsize and highmemsize.

That's true, but it is still interesting to display on Loongson 2, maybe*
keep that for Loongson 2 only?

> > >  }
> > > diff --git a/arch/mips/loongson/common/init.c
> > b/arch/mips/loongson/common/init.c
> > > index ae7af1f..81ba3b4 100644
> > > --- a/arch/mips/loongson/common/init.c
> > > +++ b/arch/mips/loongson/common/init.c
> > > @@ -17,10 +17,6 @@ unsigned long __maybe_unused
> > _loongson_addrwincfg_base;
> > >
> > >  void __init prom_init(void)
> > >  {
> > > -     /* init base address of io space */
> > > -     set_io_port_base((unsigned long)
> > > -             ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
> > > -
> > >  #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
> > >       _loongson_addrwincfg_base = (unsigned long)
> > >               ioremap(LOONGSON_ADDRWINCFG_BASE,
> > LOONGSON_ADDRWINCFG_SIZE);
> > > @@ -28,6 +24,11 @@ void __init prom_init(void)
> > >
> > >       prom_init_cmdline();
> > >       prom_init_env();
> > > +
> > > +     /* init base address of io space */
> > > +     set_io_port_base((unsigned long)
> > > +             ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
> > > +
> > >       prom_init_memory();
> > >
> > >       /*init the uart base address */
> > > diff --git a/arch/mips/loongson/common/mem.c
> > b/arch/mips/loongson/common/mem.c
> > > index 8626a42..406246b 100644
> > > --- a/arch/mips/loongson/common/mem.c
> > > +++ b/arch/mips/loongson/common/mem.c
> > > @@ -11,9 +11,14 @@
> > >  #include <asm/bootinfo.h>
> > >
> > >  #include <loongson.h>
> > > +#include <boot_param.h>
> > >  #include <mem.h>
> > >  #include <pci.h>
> > >
> > > +#ifndef CONFIG_UEFI_FIRMWARE_INTERFACE
> > > +
> >
> > Same comment as above.
> >
> > > +u32 memsize, highmemsize;
> > > +
> > >  void __init prom_init_memory(void)
> > >  {
> > >       add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
> > > @@ -49,6 +54,43 @@ void __init prom_init_memory(void)
> > >  #endif /* !CONFIG_64BIT */
> > >  }
> > >
> > > +#else /* CONFIG_UEFI_FIRMWARE_INTERFACE */
> > > +
> > > +void __init prom_init_memory(void)
> > > +{
> > > +     int i;
> > > +     u32 node_id;
> > > +     u32 mem_type;
> > > +
> > > +     /* parse memory information */
> > > +     for (i = 0; i < emap->nr_map; i++){
> > > +             node_id = emap->map[i].node_id;
> > > +             mem_type = emap->map[i].mem_type;
> > > +
> > > +             if (node_id == 0) {
> > > +                     switch (mem_type) {
> > > +                     case SYSTEM_RAM_LOW:
> > > +                             add_memory_region(emap->map[i].mem_start,
> > > +                                     (u64)emap->map[i].mem_size << 20,
> > > +                                     BOOT_MEM_RAM);
> > > +                             break;
> > > +                     case SYSTEM_RAM_HIGH:
> > > +                             add_memory_region(emap->map[i].mem_start,
> > > +                                     (u64)emap->map[i].mem_size << 20,
> > > +                                     BOOT_MEM_RAM);
> > > +                             break;
> > > +                     case MEM_RESERVED:
> > > +                             add_memory_region(emap->map[i].mem_start,
> > > +                                     (u64)emap->map[i].mem_size << 20,
> > > +                                     BOOT_MEM_RESERVED);
> > > +                             break;
> > > +                     }
> > > +             }
> > > +     }
> > > +}
> > > +
> > > +#endif /* CONFIG_UEFI_FIRMWARE_INTERFACE */
> > > +
> > >  /* override of arch/mips/mm/cache.c: __uncached_access */
> > >  int __uncached_access(struct file *file, unsigned long addr)
> > >  {
> > > diff --git a/arch/mips/loongson/common/pci.c
> > b/arch/mips/loongson/common/pci.c
> > > index fa77844..a06fd5f 100644
> > > --- a/arch/mips/loongson/common/pci.c
> > > +++ b/arch/mips/loongson/common/pci.c
> > > @@ -11,6 +11,7 @@
> > >
> > >  #include <pci.h>
> > >  #include <loongson.h>
> > > +#include <boot_param.h>
> > >
> > >  static struct resource loongson_pci_mem_resource = {
> > >       .name   = "pci memory space",
> > > @@ -82,7 +83,10 @@ static int __init pcibios_init(void)
> > >       setup_pcimap();
> > >
> > >       loongson_pci_controller.io_map_base = mips_io_port_base;
> > > -
> > > +#ifdef CONFIG_UEFI_FIRMWARE_INTERFACE
> > > +     loongson_pci_mem_resource.start = pci_mem_start_addr;
> > > +     loongson_pci_mem_resource.end = pci_mem_end_addr;
> > > +#endif
> > >       register_pci_controller(&loongson_pci_controller);
> > >
> > >       return 0;
> >
> > This part should probably be in patch 5 ("Add HT-linked PCI support").
> > Also it's a big strange defining a value in loongson_pci_mem_resource
> > from LOONGSON_PCI_MEM_START and LOONGSON_PCI_MEM_END, and later
> > overwriting it. Couldn't it be written only once?
> >
> Without UEFI-like interface, we use  LOONGSON_PCI_MEM_START and
> LOONGSON_PCI_MEM_END,
> and when using UEFI-like interface, they will be overwritten.
> 
> 
> > > diff --git a/arch/mips/loongson/common/reset.c
> > b/arch/mips/loongson/common/reset.c
> > > index 65bfbb5..9453565 100644
> > > --- a/arch/mips/loongson/common/reset.c
> > > +++ b/arch/mips/loongson/common/reset.c
> > > @@ -37,17 +37,33 @@ static inline void loongson_reboot(void)
> > >
> > >  static void loongson_restart(char *command)
> > >  {
> > > +#ifndef CONFIG_UEFI_FIRMWARE_INTERFACE
> > >       /* do preparation for reboot */
> > >       mach_prepare_reboot();
> >
> > Couldn't it be possible to provide an empty mach_prepare_reboot()? There
> > are already some Loongson 2 machines for which nothing is done in
> > mach_prepare_reboot().
> >
> > >       /* reboot via jumping to boot base address */
> > >       loongson_reboot();
> > > +#else
> > > +     extern u64 restart_addr;
> > > +     void (*fw_restart)(void) = (void *)restart_addr;
> > > +
> > > +     fw_restart();
> > > +     while (1) {}
> >
> > This is basically jumping to restart_addr, while loongson_reboot is
> > basically a jump to LOONGSON_BOOT_BASE. Couldn't it be possible to
> > share some more code here?
> >
> Not just jump to  LOONGSON_BOOT_BASE. Jumping to LOONGSON_BOOT_BASE
> cannot do a reboot because the southbridge cannot be reset correctly.

Yes, I understand that you can't jump on LOONGSON_BOOT_BASE on a
Loongson 3 machine, but in both case you jump to an address. Probably on
Loongson 2, you can define fw_restart to LOONGSON_BOOT_BASE and then use
the same code.

> > > +#endif
> > >  }
> > >
> > >  static void loongson_poweroff(void)
> > >  {
> > > +#ifndef CONFIG_UEFI_FIRMWARE_INTERFACE
> > >       mach_prepare_shutdown();
> > >       unreachable();
> > > +#else
> > > +     extern u64 poweroff_addr;
> > > +     void (*fw_poweroff)(void) = (void *)poweroff_addr;
> > > +
> > > +     fw_poweroff();
> > > +     while (1) {}
> > > +#endif
> >
> > Same kind of comments here, wouldn't it be possible to move
> > all this code into a loongson 3 specific mach_prepare_shutdown?
> >
> > >  }
> > >
> > >  static void loongson_halt(void)
> > > --
> > > 1.7.7.3
> > >
> > >
> > >
> >
> > --
> > Aurelien Jarno                          GPG: 1024D/F1BCDB73
> > aurelien@aurel32.net                 http://www.aurel32.net
> >
> >

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
