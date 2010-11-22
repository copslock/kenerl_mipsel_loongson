Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 03:24:42 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42857 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491948Ab0KVCYi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 03:24:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oAM2Oakv012929;
        Mon, 22 Nov 2010 02:24:36 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oAM2OZSr012927;
        Mon, 22 Nov 2010 02:24:35 GMT
Date:   Mon, 22 Nov 2010 02:24:35 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     shmprtd@googlemail.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for Realtek Media Player SoCs
Message-ID: <20101122022435.GB10923@linux-mips.org>
References: <tkrat.a6310f0563cae06d@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.a6310f0563cae06d@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 21, 2010 at 01:15:11AM +0100, shmprtd@googlemail.com wrote:

> I added support for at least one of the Realtek "Galaxy" SoCs to recent
> 2.6.36 kernel. Most of the patch is based on existing linux-mips code and
> a 2.6.12 kernel source released by some of Realtek customers.

For submission please use the latest linux-queue git tree or at least
the linux-mips tree.

> Currently, this allows to start the kernel and setup serial console.
> Further development/porting will have to be done for additional platform
> devices.
> 
> This code is tested on a Realtek Mars SoC. Commercial product name
> is rtd1073dd but cpu/soc id is 0x1283. Other SoCs (Venus,Jupiter,Neptune)
> have not been tested, yet.
> 
> Please comment on the patch and feel free to suggest changes that need
> to be done prior integration.

Let the flaming begin :-)

First, when submitting patches, please include a Signed-off-by: line.  For
details on that, see Documentation/SubmittingPatches in the kernel sources.
Strictly seen this is not needed to get a patch reviewed but only for the
actual submission of a patch but it's good style to always include it.
Other people might grab a patch and base their work on it and even hell
might freeze over and a patch might be applied right away.

Also please include a diffstat of a patch so everybody can see right away
what a particular patch touches.

 arch/mips/Kbuild.platforms                         |    1 
 arch/mips/Kconfig                                  |   17 +
 arch/mips/include/asm/mach-rtd128x/rtd128x-board.h |   51 +++
 arch/mips/include/asm/mach-rtd128x/rtd128x-io.h    |  276 +++++++++++++++++++++
 arch/mips/include/asm/mach-rtd128x/rtd128x-irq.h   |   70 +++++
 arch/mips/include/asm/mach-rtd128x/rtd128x-soc.h   |   41 +++
 arch/mips/include/asm/mach-rtd128x/war.h           |   26 +
 arch/mips/rtd128x/Kconfig                          |   14 +
 arch/mips/rtd128x/Makefile                         |    1 
 arch/mips/rtd128x/Platform                         |    8 
 arch/mips/rtd128x/common/Makefile                  |   10 
 arch/mips/rtd128x/common/board.c                   |  137 ++++++++++
 arch/mips/rtd128x/common/irq.c                     |  137 ++++++++++
 arch/mips/rtd128x/common/memory.c                  |  202 +++++++++++++++
 arch/mips/rtd128x/common/platform.c                |  103 +++++++
 arch/mips/rtd128x/common/printk.c                  |   33 ++
 arch/mips/rtd128x/common/prom.c                    |  224 +++++++++++++++++
 arch/mips/rtd128x/common/sb2.c                     |   46 +++
 arch/mips/rtd128x/common/setup.c                   |  179 +++++++++++++
 arch/mips/rtd128x/common/time.c                    |   87 ++++++
 20 files changed, 1663 insertions(+)

And the diffstat raises the question why the common directory if the entire
code ends up there?

Also you want to add a arch/mips/include/asm/mach-rtd128x/cpu-feature-
overrides.h file for better performance and significantly smaller kernel
code.

So let's see ...

> diff -uNr linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h
> --- linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h	2010-11-19 18:20:47.000000000 +0100
> @@ -0,0 +1,51 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +
> +#ifndef _RTD128X_BOARD_H_
> +#define _RTD128X_BOARD_H_
> +
> +#include <linux/types.h>
> +
> +enum rtd128x_board_type {
> +	RTD128X_BOARD_UNKNOWN = -1,
> +	RTD128X_BOARD_EM7080 = 0,
> +};

You probably want to have RTD128X_BOARD_UNKNOWN = 0 such that an un-
initialized variable of type enum rtd128x_board_type will be treated as
unknown platform type and not RTD128X_BOARD_EM7080.

