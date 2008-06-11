Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 12:44:00 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:46218 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20028959AbYFKLn5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 12:43:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BBhaSE029972;
	Wed, 11 Jun 2008 12:43:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BBhZiw029965;
	Wed, 11 Jun 2008 12:43:35 +0100
Date:	Wed, 11 Jun 2008 12:43:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] : Add support for =?utf-8?Q?NX?=
	=?utf-8?Q?P_PNX833x_=28STB222=2F5=29_into_linux_kernel=E2=80=8F?=
	(UPDATED)
Message-ID: <20080611114335.GB777@linux-mips.org>
References: <64660ef00806060459n5473afeer91b8441b4fc27ad3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00806060459n5473afeer91b8441b4fc27ad3@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 06, 2008 at 12:59:06PM +0100, Daniel Laird wrote:

>  arch/mips/Kconfig                          |   33
>  arch/mips/Makefile                         |    8
>  arch/mips/configs/pnx8335-stb225_defconfig | 1150 +++++++++++++++++++++++++++++
>  arch/mips/nxp/pnx833x/common/Makefile      |    1
>  arch/mips/nxp/pnx833x/common/gdb_hook.c    |  134 +++
>  arch/mips/nxp/pnx833x/common/interrupts.c  |  364 +++++++++
>  arch/mips/nxp/pnx833x/common/platform.c    |  309 +++++++
>  arch/mips/nxp/pnx833x/common/prom.c        |   70 +
>  arch/mips/nxp/pnx833x/common/reset.c       |   50 +
>  arch/mips/nxp/pnx833x/common/setup.c       |   64 +
>  arch/mips/nxp/pnx833x/stb22x/Makefile      |    1
>  arch/mips/nxp/pnx833x/stb22x/board.c       |  133 +++
>  include/asm-mips/mach-pnx833x/gpio.h       |  172 ++++
>  include/asm-mips/mach-pnx833x/irq.h        |  139 +++
>  include/asm-mips/mach-pnx833x/pnx833x.h    |  202 +++++
>  include/asm-mips/mach-pnx833x/war.h        |   25
>  16 files changed, 2855 insertions(+)
> 
> Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>
> 
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig
> linux-2.6.26-rc4/arch/mips/configs/pnx8335-stb225_defconfig
> --- linux-2.6.26-rc4.orig/arch/mips/configs/pnx8335-stb225_defconfig	1970-01-01
> 01:00:00.000000000 +0100

Your mailer line wraps patches, can you resend the patch either as
attachment or maybe using a proper mail client?  Also
http://www.linux-mips.org/wiki/Mailing-patches may have a few hints how
to get a few mail clients to do the right thing with inlined patches.

> +CONFIG_HZ_128=y

A somewhat unusual choice, I'm curious as for why?

> +static unsigned char *kgdb_uart    = UART1;
> +static unsigned char *console_uart = UART0;
> +static volatile int delay_count;
> +
> +static unsigned int serial_in(unsigned char *base_address, int offset)
> +{
> +	return *((unsigned int volatile *)(base_address + offset));
> +}
> +
> +static void serial_out(unsigned char *base_address, int offset, int value)
> +{
> +	*((unsigned int volatile *)(base_address + offset)) = value;
> +}
> +
> +static void do_delay(void)
> +{
> +	int i;
> +	for (i = 0; i < 10000; i++)
> +		delay_count++;
> +}

I assume you're using the volatile variable only to avoid gcc from
optimizing the loop away?

