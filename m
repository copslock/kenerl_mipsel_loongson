Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 03:22:28 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:9607 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022667AbXFNCWZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2007 03:22:25 +0100
Received: (qmail 13779 invoked by uid 511); 14 Jun 2007 02:25:06 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 14 Jun 2007 02:25:06 -0000
Message-ID: <4670A617.40401@lemote.com>
Date:	Thu, 14 Jun 2007 10:21:11 +0800
From:	Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Songmao Tian <tiansm@lemote.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fulong PCI updates
References: <11817874002470-git-send-email-tiansm@lemote.com>
In-Reply-To: <11817874002470-git-send-email-tiansm@lemote.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Patch against the queue tree and serial port tested

Tian

Songmao Tian wrote:
> 1. refine irq_map, southbridge slot number is now probed, not hard coded
> 2. add uhci(via686b func 2,3) irq routing, so we don't depend on the
> generic mips "pcibios_update_irq" for irq routing.
> 3. add nec usb host fixup
> 4. use mips-boards bonito64.h/ops-bonito64.c
> 5. fix resource related problem under 64-bit kernel when ram > 256M
>
> Signed-off-by: Songmao Tian <tiansm@lemote.com>
> ---
>  arch/mips/lemote/lm2e/bonito-irq.c      |    2 +-
>  arch/mips/lemote/lm2e/irq.c             |    3 +-
>  arch/mips/lemote/lm2e/pci.c             |   37 ++-
>  arch/mips/lemote/lm2e/setup.c           |    7 -
>  arch/mips/pci/Makefile                  |    2 +-
>  arch/mips/pci/fixup-lm2e.c              |  121 ++++------
>  arch/mips/pci/ops-bonito64.c            |   88 +++----
>  arch/mips/pci/ops-lm2e.c                |  153 -----------
>  include/asm-mips/mach-lemote/bonito.h   |  438 -------------------------------
>  include/asm-mips/mips-boards/bonito64.h |    7 +-
>  10 files changed, 118 insertions(+), 740 deletions(-)
>  delete mode 100644 arch/mips/pci/ops-lm2e.c
>  delete mode 100644 include/asm-mips/mach-lemote/bonito.h
>
> diff --git a/arch/mips/lemote/lm2e/bonito-irq.c b/arch/mips/lemote/lm2e/bonito-irq.c
> index 3297261..8fc3bce 100644
> --- a/arch/mips/lemote/lm2e/bonito-irq.c
> +++ b/arch/mips/lemote/lm2e/bonito-irq.c
> @@ -34,7 +34,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  
> -#include <bonito.h>
> +#include <asm/mips-boards/bonito64.h>
>  
>  
>  static inline void bonito_irq_enable(unsigned int irq)
> diff --git a/arch/mips/lemote/lm2e/irq.c b/arch/mips/lemote/lm2e/irq.c
> index 1b99ef5..05693bc 100644
> --- a/arch/mips/lemote/lm2e/irq.c
> +++ b/arch/mips/lemote/lm2e/irq.c
> @@ -33,7 +33,8 @@
>  #include <asm/irq_cpu.h>
>  #include <asm/i8259.h>
>  #include <asm/mipsregs.h>
> -#include <bonito.h>
> +#include <asm/mips-boards/bonito64.h>
> +
>  
>  /*
>   * the first level int-handler will jump here if it is a bonito irq
> diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
> index 217e2d7..1ade1ce 100644
> --- a/arch/mips/lemote/lm2e/pci.c
> +++ b/arch/mips/lemote/lm2e/pci.c
> @@ -29,8 +29,9 @@
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <asm/mips-boards/bonito64.h>
>  
> -extern struct pci_ops loongson2e_pci_pci_ops;
> +extern struct pci_ops bonito64_pci_ops;
>  
>  static struct resource loongson2e_pci_mem_resource = {
>  	.name   = "LOONGSON2E PCI MEM",
> @@ -42,30 +43,48 @@ static struct resource loongson2e_pci_mem_resource = {
>  static struct resource loongson2e_pci_io_resource = {
>  	.name   = "LOONGSON2E PCI IO MEM",
>  	.start  = 0x00004000UL,
> -	.end    = 0x1fffffffUL,
> +	.end    = IO_SPACE_LIMIT,
>  	.flags  = IORESOURCE_IO,
>  };
>  
> -
>  static struct pci_controller  loongson2e_pci_controller = {
> -	.pci_ops        = &loongson2e_pci_pci_ops,
> +	.pci_ops        = &bonito64_pci_ops,
>  	.io_resource    = &loongson2e_pci_io_resource,
>  	.mem_resource   = &loongson2e_pci_mem_resource,
>  	.mem_offset     = 0x00000000UL,
>  	.io_offset      = 0x00000000UL,
>  };
>  
> +static void __init ict_pcimap(void)
> +{
> +	/*
> +	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
> +	 *
> +	 * CPU address space [256M,448M] is window for accessing pci space
> +	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
> +	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
> +	 */
> +	/* 1,00 0110 ,0001 01,00 0000 */
> +	BONITO_PCIMAP = 0x46140;
> +
> +	/* 1, 00 0010, 0000,01, 00 0000 */
> +	/* BONITO_PCIMAP = 0x42040; */
> +
> +	/*
> +	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
> +	 */
> +	BONITO_PCIBASE0 = 0x80000000;
> +	BONITO_PCIBASE1 = 0x00800000;
> +	BONITO_PCIBASE2 = 0x90000000;
> +
> +}
>  
>  static int __init pcibios_init(void)
>  {
>  	extern int pci_probe_only;
>  	pci_probe_only = 0;
>  
> -#ifdef CONFIG_TRACE_BOOT
> -	printk(KERN_INFO"arch_initcall:pcibios_init\n");
> -	printk(KERN_INFO"register_pci_controller : %x\n",
> -	       &loongson2e_pci_controller);
> -#endif
> +	ict_pcimap();
>  	register_pci_controller(&loongson2e_pci_controller);
>  
>  	return 0;
> diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
> index 58c40a5..0e4d1fa 100644
> --- a/arch/mips/lemote/lm2e/setup.c
> +++ b/arch/mips/lemote/lm2e/setup.c
> @@ -97,11 +97,6 @@ void __init plat_mem_setup(void)
>  {
>  	set_io_port_base(PTR_PAD(0xbfd00000));
>  
> -	ioport_resource.start = 0;
> -	ioport_resource.end = 0xffffffff;
> -	iomem_resource.start = 0;
> -	iomem_resource.end = 0xffffffff;
> -
>  	mips_reboot_setup();
>  
>  	board_time_init = loongson2e_time_init;
> @@ -109,11 +104,9 @@ void __init plat_mem_setup(void)
>  
>  	__wbflush = wbflush_loongson2e;
>  
> -     /* add_memory_region(0x100000, (memsize<<20) - 0x100000, BOOT_MEM_RAM); */
>  	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
>  #ifdef CONFIG_64BIT
>  	if (highmemsize > 0) {
> -		add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RESERVED);
>  		add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
>  	}
>  #endif
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index d7f5d8b..48380cb 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -29,7 +29,7 @@ obj-$(CONFIG_MIPS_EV64120)	+= pci-ev64120.o
>  obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
>  obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
>  obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
> -obj-$(CONFIG_LEMOTE_FULONG)	+= fixup-lm2e.o ops-lm2e.o
> +obj-$(CONFIG_LEMOTE_FULONG)	+= fixup-lm2e.o ops-bonito64.o
>  obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
>  obj-$(CONFIG_MOMENCO_OCELOT)	+= fixup-ocelot.o pci-ocelot.o
>  obj-$(CONFIG_MOMENCO_OCELOT_3)	+= fixup-ocelot3.o
> diff --git a/arch/mips/pci/fixup-lm2e.c b/arch/mips/pci/fixup-lm2e.c
> index c338b85..81ad591 100644
> --- a/arch/mips/pci/fixup-lm2e.c
> +++ b/arch/mips/pci/fixup-lm2e.c
> @@ -31,52 +31,32 @@
>   */
>  #include <linux/init.h>
>  #include <linux/pci.h>
> -#include <bonito.h>
> +#include <asm/mips-boards/bonito64.h>
>  
> -int __init pcibios_map_irq(config struct pci_dev *dev, u8 slot, u8 pin)
> +/* South bridge slot number is set by the pci probe process */
> +static u8 sb_slot = 5;
> +
> +int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
> -	unsigned int val;
> +	int irq = 0;
>  
> -	if (PCI_SLOT(dev->devfn) == 4) {	/* wireless card(notebook) */
> -		dev->irq = BONITO_IRQ_BASE + 26;
> -		return dev->irq;
> -	} else if (PCI_SLOT(dev->devfn) == 5) {	/* via686b */
> +	if (slot == sb_slot) {
>  		switch (PCI_FUNC(dev->devfn)) {
>  		case 2:
> -			dev->irq = 10;
> +			irq = 10;
>  			break;
>  		case 3:
> -			dev->irq = 11;
> +			irq = 11;
>  			break;
>  		case 5:
> -			dev->irq = 9;
> +			irq = 9;
>  			break;
>  		}
> -		return dev->irq;
> -	} else if (PCI_SLOT(dev->devfn) == 6) {	/* radeon 7000 */
> -		dev->irq = BONITO_IRQ_BASE + 27;
> -		return dev->irq;
> -	} else if (PCI_SLOT(dev->devfn) == 7) {	/* 8139 */
> -		dev->irq = BONITO_IRQ_BASE + 26;
> -		return dev->irq;
> -	} else if (PCI_SLOT(dev->devfn) == 8) {	/* nec usb */
> -		switch (PCI_FUNC(dev->devfn)) {
> -		case 0:
> -			dev->irq = BONITO_IRQ_BASE + 26;
> -			break;
> -		case 1:
> -			dev->irq = BONITO_IRQ_BASE + 27;
> -			break;
> -		case 2:
> -			dev->irq = BONITO_IRQ_BASE + 28;
> -			break;
> -		}
> -		pci_read_config_dword(dev, 0xe0, &val);
> -		pci_write_config_dword(dev, 0xe0, (val & ~7) | 0x4);
> -		pci_write_config_dword(dev, 0xe4, 1 << 5);
> -		return dev->irq;
> -	} else
> -		return 0;
> +	} else {
> +		irq = BONITO_IRQ_BASE + 25 + pin;
> +	}
> +	return irq;
> +
>  }
>  
>  /* Do platform specific device initialization at pci_enable_device() time */
> @@ -85,9 +65,23 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static void __init loongson2e_nec_fixup(struct pci_dev *pdev)
> +{
> +	unsigned int val;
> +
> +	/* Configues port 1, 2, 3, 4 to be validate*/
> +	pci_read_config_dword(pdev, 0xe0, &val);
> +	pci_write_config_dword(pdev, 0xe0, (val & ~7) | 0x4);
> +
> +	/* System clock is 48-MHz Oscillator. */
> +	pci_write_config_dword(pdev, 0xe4, 1 << 5);
> +}
> +
>  static void __init loongson2e_686b_func0_fixup(struct pci_dev *pdev)
>  {
>  	unsigned char c;
> +	
> +	sb_slot = PCI_SLOT(pdev->devfn);
>  
>  	printk(KERN_INFO "via686b fix: ISA bridge\n");
>  
> @@ -191,6 +185,18 @@ static void __init loongson2e_686b_func1_fixup(struct pci_dev *pdev)
>  	printk(KERN_INFO"via686b fix: IDE done\n");
>  }
>  
> +static void __init loongson2e_686b_func2_fixup(struct pci_dev *pdev)
> +{
> +	/* irq routing */
> +	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 10);
> +}
> +
> +static void __init loongson2e_686b_func3_fixup(struct pci_dev *pdev)
> +{
> +	/* irq routing */
> +	pci_write_config_byte(pdev, PCI_INTERRUPT_LINE, 11);
> +}
> +
>  static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
>  {
>  	unsigned int val;
> @@ -205,11 +211,8 @@ static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
>  
>  	/* route ac97 IRQ */
>  	pci_write_config_byte(pdev, 0x3c, 9);
> -	pdev->irq = 9;
> -	printk(KERN_INFO"ac97 interrupt = 9\n");
>  
>  	pci_read_config_byte(pdev, 0x8, &c);
> -	printk(KERN_INFO"ac97 rev=%d\n", c);
>  
>  	/* link control: enable link & SGD PCM output */
>  	pci_write_config_byte(pdev, 0x41, 0xcc);
> @@ -217,53 +220,23 @@ static void __init loongson2e_686b_func5_fixup(struct pci_dev *pdev)
>  	/* disable game port, FM, midi, sb, enable write to reg2c-2f */
>  	pci_write_config_byte(pdev, 0x42, 0x20);
>  
> -	printk(KERN_INFO"Setting sub-vendor ID & device ID\n");
> -
>  	/* we are using Avance logic codec */
>  	pci_write_config_word(pdev, 0x2c, 0x1005);
>  	pci_write_config_word(pdev, 0x2e, 0x4710);
>  	pci_read_config_dword(pdev, 0x2c, &val);
> -	printk(KERN_INFO"sub vendor-device id=%x\n", val);
>  
>  	pci_write_config_byte(pdev, 0x42, 0x0);
>  }
>  
> -static void __init loongson2e_fixup_pcimap(struct pci_dev *pdev)
> -{
> -	static int first = 1;
> -
> -	(void)pdev;
> -	if (first)
> -		first = 0;
> -	else
> -		return;
> -
> -	/*
> -	 * local to PCI mapping: [256M,512M] -> [256M,512M]; differ from PMON
> -	 *
> -	 * CPU address space [256M,448M] is window for accessing pci space
> -	 * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
> -	 * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
> -	 */
> -	/* 1,00 0110 ,0001 01,00 0000 */
> -	BONITO_PCIMAP = 0x46140;
> -
> -	/* 1, 00 0010, 0000,01, 00 0000 */
> -	/* BONITO_PCIMAP = 0x42040; */
> -
> -	/*
> -	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
> -	 */
> -	BONITO_PCIBASE0 = 0x80000000;
> -	BONITO_PCIBASE1 = 0x00800000;
> -	BONITO_PCIBASE2 = 0x90000000;
> -
> -}
> -
> -DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, loongson2e_fixup_pcimap);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
>  			 loongson2e_686b_func0_fixup);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
>  			 loongson2e_686b_func1_fixup);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2,
> +			 loongson2e_686b_func2_fixup);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3,
> +			 loongson2e_686b_func3_fixup);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
>  			 loongson2e_686b_func5_fixup);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
> +			 loongson2e_nec_fixup);
> diff --git a/arch/mips/pci/ops-bonito64.c b/arch/mips/pci/ops-bonito64.c
> index dc35270..f742c51 100644
> --- a/arch/mips/pci/ops-bonito64.c
> +++ b/arch/mips/pci/ops-bonito64.c
> @@ -29,83 +29,60 @@
>  #define PCI_ACCESS_READ  0
>  #define PCI_ACCESS_WRITE 1
>  
> -/*
> - *  PCI configuration cycle AD bus definition
> - */
> -/* Type 0 */
> -#define PCI_CFG_TYPE0_REG_SHF           0
> -#define PCI_CFG_TYPE0_FUNC_SHF          8
> +#ifdef CONFIG_LEMOTE_FULONG
> +#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (offset))
> +#define ID_SEL_BEGIN 11
> +#else
> +#define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(_pcictrl_bonito_pcicfg + (offset))
> +#define ID_SEL_BEGIN 10
> +#endif
> +#define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
>  
> -/* Type 1 */
> -#define PCI_CFG_TYPE1_REG_SHF           0
> -#define PCI_CFG_TYPE1_FUNC_SHF          8
> -#define PCI_CFG_TYPE1_DEV_SHF           11
> -#define PCI_CFG_TYPE1_BUS_SHF           16
>  
>  static int bonito64_pcibios_config_access(unsigned char access_type,
>  				      struct pci_bus *bus,
>  				      unsigned int devfn, int where,
>  				      u32 * data)
>  {
> -	unsigned char busnum = bus->number;
> +	u32 busnum = bus->number;
> +	u32 addr, type;
>  	u32 dummy;
> -	u64 pci_addr;
> -
> -	/* Algorithmics Bonito64 system controller. */
> +	void *addrp;
> +	int device = PCI_SLOT(devfn);
> +	int function = PCI_FUNC(devfn);
> +	int reg = where & ~3;
>  
> -	if ((busnum == 0) && (PCI_SLOT(devfn) > 21)) {
> -		/* We number bus 0 devices from 0..21 */
> -		return -1;
> -	}
> -
> -	/* Clear cause register bits */
> -	BONITO_PCICMD |= (BONITO_PCICMD_MABORT_CLR |
> -			  BONITO_PCICMD_MTABORT_CLR);
> -
> -	/*
> -	 * Setup pattern to be used as PCI "address" for
> -	 * Type 0 cycle
> -	 */
>  	if (busnum == 0) {
> -		/* IDSEL */
> -		pci_addr = (u64) 1 << (PCI_SLOT(devfn) + 10);
> -	} else {
> -		/* Bus number */
> -		pci_addr = busnum << PCI_CFG_TYPE1_BUS_SHF;
> -
> -		/* Device number */
> -		pci_addr |=
> -		    PCI_SLOT(devfn) << PCI_CFG_TYPE1_DEV_SHF;
> -	}
> -
> -	/* Function (same for Type 0/1) */
> -	pci_addr |= PCI_FUNC(devfn) << PCI_CFG_TYPE0_FUNC_SHF;
> -
> -	/* Register number (same for Type 0/1) */
> -	pci_addr |= (where & ~0x3) << PCI_CFG_TYPE0_REG_SHF;
> +		/* Type 0 configuration for onboard PCI bus */
> +		if (device > MAX_DEV_NUM)
> +			return -1;
>  
> -	if (busnum == 0) {
> -		/* Type 0 */
> -		BONITO_PCIMAP_CFG = pci_addr >> 16;
> +		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
> +		type = 0;
>  	} else {
> -		/* Type 1 */
> -		BONITO_PCIMAP_CFG = (pci_addr >> 16) | 0x10000;
> +		/* Type 1 configuration for offboard PCI bus */
> +		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
> +		type = 0x10000;
>  	}
>  
> -	pci_addr &= 0xffff;
> +	/* Clear aborts */
> +	BONITO_PCICMD |= BONITO_PCICMD_MABORT_CLR | BONITO_PCICMD_MTABORT_CLR;
> +
> +	BONITO_PCIMAP_CFG = (addr >> 16) | type;
>  
>  	/* Flush Bonito register block */
>  	dummy = BONITO_PCIMAP_CFG;
> -	iob();		/* sync */
> +	mmiowb();
>  
> -	/* Perform access */
> +	addrp = CFG_SPACE_REG(addr & 0xffff);
>  	if (access_type == PCI_ACCESS_WRITE) {
> -		*(volatile u32 *) (_pcictrl_bonito_pcicfg + (u32)pci_addr) = *(u32 *) data;
> -
> +		writel(cpu_to_le32(*data), addrp);
> +#ifndef CONFIG_LEMOTE_FULONG
>  		/* Wait till done */
>  		while (BONITO_PCIMSTAT & 0xF);
> +#endif
>  	} else {
> -		*(u32 *) data = *(volatile u32 *) (_pcictrl_bonito_pcicfg + (u32)pci_addr);
> +		*data = le32_to_cpu(readl(addrp));
>  	}
>  
>  	/* Detect Master/Target abort */
> @@ -121,6 +98,7 @@ static int bonito64_pcibios_config_access(unsigned char access_type,
>  	}
>  
>  	return 0;
> +
>  }
>  
>  
> diff --git a/arch/mips/pci/ops-lm2e.c b/arch/mips/pci/ops-lm2e.c
> deleted file mode 100644
> index 5dc113b..0000000
> --- a/arch/mips/pci/ops-lm2e.c
> +++ /dev/null
> @@ -1,153 +0,0 @@
> -/*
> - * ops-lm2e.c
> - *
> - * Copyright (C) 2004 ICT CAS
> - * Author: Li xiaoyu, ICT CAS
> - *   lixy@ict.ac.cn
> - *
> - * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
> - * Author: Fuxin Zhang, zhangfx@lemote.com
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - */
> -
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include <linux/kernel.h>
> -
> -#include <bonito.h>
> -
> -#define PCI_ACCESS_READ  0
> -#define PCI_ACCESS_WRITE 1
> -
> -static inline void bflush(void)
> -{
> -	/* flush Bonito register writes */
> -	(void)BONITO_PCICMD;
> -}
> -
> -static int lm2e_pci_config_access(unsigned char access_type,
> -				  struct pci_bus *bus, unsigned int devfn,
> -				  int where, u32 *data)
> -{
> -	u32 busnum = bus->number;
> -	u32 addr, type;
> -	void *addrp;
> -	int device = PCI_SLOT(devfn);
> -	int function = PCI_FUNC(devfn);
> -	int reg = where & ~3;
> -
> -	if (busnum == 0) {
> -		/* Type 0 configuration on onboard PCI bus */
> -		if (device > 20 || function > 7) {
> -			*data = -1;	/* device out of range */
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -		}
> -		addr = (1 << (device + 11)) | (function << 8) | reg;
> -		type = 0;
> -	} else {
> -		/* Type 1 configuration on offboard PCI bus */
> -		if (device > 31 || function > 7) {
> -			*data = -1;	/* device out of range */
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -		}
> -		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
> -		type = 0x10000;
> -	}
> -
> -	/* clear aborts */
> -	BONITO_PCICMD |= BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT;
> -
> -	BONITO_PCIMAP_CFG = (addr >> 16) | type;
> -	bflush();
> -
> -	addrp = (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (addr & 0xffff));
> -	if (access_type == PCI_ACCESS_WRITE) {
> -		writel(cpu_to_le32(*data), addrp);
> -	} else {
> -		*data = le32_to_cpu(readl(addrp));
> -	}
> -	if (BONITO_PCICMD & (BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT)) {
> -		BONITO_PCICMD |= BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT;
> -		*data = -1;
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	}
> -
> -	return PCIBIOS_SUCCESSFUL;
> -
> -}
> -
> -static int lm2e_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
> -				 int where, int size, u32 * val)
> -{
> -	u32 data = 0;
> -
> -	int ret = lm2e_pci_config_access(PCI_ACCESS_READ,
> -			bus, devfn, where, &data);
> -
> -	if (ret != PCIBIOS_SUCCESSFUL)
> -		return ret;
> -
> -	if (size == 1)
> -		*val = (data >> ((where & 3) << 3)) & 0xff;
> -	else if (size == 2)
> -		*val = (data >> ((where & 3) << 3)) & 0xffff;
> -	else
> -		*val = data;
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int lm2e_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
> -				  int where, int size, u32 val)
> -{
> -	u32 data = 0;
> -	int ret;
> -
> -	if (size == 4)
> -		data = val;
> -	else {
> -		ret = lm2e_pci_config_access(PCI_ACCESS_READ,
> -				bus, devfn, where, &data);
> -		if (ret != PCIBIOS_SUCCESSFUL)
> -			return ret;
> -
> -		if (size == 1)
> -			data = (data & ~(0xff << ((where & 3) << 3))) |
> -			    (val << ((where & 3) << 3));
> -		else if (size == 2)
> -			data = (data & ~(0xffff << ((where & 3) << 3))) |
> -			    (val << ((where & 3) << 3));
> -	}
> -
> -	ret = lm2e_pci_config_access(PCI_ACCESS_WRITE,
> -			bus, devfn, where, &data);
> -	if (ret != PCIBIOS_SUCCESSFUL)
> -		return ret;
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -struct pci_ops loongson2e_pci_pci_ops = {
> -	.read = lm2e_pci_pcibios_read,
> -	.write = lm2e_pci_pcibios_write
> -};
> diff --git a/include/asm-mips/mach-lemote/bonito.h b/include/asm-mips/mach-lemote/bonito.h
> deleted file mode 100644
> index ba9a11d..0000000
> --- a/include/asm-mips/mach-lemote/bonito.h
> +++ /dev/null
> @@ -1,438 +0,0 @@
> -/*
> - * Bonito Register Map
> - *
> - * This file is the original bonito.h from Algorithmics with minor changes
> - * to fit into linux.
> - *
> - * Copyright (c) 1999 Algorithmics Ltd
> - *
> - * Carsten Langgaard, carstenl@mips.com
> - * Copyright (C) 2001 MIPS Technologies, Inc.  All rights reserved.
> - * Copyright (c) 2007 Ralf Baechle (ralf@linux-mips.org)
> - *
> - * Algorithmics gives permission for anyone to use and modify this file
> - * without any obligation or license condition except that you retain
> - * this copyright message in any source redistribution in whole or part.
> - */
> -#ifndef __ASM_MACH_LEMOTE_BONITO_H
> -#define __ASM_MACH_LEMOTE_BONITO_H
> -
> -#include <linux/types.h>
> -#include <asm/addrspace.h>
> -
> -#ifdef __ASSEMBLER__
> -
> -/* offsets from base register */
> -#define BONITO(x)	(x)
> -
> -#else /* !__ASSEMBLER */
> -
> -/* offsets from base pointer */
> -#define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x)))
> -
> -#endif /* __ASSEMBLER__ */
> -
> -#define BONITO_BOOT_BASE		0x1fc00000
> -#define BONITO_BOOT_SIZE		0x00100000
> -#define BONITO_BOOT_TOP 		(BONITO_BOOT_BASE+BONITO_BOOT_SIZE - 1)
> -#define BONITO_FLASH_BASE		0x1c000000
> -#define BONITO_FLASH_SIZE		0x03000000
> -#define BONITO_FLASH_TOP						\
> -	(BONITO_FLASH_BASE+BONITO_FLASH_SIZE - 1)
> -#define BONITO_SOCKET_BASE		0x1f800000
> -#define BONITO_SOCKET_SIZE		0x00400000
> -#define BONITO_SOCKET_TOP						\
> -	(BONITO_SOCKET_BASE + BONITO_SOCKET_SIZE - 1)
> -#define BONITO_REG_BASE 		0x1fe00000
> -#define BONITO_REG_SIZE 		0x00040000
> -#define BONITO_REG_TOP			(BONITO_REG_BASE+BONITO_REG_SIZE-1)
> -#define BONITO_DEV_BASE 		0x1ff00000
> -#define BONITO_DEV_SIZE 		0x00100000
> -#define BONITO_DEV_TOP			(BONITO_DEV_BASE+BONITO_DEV_SIZE-1)
> -#define BONITO_PCILO_BASE		0x10000000
> -#define BONITO_PCILO_SIZE		0x0c000000
> -#define BONITO_PCILO_TOP		(BONITO_PCILO_BASE+BONITO_PCILO_SIZE-1)
> -#define BONITO_PCILO0_BASE		0x10000000
> -#define BONITO_PCILO1_BASE		0x14000000
> -#define BONITO_PCILO2_BASE		0x18000000
> -#define BONITO_PCIHI_BASE		0x20000000
> -#define BONITO_PCIHI_SIZE		0x20000000
> -#define BONITO_PCIHI_TOP		(BONITO_PCIHI_BASE+BONITO_PCIHI_SIZE-1)
> -#define BONITO_PCIIO_BASE		0x1fd00000
> -#define BONITO_PCIIO_SIZE		0x00100000
> -#define BONITO_PCIIO_TOP		(BONITO_PCIIO_BASE+BONITO_PCIIO_SIZE-1)
> -#define BONITO_PCICFG_BASE		0x1fe80000
> -#define BONITO_PCICFG_SIZE		0x00080000
> -#define BONITO_PCICFG_TOP						\
> -	(BONITO_PCICFG_BASE + BONITO_PCICFG_SIZE - 1)
> -
> -/* Bonito Register Bases */
> -
> -#define BONITO_PCICONFIGBASE		0x00
> -#define BONITO_REGBASE			0x100
> -
> -/* PCI Configuration  Registers */
> -
> -#define BONITO_PCI_REG(x)               BONITO(BONITO_PCICONFIGBASE + (x))
> -#define BONITO_PCIDID			BONITO_PCI_REG(0x00)
> -#define BONITO_PCICMD			BONITO_PCI_REG(0x04)
> -#define BONITO_PCICLASS 		BONITO_PCI_REG(0x08)
> -#define BONITO_PCILTIMER		BONITO_PCI_REG(0x0c)
> -#define BONITO_PCIBASE0 		BONITO_PCI_REG(0x10)
> -#define BONITO_PCIBASE1 		BONITO_PCI_REG(0x14)
> -#define BONITO_PCIBASE2 		BONITO_PCI_REG(0x18)
> -#define BONITO_PCIEXPRBASE		BONITO_PCI_REG(0x30)
> -#define BONITO_PCIINT			BONITO_PCI_REG(0x3c)
> -
> -#define BONITO_PCICMD_PERR		0x80000000
> -#define BONITO_PCICMD_SERR		0x40000000
> -#define BONITO_PCICMD_MABORT		0x20000000
> -#define BONITO_PCICMD_MTABORT		0x10000000
> -#define BONITO_PCICMD_TABORT		0x08000000
> -#define BONITO_PCICMD_MPERR	 	0x01000000
> -#define BONITO_PCICMD_PERRRESPEN	0x00000040
> -#define BONITO_PCICMD_ASTEPEN		0x00000080
> -#define BONITO_PCICMD_SERREN		0x00000100
> -#define BONITO_PCILTIMER_BUSLATENCY	0x0000ff00
> -#define BONITO_PCILTIMER_BUSLATENCY_SHIFT	8
> -
> -/* 1. Bonito h/w Configuration */
> -/* Power on register */
> -
> -#define BONITO_BONPONCFG		BONITO(BONITO_REGBASE + 0x00)
> -
> -#define BONITO_BONPONCFG_SYSCONTROLLERRD	0x00040000
> -#define BONITO_BONPONCFG_ROMCS1SAMP	0x00020000
> -#define BONITO_BONPONCFG_ROMCS0SAMP	0x00010000
> -#define BONITO_BONPONCFG_CPUBIGEND	0x00004000
> -#define BONITO_BONPONCFG_CPUPARITY	0x00002000
> -#define BONITO_BONPONCFG_CPUTYPE	0x00000007
> -#define BONITO_BONPONCFG_CPUTYPE_SHIFT	0
> -#define BONITO_BONPONCFG_PCIRESET_OUT	0x00000008
> -#define BONITO_BONPONCFG_IS_ARBITER	0x00000010
> -#define BONITO_BONPONCFG_ROMBOOT	0x000000c0
> -#define BONITO_BONPONCFG_ROMBOOT_SHIFT	6
> -
> -#define BONITO_BONPONCFG_ROMBOOT_FLASH	(0x0<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
> -#define BONITO_BONPONCFG_ROMBOOT_SOCKET (0x1<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
> -#define BONITO_BONPONCFG_ROMBOOT_SDRAM	(0x2<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
> -#define BONITO_BONPONCFG_ROMBOOT_CPURESET				\
> -	(0x3<<BONITO_BONPONCFG_ROMBOOT_SHIFT)
> -
> -#define BONITO_BONPONCFG_ROMCS0WIDTH	0x00000100
> -#define BONITO_BONPONCFG_ROMCS1WIDTH	0x00000200
> -#define BONITO_BONPONCFG_ROMCS0FAST	0x00000400
> -#define BONITO_BONPONCFG_ROMCS1FAST	0x00000800
> -#define BONITO_BONPONCFG_CONFIG_DIS	0x00000020
> -
> -/* Other Bonito configuration */
> -
> -#define BONITO_BONGENCFG_OFFSET         0x4
> -#define BONITO_BONGENCFG						\
> -	BONITO(BONITO_REGBASE + BONITO_BONGENCFG_OFFSET)
> -
> -#define BONITO_BONGENCFG_DEBUGMODE	0x00000001
> -#define BONITO_BONGENCFG_SNOOPEN	0x00000002
> -#define BONITO_BONGENCFG_CPUSELFRESET	0x00000004
> -
> -#define BONITO_BONGENCFG_FORCE_IRQA	0x00000008
> -#define BONITO_BONGENCFG_IRQA_ISOUT	0x00000010
> -#define BONITO_BONGENCFG_IRQA_FROM_INT1 0x00000020
> -#define BONITO_BONGENCFG_BYTESWAP	0x00000040
> -
> -#define BONITO_BONGENCFG_UNCACHED	0x00000080
> -#define BONITO_BONGENCFG_PREFETCHEN	0x00000100
> -#define BONITO_BONGENCFG_WBEHINDEN	0x00000200
> -#define BONITO_BONGENCFG_CACHEALG	0x00000c00
> -#define BONITO_BONGENCFG_CACHEALG_SHIFT 10
> -#define BONITO_BONGENCFG_PCIQUEUE	0x00001000
> -#define BONITO_BONGENCFG_CACHESTOP	0x00002000
> -#define BONITO_BONGENCFG_MSTRBYTESWAP	0x00004000
> -#define BONITO_BONGENCFG_BUSERREN	0x00008000
> -#define BONITO_BONGENCFG_NORETRYTIMEOUT 0x00010000
> -#define BONITO_BONGENCFG_SHORTCOPYTIMEOUT	0x00020000
> -
> -/* 2. IO & IDE configuration */
> -
> -#define BONITO_IODEVCFG 		BONITO(BONITO_REGBASE + 0x08)
> -
> -/* 3. IO & IDE configuration */
> -
> -#define BONITO_SDCFG			BONITO(BONITO_REGBASE + 0x0c)
> -
> -/* 4. PCI address map control */
> -
> -#define BONITO_PCIMAP			BONITO(BONITO_REGBASE + 0x10)
> -#define BONITO_PCIMEMBASECFG		BONITO(BONITO_REGBASE + 0x14)
> -#define BONITO_PCIMAP_CFG		BONITO(BONITO_REGBASE + 0x18)
> -
> -/* 5. ICU & GPIO regs */
> -
> -/* GPIO Regs - r/w */
> -
> -#define BONITO_GPIODATA_OFFSET          0x1c
> -#define BONITO_GPIODATA 						\
> -		BONITO(BONITO_REGBASE + BONITO_GPIODATA_OFFSET)
> -#define BONITO_GPIOIE			BONITO(BONITO_REGBASE + 0x20)
> -
> -/* ICU Configuration Regs - r/w */
> -
> -#define BONITO_INTEDGE			BONITO(BONITO_REGBASE + 0x24)
> -#define BONITO_INTSTEER 		BONITO(BONITO_REGBASE + 0x28)
> -#define BONITO_INTPOL			BONITO(BONITO_REGBASE + 0x2c)
> -
> -/* ICU Enable Regs - IntEn & IntISR are r/o. */
> -
> -#define BONITO_INTENSET 		BONITO(BONITO_REGBASE + 0x30)
> -#define BONITO_INTENCLR 		BONITO(BONITO_REGBASE + 0x34)
> -#define BONITO_INTEN			BONITO(BONITO_REGBASE + 0x38)
> -#define BONITO_INTISR			BONITO(BONITO_REGBASE + 0x3c)
> -
> -/* PCI mail boxes */
> -
> -#define BONITO_PCIMAIL0_OFFSET          0x40
> -#define BONITO_PCIMAIL1_OFFSET          0x44
> -#define BONITO_PCIMAIL2_OFFSET          0x48
> -#define BONITO_PCIMAIL3_OFFSET          0x4c
> -#define BONITO_PCIMAIL0 		BONITO(BONITO_REGBASE + 0x40)
> -#define BONITO_PCIMAIL1 		BONITO(BONITO_REGBASE + 0x44)
> -#define BONITO_PCIMAIL2 		BONITO(BONITO_REGBASE + 0x48)
> -#define BONITO_PCIMAIL3 		BONITO(BONITO_REGBASE + 0x4c)
> -
> -/* 6. PCI cache */
> -
> -#define BONITO_PCICACHECTRL		BONITO(BONITO_REGBASE + 0x50)
> -#define BONITO_PCICACHETAG		BONITO(BONITO_REGBASE + 0x54)
> -
> -#define BONITO_PCIBADADDR		BONITO(BONITO_REGBASE + 0x58)
> -#define BONITO_PCIMSTAT 		BONITO(BONITO_REGBASE + 0x5c)
> -
> -/*
> -#define BONITO_PCIRDPOST		BONITO(BONITO_REGBASE + 0x60)
> -#define BONITO_PCIDATA			BONITO(BONITO_REGBASE + 0x64)
> -*/
> -
> -/* 7. IDE DMA & Copier */
> -
> -#define BONITO_CONFIGBASE		0x000
> -#define BONITO_BONITOBASE		0x100
> -#define BONITO_LDMABASE 		0x200
> -#define BONITO_COPBASE			0x300
> -#define BONITO_REG_BLOCKMASK		0x300
> -
> -#define BONITO_LDMACTRL 		BONITO(BONITO_LDMABASE + 0x0)
> -#define BONITO_LDMASTAT 		BONITO(BONITO_LDMABASE + 0x0)
> -#define BONITO_LDMAADDR 		BONITO(BONITO_LDMABASE + 0x4)
> -#define BONITO_LDMAGO			BONITO(BONITO_LDMABASE + 0x8)
> -#define BONITO_LDMADATA 		BONITO(BONITO_LDMABASE + 0xc)
> -
> -#define BONITO_COPCTRL			BONITO(BONITO_COPBASE + 0x0)
> -#define BONITO_COPSTAT			BONITO(BONITO_COPBASE + 0x0)
> -#define BONITO_COPPADDR 		BONITO(BONITO_COPBASE + 0x4)
> -#define BONITO_COPDADDR 		BONITO(BONITO_COPBASE + 0x8)
> -#define BONITO_COPGO			BONITO(BONITO_COPBASE + 0xc)
> -
> -/* ###### Bit Definitions for individual Registers #### */
> -
> -/* Gen DMA. */
> -
> -#define BONITO_IDECOPDADDR_DMA_DADDR	0x0ffffffc
> -#define BONITO_IDECOPDADDR_DMA_DADDR_SHIFT	2
> -#define BONITO_IDECOPPADDR_DMA_PADDR	0xfffffffc
> -#define BONITO_IDECOPPADDR_DMA_PADDR_SHIFT	2
> -#define BONITO_IDECOPGO_DMA_SIZE	0x0000fffe
> -#define BONITO_IDECOPGO_DMA_SIZE_SHIFT	0
> -#define BONITO_IDECOPGO_DMA_WRITE	0x00010000
> -#define BONITO_IDECOPGO_DMAWCOUNT	0x000f0000
> -#define BONITO_IDECOPGO_DMAWCOUNT_SHIFT	16
> -
> -#define BONITO_IDECOPCTRL_DMA_STARTBIT	0x80000000
> -#define BONITO_IDECOPCTRL_DMA_RSTBIT	0x40000000
> -
> -/* DRAM - sdCfg */
> -
> -#define BONITO_SDCFG_AROWBITS		0x00000003
> -#define BONITO_SDCFG_AROWBITS_SHIFT	0
> -#define BONITO_SDCFG_ACOLBITS		0x0000000c
> -#define BONITO_SDCFG_ACOLBITS_SHIFT	2
> -#define BONITO_SDCFG_ABANKBIT		0x00000010
> -#define BONITO_SDCFG_ASIDES		0x00000020
> -#define BONITO_SDCFG_AABSENT		0x00000040
> -#define BONITO_SDCFG_AWIDTH64		0x00000080
> -
> -#define BONITO_SDCFG_BROWBITS		0x00000300
> -#define BONITO_SDCFG_BROWBITS_SHIFT	8
> -#define BONITO_SDCFG_BCOLBITS		0x00000c00
> -#define BONITO_SDCFG_BCOLBITS_SHIFT	10
> -#define BONITO_SDCFG_BBANKBIT		0x00001000
> -#define BONITO_SDCFG_BSIDES		0x00002000
> -#define BONITO_SDCFG_BABSENT		0x00004000
> -#define BONITO_SDCFG_BWIDTH64		0x00008000
> -
> -#define BONITO_SDCFG_EXTRDDATA		0x00010000
> -#define BONITO_SDCFG_EXTRASCAS		0x00020000
> -#define BONITO_SDCFG_EXTPRECH		0x00040000
> -#define BONITO_SDCFG_EXTRASWIDTH	0x00180000
> -#define BONITO_SDCFG_EXTRASWIDTH_SHIFT	19
> -#define BONITO_SDCFG_DRAMRESET		0x00200000
> -#define BONITO_SDCFG_DRAMEXTREGS	0x00400000
> -#define BONITO_SDCFG_DRAMPARITY 	0x00800000
> -
> -/* PCI Cache - pciCacheCtrl */
> -
> -#define BONITO_PCICACHECTRL_CACHECMD	0x00000007
> -#define BONITO_PCICACHECTRL_CACHECMD_SHIFT	0
> -#define BONITO_PCICACHECTRL_CACHECMDLINE	0x00000018
> -#define BONITO_PCICACHECTRL_CACHECMDLINE_SHIFT	3
> -#define BONITO_PCICACHECTRL_CMDEXEC	0x00000020
> -
> -#define BONITO_IODEVCFG_BUFFBIT_CS0	0x00000001
> -#define BONITO_IODEVCFG_SPEEDBIT_CS0	0x00000002
> -#define BONITO_IODEVCFG_MOREABITS_CS0	0x00000004
> -
> -#define BONITO_IODEVCFG_BUFFBIT_CS1	0x00000008
> -#define BONITO_IODEVCFG_SPEEDBIT_CS1	0x00000010
> -#define BONITO_IODEVCFG_MOREABITS_CS1	0x00000020
> -
> -#define BONITO_IODEVCFG_BUFFBIT_CS2	0x00000040
> -#define BONITO_IODEVCFG_SPEEDBIT_CS2	0x00000080
> -#define BONITO_IODEVCFG_MOREABITS_CS2	0x00000100
> -
> -#define BONITO_IODEVCFG_BUFFBIT_CS3	0x00000200
> -#define BONITO_IODEVCFG_SPEEDBIT_CS3	0x00000400
> -#define BONITO_IODEVCFG_MOREABITS_CS3	0x00000800
> -
> -#define BONITO_IODEVCFG_BUFFBIT_IDE	0x00001000
> -#define BONITO_IODEVCFG_SPEEDBIT_IDE	0x00002000
> -#define BONITO_IODEVCFG_WORDSWAPBIT_IDE 0x00004000
> -#define BONITO_IODEVCFG_MODEBIT_IDE	0x00008000
> -#define BONITO_IODEVCFG_DMAON_IDE	0x001f0000
> -#define BONITO_IODEVCFG_DMAON_IDE_SHIFT 16
> -#define BONITO_IODEVCFG_DMAOFF_IDE	0x01e00000
> -#define BONITO_IODEVCFG_DMAOFF_IDE_SHIFT	21
> -#define BONITO_IODEVCFG_EPROMSPLIT	0x02000000
> -
> -/* gpio */
> -#define BONITO_GPIO_GPIOW		0x000003ff
> -#define BONITO_GPIO_GPIOW_SHIFT 	0
> -#define BONITO_GPIO_GPIOR		0x01ff0000
> -#define BONITO_GPIO_GPIOR_SHIFT 	16
> -#define BONITO_GPIO_GPINR		0xfe000000
> -#define BONITO_GPIO_GPINR_SHIFT 	25
> -#define BONITO_GPIO_IOW(N)		(1<<(BONITO_GPIO_GPIOW_SHIFT+(N)))
> -#define BONITO_GPIO_IOR(N)		(1<<(BONITO_GPIO_GPIOR_SHIFT+(N)))
> -#define BONITO_GPIO_INR(N)		(1<<(BONITO_GPIO_GPINR_SHIFT+(N)))
> -
> -/* ICU */
> -#define BONITO_ICU_MBOXES		0x0000000f
> -#define BONITO_ICU_MBOXES_SHIFT 	0
> -#define BONITO_ICU_DMARDY		0x00000010
> -#define BONITO_ICU_DMAEMPTY		0x00000020
> -#define BONITO_ICU_COPYRDY		0x00000040
> -#define BONITO_ICU_COPYEMPTY		0x00000080
> -#define BONITO_ICU_COPYERR		0x00000100
> -#define BONITO_ICU_PCIIRQ		0x00000200
> -#define BONITO_ICU_MASTERERR		0x00000400
> -#define BONITO_ICU_SYSTEMERR		0x00000800
> -#define BONITO_ICU_DRAMPERR		0x00001000
> -#define BONITO_ICU_RETRYERR		0x00002000
> -#define BONITO_ICU_GPIOS		0x01ff0000
> -#define BONITO_ICU_GPIOS_SHIFT		16
> -#define BONITO_ICU_GPINS		0x7e000000
> -#define BONITO_ICU_GPINS_SHIFT		25
> -#define BONITO_ICU_MBOX(N)		(1<<(BONITO_ICU_MBOXES_SHIFT+(N)))
> -#define BONITO_ICU_GPIO(N)		(1<<(BONITO_ICU_GPIOS_SHIFT+(N)))
> -#define BONITO_ICU_GPIN(N)		(1<<(BONITO_ICU_GPINS_SHIFT+(N)))
> -
> -/* pcimap */
> -
> -#define BONITO_PCIMAP_PCIMAP_LO0	0x0000003f
> -#define BONITO_PCIMAP_PCIMAP_LO0_SHIFT	0
> -#define BONITO_PCIMAP_PCIMAP_LO1	0x00000fc0
> -#define BONITO_PCIMAP_PCIMAP_LO1_SHIFT	6
> -#define BONITO_PCIMAP_PCIMAP_LO2	0x0003f000
> -#define BONITO_PCIMAP_PCIMAP_LO2_SHIFT	12
> -#define BONITO_PCIMAP_PCIMAP_2		0x00040000
> -#define BONITO_PCIMAP_WIN(WIN, ADDR)					\
> -	((((ADDR)>>26) & BONITO_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
> -
> -#define BONITO_PCIMAP_WINSIZE           (1<<26)
> -#define BONITO_PCIMAP_WINOFFSET(ADDR)	((ADDR) & (BONITO_PCIMAP_WINSIZE - 1))
> -#define BONITO_PCIMAP_WINBASE(ADDR)	((ADDR) << 26)
> -
> -/* pcimembaseCfg */
> -
> -#define BONITO_PCIMEMBASECFG_MASK               0xf0000000
> -#define BONITO_PCIMEMBASECFG_MEMBASE0_MASK	0x0000001f
> -#define BONITO_PCIMEMBASECFG_MEMBASE0_MASK_SHIFT	0
> -#define BONITO_PCIMEMBASECFG_MEMBASE0_TRANS	0x000003e0
> -#define BONITO_PCIMEMBASECFG_MEMBASE0_TRANS_SHIFT	5
> -#define BONITO_PCIMEMBASECFG_MEMBASE0_CACHED	0x00000400
> -#define BONITO_PCIMEMBASECFG_MEMBASE0_IO	0x00000800
> -
> -#define BONITO_PCIMEMBASECFG_MEMBASE1_MASK	0x0001f000
> -#define BONITO_PCIMEMBASECFG_MEMBASE1_MASK_SHIFT	12
> -#define BONITO_PCIMEMBASECFG_MEMBASE1_TRANS	0x003e0000
> -#define BONITO_PCIMEMBASECFG_MEMBASE1_TRANS_SHIFT	17
> -#define BONITO_PCIMEMBASECFG_MEMBASE1_CACHED	0x00400000
> -#define BONITO_PCIMEMBASECFG_MEMBASE1_IO	0x00800000
> -
> -#define BONITO_PCIMEMBASECFG_ASHIFT	23
> -#define BONITO_PCIMEMBASECFG_AMASK              0x007fffff
> -#define BONITO_PCIMEMBASECFGSIZE(WIN, SIZE)				\
> -	(								\
> -		((~((SIZE)-1)) >>					\
> -		 (BONITO_PCIMEMBASECFG_ASHIFT -				\
> -		  BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT)) &	\
> -		BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK		\
> -	)
> -#define BONITO_PCIMEMBASECFGBASE(WIN, BASE)				\
> -	(								\
> -		((BASE) >>						\
> -		 (BONITO_PCIMEMBASECFG_ASHIFT -				\
> -		  BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS_SHIFT)) &	\
> -		BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS		\
> -	)
> -
> -#define BONITO_PCIMEMBASECFG_SIZE(WIN, CFG)				\
> -	(								\
> -		(((~(CFG)) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) << \
> -		 (BONITO_PCIMEMBASECFG_ASHIFT -				\
> -		  BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT)) |	\
> -		BONITO_PCIMEMBASECFG_AMASK				\
> -	)
> -
> -#define BONITO_PCIMEMBASECFG_ADDRMASK(WIN, CFG)				\
> -	(								\
> -		(((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) >>	\
> -		 BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT) <<	\
> -		BONITO_PCIMEMBASECFG_ASHIFT				\
> -	)
> -#define BONITO_PCIMEMBASECFG_ADDRMASK(WIN, CFG)				\
> -	(								\
> -		(((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK) >>	\
> -		 BONITO_PCIMEMBASECFG_MEMBASE##WIN##_MASK_SHIFT) <<	\
> -		BONITO_PCIMEMBASECFG_ASHIFT	\
> -	)
> -#define BONITO_PCIMEMBASECFG_ADDRTRANS(WIN, CFG)			\
> -	(								\
> -		(((CFG) & BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS) >>	\
> -		 BONITO_PCIMEMBASECFG_MEMBASE##WIN##_TRANS_SHIFT) <<	\
> -		BONITO_PCIMEMBASECFG_ASHIFT				\
> -	)
> -
> -#define BONITO_PCITOPHYS(WIN, ADDR, CFG)				\
> -	(								\
> -		(((ADDR) & (~(BONITO_PCIMEMBASECFG_MASK))) &		\
> -		 (~(BONITO_PCIMEMBASECFG_ADDRMASK(WIN, CFG)))) |	\
> -		(BONITO_PCIMEMBASECFG_ADDRTRANS(WIN, CFG))		\
> -	)
> -
> -/* PCICmd */
> -
> -#define BONITO_PCICMD_MEMEN		0x00000002
> -#define BONITO_PCICMD_MSTREN		0x00000004
> -
> -#define BONITO_IRQ_BASE   32
> -
> -#endif /* __ASM_MACH_LEMOTE_BONITO_H */
> diff --git a/include/asm-mips/mips-boards/bonito64.h b/include/asm-mips/mips-boards/bonito64.h
> index cd71256..dc3fc32 100644
> --- a/include/asm-mips/mips-boards/bonito64.h
> +++ b/include/asm-mips/mips-boards/bonito64.h
> @@ -26,7 +26,12 @@
>  /* offsets from base register */
>  #define BONITO(x)	(x)
>  
> -#else /* !__ASSEMBLY__ */
> +#elif defined(CONFIG_LEMOTE_FULONG)
> +
> +#define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) + (x)))
> +#define BONITO_IRQ_BASE   32
> +
> +#else
>  
>  /*
>   * Algorithmics Bonito64 system controller register base.
>   