[...]
> +#define RTD128X_SYS_BASE_OFFSET     0x0000
> +#define RTD128X_EHCI_BASE_OFFSET    0x3000
                                   ^^^^
Format with tabs, please.

> +/*
> + * UART0/UART1 (8250 compatible)
> + */

[37 lines of UART definitions deleted.]

You may want to use the <linux/serial_reg.h> definitions instead.  A simple
wrapper macro to do writes into the UART should do the job.

> --- linux-2.6.36-vanilla/arch/mips/Kbuild.platforms	2010-10-20 23:23:01.000000000 +0200
> +++ linux-2.6.36/arch/mips/Kbuild.platforms	2010-11-16 01:16:43.000000000 +0100
> @@ -18,6 +18,7 @@
>  platforms += pnx833x
>  platforms += pnx8550
>  platforms += powertv
> +platforms += rtd128x

Read the comment at line 1 of this file!

> --- linux-2.6.36-vanilla/arch/mips/rtd128x/common/board.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/common/board.c	2010-11-19 18:09:57.000000000 +0100
> @@ -0,0 +1,137 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>

Use <linux/io.h> - or scripts/checkpatch.pl will moan loudly.

> +static void rtd128x_common_machine_restart(char *cmd)
> +{
> +#ifdef CONFIG_RTD128X_WATCHDOG

CONFIG_RTD128X_WATCHDOG is meant to control building the driver in
drivers/watchdog?  The kernel should still work ok even if it was
build without support for a particular driver, then the driver
later compiled and be loaded into the previously built kernel.  Iow,
this #ifdef should go.

> +	 */
> +	kill_watchdog();
> +#else
> +	/*
> +	 * TODO: Find a way to reset the SoC
> +	 */
> +	outl(0x0, RTD128X_TIMR_TCWCR);

MIPS doesn't have an I/O port address space.  That's pure x86 legacy and
even there it's deprecated.  in, out and their whole clan are meant to
be exclusively used to access for I/O port accesses, that is (E)ISA or
PCI port addresses.

> +#endif
> +	msleep(5000);

Just make this "while (1);"

> +
> +static enum rtd128x_board_type rtd128x_detect_board(void)
> +{
> +	return RTD128X_BOARD_EM7080;
> +
> +	/*
> +	 * TODO: Detect different board types
> +	 */
> +
> +	return RTD128X_BOARD_UNKNOWN;
> +}

I see dead code :)