> +static int put_char(unsigned char *base_address, char c)
> +{
> +	/* Wait for TX to be ready */
> +	while (((serial_in(base_address, PNX8XXX_FIFO) &
> PNX8XXX_UART_FIFO_TXFIFO) >> 16) > 15)
> +		do_delay();
> +
> +	/* Send the next character */
> +	serial_out(base_address, PNX8XXX_FIFO, c);
> +	serial_out(base_address, PNX8XXX_ICLR, PNX8XXX_UART_INT_TX);
> +
> +	return 1;
> +}
> +
> +static char get_char(unsigned char *base_address)
> +{
> +	char output;
> +
> +	/* Wait for RX to be ready */
> +	while ((serial_in(base_address, PNX8XXX_FIFO) &
> PNX8XXX_UART_FIFO_RXFIFO) == 0)
> +		do_delay();
> +
> +	/* Get the character */
> +	output = serial_in(base_address, PNX8XXX_FIFO) & 0xFF;
> +
> +	/* Move onto the next character in the buffer */
> +	serial_out(base_address, PNX8XXX_LCR, serial_in(base_address,
> PNX8XXX_LCR) | PNX8XXX_UART_LCR_RX_NEXT);
> +	serial_out(base_address, PNX8XXX_ICLR, PNX8XXX_UART_INT_RX);
> +
> +	return output;
> +}
> +
> +static void serial_init(unsigned char *base_address)
> +{
> +	serial_out(base_address, PNX8XXX_LCR, PNX8XXX_UART_LCR_8BIT |
> PNX8XXX_UART_LCR_TX_RST | PNX8XXX_UART_LCR_RX_RST);
> +	serial_out(base_address, PNX8XXX_MCR, PNX8XXX_UART_MCR_DTR |
> PNX8XXX_UART_MCR_RTS);
> +	serial_out(base_address, PNX8XXX_BAUD, 1); /* 115200 Baud */
> +	serial_out(base_address, PNX8XXX_CFG, 0x00060030);
> +	serial_out(base_address, PNX8XXX_ICLR, -1);
> +	serial_out(base_address, PNX8XXX_IEN, 0);
> +}
> +
> +static void setup_serial_output(void)
> +{
> +	static bool initialised;
> +	if (!initialised) {
> +		serial_init(kgdb_uart);
> +		serial_init(console_uart);
> +		initialised = true;
> +	}
> +}
> +
> +int rs_kgdb_hook(int tty_no, int speed)
> +{
> +	kgdb_uart    = tty_no ? UART1 : UART0;
> +	console_uart = tty_no ? UART0 : UART1;
> +
> +	setup_serial_output();
> +
> +	return speed;
> +}
> +
> +int prom_putchar(char c)
> +{
> +	setup_serial_output();
> +	return put_char(console_uart, c);
> +}
> +
> +char prom_getchar(void)
> +{
> +	setup_serial_output();
> +	return get_char(console_uart);
> +}
> +
> +int put_debug_char(char c)
> +{
> +	setup_serial_output();
> +	return put_char(kgdb_uart, c);
> +}
> +
> +char get_debug_char(void)
> +{
> +	setup_serial_output();
> +	return get_char(kgdb_uart);
> +}
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/interrupts.c
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/interrupts.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/interrupts.c	2008-06-06
> 11:29:17.000000000 +0100
> @@ -0,0 +1,364 @@
> +/*
> + *  interrupts.c: Interrupt mappings for PNX833X.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/hardirq.h>
> +#include <linux/interrupt.h>
> +#include <asm/mipsregs.h>
> +#include <asm/irq_cpu.h>
> +#include <irq.h>
> +#include <gpio.h>
> +
> +static const unsigned int irq_prio[PNX833X_PIC_NUM_IRQ] =
> +{
> +    0, /* unused */
> +    4, /* PNX833X_PIC_I2C0_INT                 1 */
> +    4, /* PNX833X_PIC_I2C1_INT                 2 */
> +    1, /* PNX833X_PIC_UART0_INT                3 */
> +    1, /* PNX833X_PIC_UART1_INT                4 */
> +    6, /* PNX833X_PIC_TS_IN0_DV_INT            5 */
> +    6, /* PNX833X_PIC_TS_IN0_DMA_INT           6 */
> +    7, /* PNX833X_PIC_GPIO_INT                 7 */
> +    4, /* PNX833X_PIC_AUDIO_DEC_INT            8 */
> +    5, /* PNX833X_PIC_VIDEO_DEC_INT            9 */
> +    4, /* PNX833X_PIC_CONFIG_INT              10 */
> +    4, /* PNX833X_PIC_AOI_INT                 11 */
> +    9, /* PNX833X_PIC_SYNC_INT                12 */
> +    9, /* PNX8335_PIC_SATA_INT                13 */
> +    4, /* PNX833X_PIC_OSD_INT                 14 */
> +    9, /* PNX833X_PIC_DISP1_INT               15 */
> +    4, /* PNX833X_PIC_DEINTERLACER_INT        16 */
> +    9, /* PNX833X_PIC_DISPLAY2_INT            17 */
> +    4, /* PNX833X_PIC_VC_INT                  18 */
> +    4, /* PNX833X_PIC_SC_INT                  19 */
> +    9, /* PNX833X_PIC_IDE_INT                 20 */
> +    9, /* PNX833X_PIC_IDE_DMA_INT             21 */
> +    6, /* PNX833X_PIC_TS_IN1_DV_INT           22 */
> +    6, /* PNX833X_PIC_TS_IN1_DMA_INT          23 */
> +    4, /* PNX833X_PIC_SGDX_DMA_INT            24 */
> +    4, /* PNX833X_PIC_TS_OUT_INT              25 */
> +    4, /* PNX833X_PIC_IR_INT                  26 */
> +    3, /* PNX833X_PIC_VMSP1_INT               27 */
> +    3, /* PNX833X_PIC_VMSP2_INT               28 */
> +    4, /* PNX833X_PIC_PIBC_INT                29 */
> +    4, /* PNX833X_PIC_TS_IN0_TRD_INT          30 */
> +    4, /* PNX833X_PIC_SGDX_TPD_INT            31 */
> +    5, /* PNX833X_PIC_USB_INT                 32 */
> +    4, /* PNX833X_PIC_TS_IN1_TRD_INT          33 */
> +    4, /* PNX833X_PIC_CLOCK_INT               34 */
> +    4, /* PNX833X_PIC_SGDX_PARSER_INT         35 */
> +    4, /* PNX833X_PIC_VMSP_DMA_INT            36 */
> +#if defined(CONFIG_SOC_PNX8335)
> +    4, /* PNX8335_PIC_MIU_INT                 37 */
> +    4, /* PNX8335_PIC_AVCHIP_IRQ_INT          38 */
> +    9, /* PNX8335_PIC_SYNC_HD_INT             39 */
> +    9, /* PNX8335_PIC_DISP_HD_INT             40 */
> +    9, /* PNX8335_PIC_DISP_SCALER_INT         41 */
> +    4, /* PNX8335_PIC_OSD_HD1_INT             42 */
> +    4, /* PNX8335_PIC_DTL_WRITER_Y_INT        43 */
> +    4, /* PNX8335_PIC_DTL_WRITER_C_INT        44 */
> +    4, /* PNX8335_PIC_DTL_EMULATOR_Y_IR_INT   45 */
> +    4, /* PNX8335_PIC_DTL_EMULATOR_C_IR_INT   46 */
> +    4, /* PNX8335_PIC_DENC_TTX_INT            47 */
> +    4, /* PNX8335_PIC_MMI_SIF0_INT            48 */
> +    4, /* PNX8335_PIC_MMI_SIF1_INT            49 */
> +    4, /* PNX8335_PIC_MMI_CDMMU_INT           50 */
> +    4, /* PNX8335_PIC_PIBCS_INT               51 */
> +   12, /* PNX8335_PIC_ETHERNET_INT            52 */
> +    3, /* PNX8335_PIC_VMSP1_0_INT             53 */
> +    3, /* PNX8335_PIC_VMSP1_1_INT             54 */
> +    4, /* PNX8335_PIC_VMSP1_DMA_INT           55 */
> +    4, /* PNX8335_PIC_TDGR_DE_INT             56 */
> +    4, /* PNX8335_PIC_IR1_IRQ_INT             57 */
> +#endif
> +};
> +
> +static void pic_dispatch(void)
> +{
> +	unsigned int irq = PNX833X_REGFIELD(PIC_INT_SRC, INT_SRC);
> +
> +	if ((irq >= 1) && (irq < (PNX833X_PIC_NUM_IRQ))) {
> +		unsigned long priority = PNX833X_PIC_INT_PRIORITY;
> +		PNX833X_PIC_INT_PRIORITY = irq_prio[irq];
> +
> +		if (irq == PNX833X_PIC_GPIO_INT) {
> +			unsigned long mask = PNX833X_PIO_INT_STATUS & PNX833X_PIO_INT_ENABLE;
> +			int pin;
> +			while ((pin = ffs(mask & 0xffff))) {
> +				pin -= 1;
> +				do_IRQ(PNX833X_GPIO_IRQ_BASE + pin);
> +				mask &= ~(1 << pin);
> +			}
> +		} else {
> +			do_IRQ(irq + PNX833X_PIC_IRQ_BASE);
> +		}
> +
> +		PNX833X_PIC_INT_PRIORITY = priority;
> +	} else {
> +		printk(KERN_ERR "plat_irq_dispatch: unexpected irq %u\n", irq);
> +	}
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int pending = read_c0_status() & read_c0_cause();
> +
> +	if (pending & STATUSF_IP4)
> +		pic_dispatch();
> +	else if (pending & STATUSF_IP7)
> +		do_IRQ(PNX833X_TIMER_IRQ);
> +	else
> +		spurious_interrupt();
> +}
> +
> +static inline void pnx833x_hard_enable_pic_irq(unsigned int irq)
> +{
> +	/* Currently we do this by setting IRQ priority to 1.
> +	   If priority support is being implemented, 1 should be repalced
> +		by a better value. */
> +	PNX833X_PIC_INT_REG(irq) = irq_prio[irq];
> +}
> +
> +static inline void pnx833x_hard_disable_pic_irq(unsigned int irq)
> +{
> +	/* Disable IRQ by writing setting it's priority to 0 */
> +	PNX833X_PIC_INT_REG(irq) = 0;
> +}
> +
> +static int irqflags[PNX833X_PIC_NUM_IRQ];	/* initialized by zeroes */
> +#define IRQFLAG_STARTED		1
> +#define IRQFLAG_DISABLED	2
> +
> +static DEFINE_SPINLOCK(pnx833x_irq_lock);
> +
> +static unsigned int pnx833x_startup_pic_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
> +
> +	spin_lock_irqsave(&pnx833x_irq_lock, flags);
> +
> +	irqflags[pic_irq] = IRQFLAG_STARTED;	/* started, not disabled */
> +	pnx833x_hard_enable_pic_irq(pic_irq);
> +
> +	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
> +	return 0;
> +}
> +
> +static void pnx833x_shutdown_pic_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
> +
> +	spin_lock_irqsave(&pnx833x_irq_lock, flags);
> +
> +	irqflags[pic_irq] = 0;			/* not started */
> +	pnx833x_hard_disable_pic_irq(pic_irq);
> +
> +	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
> +}
> +
> +static void pnx833x_enable_pic_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
> +
> +	spin_lock_irqsave(&pnx833x_irq_lock, flags);
> +
> +	irqflags[pic_irq] &= ~IRQFLAG_DISABLED;
> +	if (irqflags[pic_irq] == IRQFLAG_STARTED)
> +		pnx833x_hard_enable_pic_irq(pic_irq);
> +
> +	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
> +}
> +
> +static void pnx833x_disable_pic_irq(unsigned int irq)
> +{
> +	unsigned long flags;
> +	unsigned int pic_irq = irq - PNX833X_PIC_IRQ_BASE;
> +
> +	spin_lock_irqsave(&pnx833x_irq_lock, flags);
> +
> +	irqflags[pic_irq] |= IRQFLAG_DISABLED;
> +	pnx833x_hard_disable_pic_irq(pic_irq);
> +
> +	spin_unlock_irqrestore(&pnx833x_irq_lock, flags);
> +}
> +
> +static void pnx833x_ack_pic_irq(unsigned int irq)
> +{
> +}
> +
> +static void pnx833x_end_pic_irq(unsigned int irq)
> +{
> +}
> +
> +static DEFINE_SPINLOCK(pnx833x_gpio_pnx833x_irq_lock);
> +
> +static unsigned int pnx833x_startup_gpio_irq(unsigned int irq)
> +{
> +	int pin = irq - PNX833X_GPIO_IRQ_BASE;
> +	unsigned long flags;
> +	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +	pnx833x_gpio_enable_irq(pin);
> +	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +	return 0;
> +}
> +
> +static void pnx833x_enable_gpio_irq(unsigned int irq)
> +{
> +	int pin = irq - PNX833X_GPIO_IRQ_BASE;
> +	unsigned long flags;
> +	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +	pnx833x_gpio_enable_irq(pin);
> +	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +}
> +
> +static void pnx833x_disable_gpio_irq(unsigned int irq)
> +{
> +	int pin = irq - PNX833X_GPIO_IRQ_BASE;
> +	unsigned long flags;
> +	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +	pnx833x_gpio_disable_irq(pin);
> +	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +}
> +
> +static void pnx833x_ack_gpio_irq(unsigned int irq)
> +{
> +}
> +
> +static void pnx833x_end_gpio_irq(unsigned int irq)
> +{
> +	int pin = irq - PNX833X_GPIO_IRQ_BASE;
> +	unsigned long flags;
> +	spin_lock_irqsave(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +	pnx833x_gpio_clear_irq(pin);
> +	spin_unlock_irqrestore(&pnx833x_gpio_pnx833x_irq_lock, flags);
> +}
> +
> +static int pnx833x_set_type_gpio_irq(unsigned int irq, unsigned int flow_type)
> +{
> +	int pin = irq - PNX833X_GPIO_IRQ_BASE;
> +	int gpio_mode;
> +
> +	switch (flow_type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		gpio_mode = GPIO_INT_EDGE_RISING;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		gpio_mode = GPIO_INT_EDGE_FALLING;
> +		break;
> +	case IRQ_TYPE_EDGE_BOTH:
> +		gpio_mode = GPIO_INT_EDGE_BOTH;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		gpio_mode = GPIO_INT_LEVEL_HIGH;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		gpio_mode = GPIO_INT_LEVEL_LOW;
> +		break;
> +	default:
> +		gpio_mode = GPIO_INT_NONE;
> +		break;
> +	}
> +
> +	pnx833x_gpio_setup_irq(gpio_mode, pin);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip pnx833x_pic_irq_type = {
> +	.typename = "PNX-PIC",
> +	.startup = pnx833x_startup_pic_irq,
> +	.shutdown = pnx833x_shutdown_pic_irq,
> +	.enable = pnx833x_enable_pic_irq,
> +	.disable = pnx833x_disable_pic_irq,
> +	.ack = pnx833x_ack_pic_irq,
> +	.end = pnx833x_end_pic_irq
> +};
> +
> +static struct irq_chip pnx833x_gpio_irq_type = {
> +	.typename = "PNX-GPIO",
> +	.startup = pnx833x_startup_gpio_irq,
> +	.shutdown = pnx833x_disable_gpio_irq,
> +	.enable = pnx833x_enable_gpio_irq,
> +	.disable = pnx833x_disable_gpio_irq,
> +	.ack = pnx833x_ack_gpio_irq,
> +	.end = pnx833x_end_gpio_irq,
> +	.set_type = pnx833x_set_type_gpio_irq
> +};
> +
> +void __init arch_init_irq(void)
> +{
> +	unsigned int irq;
> +
> +	/* setup standard internal cpu irqs */
> +	mips_cpu_irq_init();
> +
> +	/* Set IRQ information in irq_desc */
> +	for (irq = PNX833X_PIC_IRQ_BASE; irq < (PNX833X_PIC_IRQ_BASE +
> PNX833X_PIC_NUM_IRQ); irq++) {
> +		pnx833x_hard_disable_pic_irq(irq);
> +		set_irq_chip_and_handler(irq, &pnx833x_pic_irq_type, handle_simple_irq);
> +	}
> +
> +	for (irq = PNX833X_GPIO_IRQ_BASE; irq < (PNX833X_GPIO_IRQ_BASE +
> PNX833X_GPIO_NUM_IRQ); irq++)
> +		set_irq_chip_and_handler(irq, &pnx833x_gpio_irq_type, handle_simple_irq);
> +
> +	/* Set PIC priority limiter register to 0 */
> +	PNX833X_PIC_INT_PRIORITY = 0;
> +
> +	/* Setup GPIO IRQ dispatching */
> +	pnx833x_startup_pic_irq(PNX833X_PIC_GPIO_INT);
> +
> +	/* Enable PIC IRQs (HWIRQ2) */
> +	if (cpu_has_vint)
> +		set_vi_handler(4, pic_dispatch);
> +
> +	write_c0_status(read_c0_status() | IE_IRQ2);
> +}
> +
> +
> +void __init plat_time_init(void)
> +{
> +	/* calculate mips_hpt_frequency based on PNX833X_CLOCK_CPUCP_CTL reg */
> +
> +	extern unsigned long mips_hpt_frequency;
> +	unsigned long reg = PNX833X_CLOCK_CPUCP_CTL;
> +
> +	if (!(PNX833X_BIT(reg, CLOCK_CPUCP_CTL, EXIT_RESET))) {
> +		/* Functional clock is disabled so use crystal frequency */
> +		mips_hpt_frequency = 25;
> +	} else {
> +#if defined(CONFIG_SOC_PNX8335)
> +		/* Functional clock is enabled, so get clock multiplier */
> +		mips_hpt_frequency = 90 + (10 * PNX8335_REGFIELD(CLOCK_PLL_CPU_CTL, FREQ));
> +#else
> +		static const unsigned long int freq[4] = {240, 160, 120, 80};
> +		mips_hpt_frequency = freq[PNX833X_FIELD(reg, CLOCK_CPUCP_CTL, DIV_CLOCK)];
> +#endif
> +	}
> +
> +	printk(KERN_INFO "CPU clock is %ld MHz\n", mips_hpt_frequency);
> +
> +	mips_hpt_frequency *= 500000;
> +}
> +
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/Makefile
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/Makefile
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/Makefile	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/Makefile	2008-03-03
> 13:09:30.000000000 +0000
> @@ -0,0 +1 @@
> +obj-y := interrupts.o platform.o prom.o setup.o reset.o gdb_hook.o
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/platform.c
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/platform.c
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/platform.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/platform.c	2008-06-06
> 11:29:35.000000000 +0100
> @@ -0,0 +1,309 @@
> +/*
> + *  platform.c: platform support for PNX833X.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  Based on software written by:
> + *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/resource.h>
> +#include <linux/serial.h>
> +#include <linux/serial_pnx8xxx.h>
> +#include <linux/i2c-pnx0105.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <irq.h>
> +#include <pnx833x.h>
> +
> +static u64 uart_dmamask     = ~(u32)0;
> +
> +static struct resource pnx833x_uart_resources[] = {
> +	[0] = {
> +		.start		= PNX833X_UART0_PORTS_START,
> +		.end		= PNX833X_UART0_PORTS_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start		= PNX833X_PIC_UART0_INT,
> +		.end		= PNX833X_PIC_UART0_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.start		= PNX833X_UART1_PORTS_START,
> +		.end		= PNX833X_UART1_PORTS_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	[3] = {
> +		.start		= PNX833X_PIC_UART1_INT,
> +		.end		= PNX833X_PIC_UART1_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct pnx8xxx_port pnx8xxx_ports[] = {
> +	[0] = {
> +		.port   = {
> +			.type		= PORT_PNX8XXX,
> +			.iotype		= UPIO_MEM,
> +			.membase	= (void __iomem *)PNX833X_UART0_PORTS_START,
> +			.mapbase	= PNX833X_UART0_PORTS_START,
> +			.irq		= PNX833X_PIC_UART0_INT,
> +			.uartclk	= 3692300,
> +			.fifosize	= 16,
> +			.flags		= UPF_BOOT_AUTOCONF,
> +			.line		= 0,
> +		},
> +	},
> +	[1] = {
> +		.port   = {
> +			.type		= PORT_PNX8XXX,
> +			.iotype		= UPIO_MEM,
> +			.membase	= (void __iomem *)PNX833X_UART1_PORTS_START,
> +			.mapbase	= PNX833X_UART1_PORTS_START,
> +			.irq		= PNX833X_PIC_UART1_INT,
> +			.uartclk	= 3692300,
> +			.fifosize	= 16,
> +			.flags		= UPF_BOOT_AUTOCONF,
> +			.line		= 1,
> +		},
> +	},
> +};
> +
> +static struct platform_device pnx833x_uart_device = {
> +	.name		= "pnx8xxx-uart",
> +	.id		= -1,
> +	.dev = {
> +		.dma_mask		= &uart_dmamask,
> +		.coherent_dma_mask	= 0xffffffff,
> +		.platform_data		= pnx8xxx_ports,
> +	},
> +	.num_resources	= ARRAY_SIZE(pnx833x_uart_resources),
> +	.resource	= pnx833x_uart_resources,
> +};
> +
> +static u64 ehci_dmamask     = ~(u32)0;
> +
> +static struct resource pnx833x_usb_ehci_resources[] = {
> +	[0] = {
> +		.start		= PNX833X_USB_PORTS_START,
> +		.end		= PNX833X_USB_PORTS_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start		= PNX833X_PIC_USB_INT,
> +		.end		= PNX833X_PIC_USB_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pnx833x_usb_ehci_device = {
> +	.name		= "pnx833x-ehci",
> +	.id		= -1,
> +	.dev = {
> +		.dma_mask		= &ehci_dmamask,
> +		.coherent_dma_mask	= 0xffffffff,
> +	},
> +	.num_resources	= ARRAY_SIZE(pnx833x_usb_ehci_resources),
> +	.resource	= pnx833x_usb_ehci_resources,
> +};
> +
> +static struct resource pnx833x_i2c0_resources[] = {
> +	{
> +		.start		= PNX833X_I2C0_PORTS_START,
> +		.end		= PNX833X_I2C0_PORTS_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= PNX833X_PIC_I2C0_INT,
> +		.end		= PNX833X_PIC_I2C0_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct resource pnx833x_i2c1_resources[] = {
> +	{
> +		.start		= PNX833X_I2C1_PORTS_START,
> +		.end		= PNX833X_I2C1_PORTS_END,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= PNX833X_PIC_I2C1_INT,
> +		.end		= PNX833X_PIC_I2C1_INT,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct i2c_pnx0105_dev pnx833x_i2c_dev[] = {
> +	{
> +		.base = PNX833X_I2C0_PORTS_START,
> +		.irq = -1, /* should be PNX833X_PIC_I2C0_INT but polling is faster */
> +		.clock = 6,	/* 0 == 400 kHz, 4 == 100 kHz(Maximum HDMI), 6 =
> 50kHz(Prefered HDCP) */
> +		.bus_addr = 0,	/* no slave support */
> +	},
> +	{
> +		.base = PNX833X_I2C1_PORTS_START,
> +		.irq = -1,	/* on high freq, polling is faster */
> +		/*.irq = PNX833X_PIC_I2C1_INT,*/
> +		.clock = 4,	/* 0 == 400 kHz, 4 == 100 kHz. 100 kHz seems a safe
> default for now */
> +		.bus_addr = 0,	/* no slave support */
> +	},
> +};
> +
> +static struct platform_device pnx833x_i2c0_device = {
> +	.name		= "i2c-pnx0105",
> +	.id		= 0,
> +	.dev = {
> +		.platform_data = &pnx833x_i2c_dev[0],
> +	},
> +	.num_resources  = ARRAY_SIZE(pnx833x_i2c0_resources),
> +	.resource	= pnx833x_i2c0_resources,
> +};
> +
> +static struct platform_device pnx833x_i2c1_device = {
> +	.name		= "i2c-pnx0105",
> +	.id		= 1,
> +	.dev = {
> +		.platform_data = &pnx833x_i2c_dev[1],
> +	},
> +	.num_resources  = ARRAY_SIZE(pnx833x_i2c1_resources),
> +	.resource	= pnx833x_i2c1_resources,
> +};
> +
> +static u64 ethernet_dmamask = ~(u32)0;
> +
> +static struct resource pnx833x_ethernet_resources[] = {
> +	[0] = {
> +		.start = PNX8335_IP3902_PORTS_START,
> +		.end   = PNX8335_IP3902_PORTS_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = PNX8335_PIC_ETHERNET_INT,
> +		.end   = PNX8335_PIC_ETHERNET_INT,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pnx833x_ethernet_device = {
> +	.name = "ip3902-eth",
> +	.id   = -1,
> +	.dev  = {
> +		.dma_mask          = &ethernet_dmamask,
> +		.coherent_dma_mask = 0xffffffff,
> +	},
> +	.num_resources = ARRAY_SIZE(pnx833x_ethernet_resources),
> +	.resource      = pnx833x_ethernet_resources,
> +};
> +
> +static struct resource pnx833x_sata_resources[] = {
> +	[0] = {
> +		.start = PNX8335_SATA_PORTS_START,
> +		.end   = PNX8335_SATA_PORTS_END,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = PNX8335_PIC_SATA_INT,
> +		.end   = PNX8335_PIC_SATA_INT,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pnx833x_sata_device = {
> +	.name          = "pnx833x-sata",
> +	.id            = -1,
> +	.num_resources = ARRAY_SIZE(pnx833x_sata_resources),
> +	.resource      = pnx833x_sata_resources,
> +};
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +static const char *part_probes[] = { "cmdlinepart", 0 };
> +#endif
> +
> +static void
> +pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +{
> +	struct nand_chip *this = mtd->priv;
> +	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
> +
> +	if (cmd == NAND_CMD_NONE)
> +		return;
> +
> +	if (ctrl & NAND_CLE)
> +		writeb(cmd, (void __iomem *)(nandaddr + PNX8335_NAND_CLE_MASK));
> +	else
> +		writeb(cmd, (void __iomem *) (nandaddr + PNX8335_NAND_ALE_MASK));
> +}
> +
> +static struct platform_nand_data pnx833x_flash_nand_data = {
> +	.chip = {
> +		.chip_delay		= 25,
> +#ifdef CONFIG_MTD_PARTITIONS
> +		.part_probe_types 	= part_probes,
> +#endif

Is this #ifdef really needed?  Same a few lines above.

> +	},
> +	.ctrl = {
> +		.cmd_ctrl 		= pnx833x_flash_nand_cmd_ctrl
> +	}
> +};
> +
> +/* Set start to be the correct address (PNX8335_NAND_BASE with no 0xb!!),
> +   12 bytes more seems to be the standard that allows for NAND access.*/

Linux comment style:

/*
 * Set start to be the correct address (PNX8335_NAND_BASE with no 0xb!!),
 * 12 bytes more seems to be the standard that allows for NAND access.
 */

See Documentation/CodingStyle.

> +static struct resource pnx833x_flash_nand_resource = {
> +	.start 	= PNX8335_NAND_BASE,
> +	.end 	= PNX8335_NAND_BASE + 12,
> +	.flags 	= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device pnx833x_flash_nand = {
> +	.name	        = "gen_nand",
> +	.id		        = -1,
> +	.num_resources	= 1,
> +	.resource	    = &pnx833x_flash_nand_resource,
> +	.dev            = {
> +		.platform_data = &pnx833x_flash_nand_data,
> +	},
> +};
> +
> +static struct platform_device *pnx833x_platform_devices[] __initdata = {
> +	&pnx833x_uart_device,
> +	&pnx833x_usb_ehci_device,
> +	&pnx833x_i2c0_device,
> +	&pnx833x_i2c1_device,
> +	&pnx833x_ethernet_device,
> +	&pnx833x_sata_device,
> +	&pnx833x_flash_nand,
> +};
> +
> +int __init pnx833x_platform_init(void)
> +{
> +	int res;
> +
> +	if (ARRAY_SIZE(pnx833x_platform_devices)) {
> +		res = platform_add_devices(pnx833x_platform_devices,
> +		ARRAY_SIZE(pnx833x_platform_devices));
> +	}
> +	return res;
> +}

ARRAY_SIZE(pnx833x_platform_devices) is always non-zero, so the if
condition is unnecessary.  If the if was ever non-true the uninitialized
variable res would be returned.  Also pnx833x_platform_init is only
referenced by arch_initicall(), so it should be static, so:

static int __init pnx833x_platform_init(void)
{
	int res;

	res = platform_add_devices(pnx833x_platform_devices,
				   ARRAY_SIZE(pnx833x_platform_devices));
	return res;
}

> +
> +arch_initcall(pnx833x_platform_init);
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/prom.c
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/prom.c
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/prom.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/prom.c	2008-06-06
> 11:29:55.000000000 +0100
> @@ -0,0 +1,70 @@
> +/*
> + *  prom.c:
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  Based on software written by:
> + *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/init.h>
> +#include <asm/bootinfo.h>
> +#include <linux/string.h>
> +
> +void __init prom_init_cmdline(void)
> +{
> +	int argc = fw_arg0;
> +	char **argv = (char **)fw_arg1;
> +	char *c = &(arcs_cmdline[0]);
> +	int i;
> +
> +	for (i = 1; i < argc; i++) {
> +		strcpy(c, argv[i]);
> +		c += strlen(argv[i]);
> +		if (i < argc-1)
> +			*c++ = ' ';
> +	}
> +	*c = 0;
> +}
> +
> +char __init *prom_getenv(char *envname)
> +{
> +	extern char **prom_envp;
> +	char **env = prom_envp;
> +	int i;
> +
> +	i = strlen(envname);
> +
> +	while (*env) {
> +		if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
> +			return *env + i + 1;
> +		env++;
> +	}
> +
> +	return 0;
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> +
> +char * __init prom_getcmdline(void)
> +{
> +	return arcs_cmdline;
> +}
> +
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/reset.c
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/reset.c
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/reset.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/reset.c	2008-06-06
> 11:30:01.000000000 +0100
> @@ -0,0 +1,50 @@
> +/*
> + *  reset.c: reset support for PNX833X.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  Based on software written by:
> + *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/slab.h>
> +#include <linux/reboot.h>
> +#include <pnx833x.h>
> +
> +void pnx833x_machine_restart(char *command)
> +{
> +	printk(KERN_ALERT "\n\n*** Restarting ***\n\n");
> +
> +	PNX833X_RESET_CONTROL_2 = 0;
> +	PNX833X_RESET_CONTROL = 0;
> +}

Please remove the message; that should be done in userspace.

> +void pnx833x_machine_halt(void)
> +{
> +	printk(KERN_ALERT "\n\n*** System halted. ***\n\n");
> +
> +	while (1)
> +		__asm__ __volatile__ ("wait");
> +
> +}

Ditto.

> +void pnx833x_machine_power_off(void)
> +{
> +	printk(KERN_ALERT "\n\n*** You can safely turn off the board. ***");
> +	pnx833x_machine_halt();
> +}

Ditto.

> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/setup.c
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/setup.c
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/common/setup.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/common/setup.c	2008-06-06
> 11:30:16.000000000 +0100
> @@ -0,0 +1,64 @@
> +/*
> + *  setup.c: Setup PNX833X Soc.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  Based on software written by:
> + *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <asm/reboot.h>
> +#include <pnx833x.h>
> +#include <gpio.h>
> +
> +extern void pnx833x_board_setup(void);
> +extern void pnx833x_machine_restart(char *);
> +extern void pnx833x_machine_halt(void);
> +extern void pnx833x_machine_power_off(void);
> +
> +int __init plat_mem_setup(void)
> +{
> +	/* fake pci bus to avoid bounce buffers */
> +	PCI_DMA_BUS_IS_PHYS = 1;
> +
> +	/* set mips clock to 320MHz */
> +#if defined(CONFIG_SOC_PNX8335)
> +	PNX8335_WRITEFIELD(0x17, CLOCK_PLL_CPU_CTL, FREQ);
> +#endif
> +	pnx833x_gpio_init();	/* so it will be ready in board_setup() */
> +
> +	pnx833x_board_setup();
> +
> +	_machine_restart = pnx833x_machine_restart;
> +	_machine_halt = pnx833x_machine_halt;
> +	pm_power_off = pnx833x_machine_power_off;
> +
> +	/* IO/MEM resources. */
> +	set_io_port_base(KSEG1);
> +	ioport_resource.start = 0;
> +	ioport_resource.end = ~0;
> +	iomem_resource.start = 0;
> +	iomem_resource.end = ~0;
> +
> +	return 0;
> +}
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/board.c
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/board.c
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/board.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/board.c	2008-06-06
> 11:28:50.000000000 +0100
> @@ -0,0 +1,133 @@
> +/*
> + *  board.c: STB225 board support.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  Based on software written by:
> + *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/init.h>
> +#include <asm/bootinfo.h>
> +#include <linux/mm.h>
> +#include <pnx833x.h>
> +#include <gpio.h>
> +
> +/* endianess twiddlers */
> +#define PNX8335_DEBUG0 0x4400
> +#define PNX8335_DEBUG1 0x4404
> +#define PNX8335_DEBUG2 0x4408
> +#define PNX8335_DEBUG3 0x440c
> +#define PNX8335_DEBUG4 0x4410
> +#define PNX8335_DEBUG5 0x4414
> +#define PNX8335_DEBUG6 0x4418
> +#define PNX8335_DEBUG7 0x441c
> +
> +int prom_argc;
> +char **prom_argv = 0, **prom_envp = 0;
> +
> +extern void prom_init_cmdline(void);
> +extern char *prom_getenv(char *envname);
> +
> +const char *get_system_type(void)
> +{
> +	return "NXP STB22x";
> +}
> +
> +static inline unsigned long env_or_default(char *env, unsigned long dfl)
> +{
> +	char *str = prom_getenv(env);
> +	return str ? simple_strtol(str, 0, 0) : dfl;
> +}
> +
> +void __init prom_init(void)
> +{
> +	unsigned long memsize;
> +
> +	prom_argc = fw_arg0;
> +	prom_argv = (char **)fw_arg1;
> +	prom_envp = (char **)fw_arg2;
> +
> +	prom_init_cmdline();
> +
> +	memsize = env_or_default("memsize", 0x02000000);
> +	add_memory_region(0, memsize, BOOT_MEM_RAM);
> +}
> +
> +void __init pnx833x_board_setup(void)
> +{
> +	pnx833x_gpio_select_function_alt(4);
> +	pnx833x_gpio_select_output(4);
> +	pnx833x_gpio_select_function_alt(5);
> +	pnx833x_gpio_select_input(5);
> +	pnx833x_gpio_select_function_alt(6);
> +	pnx833x_gpio_select_input(6);
> +	pnx833x_gpio_select_function_alt(7);
> +	pnx833x_gpio_select_output(7);
> +
> +	pnx833x_gpio_select_function_alt(25);
> +	pnx833x_gpio_select_function_alt(26);
> +
> +	pnx833x_gpio_select_function_alt(27);
> +	pnx833x_gpio_select_function_alt(28);
> +	pnx833x_gpio_select_function_alt(29);
> +	pnx833x_gpio_select_function_alt(30);
> +	pnx833x_gpio_select_function_alt(31);
> +	pnx833x_gpio_select_function_alt(32);
> +	pnx833x_gpio_select_function_alt(33);
> +
> +#if defined(CONFIG_MTD_NAND_PLATFORM) ||
> defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
> +	/* Setup MIU for NAND access on CS0...
> +	 *
> +	 * (it seems that we must also configure CS1 for reliable operation,
> +	 * otherwise the first read ID command will fail if it's read as 4 bytes
> +	 * but pass if it's read as 1 word.)
> +	 */
> +
> +	/* Setup MIU CS0 & CS1 timing */
> +	PNX833X_MIU_SEL0 = 0;
> +	PNX833X_MIU_SEL1 = 0;
> +	PNX833X_MIU_SEL0_TIMING = 0x50003081;
> +	PNX833X_MIU_SEL1_TIMING = 0x50003081;
> +
> +	/* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does
> not need this) */
> +	pnx833x_gpio_select_function_alt(0);
> +
> +	/* Setup GPIO 04 to input NAND read/busy signal */
> +	pnx833x_gpio_select_function_io(4);
> +	pnx833x_gpio_select_input(4);
> +
> +	/* Setup GPIO 05 to disable NAND write protect */
> +	pnx833x_gpio_select_function_io(5);
> +	pnx833x_gpio_select_output(5);
> +	pnx833x_gpio_write(1, 5);
> +
> +#elif defined(CONFIG_MTD_CFI) || defined(CONFIG_MTD_CFI_MODULE)
> +
> +	/* Set up MIU for 16-bit NOR access on CS0 and CS1... */
> +
> +	/* Setup MIU CS0 & CS1 timing */
> +	PNX833X_MIU_SEL0 = 1;
> +	PNX833X_MIU_SEL1 = 1;
> +	PNX833X_MIU_SEL0_TIMING = 0x6A08D082;
> +	PNX833X_MIU_SEL1_TIMING = 0x6A08D082;
> +
> +	/* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does
> not need this) */
> +	pnx833x_gpio_select_function_alt(0);
> +#endif
> +}
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/Makefile
> linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/Makefile
> --- linux-2.6.26-rc4.orig/arch/mips/nxp/pnx833x/stb22x/Makefile	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/arch/mips/nxp/pnx833x/stb22x/Makefile	2008-03-03
> 13:09:30.000000000 +0000
> @@ -0,0 +1 @@
> +lib-y := board.o
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h
> linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h
> --- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/gpio.h	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/gpio.h	2008-06-06
> 11:29:09.000000000 +0100
> @@ -0,0 +1,172 @@
> +/*
> + *  gpio.h: GPIO Support for PNX833X.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#ifndef __ASM_MIPS_MACH_PNX833X_GPIO_H
> +#define __ASM_MIPS_MACH_PNX833X_GPIO_H
> +
> +/* BIG FAT WARNING: races danger!
> +   No protections exist here. Current users are only early init code,
> +   when locking is not needed because no cuncurency yet exists there,
> +   and GPIO IRQ dispatcher, which does locking.
> +   However, if many uses will ever happen, proper locking will be needed
> +   - including locking between different uses
> +*/
> +
> +#include "pnx833x.h"
> +
> +#define SET_REG_BIT(reg, bit)		reg |= (1 << (bit))
> +#define CLEAR_REG_BIT(reg, bit)		reg &= ~(1 << (bit))
> +
> +/* Initialize GPIO to a known state */
> +static inline void pnx833x_gpio_init(void)
> +{
> +	PNX833X_PIO_DIR = 0;
> +	PNX833X_PIO_DIR2 = 0;
> +	PNX833X_PIO_SEL = 0;
> +	PNX833X_PIO_SEL2 = 0;
> +	PNX833X_PIO_INT_EDGE = 0;
> +	PNX833X_PIO_INT_HI = 0;
> +	PNX833X_PIO_INT_LO = 0;
> +
> +	/* clear any GPIO interrupt requests */
> +	PNX833X_PIO_INT_CLEAR = 0xffff;
> +	PNX833X_PIO_INT_CLEAR = 0;
> +	PNX833X_PIO_INT_ENABLE = 0;
> +}
> +
> +/* Select GPIO direction for a pin */
> +static inline void pnx833x_gpio_select_input(unsigned int pin)
> +{
> +	if (pin < 32)
> +		CLEAR_REG_BIT(PNX833X_PIO_DIR, pin);
> +	else
> +		CLEAR_REG_BIT(PNX833X_PIO_DIR2, pin & 31);
> +}
> +static inline void pnx833x_gpio_select_output(unsigned int pin)
> +{
> +	if (pin < 32)
> +		SET_REG_BIT(PNX833X_PIO_DIR, pin);
> +	else
> +		SET_REG_BIT(PNX833X_PIO_DIR2, pin & 31);
> +}
> +
> +/* Select GPIO or alternate function for a pin */
> +static inline void pnx833x_gpio_select_function_io(unsigned int pin)
> +{
> +	if (pin < 32)
> +		CLEAR_REG_BIT(PNX833X_PIO_SEL, pin);
> +	else
> +		CLEAR_REG_BIT(PNX833X_PIO_SEL2, pin & 31);
> +}
> +static inline void pnx833x_gpio_select_function_alt(unsigned int pin)
> +{
> +	if (pin < 32)
> +		SET_REG_BIT(PNX833X_PIO_SEL, pin);
> +	else
> +		SET_REG_BIT(PNX833X_PIO_SEL2, pin & 31);
> +}
> +
> +/* Read GPIO pin */
> +static inline int pnx833x_gpio_read(unsigned int pin)
> +{
> +	if (pin < 32)
> +		return(PNX833X_PIO_IN >> pin) & 1;
> +	else
> +		return(PNX833X_PIO_IN2 >> (pin & 31)) & 1;
> +}
> +
> +/* Write GPIO pin */
> +static inline void pnx833x_gpio_write(unsigned int val, unsigned int pin)
> +{
> +	if (pin < 32) {
> +		if (val)
> +			SET_REG_BIT(PNX833X_PIO_OUT, pin);
> +		else
> +			CLEAR_REG_BIT(PNX833X_PIO_OUT, pin);
> +	} else {
> +		if (val)
> +			SET_REG_BIT(PNX833X_PIO_OUT2, pin & 31);
> +		else
> +			CLEAR_REG_BIT(PNX833X_PIO_OUT2, pin & 31);
> +	}
> +}
> +
> +/* Configure GPIO interrupt */
> +#define GPIO_INT_NONE		0
> +#define GPIO_INT_LEVEL_LOW	1
> +#define GPIO_INT_LEVEL_HIGH	2
> +#define GPIO_INT_EDGE_RISING	3
> +#define GPIO_INT_EDGE_FALLING	4
> +#define GPIO_INT_EDGE_BOTH	5
> +static inline void pnx833x_gpio_setup_irq(int when, unsigned int pin)
> +{
> +	switch (when) {
> +	case GPIO_INT_LEVEL_LOW:
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
> +		SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
> +		break;
> +	case GPIO_INT_LEVEL_HIGH:
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
> +		SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
> +		break;
> +	case GPIO_INT_EDGE_RISING:
> +		SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
> +		SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
> +		break;
> +	case GPIO_INT_EDGE_FALLING:
> +		SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
> +		SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
> +		break;
> +	case GPIO_INT_EDGE_BOTH:
> +		SET_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
> +		SET_REG_BIT(PNX833X_PIO_INT_HI, pin);
> +		SET_REG_BIT(PNX833X_PIO_INT_LO, pin);
> +		break;
> +	default:
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_EDGE, pin);
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_HI, pin);
> +		CLEAR_REG_BIT(PNX833X_PIO_INT_LO, pin);
> +		break;
> +	}
> +}
> +
> +/* Enable/disable GPIO interrupt */
> +static inline void pnx833x_gpio_enable_irq(unsigned int pin)
> +{
> +	SET_REG_BIT(PNX833X_PIO_INT_ENABLE, pin);
> +}
> +static inline void pnx833x_gpio_disable_irq(unsigned int pin)
> +{
> +	CLEAR_REG_BIT(PNX833X_PIO_INT_ENABLE, pin);
> +}
> +
> +/* Clear GPIO interrupt request */
> +static inline void pnx833x_gpio_clear_irq(unsigned int pin)
> +{
> +	SET_REG_BIT(PNX833X_PIO_INT_CLEAR, pin);
> +	CLEAR_REG_BIT(PNX833X_PIO_INT_CLEAR, pin);
> +}
> +
> +#endif
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq.h
> linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq.h
> --- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/irq.h	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/irq.h	2008-06-06
> 11:29:30.000000000 +0100
> @@ -0,0 +1,139 @@
> +/*
> + *  irq.h: IRQ mappings for PNX833X.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __ASM_MIPS_MACH_PNX833X_IRQ_H
> +#define __ASM_MIPS_MACH_PNX833X_IRQ_H
> +/*
> + * The "IRQ numbers" are completely virtual.
> + *
> + * In PNX8330/1, we have 48 interrupt lines, numbered from 1 to 48.
> + * Let's use numbers 1..48 for PIC interrupts, number 0 for timer interrupt,
> + * numbers 49..64 for (virtual) GPIO interrupts.
> + *
> + * In PNX8335, we have 57 interrupt lines, numbered from 1 to 57,
> + * connected to PIC, which uses core hardware interrupt 2, and also
> + * a timer interrupt through hardware interrupt 5.
> + * Let's use numbers 1..64 for PIC interrupts, number 0 for timer interrupt,
> + * numbers 65..80 for (virtual) GPIO interrupts.
> + *
> + */
> +
> +#if defined(CONFIG_SOC_PNX8335)
> +	#define PNX833X_PIC_NUM_IRQ			58
> +#else
> +	#define PNX833X_PIC_NUM_IRQ			37
> +#endif
> +
> +#define MIPS_CPU_NUM_IRQ				8
> +#define PNX833X_GPIO_NUM_IRQ			16
> +
> +#define MIPS_CPU_IRQ_BASE				0
> +#define PNX833X_PIC_IRQ_BASE			(MIPS_CPU_IRQ_BASE + MIPS_CPU_NUM_IRQ)
> +#define PNX833X_GPIO_IRQ_BASE			(PNX833X_PIC_IRQ_BASE + PNX833X_PIC_NUM_IRQ)
> +#define NR_IRQS							(MIPS_CPU_NUM_IRQ + PNX833X_PIC_NUM_IRQ +
> PNX833X_GPIO_NUM_IRQ)
> +
> +
> +#define PNX833X_TIMER_IRQ				(MIPS_CPU_IRQ_BASE + 7)
> +
> +/* Interrupts supported by PIC */
> +#define PNX833X_PIC_I2C0_INT			(PNX833X_PIC_IRQ_BASE +  1)
> +#define PNX833X_PIC_I2C1_INT			(PNX833X_PIC_IRQ_BASE +  2)
> +#define PNX833X_PIC_UART0_INT			(PNX833X_PIC_IRQ_BASE +  3)
> +#define PNX833X_PIC_UART1_INT			(PNX833X_PIC_IRQ_BASE +  4)
> +#define PNX833X_PIC_TS_IN0_DV_INT		(PNX833X_PIC_IRQ_BASE +  5)
> +#define PNX833X_PIC_TS_IN0_DMA_INT		(PNX833X_PIC_IRQ_BASE +  6)
> +#define PNX833X_PIC_GPIO_INT			(PNX833X_PIC_IRQ_BASE +  7)
> +#define PNX833X_PIC_AUDIO_DEC_INT		(PNX833X_PIC_IRQ_BASE +  8)
> +#define PNX833X_PIC_VIDEO_DEC_INT		(PNX833X_PIC_IRQ_BASE +  9)
> +#define PNX833X_PIC_CONFIG_INT			(PNX833X_PIC_IRQ_BASE + 10)
> +#define PNX833X_PIC_AOI_INT				(PNX833X_PIC_IRQ_BASE + 11)
> +#define PNX833X_PIC_SYNC_INT			(PNX833X_PIC_IRQ_BASE + 12)
> +#define PNX8330_PIC_SPU_INT				(PNX833X_PIC_IRQ_BASE + 13)
> +#define PNX8335_PIC_SATA_INT			(PNX833X_PIC_IRQ_BASE + 13)
> +#define PNX833X_PIC_OSD_INT				(PNX833X_PIC_IRQ_BASE + 14)
> +#define PNX833X_PIC_DISP1_INT			(PNX833X_PIC_IRQ_BASE + 15)
> +#define PNX833X_PIC_DEINTERLACER_INT	(PNX833X_PIC_IRQ_BASE + 16)
> +#define PNX833X_PIC_DISPLAY2_INT		(PNX833X_PIC_IRQ_BASE + 17)
> +#define PNX833X_PIC_VC_INT				(PNX833X_PIC_IRQ_BASE + 18)
> +#define PNX833X_PIC_SC_INT				(PNX833X_PIC_IRQ_BASE + 19)
> +#define PNX833X_PIC_IDE_INT				(PNX833X_PIC_IRQ_BASE + 20)
> +#define PNX833X_PIC_IDE_DMA_INT			(PNX833X_PIC_IRQ_BASE + 21)
> +#define PNX833X_PIC_TS_IN1_DV_INT		(PNX833X_PIC_IRQ_BASE + 22)
> +#define PNX833X_PIC_TS_IN1_DMA_INT		(PNX833X_PIC_IRQ_BASE + 23)
> +#define PNX833X_PIC_SGDX_DMA_INT		(PNX833X_PIC_IRQ_BASE + 24)
> +#define PNX833X_PIC_TS_OUT_INT			(PNX833X_PIC_IRQ_BASE + 25)
> +#define PNX833X_PIC_IR_INT				(PNX833X_PIC_IRQ_BASE + 26)
> +#define PNX833X_PIC_VMSP1_INT			(PNX833X_PIC_IRQ_BASE + 27)
> +#define PNX833X_PIC_VMSP2_INT			(PNX833X_PIC_IRQ_BASE + 28)
> +#define PNX833X_PIC_PIBC_INT			(PNX833X_PIC_IRQ_BASE + 29)
> +#define PNX833X_PIC_TS_IN0_TRD_INT		(PNX833X_PIC_IRQ_BASE + 30)
> +#define PNX833X_PIC_SGDX_TPD_INT		(PNX833X_PIC_IRQ_BASE + 31)
> +#define PNX833X_PIC_USB_INT				(PNX833X_PIC_IRQ_BASE + 32)
> +#define PNX833X_PIC_TS_IN1_TRD_INT		(PNX833X_PIC_IRQ_BASE + 33)
> +#define PNX833X_PIC_CLOCK_INT			(PNX833X_PIC_IRQ_BASE + 34)
> +#define PNX833X_PIC_SGDX_PARSER_INT		(PNX833X_PIC_IRQ_BASE + 35)
> +#define PNX833X_PIC_VMSP_DMA_INT		(PNX833X_PIC_IRQ_BASE + 36)
> +
> +#if defined(CONFIG_SOC_PNX8335)
> +#define PNX8335_PIC_MIU_INT					(PNX833X_PIC_IRQ_BASE + 37)
> +#define PNX8335_PIC_AVCHIP_IRQ_INT			(PNX833X_PIC_IRQ_BASE + 38)
> +#define PNX8335_PIC_SYNC_HD_INT				(PNX833X_PIC_IRQ_BASE + 39)
> +#define PNX8335_PIC_DISP_HD_INT				(PNX833X_PIC_IRQ_BASE + 40)
> +#define PNX8335_PIC_DISP_SCALER_INT			(PNX833X_PIC_IRQ_BASE + 41)
> +#define PNX8335_PIC_OSD_HD1_INT				(PNX833X_PIC_IRQ_BASE + 42)
> +#define PNX8335_PIC_DTL_WRITER_Y_INT		(PNX833X_PIC_IRQ_BASE + 43)
> +#define PNX8335_PIC_DTL_WRITER_C_INT		(PNX833X_PIC_IRQ_BASE + 44)
> +#define PNX8335_PIC_DTL_EMULATOR_Y_IR_INT	(PNX833X_PIC_IRQ_BASE + 45)
> +#define PNX8335_PIC_DTL_EMULATOR_C_IR_INT	(PNX833X_PIC_IRQ_BASE + 46)
> +#define PNX8335_PIC_DENC_TTX_INT			(PNX833X_PIC_IRQ_BASE + 47)
> +#define PNX8335_PIC_MMI_SIF0_INT			(PNX833X_PIC_IRQ_BASE + 48)
> +#define PNX8335_PIC_MMI_SIF1_INT			(PNX833X_PIC_IRQ_BASE + 49)
> +#define PNX8335_PIC_MMI_CDMMU_INT			(PNX833X_PIC_IRQ_BASE + 50)
> +#define PNX8335_PIC_PIBCS_INT				(PNX833X_PIC_IRQ_BASE + 51)
> +#define PNX8335_PIC_ETHERNET_INT			(PNX833X_PIC_IRQ_BASE + 52)
> +#define PNX8335_PIC_VMSP1_0_INT				(PNX833X_PIC_IRQ_BASE + 53)
> +#define PNX8335_PIC_VMSP1_1_INT				(PNX833X_PIC_IRQ_BASE + 54)
> +#define PNX8335_PIC_VMSP1_DMA_INT			(PNX833X_PIC_IRQ_BASE + 55)
> +#define PNX8335_PIC_TDGR_DE_INT				(PNX833X_PIC_IRQ_BASE + 56)
> +#define PNX8335_PIC_IR1_IRQ_INT				(PNX833X_PIC_IRQ_BASE + 57)
> +#endif
> +
> +/* GPIO interrupts */
> +#define PNX833X_GPIO_0_INT					(PNX833X_GPIO_IRQ_BASE +  0)
> +#define PNX833X_GPIO_1_INT					(PNX833X_GPIO_IRQ_BASE +  1)
> +#define PNX833X_GPIO_2_INT					(PNX833X_GPIO_IRQ_BASE +  2)
> +#define PNX833X_GPIO_3_INT					(PNX833X_GPIO_IRQ_BASE +  3)
> +#define PNX833X_GPIO_4_INT					(PNX833X_GPIO_IRQ_BASE +  4)
> +#define PNX833X_GPIO_5_INT					(PNX833X_GPIO_IRQ_BASE +  5)
> +#define PNX833X_GPIO_6_INT					(PNX833X_GPIO_IRQ_BASE +  6)
> +#define PNX833X_GPIO_7_INT					(PNX833X_GPIO_IRQ_BASE +  7)
> +#define PNX833X_GPIO_8_INT					(PNX833X_GPIO_IRQ_BASE +  8)
> +#define PNX833X_GPIO_9_INT					(PNX833X_GPIO_IRQ_BASE +  9)
> +#define PNX833X_GPIO_10_INT					(PNX833X_GPIO_IRQ_BASE + 10)
> +#define PNX833X_GPIO_11_INT					(PNX833X_GPIO_IRQ_BASE + 11)
> +#define PNX833X_GPIO_12_INT					(PNX833X_GPIO_IRQ_BASE + 12)
> +#define PNX833X_GPIO_13_INT					(PNX833X_GPIO_IRQ_BASE + 13)
> +#define PNX833X_GPIO_14_INT					(PNX833X_GPIO_IRQ_BASE + 14)
> +#define PNX833X_GPIO_15_INT					(PNX833X_GPIO_IRQ_BASE + 15)
> +
> +#endif
> +

CodingStyle: try to stay with in 80 columns.

<irq.h> really is only meant to supply a few constants to the generic
interrupt header in <asm/irq.h> rsp. <linux/irq.h>, see
include/asm-mips/mach-generic/irq.h for which constants these are.  Anything
beyond that should go into a separate header file and be included where
necessary.

> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/pnx833x.h
> linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/pnx833x.h
> --- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/pnx833x.h	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/pnx833x.h	2008-06-06
> 11:29:43.000000000 +0100
> @@ -0,0 +1,202 @@
> +/*
> + *  pnx833x.h: Register mappings for PNX833X.
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *	  Chris Steel <chris.steel@nxp.com>
> + *    Daniel Laird <daniel.j.laird@nxp.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#ifndef __ASM_MIPS_MACH_PNX833X_PNX833X_H
> +#define __ASM_MIPS_MACH_PNX833X_PNX833X_H
> +
> +/* All regs are accessed in KSEG1 */
> +#define PNX833X_BASE		(0xa0000000ul + 0x17E00000ul)
> +
> +#define PNX833X_REG(offs)	*((volatile unsigned long *)(PNX833X_BASE + offs))
> +
> +/* Registers are named exactly as in PNX833X docs, just with PNX833X_ prefix */
> +
> +/* Read access to multibit fields */
> +#define PNX833X_BIT(val, reg, field)	((val) & PNX833X_##reg##_##field)
> +#define PNX833X_REGBIT(reg, field)	PNX833X_BIT(PNX833X_##reg, reg, field)
> +
> +/* Use PNX833X_FIELD to extract a field from val */
> +#define PNX_FIELD(cpu, val, reg, field) \
> +		(((val) & PNX##cpu##_##reg##_##field##_MASK) >> \
> +			PNX##cpu##_##reg##_##field##_SHIFT)
> +#define PNX833X_FIELD(val, reg, field)	PNX_FIELD(833X, val, reg, field)
> +#define PNX8330_FIELD(val, reg, field)	PNX_FIELD(8330, val, reg, field)
> +#define PNX8335_FIELD(val, reg, field)	PNX_FIELD(8335, val, reg, field)
> +
> +/* Use PNX833X_REGFIELD to extract a field from a register */
> +#define PNX833X_REGFIELD(reg, field)	PNX833X_FIELD(PNX833X_##reg, reg, field)
> +#define PNX8330_REGFIELD(reg, field)	PNX8330_FIELD(PNX8330_##reg, reg, field)
> +#define PNX8335_REGFIELD(reg, field)	PNX8335_FIELD(PNX8335_##reg, reg, field)
> +
> +
> +#define PNX_WRITEFIELD(cpu, val, reg, field) \
> +	PNX##cpu##_##reg = (PNX##cpu##_##reg &
> ~(PNX##cpu##_##reg##_##field##_MASK)) | \
> +						((val) << PNX##cpu##_##reg##_##field##_SHIFT)
> +#define PNX833X_WRITEFIELD(val, reg, field) \
> +					PNX_WRITEFIELD(833X, val, reg, field)
> +#define PNX8330_WRITEFIELD(val, reg, field) \
> +					PNX_WRITEFIELD(8330, val, reg, field)
> +#define PNX8335_WRITEFIELD(val, reg, field) \
> +					PNX_WRITEFIELD(8335, val, reg, field)
> +
> +
> +/* Macros to detect CPU type */
> +
> +#define PNX833X_CONFIG_MODULE_ID		PNX833X_REG(0x7FFC)
> +#define PNX833X_CONFIG_MODULE_ID_MAJREV_MASK	0x0000f000
> +#define PNX833X_CONFIG_MODULE_ID_MAJREV_SHIFT	12
> +#define PNX8330_CONFIG_MODULE_MAJREV		4
> +#define PNX8335_CONFIG_MODULE_MAJREV		5
> +#define CPU_IS_PNX8330	(PNX833X_REGFIELD(CONFIG_MODULE_ID, MAJREV) == \
> +					PNX8330_CONFIG_MODULE_MAJREV)
> +#define CPU_IS_PNX8335	(PNX833X_REGFIELD(CONFIG_MODULE_ID, MAJREV) == \
> +					PNX8335_CONFIG_MODULE_MAJREV)
> +
> +
> +
> +#define PNX833X_RESET_CONTROL		PNX833X_REG(0x8004)
> +#define PNX833X_RESET_CONTROL_2 	PNX833X_REG(0x8014)
> +
> +#define PNX833X_PIC_REG(offs)		PNX833X_REG(0x01000 + (offs))
> +#define PNX833X_PIC_INT_PRIORITY	PNX833X_PIC_REG(0x0)
> +#define PNX833X_PIC_INT_SRC		PNX833X_PIC_REG(0x4)
> +#define PNX833X_PIC_INT_SRC_INT_SRC_MASK	0x00000FF8ul	/* bits 11:3 */
> +#define PNX833X_PIC_INT_SRC_INT_SRC_SHIFT	3
> +#define PNX833X_PIC_INT_REG(irq)	PNX833X_PIC_REG(0x10 + 4*(irq))
> +
> +#define PNX833X_CLOCK_CPUCP_CTL	PNX833X_REG(0x9228)
> +#define PNX833X_CLOCK_CPUCP_CTL_EXIT_RESET	0x00000002ul	/* bit 1 */
> +#define PNX833X_CLOCK_CPUCP_CTL_DIV_CLOCK_MASK	0x00000018ul	/* bits 4:3 */
> +#define PNX833X_CLOCK_CPUCP_CTL_DIV_CLOCK_SHIFT	3
> +
> +#define PNX8335_CLOCK_PLL_CPU_CTL		PNX833X_REG(0x9020)
> +#define PNX8335_CLOCK_PLL_CPU_CTL_FREQ_MASK	0x1f
> +#define PNX8335_CLOCK_PLL_CPU_CTL_FREQ_SHIFT	0
> +
> +#define PNX833X_CONFIG_MUX		PNX833X_REG(0x7004)
> +#define PNX833X_CONFIG_MUX_IDE_MUX	0x00000080		/* bit 7 */
> +
> +#define PNX8330_CONFIG_POLYFUSE_7	PNX833X_REG(0x7040)
> +#define PNX8330_CONFIG_POLYFUSE_7_BOOT_MODE_MASK	0x00180000
> +#define PNX8330_CONFIG_POLYFUSE_7_BOOT_MODE_SHIFT	19
> +
> +#define PNX833X_PIO_IN		PNX833X_REG(0xF000)
> +#define PNX833X_PIO_OUT		PNX833X_REG(0xF004)
> +#define PNX833X_PIO_DIR		PNX833X_REG(0xF008)
> +#define PNX833X_PIO_SEL		PNX833X_REG(0xF014)
> +#define PNX833X_PIO_INT_EDGE	PNX833X_REG(0xF020)
> +#define PNX833X_PIO_INT_HI	PNX833X_REG(0xF024)
> +#define PNX833X_PIO_INT_LO	PNX833X_REG(0xF028)
> +#define PNX833X_PIO_INT_STATUS	PNX833X_REG(0xFFE0)
> +#define PNX833X_PIO_INT_ENABLE	PNX833X_REG(0xFFE4)
> +#define PNX833X_PIO_INT_CLEAR	PNX833X_REG(0xFFE8)
> +#define PNX833X_PIO_IN2		PNX833X_REG(0xF05C)
> +#define PNX833X_PIO_OUT2	PNX833X_REG(0xF060)
> +#define PNX833X_PIO_DIR2	PNX833X_REG(0xF064)
> +#define PNX833X_PIO_SEL2	PNX833X_REG(0xF068)
> +
> +#define PNX833X_UART0_PORTS_START	(PNX833X_BASE + 0xB000)
> +#define PNX833X_UART0_PORTS_END		(PNX833X_BASE + 0xBFFF)
> +#define PNX833X_UART1_PORTS_START	(PNX833X_BASE + 0xC000)
> +#define PNX833X_UART1_PORTS_END		(PNX833X_BASE + 0xCFFF)
> +
> +#define PNX833X_USB_PORTS_START		(PNX833X_BASE + 0x19000)
> +#define PNX833X_USB_PORTS_END		(PNX833X_BASE + 0x19FFF)
> +
> +#define PNX833X_CONFIG_USB		PNX833X_REG(0x7008)
> +
> +#define PNX833X_I2C0_PORTS_START	(PNX833X_BASE + 0xD000)
> +#define PNX833X_I2C0_PORTS_END		(PNX833X_BASE + 0xDFFF)
> +#define PNX833X_I2C1_PORTS_START	(PNX833X_BASE + 0xE000)
> +#define PNX833X_I2C1_PORTS_END		(PNX833X_BASE + 0xEFFF)
> +
> +#define PNX833X_IDE_PORTS_START		(PNX833X_BASE + 0x1A000)
> +#define PNX833X_IDE_PORTS_END		(PNX833X_BASE + 0x1AFFF)
> +#define PNX833X_IDE_MODULE_ID		PNX833X_REG(0x1AFFC)
> +
> +#define PNX833X_IDE_MODULE_ID_MODULE_ID_MASK	0xFFFF0000
> +#define PNX833X_IDE_MODULE_ID_MODULE_ID_SHIFT	16
> +#define PNX833X_IDE_MODULE_ID_VALUE		0xA009
> +
> +
> +#define PNX833X_MIU_SEL0			PNX833X_REG(0x2004)
> +#define PNX833X_MIU_SEL0_TIMING		PNX833X_REG(0x2008)
> +#define PNX833X_MIU_SEL1			PNX833X_REG(0x200C)
> +#define PNX833X_MIU_SEL1_TIMING		PNX833X_REG(0x2010)
> +#define PNX833X_MIU_SEL2			PNX833X_REG(0x2014)
> +#define PNX833X_MIU_SEL2_TIMING		PNX833X_REG(0x2018)
> +#define PNX833X_MIU_SEL3			PNX833X_REG(0x201C)
> +#define PNX833X_MIU_SEL3_TIMING		PNX833X_REG(0x2020)
> +
> +#define PNX833X_MIU_SEL0_SPI_MODE_ENABLE_MASK	(1 << 14)
> +#define PNX833X_MIU_SEL0_SPI_MODE_ENABLE_SHIFT	14
> +
> +#define PNX833X_MIU_SEL0_BURST_MODE_ENABLE_MASK	(1 << 7)
> +#define PNX833X_MIU_SEL0_BURST_MODE_ENABLE_SHIFT	7
> +
> +#define PNX833X_MIU_SEL0_BURST_PAGE_LEN_MASK	(0xF << 9)
> +#define PNX833X_MIU_SEL0_BURST_PAGE_LEN_SHIFT	9
> +
> +#define PNX833X_MIU_CONFIG_SPI		PNX833X_REG(0x2000)
> +
> +#define PNX833X_MIU_CONFIG_SPI_OPCODE_MASK	(0xFF << 3)
> +#define PNX833X_MIU_CONFIG_SPI_OPCODE_SHIFT	3
> +
> +#define PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_MASK	(1 << 2)
> +#define PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_SHIFT	2
> +
> +#define PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_MASK	(1 << 1)
> +#define PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_SHIFT	1
> +
> +#define PNX833X_MIU_CONFIG_SPI_SYNC_MASK	(1 << 0)
> +#define PNX833X_MIU_CONFIG_SPI_SYNC_SHIFT	0
> +
> +#define PNX833X_WRITE_CONFIG_SPI(opcode, data_enable, addr_enable, sync) \
> +   PNX833X_MIU_CONFIG_SPI = \
> +   ((opcode) << PNX833X_MIU_CONFIG_SPI_OPCODE_SHIFT) | \
> +   ((data_enable) << PNX833X_MIU_CONFIG_SPI_DATA_ENABLE_SHIFT) | \
> +   ((addr_enable) << PNX833X_MIU_CONFIG_SPI_ADDR_ENABLE_SHIFT) | \
> +   ((sync) << PNX833X_MIU_CONFIG_SPI_SYNC_SHIFT)
> +
> +#define PNX8335_IP3902_PORTS_START		(PNX833X_BASE + 0x2F000)
> +#define PNX8335_IP3902_PORTS_END		(PNX833X_BASE + 0x2FFFF)
> +#define PNX8335_IP3902_MODULE_ID		PNX833X_REG(0x2FFFC)
> +
> +#define PNX8335_IP3902_MODULE_ID_MODULE_ID_MASK		0xFFFF0000
> +#define PNX8335_IP3902_MODULE_ID_MODULE_ID_SHIFT	16
> +#define PNX8335_IP3902_MODULE_ID_VALUE			0x3902
> +
> + /* I/O location(gets remapped)*/
> +#define PNX8335_NAND_BASE	    0x18000000
> +/* I/O location with CLE high */
> +#define PNX8335_NAND_CLE_MASK	0x00100000
> +/* I/O location with ALE high */
> +#define PNX8335_NAND_ALE_MASK	0x00010000
> +
> +#define PNX8335_SATA_PORTS_START	(PNX833X_BASE + 0x2E000)
> +#define PNX8335_SATA_PORTS_END		(PNX833X_BASE + 0x2EFFF)
> +#define PNX8335_SATA_MODULE_ID		PNX833X_REG(0x2EFFC)
> +
> +#define PNX8335_SATA_MODULE_ID_MODULE_ID_MASK	0xFFFF0000
> +#define PNX8335_SATA_MODULE_ID_MODULE_ID_SHIFT	16
> +#define PNX8335_SATA_MODULE_ID_VALUE		0xA099
> +
> +#endif
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/war.h
> linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/war.h
> --- linux-2.6.26-rc4.orig/include/asm-mips/mach-pnx833x/war.h	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/include/asm-mips/mach-pnx833x/war.h	2008-06-05
> 09:34:22.000000000 +0100
> @@ -0,0 +1,25 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
> + */
> +#ifndef __ASM_MIPS_MACH_PNX833X_WAR_H
> +#define __ASM_MIPS_MACH_PNX833X_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR	0
> +#define R4600_V1_HIT_CACHEOP_WAR	0
> +#define R4600_V2_HIT_CACHEOP_WAR	0
> +#define R5432_CP0_INTERRUPT_WAR		0
> +#define BCM1250_M3_WAR			0
> +#define SIBYTE_1956_WAR			0
> +#define MIPS4K_ICACHE_REFILL_WAR	0
> +#define MIPS_CACHE_SYNC_WAR		0
> +#define TX49XX_ICACHE_INDEX_INV_WAR	0
> +#define RM9000_CDEX_SMP_WAR		0
> +#define ICACHE_REFILLS_WORKAROUND_WAR	0
> +#define R10000_LLSC_WAR			0
> +#define MIPS34K_MISSED_ITLB_WAR		0
> +
> +#endif /* __ASM_MIPS_MACH_PNX8550_WAR_H */

Not too bad all in all.

Cheers,

  Ralf
