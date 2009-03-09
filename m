Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 13:40:11 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2710 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366941AbZCINkH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2009 13:40:07 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n29De5xV022470;
	Mon, 9 Mar 2009 14:40:05 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n29De4a1022468;
	Mon, 9 Mar 2009 14:40:04 +0100
Date:	Mon, 9 Mar 2009 14:40:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 01/10] Initial Au1300 and DBAu1300 support
Message-ID: <20090309134003.GE6492@linux-mips.org>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com> <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 06, 2009 at 10:20:00AM -0600, Kevin Hickey wrote:

> @@ -135,3 +147,9 @@ config SOC_AU1X00
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_APM_EMULATION
>  	select GENERIC_HARDIRQS_NO__DO_IRQ
> +
> +config AU_INT_CNTLR
> +	bool
> +
> +config AU_GPIO_INT_CNTLR
> +	bool

These two definitions should be in patch 2/10 with the code that uses it.

> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 5c76c64..fd096d1 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -65,6 +65,7 @@ static struct platform_device au1xx0_uart_device = {
>  	},
>  };
>  
> +#ifndef CONFIG_SOC_AU13XX
>  /* OHCI (USB full speed host controller) */
>  static struct resource au1xxx_usb_ohci_resources[] = {
>  	[0] = {
> @@ -92,6 +93,7 @@ static struct platform_device au1xxx_usb_ohci_device = {
>  	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
>  	.resource	= au1xxx_usb_ohci_resources,
>  };
> +#endif

Try to avoid this kind of #ifdef.  It'll only get more ugly in the future
when there are more members of the SOC family that don't have the USB.

> +#if 0
> +void __init prom_init(void)
> +{
> +       unsigned char *memsize_str;
> +       unsigned long memsize;
> +
> +       prom_argc = (int)fw_arg0;
> +       prom_argv = (char **)fw_arg1;
> +       prom_envp = (char **)fw_arg2;
> +
> +       prom_init_cmdline();
> +       memsize_str = prom_getenv("memsize");
> +       /* KH: TODO - Change back to 128 MB when the second DDR channel is working. */
> +       if (!memsize_str)
> +               memsize = 0x04000000;
> +       else
> +               strict_strtol(memsize_str, 0, &memsize);
> +       add_memory_region(0, memsize, BOOT_MEM_RAM);
> +}
> +#endif

#if 0, so delete?

> --- a/arch/mips/include/asm/mach-au1x00/au1000.h
> +++ b/arch/mips/include/asm/mach-au1x00/au1000.h

> +void static inline au_iowrite32(u32 val, volatile u32 *reg)
> +{
> +	*reg = val;
> +}
> +
> +static inline u32 au_ioread32(volatile u32 *reg)
> +{
> +	return *reg;
> +}
> +
> +#define AU_SET_BITS_16(mask, reg) \
> +do { \
> +	au_iowrite16((au_ioread16(reg) | mask ), reg); \
> +} while(0)

Macros should be bullet proof against side effects:

#define au_set_bits_16(mask, reg)					\
do {									\
	volatile u16 *__r = (reg);					\
									\
	au_iowrite16((au_ioread16(__r) | (mask)), __r);			\
} while(0)

Or simply use an inline function instead.

> +#define AU_CLEAR_BITS_16(mask, reg) \
> +do { \
> +	au_iowrite16((au_ioread16(reg) & ~mask ), reg); \
> +} while(0)
> +
> +#define AU_SET_BITS_32(mask, reg) \
> +do { \
> +	au_iowrite32((au_ioread32(reg) | mask), reg); \
> +} while(0)
> +
> +#define AU_CLEAR_BITS_32(mask, reg) \
> +do { \
> +	au_iowrite32((au_ioread32(reg) & ~mask), reg); \
> +} while(0)
> +
>  /* arch/mips/au1000/common/clocks.c */
>  extern void set_au1x00_speed(unsigned int new_freq);
>  extern unsigned int get_au1x00_speed(void);

> --- /dev/null
> +++ b/arch/mips/include/asm/mach-au1x00/au13xx.h
> @@ -0,0 +1,207 @@

> +#ifdef CONFIG_SOC_AU13XX
> +
> +#define NR_INTS			255

Unused macro - did you mean NR_IRQS?  Also keep the value of
NR_IRQS a multiple of BITS_PER_LONG or unpleasant things might happen.

> +#define UART0_ADDR		0xB0100000
> +#define UART1_ADDR		0xB0101000
> +#define UART2_ADDR		0xB0102000
> +#define UART3_ADDR		0xB0103000
> +
> +#define KSEG1_OFFSET		0xA0000000

This constant duplicates KSEG1 defined in <asm/addrspace.h>.

> +#define GPIO_INT_CTRLR_BASE	0x10200000
> +/*
> + * Linux uses IRQ 0-7 for the 8 causes.  That means that all of our channel
> + * bits need to be offset by 8 either when passed to do_IRQ or when received
> + * through the irq_chip calls
> + *
> + * KH: TODO - This is duplicated from gpio_int.h  Is that the right thing to do?
> + */
> +#define	GPINT_LINUX_IRQ_OFFSET		8
> +
> +#define AU1300_IRQ_UART1	17
> +#define AU1300_IRQ_UART2	25
> +#define AU1300_IRQ_UART3	27
> +#define AU1300_IRQ_SD1		32
> +#define AU1300_IRQ_SD2		38
> +#define AU1300_IRQ_PSC0		48
> +#define AU1300_IRQ_PSC1		52
> +#define AU1300_IRQ_PSC2		56
> +#define AU1300_IRQ_PSC3		60
> +#define AU1300_IRQ_NAND		62
> +#define AU1300_IRQ_DDMA		75
> +#define AU1300_IRQ_GPU		78
> +#define AU1300_IRQ_MPU		77
> +#define AU1300_IRQ_MMU		76
> +#define AU1300_IRQ_UDMA		79
> +#define AU1300_IRQ_TOY_TICK	80
> +#define AU1300_IRQ_TOYMATCH_0	81
> +#define AU1300_IRQ_TOYMATCH_1	82
> +#define AU1300_IRQ_TOYMATCH_2	83
> +#define AU1300_IRQ_RTC_TICK	84
> +#define AU1300_IRQ_RTCMATCH_0	85
> +#define AU1300_IRQ_RTCMATCH_1	86
> +#define AU1300_IRQ_RTCMATCH_2	87
> +#define AU1300_IRQ_UART0	88
> +#define AU1300_IRQ_SD0		89
> +#define AU1300_IRQ_USB		90
> +#define AU1300_IRQ_LCD		91
> +#define AU1300_IRQ_BSA		94
> +#define AU1300_IRQ_MPE		93
> +#define AU1300_IRQ_ITE		92
> +#define AU1300_IRQ_AES		95
> +#define AU1300_IRQ_CIM		96
> +
> +#define LCD_PHYS_ADDR		0x15000000
> +
> +#define AU1200_LCD_INT		(GPINT_LINUX_IRQ_OFFSET + AU1300_IRQ_LCD)
> +#define AU1000_RTC_MATCH2_INT	(GPINT_LINUX_IRQ_OFFSET + AU1300_IRQ_RTCMATCH_2)
> +
> +#define SD0_PHYS_ADDR		0x10600000
> +#define SD1_PHYS_ADDR		0x10601000
> +
> +
> +#define	USB_BASE_PHYS_ADDR	0x14021000
> +#define USB_EHCI_BASE		0x14020000
> +#define USB_EHCI_LEN		0x400
> +#define USB_OHCI_BASE		0x14020800
> +#define USB_OHCI_LEN		0x400
> +#define USB_UOC_BASE		0x14022000
> +#define USB_UOC_LEN		0x20
> +#define USB_UDC_BASE		0x14022000
> +#define USB_UDC_LEN		0x2000
> +
> +#if !defined(ASSEMBLER)

There is no ASSEMBLER macro defined by cpp.  Within the kernel please use
#ifndef __ASSEMBLY__ instead.  However this bug suggests you don't use this
header in assembly code at all so maybe the whole ifdef should go?

> +typedef volatile struct

See Documentation/volatile-considered-harmful.txt ...

> +{
> +    // setup registers

Please use /* ... */ only within the kernel.

You did run your patches through scripts/checkpatch.pl, no?

> +    u32 dwc_ctrl1;           //0x0000

See Documentation/volatile-considered-harmful.txt ...

  Ralf