> +void rtd128x_board_setup(void)
> +{
> +	switch (rtd128x_detect_board()) {
> +	case RTD128X_BOARD_EM7080:
> +		memcpy(&rtd128x_board_info, &rtd128x_em7080_info,
> +		       sizeof(struct rtd128x_board));

You probably want to turn rtd128x_board_info into a pointer which would
turn this into a simple pointer assignment:

	rtd128x_board_info = &rtd128x_em7080_info;

And many other places would get a little more elegant also.

> +		break;
> +	default:
> +		printk("Unknown rtd128x board.");

I guess as early as this not even early prinkt is working yet so
maybe just BUG() would do?

> +++ linux-2.6.36/arch/mips/rtd128x/common/memory.c	2010-11-19 18:10:26.000000000 +0100
> @@ -0,0 +1,202 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/bootmem.h>
> +#include <linux/pfn.h>
> +#include <linux/string.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/page.h>
> +#include <asm/sections.h>
> +
> +#include <asm/mips-boards/prom.h>
> +#include <rtd128x-board.h>
> +#include <rtd128x-soc.h>
> +
> +//#define DEBUG
> +
> +enum yamon_memtypes {
> +	yamon_dontuse,
> +	yamon_prom,
> +	yamon_free,
> +};
> +static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];

Ah, the 3rd copy of YAMON support code.  No fucking way.  Please
extract the code from the other copies to a shared place and use
those definitions for the rtd128x.

> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	/* SOC-it swaps, or perhaps doesn't swap, when DMA'ing the last
> +	   word of physical memory */
> +	physical_memsize -= PAGE_SIZE;
> +#endif

But you most likely don't have SOC-it (a system controller from MIPS).
And your Kconfig is setup to hardwire endianess to little endian so
this is doubly dead code.

> +#ifdef CONFIG_RTD128X_RECLAIM_BOOT_MEMORY

Is there a good reason why CONFIG_RTD128X_RECLAIM_BOOT_MEMORY is
configurable?  This probably should always be abled.

> +device_initcall(rtd128x_devinit);
> diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/printk.c linux-2.6.36/arch/mips/rtd128x/common/printk.c
> --- linux-2.6.36-vanilla/arch/mips/rtd128x/common/printk.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/common/printk.c	2010-11-19 18:10:44.000000000 +0100
> @@ -0,0 +1,33 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <asm/io.h>

Again, use <linux/io.h>.

> +#include <rtd128x-io.h>
> +
> +#define UART_LSR_TEMT		0x40	/* Transmitter empty */
> +#define UART_LSR_THRE		0x20	/* Transmit-hold-register empty */

This duplicates definitions from <linux/serial_reg.h>.

> +void __init prom_putchar(char c)
> +{
> +	wait_xfered();
> +	outl(c, RTD128X_UART_U0RBR_THR_DLL);
> +	wait_xfered();
> +}

Should be ok to only wait only before writing the character
into the output register.  UART accesses are terribly slow and
that way you can at least overlap some of the I/O with other
activity.

> +void prom_puts(char *s)
> +{
> +	while (*s != '\0') {
> +		if (*s == '\n') {
> +			prom_putchar(*s++);

What's wrong with prm_putchar('\n');

> +
> +void prom_puthex(unsigned long l)
> +{
> +	char n;
> +	int i;

Insert blank line here.

> +	prom_putchar('0');
> +	prom_putchar('x');

> +int prom_argc;
> +int *_prom_argv, *_prom_envp;

Consider making these static and __init.  I assume these variables
are not being used after kernel initialization?

> +
> +/* TODO: Verify on linux-mips mailing list that the following two  */
> +/* functions are correct                                           */

Ah, comments copied from PowerTV :)

> +/* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
> +/* BootROM exception vectors. Flush their cache entries. test it.  */
> +
> +static void __init mips_nmi_setup(void)
> +{
> +	void *base;
> +#if defined(CONFIG_CPU_MIPS32_R1)
> +	base = cpu_has_veic ?
> +	    (void *)(CAC_BASE + 0xa80) : (void *)(CAC_BASE + 0x380);

Won't fly for NMI.  NMIs set BEV = 1 which means all your nice vectors
will be bypassed and the processor will jump straight to 0xbfc00000.
The average firmware will reininitialize the system but some is slightly
nicer and allows the OS to regain control.

> +#elif defined(CONFIG_CPU_MIPS32_R2)
> +	base = (void *)0xbfc00000;
> +#else
> +#error NMI exception handler address not defined
> +#endif
> +}

> --- linux-2.6.36-vanilla/arch/mips/rtd128x/common/sb2.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/common/sb2.c	2010-11-19 18:11:12.000000000 +0100

> +	if (!(inl(RTD128X_SB2_INV_INTSTAT) & 0x2))
> +		return IRQ_NONE;
> +
> +	/* 
        ^^^^
remove the trailing space, please.

> diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/setup.c linux-2.6.36/arch/mips/rtd128x/common/setup.c
> --- linux-2.6.36-vanilla/arch/mips/rtd128x/common/setup.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/common/setup.c	2010-11-19 18:11:21.000000000 +0100
> @@ -0,0 +1,179 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/sched.h>

Do you really need sched.h?

> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/screen_info.h>
> +#include <linux/notifier.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_ether.h>
> +#include <linux/ctype.h>
> +#include <linux/cpu.h>
> +#include <linux/time.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/irq.h>
> +#include <asm/mips-boards/generic.h>
> +#include <asm/mips-boards/prom.h>
> +#include <asm/dma.h>
> +#include <asm/time.h>
> +#include <asm/asm.h>
> +#include <asm/traps.h>
> +#include <asm/reboot.h>
> +#include <asm/asm-offsets.h>
> +
> +#include <rtd128x-board.h>
> +
> +extern void rtd128x_board_setup(void);
> +
> +#define VAL(n)		STR(n)
> +
> +/*
> + * Macros for loading addresses and storing registers:
> + * LONG_L_	Stringified version of LONG_L for use in asm() statement
> + * LONG_S_	Stringified version of LONG_S for use in asm() statement
> + * PTR_LA_	Stringified version of PTR_LA for use in asm() statement
> + * REG_SIZE	Number of 8-bit bytes in a full width register
> + */
> +#define LONG_L_		VAL(LONG_L) " "
> +#define LONG_S_		VAL(LONG_S) " "
> +#define PTR_LA_		VAL(PTR_LA) " "
> +
> +#ifdef CONFIG_64BIT
> +#warning TODO: 64-bit code needs to be verified
> +#define REG_SIZE	"8"	/* In bytes */
> +#endif
> +
> +#ifdef CONFIG_32BIT
> +#define REG_SIZE	"4"	/* In bytes */
> +#endif
> +
> +static void register_panic_notifier(void);
> +static int panic_handler(struct notifier_block *notifier_block,
> +			 unsigned long event, void *cause_string);
> +
> +/*
> + * Install a panic notifier for platform-specific diagnostics
> + */
> +static void register_panic_notifier()
> +{
> +	static struct notifier_block panic_notifier = {
> +		.notifier_call = panic_handler,
> +		.next = NULL,
> +		.priority = INT_MAX
> +	};
> +	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
> +}
> +
> +static int panic_handler(struct notifier_block *notifier_block,
> +			 unsigned long event, void *cause_string)
> +{
> +	struct pt_regs my_regs;
> +
> +	/* Save all of the registers */
> +	{
> +		unsigned long at, v0, v1;	/* Must be on the stack */
> +
> +		/* Start by saving $at and v0 on the stack. We use $at
> +		 * ourselves, but it looks like the compiler may use v0 or v1
> +		 * to load the address of the pt_regs structure. We'll come
> +		 * back later to store the registers in the pt_regs
> +		 * structure. */
> +		__asm__ __volatile__(".set	noat\n"
> +				     LONG_S_ "$at, %[at]\n"

Copied from PowerTV :)  I somehow doubt saving registers at this late stage
provides much useful information.

> +	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
> +		"zzzz... \n");

This is a panic so pr_emerg() would see more apropriate to express
the urgency of this nap :-)

> --- linux-2.6.36-vanilla/arch/mips/rtd128x/common/time.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/common/time.c	2010-11-19 18:11:27.000000000 +0100
> @@ -0,0 +1,87 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/time.h>
> +#include <linux/timex.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/mipsmtregs.h>

Eh...  You said you have a 24K.  There is no way you then
could use any of the definitions in this file.

> +#include <asm/hardirq.h>
> +#include <asm/irq.h>
> +#include <asm/div64.h>
> +#include <asm/cpu.h>
> +#include <asm/time.h>
> +
> +#include <rtd128x-io.h>
> +#include <rtd128x-irq.h>
> +#include <rtd128x-board.h>
> +
> +extern void platform_setup(void);

Declaration but the symbol platform_setup() is not being used anywhere.
And another file also declared platform_setup() without using it ...

> +
> +unsigned long cpu_khz;

Unused junk.

> diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/Kconfig linux-2.6.36/arch/mips/rtd128x/Kconfig
> --- linux-2.6.36-vanilla/arch/mips/rtd128x/Kconfig	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/Kconfig	2010-11-19 18:09:41.000000000 +0100
> @@ -0,0 +1,14 @@
> +config RTD128X_RECLAIM_BOOT_MEMORY
> +        bool "reclaim memory from bootloader"
> +
> +#
> +# FIXME: do we really need this?
> +#
> +#config RTD128X_EXTERNAL_TIMER
> +#        bool "use external timer interrupt"

You certainly don't want to expose such stuff to the Kconfig user
who most likely has no clue whatsoever what this option means.
Especially not without a help text but that's besides the point.
The option should simply not exist.

> --- linux-2.6.36-vanilla/arch/mips/rtd128x/Platform	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.36/arch/mips/rtd128x/Platform	2010-11-16 01:16:43.000000000 +0100
> @@ -0,0 +1,8 @@
> +#
> +# Realtek Galaxy SoC boards
> +#
> +
> +platform-${CONFIG_RTD128X} += rtd128x/
> +cflags-${CONFIG_RTD128X}   += -I$(srctree)/arch/mips/include/asm/mach-rtd128x/
> +load-${CONFIG_RTD128X}     := 0xffffffff80100000
> +all-$(CONFIG_RTD128X)      := $(COMPRESSION_FNAME).bin

  Ralf
