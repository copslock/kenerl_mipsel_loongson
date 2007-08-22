Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 02:15:52 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:32829 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022390AbXHVBPu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2007 02:15:50 +0100
Received: by mo.po.2iij.net (mo30) id l7M1EUx0053105; Wed, 22 Aug 2007 10:14:30 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l7M1EPD6006451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Aug 2007 10:14:25 +0900
Date:	Wed, 22 Aug 2007 10:14:25 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	brm <brm@murphy.dk>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
Message-Id: <20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200708212034.l7LKYGiD011023@potty.localnet>
References: <200708212034.l7LKYGiD011023@potty.localnet>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 21 Aug 2007 22:34:16 +0200
brm <brm@murphy.dk> wrote:

> Add back support for LASAT platforms.
> 
> Signed-off-by: Brian Murphy <brian@murphy.dk>

<snip>

> diff --git a/arch/mips/lasat/Kconfig b/arch/mips/lasat/Kconfig
> new file mode 100644
> index 0000000..1d2ee8a
> --- /dev/null
> +++ b/arch/mips/lasat/Kconfig
> @@ -0,0 +1,15 @@
> +config PICVUE
> +	tristate "PICVUE LCD display driver"
> +	depends on LASAT
> +
> +config PICVUE_PROC
> +	tristate "PICVUE LCD display driver /proc interface"
> +	depends on PICVUE
> +
> +config DS1603
> +	bool "DS1603 RTC driver"
> +	depends on LASAT

If you add new RTC driver, it should go to drivers/rtc.

