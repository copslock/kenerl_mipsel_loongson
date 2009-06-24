Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 14:11:46 +0200 (CEST)
Received: from main.gmane.org ([80.91.229.2]:52265 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492671AbZFXMLk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jun 2009 14:11:40 +0200
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MJRGx-00008g-Mx
	for linux-mips@linux-mips.org; Wed, 24 Jun 2009 12:08:15 +0000
Received: from woodchuck.wormnet.eu ([77.75.105.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 24 Jun 2009 12:08:15 +0000
Received: from alex by woodchuck.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 24 Jun 2009 12:08:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH 5/8] add Texas Instruments AR7 support
Date:	Wed, 24 Jun 2009 12:28:56 +0100
Message-ID:  <o8f9h6-v4l.ln1@woodchuck.wormnet.eu>
References:  <200906041619.25359.florian@openwrt.org> <200906231128.29760.florian@openwrt.org> <20090623181509.GA9966@linux-mips.org> <200906241112.58301.florian@openwrt.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-15
Content-Transfer-Encoding:  8bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: woodchuck.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-1-sparc64 (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Hi,

Florian Fainelli <florian@openwrt.org> wrote:
> Le Tuesday 23 June 2009 20:15:09 Ralf Baechle, vous avez écrit :
>> On Tue, Jun 23, 2009 at 11:28:27AM +0200, Florian Fainelli wrote:
>>
>> AR7 time again - the platform pending longest ...  Let's see:
> 
> Thank you very much for your comments Ralf, please find below an updated
> version which addresses all of your comments. I hope this time we are going
> to make it ;)
>
I am hoping someone can have a tackle of the lzma/bzip2 kernel/initramfs 
generic compression code myself, but I guess one thing at a time. :)  If 
you have a simple way for me to produce a LZMA'd image, I'll test it 
this on my WAG54Gv2 (I need the image to be less than 700kB).

My comments, for what they are worth, below:

> From: Florian Fainelli <florian@openwrt.org>
> Subject: Add support for Texas Instruments AR7 System-on-a-Chip
> 
> This patch adds support for the Texas Instruments AR7 System-on-a-Chip.
> It supports the TNETD7100, 7200 and 7300 versions of the SoC.
> 
> Changes from v4:
> [snipped]
> 
> Signed-off-by: Matteo Croce <matteo@openwrt.org>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> Signed-off-by: Eugene Konev <ejka@openwrt.org>
> Signed-off-by: Nicolas Thill <nico@openwrt.org>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> -- 
> [snipped]
>
> diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
> new file mode 100644
> index 0000000..7ce5f07
> --- /dev/null
> +++ b/arch/mips/ar7/clock.c
> @@ -0,0 +1,450 @@
> [snipped]
> +static void __init tnetd7300_init_clocks(void)
> +{
> +       u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> +       struct tnetd7300_clocks *clocks =
> +                                       (struct tnetd7300_clocks *)
> +                                       ioremap_nocache(AR7_REGS_POWER + 0x20,
> +                                       sizeof(struct tnetd7300_clocks));
> +
>
Needless cast'ing and also should you not check that NULL is not 
returned for both of these ioremap's?

> +       ar7_bus_clock = tnetd7300_get_clock(BUS_PLL_SOURCE_SHIFT,
> +               &clocks->bus, bootcr, AR7_AFE_CLOCK);
> +
> +       if (*bootcr & BOOT_PLL_ASYNC_MODE)
> +               ar7_cpu_clock = tnetd7300_get_clock(CPU_PLL_SOURCE_SHIFT,
> +                       &clocks->cpu, bootcr, AR7_AFE_CLOCK);
> +       else
> +               ar7_cpu_clock = ar7_bus_clock;
> +/*
> +       tnetd7300_set_clock(USB_PLL_SOURCE_SHIFT, &clocks->usb,
> +               bootcr, 48000000);
> +*/
>
Dead code?  Feels that way with what then follows.

> +       if (ar7_dsp_clock == 250000000)
> +               tnetd7300_set_clock(DSP_PLL_SOURCE_SHIFT, &clocks->dsp,
> +                       bootcr, ar7_dsp_clock);
> +
> +       iounmap(clocks);
> +       iounmap(bootcr);
> +}
>
> [snipped]
>
> +static void tnetd7200_set_clock(int base, struct tnetd7200_clock *clock,
> +       int prediv, int postdiv, int postdiv2, int mul, u32 frequency)
> +{
> +       printk(KERN_INFO
> +               "Clocks: base = %d, frequency = %u, prediv = %d, "
> +               "postdiv = %d, postdiv2 = %d, mul = %d\n",
> +               base, frequency, prediv, postdiv, postdiv2, mul);
> +
> +       writel(0, &clock->ctrl);
> +       writel(DIVISOR_ENABLE_MASK | ((prediv - 1) & 0x1F), &clock->prediv);
> +       writel((mul - 1) & 0xF, &clock->mul);
> +
> +       for (mul = 0; mul < 2000; mul++)
> +               ; /* nop */
> +
Only for furthering my know how, this because the timing is changing so 
you cannot msleep() or whatever?  Can we not jump straight into the 
while() instead and wait it out?  Alternatively start with a:
----
while (!readl(&clock->status) & 0x1)
	;
----

and then lead into the following?

> +       while (readl(&clock->status) & 0x1)
> +               ; /* nop */
> +
> +       writel(DIVISOR_ENABLE_MASK | ((postdiv - 1) & 0x1F), &clock->postdiv);
> +
> +       writel(readl(&clock->cmden) | 1, &clock->cmden);
> +       writel(readl(&clock->cmd) | 1, &clock->cmd);
> +
> +       while (readl(&clock->status) & 0x1)
> +               ; /* nop */
> +
> +       writel(DIVISOR_ENABLE_MASK | ((postdiv2 - 1) & 0x1F), &clock->postdiv2);
> +
> +       writel(readl(&clock->cmden) | 1, &clock->cmden);
> +       writel(readl(&clock->cmd) | 1, &clock->cmd);
> +
> +       while (readl(&clock->status) & 0x1)
> +               ; /* nop */
> +
> +       writel(readl(&clock->ctrl) | 1, &clock->ctrl);
> +}
>
> [snipped]
>
> +static void __init tnetd7200_init_clocks(void)
> +{
> +       u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> +       struct tnetd7200_clocks *clocks =
> +                                       (struct tnetd7200_clocks *)
> +                                       ioremap_nocache(AR7_REGS_POWER + 0x80,
> +                                       sizeof(struct tnetd7200_clocks));
>
casting and NULL checks?

> +int __init ar7_init_clocks(void)
> +{
> +       switch (ar7_chip_id()) {
> +       case AR7_CHIP_7100:
> +               tnetd7200_init_clocks();
> +               break;
> +       case AR7_CHIP_7200:
> +               tnetd7200_init_clocks();
> +               break;
>
Change this to the following maybe?
----
switch (ar7_chip_id()) {
case AR7_CHIP_7100:
case AR7_CHIP_7200:
	tnetd7200_init_clocks();
	break;
----

> +       case AR7_CHIP_7300:
> +               ar7_dsp_clock = tnetd7300_dsp_clock();
> +               tnetd7300_init_clocks();
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +arch_initcall(ar7_init_clocks);

> diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
>
Too late now but gpiolib is rather nice to look into at some stage.

> diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
> [snipped]
> +#include <linux/version.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/pm.h>
> +#include <linux/time.h>
> +
> +#include <asm/reboot.h>
> +#include <asm/mach-ar7/ar7.h>
> +#include <asm/mach-ar7/prom.h>
> +
> +static void ar7_machine_restart(char *command);
> +static void ar7_machine_halt(void);
> +static void ar7_machine_power_off(void);
> +
>
I don't think these are needed as you have the following in the 
'correct' order.

> +static void ar7_machine_restart(char *command)
> +{
> +       u32 *softres_reg = ioremap(AR7_REGS_RESET +
> +                                         AR7_RESET_SOFTWARE, 1);
> +       writel(1, softres_reg);
> +}
> +
> +static void ar7_machine_halt(void)
> +{
> +       while (1)
> +               ;
> +}
> +
> +static void ar7_machine_power_off(void)
> +{
> +       u32 *power_reg = (u32 *)ioremap(AR7_REGS_POWER, 1);
> +       u32 power_state = readl(power_reg) | (3 << 30);
> +       writel(power_state, power_reg);
> +       ar7_machine_halt();
> +}
>
> +const char *get_system_type(void)
> +{
> +       u16 chip_id = ar7_chip_id();
> +       switch (chip_id) {
> +       case AR7_CHIP_7300:
> +               return "TI AR7 (TNETD7300)";
> +       case AR7_CHIP_7100:
> +               return "TI AR7 (TNETD7100)";
> +       case AR7_CHIP_7200:
> +               return "TI AR7 (TNETD7200)";
> +       default:
> +               return "TI AR7 (Unknown)";
> +       }
> +}
> +
> +static int __init ar7_init_console(void)
> +{
> +       return 0;
> +}
> +console_initcall(ar7_init_console);
> +
Does this need to be called?

> +/*
> + * Initializes basic routines and structures pointers, memory size (as
> + * given by the bios and saves the command line.
> + */
> +
> +void __init plat_mem_setup(void)
> +{
> +       unsigned long io_base;
> +
> +       _machine_restart = ar7_machine_restart;
> +       _machine_halt = ar7_machine_halt;
> +       pm_power_off = ar7_machine_power_off;
> +       panic_timeout = 3;
> +
> +       io_base = (unsigned long)ioremap(AR7_REGS_BASE, 0x10000);
> +       if (!io_base)
> +               panic("Can't remap IO base!\n");
> +       set_io_port_base(io_base);
> +
>
Casting a pointer to a unsigned long...hmmmm.

> +       prom_meminit();
> +
> +       printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
> +                                       get_system_type(),
> +               ar7_chip_id(), ar7_chip_rev());
> +}
> diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
> new file mode 100644
> index 0000000..a1fba89
> --- /dev/null
> +++ b/arch/mips/ar7/time.c
> @@ -0,0 +1,30 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
> + * Setting up the clock on the MIPS boards.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/time.h>
> +
> +#include <asm/time.h>
> +#include <asm/mach-ar7/ar7.h>
> +
> +void __init plat_time_init(void)
> +{
> +       mips_hpt_frequency = ar7_cpu_freq() / 2;
> +}

> diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
> [snipped]
> +#ifndef __AR7_H__
> +#define __AR7_H__
> +
> +#include <linux/delay.h>
> +#include <asm/addrspace.h>
> +#include <linux/io.h>
> +
> +#define AR7_SDRAM_BASE 0x14000000
> +
> +#define AR7_REGS_BASE  0x08610000
> +
> +#define AR7_REGS_MAC0  (AR7_REGS_BASE + 0x0000)
> +#define AR7_REGS_GPIO  (AR7_REGS_BASE + 0x0900)
> +/* 0x08610A00 - 0x08610BFF (512 bytes, 128 bytes / clock) */
> +#define AR7_REGS_POWER (AR7_REGS_BASE + 0x0a00)
> +#define AR7_REGS_UART0 (AR7_REGS_BASE + 0x0e00)
> +#define AR7_REGS_USB   (AR7_REGS_BASE + 0x1200)
> +#define AR7_REGS_RESET (AR7_REGS_BASE + 0x1600)
> +#define AR7_REGS_VLYNQ0        (AR7_REGS_BASE + 0x1800)
> +#define AR7_REGS_DCL   (AR7_REGS_BASE + 0x1a00)
> +#define AR7_REGS_VLYNQ1        (AR7_REGS_BASE + 0x1c00)
> +#define AR7_REGS_MDIO  (AR7_REGS_BASE + 0x1e00)
> +#define AR7_REGS_IRQ   (AR7_REGS_BASE + 0x2400)
> +#define AR7_REGS_MAC1  (AR7_REGS_BASE + 0x2800)
> +
> +#define AR7_REGS_WDT   (AR7_REGS_BASE + 0x1f00)
> +#define UR8_REGS_WDT   (AR7_REGS_BASE + 0x0b00)
> +#define UR8_REGS_UART1 (AR7_REGS_BASE + 0x0f00)
> +
>
I guess it's style, but I have preferred '(<blah> | <offset>)'.  You 
might want to add a few more for unlabelled offsets such as 
"AR7_REGS_POWER + 0x80" to make things more self documenting?

> [snipped]
> +extern int ar7_cpu_clock, ar7_bus_clock, ar7_dsp_clock;
> +
> +static inline u16 ar7_chip_id(void)
> +{
> +       return readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x14)) & 0xffff;
> +}
> +
> +static inline u8 ar7_chip_rev(void)
> +{
> +       return (readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x14)) >> 16) & 0xff;
> +}
>
unneeded casting?

> [snipped]
> +
> +static inline int ar7_has_high_cpmac(void)
> +{
> +       u16 chip_id = ar7_chip_id();
> +       switch (chip_id) {
> +       case AR7_CHIP_7100:
> +       case AR7_CHIP_7200:
> +               return 0;
> +       default:
> +               return 1;
> +       }
> +}
I would probably recommend as a default to return ENXIO or EINVAL maybe?  
Then for AR7_CHIP_7300 you return 1, I'm guessing?

I have been slightly tracking the ar7 code for a while and I have to say 
it is really looking much nicer now-a-days.  Well done!  If you ever are 
in London, I'll buy you a beer.

Cheers

-- 
Alexander Clouter
.sigmonster says: Happiness is the greatest good.