> diff --git a/arch/mips/lasat/reset.c b/arch/mips/lasat/reset.c
> new file mode 100644
> index 0000000..9e22acf
> --- /dev/null
> +++ b/arch/mips/lasat/reset.c
> @@ -0,0 +1,69 @@
> +/*
> + * Thomas Horsten <thh@lasat.com>
> + * Copyright (C) 2000 LASAT Networks A/S.
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
> + * Reset the LASAT board.
> + */
> +#include <linux/kernel.h>
> +#include <linux/pm.h>
> +
> +#include <asm/reboot.h>
> +#include <asm/system.h>
> +#include <asm/lasat/lasat.h>
> +
> +#include "picvue.h"
> +#include "prom.h"
> +
> +static void lasat_machine_restart(char *command);
> +static void lasat_machine_halt(void);
> +
> +/* Used to set machine to boot in service mode via /proc interface */
> +int lasat_boot_to_service = 0;
> +
> +static void lasat_machine_restart(char *command)
> +{
> +	local_irq_disable();
> +
> +	if (lasat_boot_to_service) {
> +		printk("machine_restart: Rebooting to service mode\n");
> +		*(volatile unsigned int *)0xa0000024 = 0xdeadbeef;
> +		*(volatile unsigned int *)0xa00000fc = 0xfedeabba;
> +	}
> +	*lasat_misc->reset_reg = 0xbedead;
> +	for (;;) ;
> +}
> +
> +#define MESSAGE "System halted"
> +static void lasat_machine_halt(void)
> +{
> +	local_irq_disable();
> +
> +	/* Disable interrupts and loop forever */
> +	printk(KERN_NOTICE MESSAGE "\n");

alreade displayed in kernel_halt().

> diff --git a/include/asm-mips/lasat/lasatint.h b/include/asm-mips/lasat/lasatint.h
> new file mode 100644
> index 0000000..065474f
> --- /dev/null
> +++ b/include/asm-mips/lasat/lasatint.h
> @@ -0,0 +1,12 @@
> +#define LASATINT_END 16
> +
> +/* lasat 100 */
> +#define LASAT_INT_STATUS_REG_100	(KSEG1ADDR(0x1c880000))
> +#define LASAT_INT_MASK_REG_100		(KSEG1ADDR(0x1c890000))
> +#define LASATINT_MASK_SHIFT_100		0
> +
> +/* lasat 200 */
> +#define LASAT_INT_STATUS_REG_200	(KSEG1ADDR(0x1104003c))
> +#define LASAT_INT_MASK_REG_200		(KSEG1ADDR(0x1104003c))
> +#define LASATINT_MASK_SHIFT_200		16
> +

Only used in arch/mips/lasat/interrupt.c .
Please move to interrupt.c .

> diff --git a/include/asm-mips/lasat/picvue.h b/include/asm-mips/lasat/picvue.h
> new file mode 100644
> index 0000000..42a492e
> --- /dev/null
> +++ b/include/asm-mips/lasat/picvue.h
> @@ -0,0 +1,15 @@
> +/* Lasat 100 */
> +#define PVC_REG_100		KSEG1ADDR(0x1c820000)
> +#define PVC_DATA_SHIFT_100	0
> +#define PVC_DATA_M_100		0xFF
> +#define PVC_E_100		(1 << 8)
> +#define PVC_RW_100		(1 << 9)
> +#define PVC_RS_100		(1 << 10)
> +
> +/* Lasat 200 */
> +#define PVC_REG_200		KSEG1ADDR(0x11000000)
> +#define PVC_DATA_SHIFT_200	24
> +#define PVC_DATA_M_200		(0xFF << PVC_DATA_SHIFT_200)
> +#define PVC_E_200		(1 << 16)
> +#define PVC_RW_200		(1 << 17)
> +#define PVC_RS_200		(1 << 18)

Only used in arch/mips/lasat/setup.c .
Please move to setup.c or arch/mips/lasat/picvue.h .

> diff --git a/include/asm-mips/lasat/serial.h b/include/asm-mips/lasat/serial.h
> new file mode 100644
> index 0000000..9e88c76
> --- /dev/null
> +++ b/include/asm-mips/lasat/serial.h
> @@ -0,0 +1,13 @@
> +#include <asm/lasat/lasat.h>
> +
> +/* Lasat 100 boards serial configuration */
> +#define LASAT_BASE_BAUD_100 		( 7372800 / 16 )
> +#define LASAT_UART_REGS_BASE_100	0x1c8b0000
> +#define LASAT_UART_REGS_SHIFT_100	2
> +#define LASATINT_UART_100		8
> +
> +/* * LASAT 200 boards serial configuration */
> +#define LASAT_BASE_BAUD_200		(100000000 / 16 / 12)
> +#define LASAT_UART_REGS_BASE_200	(Vrc5074_PHYS_BASE + 0x0300)
> +#define LASAT_UART_REGS_SHIFT_200	3
> +#define LASATINT_UART_200		13

Only used in arch/mips/lasat/serial.c .
Please move to serial.c.

> diff --git a/include/asm-mips/mach-lasat/mach-gt64120.h b/include/asm-mips/mach-lasat/mach-gt64120.h
> new file mode 100644
> index 0000000..1a9ad45
> --- /dev/null
> +++ b/include/asm-mips/mach-lasat/mach-gt64120.h
> @@ -0,0 +1,27 @@
> +/*
> + *  This is a direct copy of the ev96100.h file, with a global
> + * search and replace.  The numbers are the same.
> + *
> + *  The reason I'm duplicating this is so that the 64120/96100
> + * defines won't be confusing in the source code.
> + */
> +#ifndef _ASM_GT64120_LASAT_GT64120_DEP_H
> +#define _ASM_GT64120_LASAT_GT64120_DEP_H
> +
> +/*
> + *   GT64120 config space base address on Lasat 100
> + */
> +#define GT64120_BASE	(KSEG1ADDR(0x14000000))
> +
> +/*
> + *   PCI Bus allocation
> + *
> + *   (Guessing ...)
> + */
> +#define GT_PCI_MEM_BASE	0x12000000UL
> +#define GT_PCI_MEM_SIZE	0x02000000UL
> +#define GT_PCI_IO_BASE	0x10000000UL
> +#define GT_PCI_IO_SIZE	0x02000000UL

There are already defined in include/asm-mips/gt64120.h
Please use default definitions.

> +#define GT_ISA_IO_BASE	PCI_IO_BASE

Not used.

> +#endif /* _ASM_GT64120_LASAT_GT64120_DEP_H */
> diff --git a/include/asm-mips/nile4.h b/include/asm-mips/nile4.h
> new file mode 100644
> index 0000000..c3ca959
> --- /dev/null
> +++ b/include/asm-mips/nile4.h
> @@ -0,0 +1,310 @@
> +/*
> + *  asm-mips/nile4.h -- NEC Vrc-5074 Nile 4 definitions

<snip>

> +    /*
> +     *  Interrupt Programming
> +     */
> +
> +#define NUM_I8259_INTERRUPTS	16
> +#define NUM_NILE4_INTERRUPTS	16
> +
> +#define IRQ_I8259_CASCADE	NILE4_INT_INTE
> +#define is_i8259_irq(irq)	((irq) < NUM_I8259_INTERRUPTS)
> +#define nile4_to_irq(n)		((n)+NUM_I8259_INTERRUPTS)
> +#define irq_to_nile4(n)		((n)-NUM_I8259_INTERRUPTS)
> +
> +extern void nile4_map_irq(int nile4_irq, int cpu_irq);
> +extern void nile4_map_irq_all(int cpu_irq);
> +extern void nile4_enable_irq(unsigned int nile4_irq);
> +extern void nile4_disable_irq(unsigned int nile4_irq);
> +extern void nile4_disable_irq_all(void);
> +extern u16 nile4_get_irq_stat(int cpu_irq);
> +extern void nile4_enable_irq_output(int cpu_irq);
> +extern void nile4_disable_irq_output(int cpu_irq);
> +extern void nile4_set_pci_irq_polarity(int pci_irq, int high);
> +extern void nile4_set_pci_irq_level_or_edge(int pci_irq, int level);
> +extern void nile4_clear_irq(int nile4_irq);
> +extern void nile4_clear_irq_mask(u32 mask);
> +extern u8 nile4_i8259_iack(void);
> +extern void nile4_dump_irq_status(void);	/* Debug */

nile4 IRQ functions don't exist.

Yoichi
