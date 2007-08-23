Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 13:32:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14492 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023765AbXHWMcb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Aug 2007 13:32:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7NCWV9u012389;
	Thu, 23 Aug 2007 13:32:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7NCWVYS012388;
	Thu, 23 Aug 2007 13:32:31 +0100
Date:	Thu, 23 Aug 2007 13:32:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	brm <brm@murphy.dk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
Message-ID: <20070823123231.GB19588@linux-mips.org>
References: <200708212034.l7LKYGiD011023@potty.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200708212034.l7LKYGiD011023@potty.localnet>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 21, 2007 at 10:34:16PM +0200, brm wrote:

Patch queued for 2.6.24 but here a few more comments.

>  drivers/mtd/maps/Kconfig                   |    6 +
>  drivers/mtd/maps/Makefile                  |    1 +
>  drivers/mtd/maps/lasat.c                   |  103 +++++++

I've stripped these from the patch.  Please submit the MTD bits to
the MTD maintainers:

MEMORY TECHNOLOGY DEVICES (MTD)
P:      David Woodhouse
M:      dwmw2@infradead.org
W:      http://www.linux-mtd.infradead.org/
L:      linux-mtd@lists.infradead.org
T:      git git://git.infradead.org/mtd-2.6.git
S:      Maintained

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 516b18d..793590b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -107,6 +107,20 @@ config MACH_JAZZ
>  	 Members include the Acer PICA, MIPS Magnum 4000, MIPS Millenium and
>  	 Olivetti M700-10 workstations.
>  
> +config LASAT
> +	bool "LASAT Networks platforms"
> +	select DMA_NONCOHERENT
> +	select SYS_HAS_EARLY_PRINTK
> +	select HW_HAS_PCI
> +	select PCI_GT64XXX_PCI0
> +	select MIPS_NILE4
> +	select R5000_CPU_SCACHE
> +	select SYS_HAS_CPU_R5000
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_64BIT_KERNEL if BROKEN
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
> +
>  config LEMOTE_FULONG
>  	bool "Lemote Fulong mini-PC"
>  	select ARCH_SPARSEMEM_ENABLE
> @@ -598,6 +612,7 @@ endchoice
>  
>  source "arch/mips/au1000/Kconfig"
>  source "arch/mips/jazz/Kconfig"
> +source "arch/mips/lasat/Kconfig"
>  source "arch/mips/pmc-sierra/Kconfig"
>  source "arch/mips/sgi-ip27/Kconfig"
>  source "arch/mips/sibyte/Kconfig"
> @@ -713,6 +728,9 @@ config MIPS_BONITO64
>  config MIPS_MSC
>  	bool
>  
> +config MIPS_NILE4
> +	bool
> +
>  config MIPS_DISABLE_OBSOLETE_IDE
>  	bool
>  
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 32c1c8f..34c39fc 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -367,6 +367,13 @@ cflags-$(CONFIG_BASLER_EXCITE)	+= -Iinclude/asm-mips/mach-excite
>  load-$(CONFIG_BASLER_EXCITE)	+= 0x80100000
>  
>  #
> +# LASAT platforms
> +#
> +core-$(CONFIG_LASAT)		+= arch/mips/lasat/
> +cflags-$(CONFIG_LASAT)		+= -Iinclude/asm-mips/mach-lasat
> +load-$(CONFIG_LASAT)		+= 0xffffffff80000000
> +
> +#
>  # Common VR41xx
>  #
>  core-$(CONFIG_MACH_VR41XX)	+= arch/mips/vr41xx/common/
> @@ -615,6 +622,11 @@ core-y			+= arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/
>  
>  drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
>  
> +ifdef CONFIG_LASAT
> +rom.bin rom.sw: vmlinux
> +	$(Q)$(MAKE) $(build)=arch/mips/lasat/image $@
> +endif
> +
>  #
>  # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
>  # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
> @@ -658,6 +670,7 @@ endif
>  
>  archclean:
>  	@$(MAKE) $(clean)=arch/mips/boot
> +	@$(MAKE) $(clean)=arch/mips/lasat
>  
>  define archhelp
>  	echo '  vmlinux.ecoff        - ECOFF boot image'
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
> +
> +config LASAT_SYSCTL
> +	bool "LASAT sysctl interface"
> +	depends on LASAT
> diff --git a/arch/mips/lasat/Makefile b/arch/mips/lasat/Makefile
> new file mode 100644
> index 0000000..9cc4e4d
> --- /dev/null
> +++ b/arch/mips/lasat/Makefile
> @@ -0,0 +1,14 @@
> +#
> +# Makefile for the LASAT specific kernel interface routines under Linux.
> +#
> +
> +obj-y	 			+= reset.o setup.o prom.o lasat_board.o \
> +				   at93c.o interrupt.o serial.o
> +
> +obj-$(CONFIG_LASAT_SYSCTL)	+= sysctl.o
> +obj-$(CONFIG_DS1603)		+= ds1603.o
> +obj-$(CONFIG_PICVUE)		+= picvue.o
> +obj-$(CONFIG_PICVUE_PROC)	+= picvue_proc.o
> +
> +clean:
> +	make -C image clean
> diff --git a/arch/mips/lasat/at93c.c b/arch/mips/lasat/at93c.c
> new file mode 100644
> index 0000000..ca26e55
> --- /dev/null
> +++ b/arch/mips/lasat/at93c.c
> @@ -0,0 +1,148 @@
> +/*
> + * Atmel AT93C46 serial eeprom driver
> + *
> + * Brian Murphy <brian.murphy@eicon.com>
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <asm/lasat/lasat.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +
> +#include "at93c.h"
> +
> +#define AT93C_ADDR_SHIFT	7
> +#define AT93C_ADDR_MAX		((1 << AT93C_ADDR_SHIFT) - 1)
> +#define AT93C_RCMD		(0x6 << AT93C_ADDR_SHIFT)
> +#define AT93C_WCMD		(0x5 << AT93C_ADDR_SHIFT)
> +#define AT93C_WENCMD		0x260
> +#define AT93C_WDSCMD		0x200
> +
> +struct at93c_defs *at93c;
> +
> +static void at93c_reg_write(u32 val)
> +{
> +	*at93c->reg = val;
> +}
> +
> +static u32 at93c_reg_read(void)
> +{
> +	u32 tmp = *at93c->reg;
> +	return tmp;
> +}
> +
> +static u32 at93c_datareg_read(void)
> +{
> +	u32 tmp = *at93c->rdata_reg;
> +	return tmp;
> +}
> +
> +static void at93c_cycle_clk(u32 data)
> +{
> +	at93c_reg_write(data | at93c->clk);
> +	lasat_ndelay(250);
> +	at93c_reg_write(data & ~at93c->clk);
> +	lasat_ndelay(250);
> +}
> +
> +static void at93c_write_databit(u8 bit)
> +{
> +	u32 data = at93c_reg_read();
> +	if (bit)
> +		data |= 1 << at93c->wdata_shift;
> +	else
> +		data &= ~(1 << at93c->wdata_shift);
> +
> +	at93c_reg_write(data);
> +	lasat_ndelay(100);
> +	at93c_cycle_clk(data);
> +}
> +
> +static unsigned int at93c_read_databit(void)
> +{
> +	u32 data;
> +
> +	at93c_cycle_clk(at93c_reg_read());
> +	data = (at93c_datareg_read() >> at93c->rdata_shift) & 1;
> +	return data;
> +}
> +
> +static u8 at93c_read_byte(void)
> +{
> +	int i;
> +	u8 data = 0;
> +
> +	for (i = 0; i<=7; i++) {
> +		data <<= 1;
> +		data |= at93c_read_databit();
> +	}
> +	return data;
> +}
> +
> +static void at93c_write_bits(u32 data, int size)
> +{
> +	int i;
> +	int shift = size - 1;
> +	u32 mask = (1 << shift);
> +
> +	for (i = 0; i < size; i++) {
> +		at93c_write_databit((data & mask) >> shift);
> +		data <<= 1;
> +	}
> +}
> +
> +static void at93c_init_op(void)
> +{
> +	at93c_reg_write((at93c_reg_read() | at93c->cs) & ~at93c->clk & ~(1 << at93c->rdata_shift));
> +	lasat_ndelay(50);
> +}
> +
> +static void at93c_end_op(void)
> +{
> +	at93c_reg_write(at93c_reg_read() & ~at93c->cs);
> +	lasat_ndelay(250);
> +}
> +
> +static void at93c_wait(void)
> +{
> +	at93c_init_op();
> +	while (!at93c_read_databit())
> +		;
> +	at93c_end_op();
> +};
> +
> +static void at93c_disable_wp(void)
> +{
> +	at93c_init_op();
> +	at93c_write_bits(AT93C_WENCMD, 10);
> +	at93c_end_op();
> +}
> +
> +static void at93c_enable_wp(void)
> +{
> +	at93c_init_op();
> +	at93c_write_bits(AT93C_WDSCMD, 10);
> +	at93c_end_op();
> +}
> +
> +u8 at93c_read(u8 addr)
> +{
> +	u8 byte;
> +	at93c_init_op();
> +	at93c_write_bits((addr & AT93C_ADDR_MAX)|AT93C_RCMD, 10);
> +	byte = at93c_read_byte();
> +	at93c_end_op();
> +	return byte;
> +}
> +
> +void at93c_write(u8 addr, u8 data)
> +{
> +	at93c_disable_wp();
> +	at93c_init_op();
> +	at93c_write_bits((addr & AT93C_ADDR_MAX)|AT93C_WCMD, 10);
> +	at93c_write_bits(data, 8);
> +	at93c_end_op();
> +	at93c_wait();
> +	at93c_enable_wp();
> +}
> diff --git a/arch/mips/lasat/at93c.h b/arch/mips/lasat/at93c.h
> new file mode 100644
> index 0000000..cfe2f99
> --- /dev/null
> +++ b/arch/mips/lasat/at93c.h
> @@ -0,0 +1,18 @@
> +/*
> + * Atmel AT93C46 serial eeprom driver
> + *
> + * Brian Murphy <brian.murphy@eicon.com>
> + *
> + */
> +
> +extern struct at93c_defs {
> +	volatile u32 *reg;
> +	volatile u32 *rdata_reg;
> +	int rdata_shift;
> +	int wdata_shift;
> +	u32 cs;
> +	u32 clk;
> +} *at93c;
> +
> +u8 at93c_read(u8 addr);
> +void at93c_write(u8 addr, u8 data);
> diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
> new file mode 100644
> index 0000000..7dced67
> --- /dev/null
> +++ b/arch/mips/lasat/ds1603.c
> @@ -0,0 +1,183 @@
> +/*
> + * Dallas Semiconductors 1603 RTC driver
> + *
> + * Brian Murphy <brian@murphy.dk>
> + *
> + */
> +#include <linux/kernel.h>
> +#include <asm/lasat/lasat.h>
> +#include <linux/delay.h>
> +#include <asm/lasat/ds1603.h>
> +#include <asm/time.h>
> +
> +#include "ds1603.h"
> +
> +#define READ_TIME_CMD 0x81
> +#define SET_TIME_CMD 0x80
> +#define TRIMMER_SET_CMD 0xC0
> +#define TRIMMER_VALUE_MASK 0x38
> +#define TRIMMER_SHIFT 3
> +
> +struct ds_defs *ds1603 = NULL;

No initializations of static variables to NULL or 0.  This makes them end
instead of .bss in .data where they will inflate the executable.

> +
> +/* HW specific register functions */
> +static void rtc_reg_write(unsigned long val)
> +{
> +	*ds1603->reg = val;
> +}
> +
> +static unsigned long rtc_reg_read(void)
> +{
> +	unsigned long tmp = *ds1603->reg;
> +	return tmp;
> +}
> +
> +static unsigned long rtc_datareg_read(void)
> +{
> +	unsigned long tmp = *ds1603->data_reg;
> +	return tmp;
> +}
> +
> +static void rtc_nrst_high(void)
> +{
> +	rtc_reg_write(rtc_reg_read() | ds1603->rst);
> +}
> +
> +static void rtc_nrst_low(void)
> +{
> +	rtc_reg_write(rtc_reg_read() & ~ds1603->rst);
> +}
> +
> +static void rtc_cycle_clock(unsigned long data)
> +{
> +	data |= ds1603->clk;
> +	rtc_reg_write(data);
> +	lasat_ndelay(250);
> +	if (ds1603->data_reversed)
> +		data &= ~ds1603->data;
> +	else
> +		data |= ds1603->data;
> +	data &= ~ds1603->clk;
> +	rtc_reg_write(data);
> +	lasat_ndelay(250 + ds1603->huge_delay);
> +}
> +
> +static void rtc_write_databit(unsigned int bit)
> +{
> +	unsigned long data = rtc_reg_read();
> +	if (ds1603->data_reversed)
> +		bit = !bit;
> +	if (bit)
> +		data |= ds1603->data;
> +	else
> +		data &= ~ds1603->data;
> +
> +	rtc_reg_write(data);
> +	lasat_ndelay(50 + ds1603->huge_delay);
> +	rtc_cycle_clock(data);
> +}
> +
> +static unsigned int rtc_read_databit(void)
> +{
> +	unsigned int data;
> +
> +	data = (rtc_datareg_read() & (1 << ds1603->data_read_shift))
> +		>> ds1603->data_read_shift;
> +	rtc_cycle_clock(rtc_reg_read());
> +	return data;
> +}
> +
> +static void rtc_write_byte(unsigned int byte)
> +{
> +	int i;
> +
> +	for (i = 0; i<=7; i++) {
> +		rtc_write_databit(byte & 1L);
> +		byte >>= 1;
> +	}
> +}
> +
> +static void rtc_write_word(unsigned long word)
> +{
> +	int i;
> +
> +	for (i = 0; i<=31; i++) {
> +		rtc_write_databit(word & 1L);
> +		word >>= 1;
> +	}
> +}
> +
> +static unsigned long rtc_read_word(void)
> +{
> +	int i;
> +	unsigned long word = 0;
> +	unsigned long shift = 0;
> +
> +	for (i = 0; i<=31; i++) {
> +		word |= rtc_read_databit() << shift;
> +		shift++;
> +	}
> +	return word;
> +}
> +
> +static void rtc_init_op(void)
> +{
> +	rtc_nrst_high();
> +
> +	rtc_reg_write(rtc_reg_read() & ~ds1603->clk);
> +
> +	lasat_ndelay(50);
> +}
> +
> +static void rtc_end_op(void)
> +{
> +	rtc_nrst_low();
> +	lasat_ndelay(1000);
> +}
> +
> +/* interface */
> +unsigned long ds1603_read(void)
> +{
> +	unsigned long word;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtc_lock, flags);
> +	rtc_init_op();
> +	rtc_write_byte(READ_TIME_CMD);
> +	word = rtc_read_word();
> +	rtc_end_op();
> +	spin_unlock_irqrestore(&rtc_lock, flags);
> +	return word;
> +}
> +
> +int ds1603_set(unsigned long time)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtc_lock, flags);
> +	rtc_init_op();
> +	rtc_write_byte(SET_TIME_CMD);
> +	rtc_write_word(time);
> +	rtc_end_op();
> +	spin_unlock_irqrestore(&rtc_lock, flags);
> +
> +	return 0;
> +}
> +
> +void ds1603_set_trimmer(unsigned int trimval)
> +{
> +	rtc_init_op();
> +	rtc_write_byte(((trimval << TRIMMER_SHIFT) & TRIMMER_VALUE_MASK)
> +			| (TRIMMER_SET_CMD));
> +	rtc_end_op();
> +}
> +
> +void ds1603_disable(void)
> +{
> +	ds1603_set_trimmer(TRIMMER_DISABLE_RTC);
> +}
> +
> +void ds1603_enable(void)
> +{
> +	ds1603_set_trimmer(TRIMMER_DEFAULT);
> +}
> diff --git a/arch/mips/lasat/ds1603.h b/arch/mips/lasat/ds1603.h
> new file mode 100644
> index 0000000..c2e5c76
> --- /dev/null
> +++ b/arch/mips/lasat/ds1603.h
> @@ -0,0 +1,33 @@
> +/*
> + * Dallas Semiconductors 1603 RTC driver
> + *
> + * Brian Murphy <brian@murphy.dk>
> + *
> + */
> +#ifndef __DS1603_H
> +#define __DS1603_H
> +
> +struct ds_defs {
> +	volatile u32 *reg;
> +	volatile u32 *data_reg;
> +	u32 rst;
> +	u32 clk;
> +	u32 data;
> +	u32 data_read_shift;
> +	char data_reversed;
> +	u32 huge_delay;
> +};
> +
> +extern struct ds_defs *ds1603;
> +
> +unsigned long ds1603_read(void);
> +int ds1603_set(unsigned long);
> +void ds1603_set_trimmer(unsigned int);
> +void ds1603_enable(void);
> +void ds1603_disable(void);
> +void ds1603_init(struct ds_defs *);
> +
> +#define TRIMMER_DEFAULT	3
> +#define TRIMMER_DISABLE_RTC 0
> +
> +#endif
> diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
> new file mode 100644
> index 0000000..5332449
> --- /dev/null
> +++ b/arch/mips/lasat/image/Makefile
> @@ -0,0 +1,54 @@
> +#
> +# MAKEFILE FOR THE MIPS LINUX BOOTLOADER AND ROM DEBUGGER
> +#
> +# i-data Networks
> +#
> +# Author: Thomas Horsten <thh@i-data.com>
> +#
> +
> +ifndef Version
> + Version = "$(USER)-test"
> +endif
> +
> +MKLASATIMG = mklasatimg
> +MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
> +KERNEL_IMAGE = $(TOPDIR)/vmlinux
> +KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
> +KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
> +
> +LDSCRIPT= -L$(obj) -Tromscript.normal
> +
> +HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
> +		-D_kernel_entry=0x$(KERNEL_ENTRY) \
> +		-D VERSION="\"$(Version)\"" \
> +		-D TIMESTAMP=$(shell date +%s)
> +
> +$(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
> +	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
> +
> +OBJECTS = head.o kImage.o
> +
> +rom.sw:	$(obj)/rom.sw
> +rom.bin:	$(obj)/rom.bin
> +
> +$(obj)/rom.sw:	$(obj)/rom.bin
> +	$(MKLASATIMG) -o $@ -k $^ -m $(MKLASATIMG_ARCH)
> +
> +$(obj)/rom.bin: $(obj)/rom
> +	$(OBJCOPY) -O binary -S $^ $@
> +
> +# Rule to make the bootloader
> +$(obj)/rom: $(addprefix $(obj)/,$(OBJECTS))
> +	$(LD) $(LDFLAGS) $(LDSCRIPT) -o $@ $^
> +
> +$(obj)/%.o: $(obj)/%.gz
> +	$(LD) -r -o $@ -b binary $<
> +
> +$(obj)/%.gz: $(obj)/%.bin
> +	gzip -cf -9 $< > $@
> +
> +$(obj)/kImage.bin: $(KERNEL_IMAGE)
> +	$(OBJCOPY) -O binary -S $^ $@
> +
> +clean:
> +	rm -f rom rom.bin rom.sw kImage.bin kImage.o
> diff --git a/arch/mips/lasat/image/head.S b/arch/mips/lasat/image/head.S
> new file mode 100644
> index 0000000..efb95f2
> --- /dev/null
> +++ b/arch/mips/lasat/image/head.S
> @@ -0,0 +1,31 @@
> +#include <asm/lasat/head.h>
> +
> +	.text
> +	.section .text.start, "ax"
> +	.set noreorder
> +	.set mips3
> +
> +	/* Magic words identifying a software image */
> +	.word	LASAT_K_MAGIC0_VAL
> +	.word 	LASAT_K_MAGIC1_VAL
> +
> +	/* Image header version */
> +	.word	0x00000002
> +
> +	/* image start and size */
> +	.word	_image_start
> +	.word	_image_size
> +
> +	/* start of kernel and entrypoint in uncompressed image */
> +	.word	_kernel_start
> +	.word	_kernel_entry
> +
> +	/* Here we have room for future flags */
> +
> +	.org	0x40
> +reldate:
> +	.word	TIMESTAMP
> +
> +	.org	0x50
> +release:
> +	.string VERSION
> diff --git a/arch/mips/lasat/image/romscript.normal b/arch/mips/lasat/image/romscript.normal
> new file mode 100644
> index 0000000..988f8ad
> --- /dev/null
> +++ b/arch/mips/lasat/image/romscript.normal
> @@ -0,0 +1,23 @@
> +OUTPUT_ARCH(mips)
> +
> +SECTIONS
> +{
> +  .text :
> +  {
> +    *(.text.start)
> +  }
> +
> +  /* Data in ROM */
> +
> +  .data ALIGN(0x10) :
> +  {
> +    *(.data)
> +  }
> +  _image_start = ADDR(.data);
> +  _image_size = SIZEOF(.data);
> +
> +  .other :
> +  {
> +    *(.*)
> +  }
> +}
> diff --git a/arch/mips/lasat/interrupt.c b/arch/mips/lasat/interrupt.c
> new file mode 100644
> index 0000000..9a622b9
> --- /dev/null
> +++ b/arch/mips/lasat/interrupt.c
> @@ -0,0 +1,130 @@
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
> + * Routines for generic manipulation of the interrupts found on the
> + * Lasat boards.
> + */
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel_stat.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/irq.h>
> +#include <asm/lasat/lasatint.h>
> +#include <asm/time.h>
> +#include <asm/gdb-stub.h>
> +
> +static volatile int *lasat_int_status = NULL;
> +static volatile int *lasat_int_mask = NULL;
> +static volatile int lasat_int_mask_shift;
> +
> +void disable_lasat_irq(unsigned int irq_nr)
> +{
> +	*lasat_int_mask &= ~(1 << irq_nr) << lasat_int_mask_shift;
> +}
> +
> +void enable_lasat_irq(unsigned int irq_nr)
> +{
> +	*lasat_int_mask |= (1 << irq_nr) << lasat_int_mask_shift;
> +}
> +
> +static struct irq_chip lasat_irq_type = {
> +	.name = "Lasat",
> +	.ack = disable_lasat_irq,
> +	.mask = disable_lasat_irq,
> +	.mask_ack = disable_lasat_irq,
> +	.unmask = enable_lasat_irq,
> +};
> +
> +static inline int ls1bit32(unsigned int x)
> +{
> +	int b = 31, s;
> +
> +	s = 16; if (x << 16 == 0) s = 0; b -= s; x <<= s;
> +	s =  8; if (x <<  8 == 0) s = 0; b -= s; x <<= s;
> +	s =  4; if (x <<  4 == 0) s = 0; b -= s; x <<= s;
> +	s =  2; if (x <<  2 == 0) s = 0; b -= s; x <<= s;
> +	s =  1; if (x <<  1 == 0) s = 0; b -= s;
> +
> +	return b;
> +}
> +
> +static unsigned long (* get_int_status)(void);
> +
> +static unsigned long get_int_status_100(void)
> +{
> +	return *lasat_int_status & *lasat_int_mask;
> +}
> +
> +static unsigned long get_int_status_200(void)
> +{
> +	unsigned long int_status;
> +
> +	int_status = *lasat_int_status;
> +	int_status &= (int_status >> LASATINT_MASK_SHIFT_200) & 0xffff;
> +	return int_status;
> +}
> +
> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned long int_status;
> +	unsigned int cause = read_c0_cause();
> +	int irq;
> +
> +	if (cause & CAUSEF_IP7) {	/* R4000 count / compare IRQ */
> +		ll_timer_interrupt(7);
> +		return;
> +	}
> +
> +	int_status = get_int_status();
> +
> +	/* if int_status == 0, then the interrupt has already been cleared */
> +	if (int_status) {
> +		irq = ls1bit32(int_status);
> +
> +		do_IRQ(irq);
> +	}
> +}
> +
> +void __init arch_init_irq(void)
> +{
> +	int i;
> +
> +	switch (mips_machtype) {
> +	case MACH_LASAT_100:
> +		lasat_int_status = (void *)LASAT_INT_STATUS_REG_100;
> +		lasat_int_mask = (void *)LASAT_INT_MASK_REG_100;
> +		lasat_int_mask_shift = LASATINT_MASK_SHIFT_100;
> +		get_int_status = get_int_status_100;
> +		*lasat_int_mask = 0;
> +		break;
> +	case MACH_LASAT_200:
> +		lasat_int_status = (void *)LASAT_INT_STATUS_REG_200;
> +		lasat_int_mask = (void *)LASAT_INT_MASK_REG_200;
> +		lasat_int_mask_shift = LASATINT_MASK_SHIFT_200;
> +		get_int_status = get_int_status_200;
> +		*lasat_int_mask &= 0xffff;
> +		break;
> +	default:
> +		panic("arch_init_irq: mips_machtype incorrect");
> +	}
> +
> +	for (i = 0; i <= LASATINT_END; i++)
> +		set_irq_chip_and_handler(i, &lasat_irq_type, handle_level_irq);
> +}
> diff --git a/arch/mips/lasat/lasat_board.c b/arch/mips/lasat/lasat_board.c
> new file mode 100644
> index 0000000..fbe9a87
> --- /dev/null
> +++ b/arch/mips/lasat/lasat_board.c
> @@ -0,0 +1,279 @@
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
> + * Routines specific to the LASAT boards
> + */
> +#include <linux/types.h>
> +#include <linux/crc32.h>
> +#include <asm/lasat/lasat.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/ctype.h>
> +#include <asm/bootinfo.h>
> +#include <asm/addrspace.h>
> +#include "at93c.h"
> +/* New model description table */
> +#include "lasat_models.h"
> +
> +#define EEPROM_CRC(data, len) (~0 ^ crc32(~0, data, len))

Complicated method for ~crc32(~0, data, len)?

> +
> +struct lasat_info lasat_board_info;
> +
> +void update_bcastaddr(void);
> +
> +int EEPROMRead(unsigned int pos, unsigned char *data, int len)
> +{
> +	int i;
> +
> +	for (i=0; i<len; i++)
> +		*data++ = at93c_read(pos++);
> +
> +	return 0;
> +}
> +int EEPROMWrite(unsigned int pos, unsigned char *data, int len)
> +{
> +	int i;
> +
> +	for (i=0; i<len; i++)
> +		at93c_write(pos++, *data++);
> +
> +	return 0;
> +}
> +
> +static void init_flash_sizes(void)
> +{
> +	int i;
> +	unsigned long *lb = lasat_board_info.li_flashpart_base;
> +	unsigned long *ls = lasat_board_info.li_flashpart_size;
> +
> +	ls[LASAT_MTD_BOOTLOADER] = 0x40000;
> +	ls[LASAT_MTD_SERVICE] = 0xC0000;
> +	ls[LASAT_MTD_NORMAL] = 0x100000;
> +
> +	if (mips_machtype == MACH_LASAT_100) {
> +		lasat_board_info.li_flash_base = 0x1e000000;
> +
> +		lb[LASAT_MTD_BOOTLOADER] = 0x1e400000;
> +
> +		if (lasat_board_info.li_flash_size > 0x200000) {
> +			ls[LASAT_MTD_CONFIG] = 0x100000;
> +			ls[LASAT_MTD_FS] = 0x500000;
> +		}
> +	} else {
> +		lasat_board_info.li_flash_base = 0x10000000;
> +
> +		if (lasat_board_info.li_flash_size < 0x1000000) {
> +			lb[LASAT_MTD_BOOTLOADER] = 0x10000000;
> +			ls[LASAT_MTD_CONFIG] = 0x100000;
> +			if (lasat_board_info.li_flash_size >= 0x400000) {
> +				ls[LASAT_MTD_FS] = lasat_board_info.li_flash_size - 0x300000;
> +			}
> +		}
> +	}
> +
> +	for (i = 1; i < LASAT_MTD_LAST; i++)
> +		lb[i] = lb[i-1] + ls[i-1];
> +}
> +
> +int lasat_init_board_info(void)
> +{
> +	int c;
> +	unsigned long crc;
> +	unsigned long cfg0, cfg1;
> +	const product_info_t   *ppi;
> +	int i_n_base_models = N_BASE_MODELS;
> +	const char * const * i_txt_base_models = txt_base_models;
> +	int i_n_prids = N_PRIDS;
> +
> +	memset(&lasat_board_info, 0, sizeof(lasat_board_info));
> +
> +	/* First read the EEPROM info */
> +	EEPROMRead(0, (unsigned char *)&lasat_board_info.li_eeprom_info,
> +		   sizeof(struct lasat_eeprom_struct));
> +
> +	/* Check the CRC */
> +	crc = EEPROM_CRC((unsigned char *)(&lasat_board_info.li_eeprom_info),
> +		    sizeof(struct lasat_eeprom_struct) - 4);
> +
> +	if (crc != lasat_board_info.li_eeprom_info.crc32) {
> +		printk(KERN_WARNING "WARNING...\nWARNING...\nEEPROM CRC does "
> +		       "not match calculated, attempting to soldier on...\n");
> +	}
> +
> +	if (lasat_board_info.li_eeprom_info.version != LASAT_EEPROM_VERSION) {
> +		printk(KERN_WARNING "WARNING...\nWARNING...\nEEPROM version "
> +		       "%d, wanted version %d, attempting to soldier on...\n",
> +		       (unsigned int)lasat_board_info.li_eeprom_info.version,
> +		       LASAT_EEPROM_VERSION);
> +	}
> +
> +	cfg0 = lasat_board_info.li_eeprom_info.cfg[0];
> +	cfg1 = lasat_board_info.li_eeprom_info.cfg[1];
> +
> +	if ( LASAT_W0_DSCTYPE(cfg0) != 1) {
> +		printk(KERN_WARNING "WARNING...\nWARNING...\n"
> +		       "Invalid configuration read from EEPROM, attempting to "
> +		       "soldier on...");
> +	}
> +	/* We have a valid configuration */
> +
> +	switch (LASAT_W0_SDRAMBANKSZ(cfg0)) {
> +	case 0:
> +		lasat_board_info.li_memsize = 0x0800000;
> +		break;
> +	case 1:
> +		lasat_board_info.li_memsize = 0x1000000;
> +		break;
> +	case 2:
> +		lasat_board_info.li_memsize = 0x2000000;
> +		break;
> +	case 3:
> +		lasat_board_info.li_memsize = 0x4000000;
> +		break;
> +	case 4:
> +		lasat_board_info.li_memsize = 0x8000000;
> +		break;
> +	default:
> +		lasat_board_info.li_memsize = 0;
> +	}
> +
> +	switch (LASAT_W0_SDRAMBANKS(cfg0)) {
> +	case 0:
> +		break;
> +	case 1:
> +		lasat_board_info.li_memsize *= 2;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (LASAT_W0_BUSSPEED(cfg0)) {
> +	case 0x0:
> +		lasat_board_info.li_bus_hz = 60000000;
> +		break;
> +	case 0x1:
> +		lasat_board_info.li_bus_hz = 66000000;
> +		break;
> +	case 0x2:
> +		lasat_board_info.li_bus_hz = 66666667;
> +		break;
> +	case 0x3:
> +		lasat_board_info.li_bus_hz = 80000000;
> +		break;
> +	case 0x4:
> +		lasat_board_info.li_bus_hz = 83333333;
> +		break;
> +	case 0x5:
> +		lasat_board_info.li_bus_hz = 100000000;
> +		break;
> +	}
> +
> +	switch (LASAT_W0_CPUCLK(cfg0)) {
> +	case 0x0:
> +		lasat_board_info.li_cpu_hz =
> +			lasat_board_info.li_bus_hz;
> +		break;
> +	case 0x1:
> +		lasat_board_info.li_cpu_hz =
> +			lasat_board_info.li_bus_hz +
> +			(lasat_board_info.li_bus_hz >> 1);
> +		break;
> +	case 0x2:
> +		lasat_board_info.li_cpu_hz =
> +			lasat_board_info.li_bus_hz +
> +			lasat_board_info.li_bus_hz;
> +		break;
> +	case 0x3:
> +		lasat_board_info.li_cpu_hz =
> +			lasat_board_info.li_bus_hz +
> +			lasat_board_info.li_bus_hz +
> +			(lasat_board_info.li_bus_hz >> 1);
> +		break;
> +	case 0x4:
> +		lasat_board_info.li_cpu_hz =
> +			lasat_board_info.li_bus_hz +
> +			lasat_board_info.li_bus_hz +
> +			lasat_board_info.li_bus_hz;
> +		break;
> +	}
> +
> +	/* Flash size */
> +	switch (LASAT_W1_FLASHSIZE(cfg1)) {
> +	case 0:
> +		lasat_board_info.li_flash_size = 0x200000;
> +		break;
> +	case 1:
> +		lasat_board_info.li_flash_size = 0x400000;
> +		break;
> +	case 2:
> +		lasat_board_info.li_flash_size = 0x800000;
> +		break;
> +	case 3:
> +		lasat_board_info.li_flash_size = 0x1000000;
> +		break;
> +	case 4:
> +		lasat_board_info.li_flash_size = 0x2000000;
> +		break;
> +	}
> +
> +	init_flash_sizes();
> +
> +	lasat_board_info.li_bmid = LASAT_W0_BMID(cfg0);
> +	lasat_board_info.li_prid = lasat_board_info.li_eeprom_info.prid;
> +	if (lasat_board_info.li_prid == 0xffff || lasat_board_info.li_prid == 0)
> +		lasat_board_info.li_prid = lasat_board_info.li_bmid;
> +
> +	/* Base model stuff */
> +	if (lasat_board_info.li_bmid > i_n_base_models)
> +		lasat_board_info.li_bmid = i_n_base_models;
> +	strcpy(lasat_board_info.li_bmstr, i_txt_base_models[lasat_board_info.li_bmid]);
> +
> +	/* Product ID dependent values */
> +	c = lasat_board_info.li_prid;
> +	if (c >= i_n_prids) {
> +		strcpy(lasat_board_info.li_namestr, "Unknown Model");
> +		strcpy(lasat_board_info.li_typestr, "Unknown Type");
> +	} else {
> +		ppi = &vendor_info_table[0].vi_product_info[c];
> +		strcpy(lasat_board_info.li_namestr, ppi->pi_name);
> +		if (ppi->pi_type)
> +			strcpy(lasat_board_info.li_typestr, ppi->pi_type);
> +		else
> +			sprintf(lasat_board_info.li_typestr, "%d",10*c);
> +	}
> +
> +#if defined(CONFIG_INET) && defined(CONFIG_SYSCTL)
> +	update_bcastaddr();
> +#endif
> +
> +	return 0;
> +}
> +
> +void lasat_write_eeprom_info(void)
> +{
> +	unsigned long crc;
> +
> +	/* Generate the CRC */
> +	crc = EEPROM_CRC((unsigned char *)(&lasat_board_info.li_eeprom_info),
> +		    sizeof(struct lasat_eeprom_struct) - 4);
> +	lasat_board_info.li_eeprom_info.crc32 = crc;
> +
> +	/* Write the EEPROM info */
> +	EEPROMWrite(0, (unsigned char *)&lasat_board_info.li_eeprom_info,
> +		    sizeof(struct lasat_eeprom_struct));
> +}
> +
> diff --git a/arch/mips/lasat/lasat_models.h b/arch/mips/lasat/lasat_models.h
> new file mode 100644
> index 0000000..ae0c5d0
> --- /dev/null
> +++ b/arch/mips/lasat/lasat_models.h
> @@ -0,0 +1,63 @@
> +/*
> + * Model description tables
> + */
> +
> +typedef struct product_info_t {

No typdefs.

> +	const char     *pi_name;
> +	const char     *pi_type;
> +} product_info_t;
> +
> +typedef struct vendor_info_t {
> +	const char     *vi_name;
> +	const product_info_t *vi_product_info;
> +} vendor_info_t;
> +
> +/*
> + * Base models
> + */
> +static const char * const txt_base_models[] = {
> +  "MQ 2", "MQ Pro", "SP 25", "SP 50", "SP 100", "SP 5000", "SP 7000", "SP 1000", "Unknown"
> +};
> +#define N_BASE_MODELS (sizeof(txt_base_models)/sizeof(char*)-1)
> +
> +/*
> + * Eicon Networks
> + */
> +static const char txt_en_mq[] = "Masquerade";
> +static const char txt_en_sp[] = "Safepipe";
> +
> +static const product_info_t product_info_eicon[] = {
> +  { txt_en_mq, "II"   }, /*  0 */
> +  { txt_en_mq, "Pro"  }, /*  1 */
> +  { txt_en_sp, "25"   }, /*  2 */
> +  { txt_en_sp, "50"   }, /*  3 */
> +  { txt_en_sp, "100"  }, /*  4 */
> +  { txt_en_sp, "5000" }, /*  5 */
> +  { txt_en_sp, "7000" }, /*  6 */
> +  { txt_en_sp, "30"   }, /*  7 */
> +  { txt_en_sp, "5100" }, /*  8 */
> +  { txt_en_sp, "7100" }, /*  9 */
> +  { txt_en_sp, "1110" }, /* 10 */
> +  { txt_en_sp, "3020" }, /* 11 */
> +  { txt_en_sp, "3030" }, /* 12 */
> +  { txt_en_sp, "5020" }, /* 13 */
> +  { txt_en_sp, "5030" }, /* 14 */
> +  { txt_en_sp, "1120" }, /* 15 */
> +  { txt_en_sp, "1130" }, /* 16 */
> +  { txt_en_sp, "6010" }, /* 17 */
> +  { txt_en_sp, "6110" }, /* 18 */
> +  { txt_en_sp, "6210" }, /* 19 */
> +  { txt_en_sp, "1020" }, /* 20 */
> +  { txt_en_sp, "1040" }, /* 21 */
> +  { txt_en_sp, "1050" }, /* 22 */
> +  { txt_en_sp, "1060" }, /* 23 */
> +};
> +#define N_PRIDS (sizeof(product_info_eicon)/sizeof(product_info_t))
> +
> +/*
> + * The vendor table
> + */
> +static vendor_info_t const vendor_info_table[] = {
> +  { "Eicon Networks",	product_info_eicon   },
> +};
> +#define N_VENDORS (sizeof(vendor_info_table)/sizeof(vendor_info_t))
> diff --git a/arch/mips/lasat/picvue.c b/arch/mips/lasat/picvue.c
> new file mode 100644
> index 0000000..9ae82c3
> --- /dev/null
> +++ b/arch/mips/lasat/picvue.c
> @@ -0,0 +1,240 @@
> +/*
> + * Picvue PVC160206 display driver
> + *
> + * Brian Murphy <brian@murphy.dk>
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <asm/bootinfo.h>
> +#include <asm/lasat/lasat.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +
> +#include "picvue.h"
> +
> +#define PVC_BUSY		0x80
> +#define PVC_NLINES		2
> +#define PVC_DISPMEM		80
> +#define PVC_LINELEN		PVC_DISPMEM / PVC_NLINES
> +
> +struct pvc_defs *picvue = NULL;
> +
> +DECLARE_MUTEX(pvc_sem);
> +
> +static void pvc_reg_write(u32 val)
> +{
> +	*picvue->reg = val;
> +}
> +
> +static u32 pvc_reg_read(void)
> +{
> +	u32 tmp = *picvue->reg;
> +	return tmp;
> +}
> +
> +static void pvc_write_byte(u32 data, u8 byte)
> +{
> +	data |= picvue->e;
> +	pvc_reg_write(data);
> +	data &= ~picvue->data_mask;
> +	data |= byte << picvue->data_shift;
> +	pvc_reg_write(data);
> +	ndelay(220);
> +	pvc_reg_write(data & ~picvue->e);
> +	ndelay(220);
> +}
> +
> +static u8 pvc_read_byte(u32 data)
> +{
> +	u8 byte;
> +
> +	data |= picvue->e;
> +	pvc_reg_write(data);
> +	ndelay(220);
> +	byte = (pvc_reg_read() & picvue->data_mask) >> picvue->data_shift;
> +	data &= ~picvue->e;
> +	pvc_reg_write(data);
> +	ndelay(220);
> +	return byte;
> +}
> +
> +static u8 pvc_read_data(void)
> +{
> +	u32 data = pvc_reg_read();
> +	u8 byte;
> +	data |= picvue->rw;
> +	data &= ~picvue->rs;
> +	pvc_reg_write(data);
> +	ndelay(40);
> +	byte = pvc_read_byte(data);
> +	data |= picvue->rs;
> +	pvc_reg_write(data);
> +	return byte;
> +}
> +
> +#define TIMEOUT 1000
> +static int pvc_wait(void)
> +{
> +	int i = TIMEOUT;
> +	int err = 0;
> +
> +	while ((pvc_read_data() & PVC_BUSY) && i)
> +		i--;
> +	if (i == 0)
> +		err = -ETIME;
> +
> +	return err;
> +}
> +
> +#define MODE_INST 0
> +#define MODE_DATA 1
> +static void pvc_write(u8 byte, int mode)
> +{
> +	u32 data = pvc_reg_read();
> +	data &= ~picvue->rw;
> +	if (mode == MODE_DATA)
> +		data |= picvue->rs;
> +	else
> +		data &= ~picvue->rs;
> +	pvc_reg_write(data);
> +	ndelay(40);
> +	pvc_write_byte(data, byte);
> +	if (mode == MODE_DATA)
> +		data &= ~picvue->rs;
> +	else
> +		data |= picvue->rs;
> +	pvc_reg_write(data);
> +	pvc_wait();
> +}
> +
> +void pvc_write_string(const unsigned char *str, u8 addr, int line)
> +{
> +	int i = 0;
> +
> +	if (line > 0 && (PVC_NLINES > 1))
> +		addr += 0x40 * line;
> +	pvc_write(0x80 | addr, MODE_INST);
> +
> +	while (*str != 0 && i < PVC_LINELEN) {
> +		pvc_write(*str++, MODE_DATA);
> +		i++;
> +	}
> +}
> +
> +void pvc_write_string_centered(const unsigned char *str, int line)
> +{
> +	int len = strlen(str);
> +	u8 addr;
> +
> +	if (len > PVC_VISIBLE_CHARS)
> +		addr = 0;
> +	else
> +		addr = (PVC_VISIBLE_CHARS - strlen(str))/2;
> +
> +	pvc_write_string(str, addr, line);
> +}
> +
> +void pvc_dump_string(const unsigned char *str)
> +{
> +	int len = strlen(str);
> +
> +	pvc_write_string(str, 0, 0);
> +	if (len > PVC_VISIBLE_CHARS)
> +		pvc_write_string(&str[PVC_VISIBLE_CHARS], 0, 1);
> +}
> +
> +#define BM_SIZE			8
> +#define MAX_PROGRAMMABLE_CHARS	8
> +int pvc_program_cg(int charnum, u8 bitmap[BM_SIZE])
> +{
> +	int i;
> +	int addr;
> +
> +	if (charnum > MAX_PROGRAMMABLE_CHARS)
> +		return -ENOENT;
> +
> +	addr = charnum * 8;
> +	pvc_write(0x40 | addr, MODE_INST);
> +
> +	for (i=0; i<BM_SIZE; i++)
> +		pvc_write(bitmap[i], MODE_DATA);
> +	return 0;
> +}
> +
> +#define FUNC_SET_CMD	0x20
> +#define  EIGHT_BYTE	(1 << 4)
> +#define  FOUR_BYTE	0
> +#define  TWO_LINES	(1 << 3)
> +#define  ONE_LINE	0
> +#define  LARGE_FONT	(1 << 2)
> +#define  SMALL_FONT	0
> +static void pvc_funcset(u8 cmd)
> +{
> +	pvc_write(FUNC_SET_CMD | (cmd & (EIGHT_BYTE|TWO_LINES|LARGE_FONT)), MODE_INST);
> +}
> +
> +#define ENTRYMODE_CMD		0x4
> +#define  AUTO_INC		(1 << 1)
> +#define  AUTO_DEC		0
> +#define  CURSOR_FOLLOWS_DISP	(1 << 0)
> +static void pvc_entrymode(u8 cmd)
> +{
> +	pvc_write(ENTRYMODE_CMD | (cmd & (AUTO_INC|CURSOR_FOLLOWS_DISP)), MODE_INST);
> +}
> +
> +#define DISP_CNT_CMD	0x08
> +#define  DISP_OFF	0
> +#define  DISP_ON	(1 << 2)
> +#define  CUR_ON		(1 << 1)
> +#define  CUR_BLINK	(1 << 0)
> +void pvc_dispcnt(u8 cmd)
> +{
> +	pvc_write(DISP_CNT_CMD | (cmd & (DISP_ON|CUR_ON|CUR_BLINK)), MODE_INST);
> +}
> +
> +#define MOVE_CMD	0x10
> +#define  DISPLAY	(1 << 3)
> +#define  CURSOR		0
> +#define  RIGHT		(1 << 2)
> +#define  LEFT		0
> +void pvc_move(u8 cmd)
> +{
> +	pvc_write(MOVE_CMD | (cmd & (DISPLAY|RIGHT)), MODE_INST);
> +}
> +
> +#define CLEAR_CMD	0x1
> +void pvc_clear(void)
> +{
> +	pvc_write(CLEAR_CMD, MODE_INST);
> +}
> +
> +#define HOME_CMD	0x2
> +void pvc_home(void)
> +{
> +	pvc_write(HOME_CMD, MODE_INST);
> +}
> +
> +int pvc_init(void)
> +{
> +	u8 cmd = EIGHT_BYTE;
> +
> +	if (PVC_NLINES == 2)
> +		cmd |= (SMALL_FONT|TWO_LINES);
> +	else
> +		cmd |= (LARGE_FONT|ONE_LINE);
> +	pvc_funcset(cmd);
> +	pvc_dispcnt(DISP_ON);
> +	pvc_entrymode(AUTO_INC);
> +
> +	pvc_clear();
> +	pvc_write_string_centered("Display", 0);
> +	pvc_write_string_centered("Initialized", 1);
> +
> +	return 0;
> +}
> +
> +module_init(pvc_init);
> +MODULE_LICENSE("GPL");
> diff --git a/arch/mips/lasat/picvue.h b/arch/mips/lasat/picvue.h
> new file mode 100644
> index 0000000..2a96bf9
> --- /dev/null
> +++ b/arch/mips/lasat/picvue.h
> @@ -0,0 +1,48 @@
> +/*
> + * Picvue PVC160206 display driver
> + *
> + * Brian Murphy <brian.murphy@eicon.com>
> + *
> + */
> +#include <asm/semaphore.h>
> +
> +struct pvc_defs {
> +	volatile u32 *reg;
> +	u32 data_shift;
> +	u32 data_mask;
> +	u32 e;
> +	u32 rw;
> +	u32 rs;
> +};
> +
> +extern struct pvc_defs *picvue;
> +
> +#define PVC_NLINES		2
> +#define PVC_DISPMEM		80
> +#define PVC_LINELEN		PVC_DISPMEM / PVC_NLINES
> +#define PVC_VISIBLE_CHARS	16
> +
> +void pvc_write_string(const unsigned char *str, u8 addr, int line);
> +void pvc_write_string_centered(const unsigned char *str, int line);
> +void pvc_dump_string(const unsigned char *str);
> +
> +#define BM_SIZE			8
> +#define MAX_PROGRAMMABLE_CHARS	8
> +int pvc_program_cg(int charnum, u8 bitmap[BM_SIZE]);
> +
> +void pvc_dispcnt(u8 cmd);
> +#define  DISP_OFF	0
> +#define  DISP_ON	(1 << 2)
> +#define  CUR_ON		(1 << 1)
> +#define  CUR_BLINK	(1 << 0)
> +
> +void pvc_move(u8 cmd);
> +#define  DISPLAY	(1 << 3)
> +#define  CURSOR		0
> +#define  RIGHT		(1 << 2)
> +#define  LEFT		0
> +
> +void pvc_clear(void);
> +void pvc_home(void);
> +
> +extern struct semaphore pvc_sem;
> diff --git a/arch/mips/lasat/picvue_proc.c b/arch/mips/lasat/picvue_proc.c
> new file mode 100644
> index 0000000..cce7cdd
> --- /dev/null
> +++ b/arch/mips/lasat/picvue_proc.c
> @@ -0,0 +1,186 @@
> +/*
> + * Picvue PVC160206 display driver
> + *
> + * Brian Murphy <brian.murphy@eicon.com>
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +
> +#include <linux/proc_fs.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/timer.h>
> +
> +#include "picvue.h"
> +
> +static char pvc_lines[PVC_NLINES][PVC_LINELEN+1];
> +static int pvc_linedata[PVC_NLINES];
> +static struct proc_dir_entry *pvc_display_dir;
> +static char *pvc_linename[PVC_NLINES] = {"line1", "line2"};
> +#define DISPLAY_DIR_NAME "display"
> +static int scroll_dir = 0, scroll_interval = 0;
> +
> +static struct timer_list timer;
> +
> +static void pvc_display(unsigned long data) {
> +	int i;
> +
> +	pvc_clear();
> +	for (i=0; i<PVC_NLINES; i++)
> +		pvc_write_string(pvc_lines[i], 0, i);
> +}
> +
> +static DECLARE_TASKLET(pvc_display_tasklet, &pvc_display, 0);
> +
> +static int pvc_proc_read_line(char *page, char **start,
> +                             off_t off, int count,
> +                             int *eof, void *data)
> +{
> +        char *origpage = page;

Plenty of places were doing indentation with spaces not tabs, fixed.

> +	int lineno = *(int *)data;
> +
> +	if (lineno < 0 || lineno > PVC_NLINES) {
> +		printk("proc_read_line: invalid lineno %d\n", lineno);
> +		return 0;
> +	}
> +
> +	down(&pvc_sem);
> +        page += sprintf(page, "%s\n", pvc_lines[lineno]);
> +	up(&pvc_sem);
> +
> +        return page - origpage;
> +}
> +
> +static int pvc_proc_write_line(struct file *file, const char *buffer,
> +                           unsigned long count, void *data)
> +{
> +        int origcount = count;
> +	int lineno = *(int *)data;
> +
> +	if (lineno < 0 || lineno > PVC_NLINES) {
> +		printk("proc_write_line: invalid lineno %d\n", lineno);
> +		return origcount;
> +	}
> +
> +	if (count > PVC_LINELEN)
> +		count = PVC_LINELEN;
> +
> +	if (buffer[count-1] == '\n')
> +		count--;
> +
> +	down(&pvc_sem);
> +	strncpy(pvc_lines[lineno], buffer, count);
> +	pvc_lines[lineno][count] = '\0';
> +	up(&pvc_sem);
> +
> +	tasklet_schedule(&pvc_display_tasklet);
> +
> +        return origcount;
> +}
> +
> +static int pvc_proc_write_scroll(struct file *file, const char *buffer,
> +                           unsigned long count, void *data)
> +{
> +        int origcount = count;
> +	int cmd = simple_strtol(buffer, NULL, 10);
> +
> +	down(&pvc_sem);
> +	if (scroll_interval != 0)
> +		del_timer(&timer);
> +
> +	if (cmd == 0) {
> +		scroll_dir = 0;
> +		scroll_interval = 0;
> +	} else {
> +		if (cmd < 0) {
> +			scroll_dir = -1;
> +			scroll_interval = -cmd;
> +		} else {
> +			scroll_dir = 1;
> +			scroll_interval = cmd;
> +		}
> +		add_timer(&timer);
> +	}
> +	up(&pvc_sem);
> +
> +        return origcount;
> +}
> +
> +static int pvc_proc_read_scroll(char *page, char **start,
> +                             off_t off, int count,
> +                             int *eof, void *data)
> +{
> +        char *origpage = page;
> +
> +	down(&pvc_sem);
> +        page += sprintf(page, "%d\n", scroll_dir * scroll_interval);
> +	up(&pvc_sem);
> +
> +        return page - origpage;
> +}
> +
> +
> +void pvc_proc_timerfunc(unsigned long data)
> +{
> +	if (scroll_dir < 0)
> +		pvc_move(DISPLAY|RIGHT);
> +	else if (scroll_dir > 0)
> +		pvc_move(DISPLAY|LEFT);
> +
> +	timer.expires = jiffies + scroll_interval;
> +	add_timer(&timer);
> +}
> +
> +static void pvc_proc_cleanup(void)
> +{
> +	int i;
> +	for (i=0; i<PVC_NLINES; i++)
> +		remove_proc_entry(pvc_linename[i], pvc_display_dir);
> +	remove_proc_entry("scroll", pvc_display_dir);
> +	remove_proc_entry(DISPLAY_DIR_NAME, NULL);
> +
> +	del_timer(&timer);
> +}
> +
> +static int __init pvc_proc_init(void)
> +{
> +	struct proc_dir_entry *proc_entry;
> +	int i;
> +
> +	pvc_display_dir = proc_mkdir(DISPLAY_DIR_NAME, NULL);
> +	if (pvc_display_dir == NULL)
> +		goto error;
> +
> +	for (i=0; i<PVC_NLINES; i++) {
> +		strcpy(pvc_lines[i], "");
> +		pvc_linedata[i] = i;
> +	}
> +	for (i=0; i<PVC_NLINES; i++) {
> +		proc_entry = create_proc_entry(pvc_linename[i], 0644, pvc_display_dir);
> +		if (proc_entry == NULL)
> +			goto error;
> +		proc_entry->read_proc = pvc_proc_read_line;
> +		proc_entry->write_proc = pvc_proc_write_line;
> +		proc_entry->data = &pvc_linedata[i];
> +	}
> +	proc_entry = create_proc_entry("scroll", 0644, pvc_display_dir);
> +	if (proc_entry == NULL)
> +		goto error;
> +	proc_entry->write_proc = pvc_proc_write_scroll;
> +	proc_entry->read_proc = pvc_proc_read_scroll;
> +
> +	init_timer(&timer);
> +	timer.function = pvc_proc_timerfunc;
> +
> +	return 0;
> +error:
> +	pvc_proc_cleanup();
> +	return -ENOMEM;
> +}
> +
> +module_init(pvc_proc_init);
> +module_exit(pvc_proc_cleanup);
> +MODULE_LICENSE("GPL");
> diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
> new file mode 100644
> index 0000000..812c6ac
> --- /dev/null
> +++ b/arch/mips/lasat/prom.c
> @@ -0,0 +1,117 @@
> +/*
> + * PROM interface routines.
> + */
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/ctype.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/bootmem.h>
> +#include <linux/ioport.h>
> +#include <asm/bootinfo.h>
> +#include <asm/lasat/lasat.h>
> +#include <asm/cpu.h>
> +
> +#include "at93c.h"
> +#include <asm/lasat/eeprom.h>
> +#include "prom.h"
> +
> +#define RESET_VECTOR	0xbfc00000
> +#define PROM_JUMP_TABLE_ENTRY(n) (*((u32 *)(RESET_VECTOR + 0x20) + n))
> +#define PROM_DISPLAY_ADDR	PROM_JUMP_TABLE_ENTRY(0)
> +#define PROM_PUTC_ADDR		PROM_JUMP_TABLE_ENTRY(1)
> +#define PROM_MONITOR_ADDR	PROM_JUMP_TABLE_ENTRY(2)
> +
> +static void null_prom_display(const char *string, int pos, int clear)
> +{
> +}
> +
> +static void null_prom_monitor(void)
> +{
> +}
> +
> +static void null_prom_putc(char c)
> +{
> +}
> +
> +/* these are functions provided by the bootloader */
> +static void (* __prom_putc)(char c) = null_prom_putc;
> +
> +void prom_putchar(char c)
> +{
> +	__prom_putc(c);
> +}
> +
> +void (* prom_display)(const char *string, int pos, int clear) =
> +		null_prom_display;
> +void (* prom_monitor)(void) = null_prom_monitor;
> +
> +unsigned int lasat_ndelay_divider;
> +
> +static void setup_prom_vectors(void)
> +{
> +	u32 version = *(u32 *)(RESET_VECTOR + 0x90);
> +
> +	if (version >= 307) {
> +		prom_display = (void *)PROM_DISPLAY_ADDR;
> +		__prom_putc = (void *)PROM_PUTC_ADDR;
> +		prom_monitor = (void *)PROM_MONITOR_ADDR;
> +	}
> +	printk("prom vectors set up\n");
> +}
> +
> +static struct at93c_defs at93c_defs[N_MACHTYPES] = {
> +	{(void *)AT93C_REG_100, (void *)AT93C_RDATA_REG_100, AT93C_RDATA_SHIFT_100,
> +	AT93C_WDATA_SHIFT_100, AT93C_CS_M_100, AT93C_CLK_M_100},
> +	{(void *)AT93C_REG_200, (void *)AT93C_RDATA_REG_200, AT93C_RDATA_SHIFT_200,
> +	AT93C_WDATA_SHIFT_200, AT93C_CS_M_200, AT93C_CLK_M_200},

Lines longer than 80 characters and certainly this struct gets more readable
from ISO initializers.

> +};
> +
> +void __init prom_init(void)
> +{
> +	int argc = fw_arg0;
> +	char **argv = (char **) fw_arg1;
> +
> +	setup_prom_vectors();
> +
> +	if (current_cpu_data.cputype == CPU_R5000) {
> +	        printk("LASAT 200 board\n");
> +		mips_machtype = MACH_LASAT_200;
> +                lasat_ndelay_divider = LASAT_200_DIVIDER;
> +        } else {
> +	        printk("LASAT 100 board\n");
> +		mips_machtype = MACH_LASAT_100;
> +                lasat_ndelay_divider = LASAT_100_DIVIDER;
> +        }
> +
> +	at93c = &at93c_defs[mips_machtype];
> +
> +	lasat_init_board_info();		/* Read info from EEPROM */
> +
> +	mips_machgroup = MACH_GROUP_LASAT;
> +
> +	/* Get the command line */
> +	if (argc > 0) {
> +		strncpy(arcs_cmdline, argv[0], CL_SIZE-1);
> +		arcs_cmdline[CL_SIZE-1] = '\0';
> +	}
> +
> +	/* Set the I/O base address */
> +	set_io_port_base(KSEG1);
> +
> +	/* Set memory regions */
> +	ioport_resource.start = 0;
> +	ioport_resource.end = 0xffffffff;	/* Wrong, fixme.  */
> +
> +	add_memory_region(0, lasat_board_info.li_memsize, BOOT_MEM_RAM);
> +}
> +
> +void __init prom_free_prom_memory(void)
> +{
> +}
> +
> +const char *get_system_type(void)
> +{
> +	return lasat_board_info.li_bmstr;
> +}
> diff --git a/arch/mips/lasat/prom.h b/arch/mips/lasat/prom.h
> new file mode 100644
> index 0000000..019d45f
> --- /dev/null
> +++ b/arch/mips/lasat/prom.h
> @@ -0,0 +1,5 @@
> +#ifndef PROM_H
> +#define PROM_H
> +extern void (* prom_display)(const char *string, int pos, int clear);
> +extern void (* prom_monitor)(void);
> +#endif
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

The reboot/restart functions shouldn't print any messages.  If that is
desired, userspace should do so.

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
> +#ifdef CONFIG_PICVUE
> +	pvc_clear();
> +	pvc_write_string(MESSAGE, 0, 0);
> +#endif

The reboot/restart functions shouldn't print any messages.  If that is
desired, userspace should do so.

> +	prom_monitor();
> +	for (;;) ;
> +}
> +
> +void lasat_reboot_setup(void)
> +{
> +	_machine_restart = lasat_machine_restart;
> +	_machine_halt = lasat_machine_halt;
> +	pm_power_off = lasat_machine_halt;
> +}
> diff --git a/arch/mips/lasat/serial.c b/arch/mips/lasat/serial.c
> new file mode 100644
> index 0000000..bfc0deb
> --- /dev/null
> +++ b/arch/mips/lasat/serial.c
> @@ -0,0 +1,93 @@
> +/*
> + *  Registration of Lasat UART platform device.
> + *
> + *  Copyright (C) 2007  Brian Murphy <brian@murphy.dk>
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
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Please stick to the 80 columns limit.  That's valid even for the GPL ;-)

> + */
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_8250.h>
> +
> +#include <asm/bootinfo.h>
> +#include <asm/lasat/lasat.h>
> +#include <asm/lasat/serial.h>
> +
> +static struct resource lasat_serial_res[2] __initdata;
> +
> +static struct plat_serial8250_port lasat_serial8250_port[] = {
> +	{
> +		.iotype		= UPIO_MEM,
> +		.flags		= UPF_IOREMAP | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
> +	},
> +	{},
> +};
> +
> +static __init int lasat_uart_add(void)
> +{
> +	struct platform_device *pdev;
> +	int retval;
> +
> +	pdev = platform_device_alloc("serial8250", -1);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	if (mips_machtype == MACH_LASAT_100) {
> +		lasat_serial_res[0].start = KSEG1ADDR(LASAT_UART_REGS_BASE_100);
> +		lasat_serial_res[0].end = lasat_serial_res[0].start + LASAT_UART_REGS_SHIFT_100 * 8 - 1;
> +		lasat_serial_res[0].flags = IORESOURCE_MEM;
> +		lasat_serial_res[1].start = LASATINT_UART_100;
> +		lasat_serial_res[1].end = LASATINT_UART_100;
> +		lasat_serial_res[1].flags = IORESOURCE_IRQ;
> +
> +		lasat_serial8250_port[0].mapbase = LASAT_UART_REGS_BASE_100;
> +		lasat_serial8250_port[0].uartclk = LASAT_BASE_BAUD_100 * 16;
> +		lasat_serial8250_port[0].regshift = LASAT_UART_REGS_SHIFT_100;
> +		lasat_serial8250_port[0].irq = LASATINT_UART_100;
> +	} else {
> +		lasat_serial_res[0].start = KSEG1ADDR(LASAT_UART_REGS_BASE_200);
> +		lasat_serial_res[0].end = lasat_serial_res[0].start + LASAT_UART_REGS_SHIFT_200 * 8 - 1;
> +		lasat_serial_res[0].flags = IORESOURCE_MEM;
> +		lasat_serial_res[1].start = LASATINT_UART_200;
> +		lasat_serial_res[1].end = LASATINT_UART_200;
> +		lasat_serial_res[1].flags = IORESOURCE_IRQ;
> +
> +		lasat_serial8250_port[0].mapbase = LASAT_UART_REGS_BASE_200;
> +		lasat_serial8250_port[0].uartclk = LASAT_BASE_BAUD_200 * 16;
> +		lasat_serial8250_port[0].regshift = LASAT_UART_REGS_SHIFT_200;
> +		lasat_serial8250_port[0].irq = LASATINT_UART_200;
> +	}
> +
> +	pdev->id = PLAT8250_DEV_PLATFORM;
> +	pdev->dev.platform_data = lasat_serial8250_port;
> +
> +	retval = platform_device_add_resources(pdev, lasat_serial_res, ARRAY_SIZE(lasat_serial_res));
> +	if (retval)
> +		goto err_free_device;
> +
> +	retval = platform_device_add(pdev);
> +	if (retval)
> +		goto err_free_device;
> +
> +	return 0;
> +
> +err_free_device:
> +	platform_device_put(pdev);
> +
> +	return retval;
> +}
> +device_initcall(lasat_uart_add);
> diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
> new file mode 100644
> index 0000000..6eeb0ce
> --- /dev/null
> +++ b/arch/mips/lasat/setup.c
> @@ -0,0 +1,150 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999 MIPS Technologies, Inc.  All rights reserved.
> + *
> + * Thomas Horsten <thh@lasat.com>
> + * Copyright (C) 2000 LASAT Networks A/S.
> + *
> + * Brian Murphy <brian@murphy.dk>
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
> + * Lasat specific setup.
> + */
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/pci.h>
> +#include <linux/interrupt.h>
> +#include <linux/tty.h>
> +
> +#include <asm/time.h>
> +#include <asm/cpu.h>
> +#include <asm/bootinfo.h>
> +#include <asm/irq.h>
> +#include <asm/lasat/lasat.h>
> +#include <asm/lasat/serial.h>
> +
> +#ifdef CONFIG_PICVUE
> +#include <linux/notifier.h>
> +#endif
> +
> +#include "ds1603.h"
> +#include <asm/lasat/ds1603.h>
> +#include <asm/lasat/picvue.h>
> +#include <asm/lasat/eeprom.h>
> +
> +#include "prom.h"
> +
> +int lasat_command_line = 0;
> +void lasatint_init(void);
> +
> +extern void lasat_reboot_setup(void);
> +extern void pcisetup(void);
> +extern void edhac_init(void *, void *, void *);
> +extern void addrflt_init(void);
> +
> +struct lasat_misc lasat_misc_info[N_MACHTYPES] = {
> +	{(void *)KSEG1ADDR(0x1c840000), (void *)KSEG1ADDR(0x1c800000), 2},
> +	{(void *)KSEG1ADDR(0x11080000), (void *)KSEG1ADDR(0x11000000), 6}
> +};
> +
> +struct lasat_misc *lasat_misc = NULL;
> +
> +#ifdef CONFIG_DS1603
> +static struct ds_defs ds_defs[N_MACHTYPES] = {
> +	{ (void *)DS1603_REG_100, (void *)DS1603_REG_100,
> +		DS1603_RST_100, DS1603_CLK_100, DS1603_DATA_100,
> +		DS1603_DATA_SHIFT_100, 0, 0 },
> +	{ (void *)DS1603_REG_200, (void *)DS1603_DATA_REG_200,
> +		DS1603_RST_200, DS1603_CLK_200, DS1603_DATA_200,
> +		DS1603_DATA_READ_SHIFT_200, 1, 2000 }
> +};
> +#endif
> +
> +#ifdef CONFIG_PICVUE
> +#include "picvue.h"
> +static struct pvc_defs pvc_defs[N_MACHTYPES] = {
> +	{ (void *)PVC_REG_100, PVC_DATA_SHIFT_100, PVC_DATA_M_100,
> +		PVC_E_100, PVC_RW_100, PVC_RS_100 },
> +	{ (void *)PVC_REG_200, PVC_DATA_SHIFT_200, PVC_DATA_M_200,
> +		PVC_E_200, PVC_RW_200, PVC_RS_200 }
> +};
> +#endif
> +
> +static int lasat_panic_display(struct notifier_block *this,
> +			     unsigned long event, void *ptr)
> +{
> +#ifdef CONFIG_PICVUE
> +	unsigned char *string = ptr;
> +	if (string == NULL)
> +		string = "Kernel Panic";
> +	pvc_dump_string(string);
> +#endif
> +	return NOTIFY_DONE;
> +}
> +
> +static int lasat_panic_prom_monitor(struct notifier_block *this,
> +			     unsigned long event, void *ptr)
> +{
> +	prom_monitor();
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block lasat_panic_block[] =
> +{
> +	{ lasat_panic_display, NULL, INT_MAX },
> +	{ lasat_panic_prom_monitor, NULL, INT_MIN }
> +};
> +
> +static void lasat_time_init(void)
> +{
> +	mips_hpt_frequency = lasat_board_info.li_cpu_hz / 2;
> +}
> +
> +void __init plat_timer_setup(struct irqaction *irq)
> +{
> +	change_c0_status(ST0_IM, IE_IRQ0 | IE_IRQ5);
> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +	int i;
> +	lasat_misc  = &lasat_misc_info[mips_machtype];
> +#ifdef CONFIG_PICVUE
> +	picvue = &pvc_defs[mips_machtype];
> +#endif
> +
> +	/* Set up panic notifier */
> +	for (i = 0; i < sizeof(lasat_panic_block) / sizeof(struct notifier_block); i++)

Changed this place and many others to use ARRAY_SIZE().

> +		atomic_notifier_chain_register(&panic_notifier_list,
> +				&lasat_panic_block[i]);
> +
> +	lasat_reboot_setup();
> +
> +	board_time_init = lasat_time_init;
> +
> +#ifdef CONFIG_DS1603
> +	ds1603 = &ds_defs[mips_machtype];
> +	rtc_mips_get_time = ds1603_read;
> +	rtc_mips_set_time = ds1603_set;
> +#endif
> +
> +#ifdef DYNAMIC_SERIAL_INIT
> +	serial_init();
> +#endif

Neither DYNAMIC_SERIAL_INIT nor are defined anywhere, so I deleted this.

> +	/* Switch from prom exception handler to normal mode */
> +	change_c0_status(ST0_BEV,0);

This already happens in traps.c and a clear_c0_status(ST0_BEV) would
actually be a bit more readable and less code.

> +
> +	pr_info("Lasat specific initialization complete\n");
> +}
> diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
> new file mode 100644
> index 0000000..699ab18
> --- /dev/null
> +++ b/arch/mips/lasat/sysctl.c
> @@ -0,0 +1,441 @@
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
> + * Routines specific to the LASAT boards
> + */
> +#include <linux/types.h>
> +#include <asm/lasat/lasat.h>
> +
> +#include <linux/module.h>
> +#include <linux/sysctl.h>
> +#include <linux/stddef.h>
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/ctype.h>
> +#include <linux/string.h>
> +#include <linux/net.h>
> +#include <linux/inet.h>
> +#include <linux/mutex.h>
> +#include <asm/uaccess.h>

This should use <linux/uaccess.h> like all cases where a header file in
include/linux exists which includes the include/asm/ file of the same name.

> +
> +#include "sysctl.h"
> +#include "ds1603.h"
> +
> +static DEFINE_MUTEX(lasat_info_mutex);
> +
> +/* Strategy function to write EEPROM after changing string entry */
> +int sysctl_lasatstring(ctl_table *table, int *name, int nlen,
> +		void *oldval, size_t *oldlenp,
> +		void *newval, size_t newlen)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	r = sysctl_string(table, name,
> +			  nlen, oldval, oldlenp, newval, newlen);
> +	if (r < 0) {
> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	if (newval && newlen) {
> +		lasat_write_eeprom_info();
> +	}
> +	mutex_unlock(&lasat_info_mutex);
> +	return 1;
> +}
> +
> +
> +/* And the same for proc */
> +int proc_dolasatstring(ctl_table *table, int write, struct file *filp,
> +		       void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	r = proc_dostring(table, write, filp, buffer, lenp, ppos);
> +	if ( (!write) || r) {
            ^
No space here.

> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	lasat_write_eeprom_info();
> +	mutex_unlock(&lasat_info_mutex);
> +	return 0;
> +}
> +
> +/* proc function to write EEPROM after changing int entry */
> +int proc_dolasatint(ctl_table *table, int write, struct file *filp,
> +		       void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
> +	if ( (!write) || r) {
            ^
No space here.

> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	lasat_write_eeprom_info();
> +	mutex_unlock(&lasat_info_mutex);
> +	return 0;
> +}
> +
> +static int rtctmp;
> +
> +#ifdef CONFIG_DS1603
> +/* proc function to read/write RealTime Clock */
> +int proc_dolasatrtc(ctl_table *table, int write, struct file *filp,
> +		       void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	if (!write) {
> +		rtctmp = ds1603_read();
> +		/* check for time < 0 and set to 0 */
> +		if (rtctmp < 0)
> +			rtctmp = 0;
> +	}
> +	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
> +	if ( (!write) || r) {
> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	ds1603_set(rtctmp);
> +	mutex_unlock(&lasat_info_mutex);
> +	return 0;
> +}
> +#endif
> +
> +/* Sysctl for setting the IP addresses */
> +int sysctl_lasat_intvec(ctl_table *table, int *name, int nlen,
> +		    void *oldval, size_t *oldlenp,
> +		    void *newval, size_t newlen)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
> +	if (r < 0) {
> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	if (newval && newlen) {
> +		lasat_write_eeprom_info();
> +	}
> +	mutex_unlock(&lasat_info_mutex);
> +	return 1;
> +}
> +
> +#ifdef CONFIG_DS1603
> +/* Same for RTC */
> +int sysctl_lasat_rtc(ctl_table *table, int *name, int nlen,
> +		    void *oldval, size_t *oldlenp,
> +		    void *newval, size_t newlen)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	rtctmp = ds1603_read();
> +	if (rtctmp < 0)
> +		rtctmp = 0;
> +	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
> +	if (r < 0) {
> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	if (newval && newlen) {
> +		ds1603_set(rtctmp);
> +	}
> +	mutex_unlock(&lasat_info_mutex);
> +	return 1;
> +}
> +#endif
> +
> +#ifdef CONFIG_INET
> +static char lasat_bcastaddr[16];
> +
> +void update_bcastaddr(void)
> +{
> +	unsigned int ip;
> +
> +	ip = (lasat_board_info.li_eeprom_info.ipaddr &
> +		lasat_board_info.li_eeprom_info.netmask) |
> +		~lasat_board_info.li_eeprom_info.netmask;
> +
> +	sprintf(lasat_bcastaddr, "%d.%d.%d.%d",
> +			(ip      ) & 0xff,
> +			(ip >>  8) & 0xff,
> +			(ip >> 16) & 0xff,
> +			(ip >> 24) & 0xff);
> +}
> +
> +static char proc_lasat_ipbuf[32];
> +/* Parsing of IP address */
> +int proc_lasat_ip(ctl_table *table, int write, struct file *filp,
> +		       void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int len;
> +        unsigned int ip;
> +	char *p, c;
> +
> +	if (!table->data || !table->maxlen || !*lenp ||
> +	    (*ppos && !write)) {
> +		*lenp = 0;
> +		return 0;
> +	}
> +
> +	mutex_lock(&lasat_info_mutex);
> +	if (write) {
> +		len = 0;
> +		p = buffer;
> +		while (len < *lenp) {
> +			if(get_user(c, p++)) {
> +				mutex_unlock(&lasat_info_mutex);
> +				return -EFAULT;
> +			}
> +			if (c == 0 || c == '\n')
> +				break;
> +			len++;
> +		}
> +		if (len >= sizeof(proc_lasat_ipbuf)-1)
> +			len = sizeof(proc_lasat_ipbuf) - 1;
> +		if (copy_from_user(proc_lasat_ipbuf, buffer, len))
> +		{
> +			mutex_unlock(&lasat_info_mutex);
> +			return -EFAULT;
> +		}
> +		proc_lasat_ipbuf[len] = 0;
> +		*ppos += *lenp;
> +		/* Now see if we can convert it to a valid IP */
> +		ip = in_aton(proc_lasat_ipbuf);
> +		*(unsigned int *)(table->data) = ip;
> +		lasat_write_eeprom_info();
> +	} else {
> +		ip = *(unsigned int *)(table->data);
> +		sprintf(proc_lasat_ipbuf, "%d.%d.%d.%d",
> +			(ip      ) & 0xff,
> +			(ip >>  8) & 0xff,
> +			(ip >> 16) & 0xff,
> +			(ip >> 24) & 0xff);
> +		len = strlen(proc_lasat_ipbuf);
> +		if (len > *lenp)
> +			len = *lenp;
> +		if (len)
> +			if(copy_to_user(buffer, proc_lasat_ipbuf, len)) {
> +				mutex_unlock(&lasat_info_mutex);
> +				return -EFAULT;
> +			}
> +		if (len < *lenp) {
> +			if(put_user('\n', ((char *) buffer) + len)) {
> +				mutex_unlock(&lasat_info_mutex);
> +				return -EFAULT;
> +			}
> +			len++;
> +		}
> +		*lenp = len;
> +		*ppos += len;
> +	}
> +	update_bcastaddr();
> +	mutex_unlock(&lasat_info_mutex);
> +	return 0;
> +}
> +#endif /* defined(CONFIG_INET) */
> +
> +static int sysctl_lasat_eeprom_value(ctl_table *table, int *name, int nlen,
> +				     void *oldval, size_t *oldlenp,
> +				     void *newval, size_t newlen)
> +{
> +	int r;
> +
> +	mutex_lock(&lasat_info_mutex);
> +	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
> +	if (r < 0) {
> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +
> +	if (newval && newlen)
> +	{
> +		if (name && *name == LASAT_PRID)
> +			lasat_board_info.li_eeprom_info.prid = *(int*)newval;
> +
> +		lasat_write_eeprom_info();
> +		lasat_init_board_info();
> +	}
> +	mutex_unlock(&lasat_info_mutex);
> +
> +	return 0;
> +}
> +
> +int proc_lasat_eeprom_value(ctl_table *table, int write, struct file *filp,
> +		       void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int r;
> +	mutex_lock(&lasat_info_mutex);
> +	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
> +	if ( (!write) || r) {
> +		mutex_unlock(&lasat_info_mutex);
> +		return r;
> +	}
> +	if (filp && filp->f_path.dentry)
> +	{
> +		if (!strcmp(filp->f_path.dentry->d_name.name, "prid"))
> +			lasat_board_info.li_eeprom_info.prid = lasat_board_info.li_prid;
> +		if (!strcmp(filp->f_path.dentry->d_name.name, "debugaccess"))
> +			lasat_board_info.li_eeprom_info.debugaccess = lasat_board_info.li_debugaccess;
> +	}
> +	lasat_write_eeprom_info();
> +	mutex_unlock(&lasat_info_mutex);
> +	return 0;
> +}
> +
> +extern int lasat_boot_to_service;
> +
> +#ifdef CONFIG_SYSCTL
> +
> +static ctl_table lasat_table[] = {
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "cpu-hz",
> +		.data		= &lasat_board_info.li_cpu_hz,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0444,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "bus-hz",
> +		.data		= &lasat_board_info.li_bus_hz,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0444,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "bmid",
> +		.data		= &lasat_board_info.li_bmid,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0444,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "prid",
> +		.data		= &lasat_board_info.li_prid,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_lasat_eeprom_value,
> +		.strategy	= &sysctl_lasat_eeprom_value
> +	},
> +#ifdef CONFIG_INET
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "ipaddr",
> +		.data		= &lasat_board_info.li_eeprom_info.ipaddr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_lasat_ip,
> +		.strategy	= &sysctl_lasat_intvec
> +	},
> +	{
> +		.ctl_name	= LASAT_NETMASK,
> +		.procname	= "netmask",
> +		.data		= &lasat_board_info.li_eeprom_info.netmask,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_lasat_ip,
> +		.strategy	= &sysctl_lasat_intvec
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "bcastaddr",
> +		.data		= &lasat_bcastaddr,
> +		.maxlen		= sizeof(lasat_bcastaddr),
> +		.mode		= 0600,
> +		.proc_handler	= &proc_dostring,
> +		.strategy	= &sysctl_string
> +	},
> +#endif
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "passwd_hash",
> +		.data		= &lasat_board_info.li_eeprom_info.passwd_hash,
> +		.maxlen		= sizeof(lasat_board_info.li_eeprom_info.passwd_hash),
> +		.mode		= 0600,
> +		.proc_handler	= &proc_dolasatstring,
> +		.strategy	= &sysctl_lasatstring
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "boot-service",
> +		.data		= &lasat_boot_to_service,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec
> +	},
> +#ifdef CONFIG_DS1603
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "rtc",
> +		.data		= &rtctmp,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dolasatrtc,
> +		.strategy	= &sysctl_lasat_rtc
> +	},
> +#endif
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "namestr",
> +		.data		= &lasat_board_info.li_namestr,
> +		.maxlen		= sizeof(lasat_board_info.li_namestr),
> +		.mode		= 0444,
> +		.proc_handler	=  &proc_dostring,
> +		.strategy	= &sysctl_string
> +	},
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "typestr",
> +		.data		= &lasat_board_info.li_typestr,
> +		.maxlen		= sizeof(lasat_board_info.li_typestr),
> +		.mode		= 0444,
> +		.proc_handler	= &proc_dostring,
> +		.strategy	= &sysctl_string
> +	},
> +	{}
> +};
> +
> +static ctl_table lasat_root_table[] = {
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "lasat",
> +		.mode		=  0555,
> +		.child		= lasat_table
> +	},
> +	{}
> +};
> +
> +static int __init lasat_register_sysctl(void)
> +{
> +	struct ctl_table_header *lasat_table_header;
> +
> +	lasat_table_header =
> +		register_sysctl_table(lasat_root_table);
> +
> +	return 0;
> +}
> +
> +__initcall(lasat_register_sysctl);
> +#endif /* CONFIG_SYSCTL */
> diff --git a/arch/mips/lasat/sysctl.h b/arch/mips/lasat/sysctl.h
> new file mode 100644
> index 0000000..4d139d2
> --- /dev/null
> +++ b/arch/mips/lasat/sysctl.h
> @@ -0,0 +1,24 @@
> +/*
> + * LASAT sysctl values
> + */
> +
> +#ifndef _LASAT_SYSCTL_H
> +#define _LASAT_SYSCTL_H
> +
> +/* /proc/sys/lasat */
> +enum {
> +	LASAT_CPU_HZ=1,
> +	LASAT_BUS_HZ,
> +	LASAT_MODEL,
> +	LASAT_PRID,
> +	LASAT_IPADDR,
> +	LASAT_NETMASK,
> +	LASAT_BCAST,
> +	LASAT_PASSWORD,
> +	LASAT_SBOOT,
> +	LASAT_RTC,
> +	LASAT_NAMESTR,
> +	LASAT_TYPESTR,
> +};
> +
> +#endif /* _LASAT_SYSCTL_H */
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index 4ee6800..ed0c076 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -10,6 +10,7 @@ obj-y				+= pci.o
>  obj-$(CONFIG_MIPS_BONITO64)	+= ops-bonito64.o
>  obj-$(CONFIG_PCI_GT64XXX_PCI0)	+= ops-gt64xxx_pci0.o
>  obj-$(CONFIG_MIPS_MSC)		+= ops-msc.o
> +obj-$(CONFIG_MIPS_NILE4)	+= ops-nile4.o
>  obj-$(CONFIG_MIPS_TX3927)	+= ops-tx3927.o
>  obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
>  obj-$(CONFIG_NEC_CMBVR4133)	+= fixup-vr4133.o
> @@ -19,6 +20,7 @@ obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
>  # These are still pretty much in the old state, watch, go blind.
>  #
>  obj-$(CONFIG_BASLER_EXCITE)	+= ops-titan.o pci-excite.o fixup-excite.o
> +obj-$(CONFIG_LASAT)		+= pci-lasat.o
>  obj-$(CONFIG_MIPS_ATLAS)	+= fixup-atlas.o
>  obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
>  obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
> diff --git a/arch/mips/pci/ops-nile4.c b/arch/mips/pci/ops-nile4.c
> new file mode 100644
> index 0000000..a8d38dc
> --- /dev/null
> +++ b/arch/mips/pci/ops-nile4.c
> @@ -0,0 +1,147 @@
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <asm/bootinfo.h>
> +
> +#include <asm/lasat/lasat.h>
> +#include <asm/gt64120.h>
> +#include <asm/nile4.h>
> +
> +#define PCI_ACCESS_READ  0
> +#define PCI_ACCESS_WRITE 1
> +
> +#define LO(reg) (reg / 4)
> +#define HI(reg) (reg / 4 + 1)
> +
> +volatile unsigned long *const vrc_pciregs = (void *) Vrc5074_BASE;
> +
> +static DEFINE_SPINLOCK(nile4_pci_lock);
> +
> +static int nile4_pcibios_config_access(unsigned char access_type,
> +	struct pci_bus *bus, unsigned int devfn, int where, u32 * val)
> +{
> +	unsigned char busnum = bus->number;
> +	u32 adr, mask, err;
> +
> +	if ((busnum == 0) && (PCI_SLOT(devfn) > 8))
> +		/* The addressing scheme chosen leaves room for just
> +		 * 8 devices on the first busnum (besides the PCI
> +		 * controller itself) */
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if ((busnum == 0) && (devfn == PCI_DEVFN(0, 0))) {
> +		/* Access controller registers directly */
> +		if (access_type == PCI_ACCESS_WRITE) {
> +			vrc_pciregs[(0x200 + where) >> 2] = *val;
> +		} else {
> +			*val = vrc_pciregs[(0x200 + where) >> 2];
> +		}
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	/* Temporarily map PCI Window 1 to config space */
> +	mask = vrc_pciregs[LO(NILE4_PCIINIT1)];
> +	vrc_pciregs[LO(NILE4_PCIINIT1)] = 0x0000001a | (busnum ? 0x200 : 0);
> +
> +	/* Clear PCI Error register. This also clears the Error Type
> +	 * bits in the Control register */
> +	vrc_pciregs[LO(NILE4_PCIERR)] = 0;
> +	vrc_pciregs[HI(NILE4_PCIERR)] = 0;
> +
> +	/* Setup address */
> +	if (busnum == 0)
> +		adr =
> +		    KSEG1ADDR(PCI_WINDOW1) +
> +		    ((1 << (PCI_SLOT(devfn) + 15)) | (PCI_FUNC(devfn) << 8)
> +		     | (where & ~3));
> +	else
> +		adr = KSEG1ADDR(PCI_WINDOW1) | (busnum << 16) | (devfn << 8) |
> +		      (where & ~3);
> +
> +	if (access_type == PCI_ACCESS_WRITE)
> +		*(u32 *) adr = *val;
> +	else
> +		*val = *(u32 *) adr;
> +
> +	/* Check for master or target abort */
> +	err = (vrc_pciregs[HI(NILE4_PCICTRL)] >> 5) & 0x7;
> +
> +	/* Restore PCI Window 1 */
> +	vrc_pciregs[LO(NILE4_PCIINIT1)] = mask;
> +
> +	if (err)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int nile4_pcibios_read(struct pci_bus *bus, unsigned int devfn,
> +	int where, int size, u32 * val)
> +{
> +	unsigned long flags;
> +	u32 data = 0;
> +	int err;
> +
> +	if ((size == 2) && (where & 1))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	else if ((size == 4) && (where & 3))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	spin_lock_irqsave(&nile4_pci_lock, flags);
> +	err = nile4_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
> +					&data);
> +	spin_unlock_irqrestore(&nile4_pci_lock, flags);
> +
> +	if (err)
> +		return err;
> +
> +	if (size == 1)
> +		*val = (data >> ((where & 3) << 3)) & 0xff;
> +	else if (size == 2)
> +		*val = (data >> ((where & 3) << 3)) & 0xffff;
> +	else
> +		*val = data;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int nile4_pcibios_write(struct pci_bus *bus, unsigned int devfn,
> +	int where, int size, u32 val)
> +{
> +	unsigned long flags;
> +	u32 data = 0;
> +	int err;
> +
> +	if ((size == 2) && (where & 1))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	else if ((size == 4) && (where & 3))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	spin_lock_irqsave(&nile4_pci_lock, flags);
> +	err = nile4_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
> +	                                  &data);
> +	spin_unlock_irqrestore(&nile4_pci_lock, flags);
> +
> +	if (err)
> +		return err;
> +
> +	if (size == 1)
> +		data = (data & ~(0xff << ((where & 3) << 3))) |
> +		    (val << ((where & 3) << 3));
> +	else if (size == 2)
> +		data = (data & ~(0xffff << ((where & 3) << 3))) |
> +		    (val << ((where & 3) << 3));
> +	else
> +		data = val;
> +
> +	if (nile4_pcibios_config_access
> +	    (PCI_ACCESS_WRITE, bus, devfn, where, &data))
> +		return -1;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +struct pci_ops nile4_pci_ops = {
> +	.read = nile4_pcibios_read,
> +	.write = nile4_pcibios_write,
> +};
> diff --git a/arch/mips/pci/pci-lasat.c b/arch/mips/pci/pci-lasat.c
> new file mode 100644
> index 0000000..c5045ff
> --- /dev/null
> +++ b/arch/mips/pci/pci-lasat.c
> @@ -0,0 +1,91 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2000, 2001, 04 Keith M Wesolowski
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <asm/bootinfo.h>
> +
> +extern struct pci_ops nile4_pci_ops;
> +extern struct pci_ops gt64xxx_pci0_ops;
> +static struct resource lasat_pci_mem_resource = {
> +	.name	= "LASAT PCI MEM",
> +	.start	= 0x18000000,
> +	.end	= 0x19ffffff,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static struct resource lasat_pci_io_resource = {
> +	.name	= "LASAT PCI IO",
> +	.start	= 0x1a000000,
> +	.end	= 0x1bffffff,
> +	.flags	= IORESOURCE_IO,
> +};
> +
> +static struct pci_controller lasat_pci_controller = {
> +	.mem_resource	= &lasat_pci_mem_resource,
> +	.io_resource	= &lasat_pci_io_resource,
> +};
> +
> +static int __init lasat_pci_setup(void)
> +{
> +	printk("PCI: starting\n");
> +
> +	switch (mips_machtype) {
> +	case MACH_LASAT_100:
> +                lasat_pci_controller.pci_ops = &gt64xxx_pci0_ops;
> +                break;
> +	case MACH_LASAT_200:
> +                lasat_pci_controller.pci_ops = &nile4_pci_ops;
> +                break;
> +	default:
> +                panic("pcibios_init: mips_machtype incorrect");
> +        }
> +
> +	register_pci_controller(&lasat_pci_controller);
> +
> +	return 0;
> +}
> +
> +arch_initcall(lasat_pci_setup);
> +
> +#define LASATINT_ETH1   0
> +#define LASATINT_ETH0   1
> +#define LASATINT_HDC    2
> +#define LASATINT_COMP   3
> +#define LASATINT_HDLC   4
> +#define LASATINT_PCIA   5
> +#define LASATINT_PCIB   6
> +#define LASATINT_PCIC   7
> +#define LASATINT_PCID   8
> +
> +int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	switch (slot) {
> +	case 1:
> +	case 2:
> +	case 3:
> +		return LASATINT_PCIA + (((slot-1) + (pin-1)) % 4);
> +	case 4:
> +		return LASATINT_ETH1;   /* Ethernet 1 (LAN 2) */
> +	case 5:
> +		return LASATINT_ETH0;   /* Ethernet 0 (LAN 1) */
> +	case 6:
> +		return LASATINT_HDC;    /* IDE controller */
> +	default:
> +		return 0xff;            /* Illegal */
> +	}
> +
> +	return -1;
> +}
> +
> +/* Do platform specific device initialization at pci_enable_device() time */
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index cc6c734..829723e 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -258,6 +258,12 @@ config MTD_TSUNAMI
>  	help
>  	  Support for the flash chip on Tsunami TIG bus.
>  
> +config MTD_LASAT
> +	tristate "LASAT flash device"
> +	depends on LASAT && MTD_CFI
> +	help
> +	  Support for the flash chips on the Lasat 100 and 200 boards.
> +
>  config MTD_NETtel
>  	tristate "CFI flash device on SnapGear/SecureEdge"
>  	depends on X86 && MTD_PARTITIONS && MTD_JEDECPROBE
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 970b189..3acbb5d 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_MTD_OCELOT)	+= ocelot.o
>  obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
>  obj-$(CONFIG_MTD_PCI)		+= pci.o
>  obj-$(CONFIG_MTD_ALCHEMY)       += alchemy-flash.o
> +obj-$(CONFIG_MTD_LASAT)		+= lasat.o
>  obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o
>  obj-$(CONFIG_MTD_EDB7312)	+= edb7312.o
>  obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
> diff --git a/drivers/mtd/maps/lasat.c b/drivers/mtd/maps/lasat.c
> new file mode 100644
> index 0000000..e343763
> --- /dev/null
> +++ b/drivers/mtd/maps/lasat.c
> @@ -0,0 +1,103 @@
> +/*
> + * Flash device on Lasat 100 and 200 boards
> + *
> + * (C) 2002 Brian Murphy <brian@murphy.dk>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * $Id: lasat.c,v 1.9 2004/11/04 13:24:15 gleixner Exp $
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <asm/io.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/map.h>
> +#include <linux/mtd/partitions.h>
> +#include <asm/lasat/lasat.h>
> +
> +static struct mtd_info *lasat_mtd;
> +
> +static struct mtd_partition partition_info[LASAT_MTD_LAST];
> +static char *lasat_mtd_partnames[] = {"Bootloader", "Service", "Normal", "Filesystem", "Config"};
> +
> +static void lasat_set_vpp(struct map_info *map, int vpp)
> +{
> +	if (vpp)
> +	    *lasat_misc->flash_wp_reg |= 1 << lasat_misc->flash_wp_bit;
> +	else
> +	    *lasat_misc->flash_wp_reg &= ~(1 << lasat_misc->flash_wp_bit);
> +}
> +
> +static struct map_info lasat_map = {
> +	.name = "LASAT flash",
> +	.bankwidth = 4,
> +	.set_vpp = lasat_set_vpp
> +};
> +
> +static int __init init_lasat(void)
> +{
> +	int i;
> +	/* since we use AMD chips and set_vpp is not implimented
> +	 * for these (yet) we still have to permanently enable flash write */
> +	printk(KERN_NOTICE "Unprotecting flash\n");
> +	ENABLE_VPP((&lasat_map));
> +
> +	lasat_map.phys = lasat_flash_partition_start(LASAT_MTD_BOOTLOADER);
> +	lasat_map.virt = ioremap_nocache(
> +		        lasat_map.phys, lasat_board_info.li_flash_size);
> +	lasat_map.size = lasat_board_info.li_flash_size;
> +
> +	simple_map_init(&lasat_map);
> +
> +	for (i=0; i < LASAT_MTD_LAST; i++)
> +		partition_info[i].name = lasat_mtd_partnames[i];
> +
> +	lasat_mtd = do_map_probe("cfi_probe", &lasat_map);
> +
> +	if (!lasat_mtd)
> +	    lasat_mtd = do_map_probe("jedec_probe", &lasat_map);
> +
> +	if (lasat_mtd) {
> +		u32 size, offset = 0;
> +
> +		lasat_mtd->owner = THIS_MODULE;
> +
> +		for (i=0; i < LASAT_MTD_LAST; i++) {
> +			size = lasat_flash_partition_size(i);
> +			partition_info[i].size = size;
> +			partition_info[i].offset = offset;
> +			offset += size;
> +		}
> +
> +		add_mtd_partitions( lasat_mtd, partition_info, LASAT_MTD_LAST );
> +		return 0;
> +	}
> +
> +	iounmap(lasat_map.virt);
> +	return -ENXIO;
> +}
> +
> +static void __exit cleanup_lasat(void)
> +{
> +	if (lasat_mtd) {
> +		del_mtd_partitions(lasat_mtd);
> +		map_destroy(lasat_mtd);
> +	}
> +	if (lasat_map.virt) {
> +		iounmap(lasat_map.virt);
> +		lasat_map.virt = 0;
> +	}
> +}
> +
> +module_init(init_lasat);
> +module_exit(cleanup_lasat);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Brian Murphy <brian@murphy.dk>");
> +MODULE_DESCRIPTION("Lasat Safepipe/Masquerade MTD map driver");
> diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
> index c0f052b..1bb4bf6 100644
> --- a/include/asm-mips/bootinfo.h
> +++ b/include/asm-mips/bootinfo.h
> @@ -175,6 +175,13 @@
>  #define  MACH_HP_LASERJET	1
>  
>  /*
> + * Valid machtype for group LASAT
> + */
> +#define MACH_GROUP_LASAT       21
> +#define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
> +#define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
> +
> +/*
>   * Valid machtype for group TITAN
>   */
>  #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
> diff --git a/include/asm-mips/lasat/ds1603.h b/include/asm-mips/lasat/ds1603.h
> new file mode 100644
> index 0000000..edcd754
> --- /dev/null
> +++ b/include/asm-mips/lasat/ds1603.h
> @@ -0,0 +1,18 @@
> +#include <asm/addrspace.h>
> +
> +/* Lasat 100	*/
> +#define DS1603_REG_100		(KSEG1ADDR(0x1c810000))
> +#define DS1603_RST_100		(1 << 2)
> +#define DS1603_CLK_100		(1 << 0)
> +#define DS1603_DATA_SHIFT_100	1
> +#define DS1603_DATA_100		(1 << DS1603_DATA_SHIFT_100)
> +
> +/* Lasat 200	*/
> +#define DS1603_REG_200		(KSEG1ADDR(0x11000000))
> +#define DS1603_RST_200		(1 << 3)
> +#define DS1603_CLK_200		(1 << 4)
> +#define DS1603_DATA_200		(1 << 5)
> +
> +#define DS1603_DATA_REG_200		(DS1603_REG_200 + 0x10000)
> +#define DS1603_DATA_READ_SHIFT_200	9
> +#define DS1603_DATA_READ_200	(1 << DS1603_DATA_READ_SHIFT_200)
> diff --git a/include/asm-mips/lasat/eeprom.h b/include/asm-mips/lasat/eeprom.h
> new file mode 100644
> index 0000000..7b53edd
> --- /dev/null
> +++ b/include/asm-mips/lasat/eeprom.h
> @@ -0,0 +1,17 @@
> +#include <asm/addrspace.h>
> +
> +/* lasat 100 */
> +#define AT93C_REG_100               KSEG1ADDR(0x1c810000)
> +#define AT93C_RDATA_REG_100         AT93C_REG_100
> +#define AT93C_RDATA_SHIFT_100       4
> +#define AT93C_WDATA_SHIFT_100       4
> +#define AT93C_CS_M_100              ( 1 << 5 )
> +#define AT93C_CLK_M_100             ( 1 << 3 )
> +
> +/* lasat 200 */
> +#define AT93C_REG_200		KSEG1ADDR(0x11000000)
> +#define AT93C_RDATA_REG_200	(AT93C_REG_200+0x10000)
> +#define AT93C_RDATA_SHIFT_200	8
> +#define AT93C_WDATA_SHIFT_200	2
> +#define AT93C_CS_M_200		( 1 << 0 )
> +#define AT93C_CLK_M_200		( 1 << 1 )
> diff --git a/include/asm-mips/lasat/head.h b/include/asm-mips/lasat/head.h
> new file mode 100644
> index 0000000..f5589f3
> --- /dev/null
> +++ b/include/asm-mips/lasat/head.h
> @@ -0,0 +1,22 @@
> +/*
> + * Image header stuff
> + */
> +#ifndef _HEAD_H
> +#define _HEAD_H
> +
> +#define LASAT_K_MAGIC0_VAL	0xfedeabba
> +#define LASAT_K_MAGIC1_VAL	0x00bedead
> +
> +#ifndef _LANGUAGE_ASSEMBLY
> +#include <linux/types.h>
> +struct bootloader_header {
> +	u32 magic[2];
> +	u32 version;
> +	u32 image_start;
> +	u32 image_size;
> +	u32 kernel_start;
> +	u32 kernel_entry;
> +};
> +#endif
> +
> +#endif /* _HEAD_H */
> diff --git a/include/asm-mips/lasat/lasat.h b/include/asm-mips/lasat/lasat.h
> new file mode 100644
> index 0000000..42077e3
> --- /dev/null
> +++ b/include/asm-mips/lasat/lasat.h
> @@ -0,0 +1,253 @@
> +/*
> + * lasat.h
> + *
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
> + * Configuration for LASAT boards, loads the appropriate include files.
> + */
> +#ifndef _LASAT_H
> +#define _LASAT_H
> +
> +#ifndef _LANGUAGE_ASSEMBLY
> +
> +extern struct lasat_misc {
> +	volatile u32 *reset_reg;
> +	volatile u32 *flash_wp_reg;
> +	u32 flash_wp_bit;
> +} *lasat_misc;
> +
> +enum lasat_mtdparts {
> +	LASAT_MTD_BOOTLOADER,
> +	LASAT_MTD_SERVICE,
> +	LASAT_MTD_NORMAL,
> +	LASAT_MTD_CONFIG,
> +	LASAT_MTD_FS,
> +	LASAT_MTD_LAST
> +};
> +
> +/*
> + * The format of the data record in the EEPROM.
> + * See Documentation/LASAT/eeprom.txt for a detailed description
> + * of the fields in this struct, and the LASAT Hardware Configuration
> + * field specification for a detailed description of the config
> + * field.
> + */
> +#include <linux/types.h>
> +
> +#define LASAT_EEPROM_VERSION 7
> +struct lasat_eeprom_struct {
> +	unsigned int  version;
> +	unsigned int  cfg[3];
> +	unsigned char hwaddr[6];
> +	unsigned char print_partno[12];
> +	unsigned char term0;
> +	unsigned char print_serial[14];
> +	unsigned char term1;
> +	unsigned char prod_partno[12];
> +	unsigned char term2;
> +	unsigned char prod_serial[14];
> +	unsigned char term3;
> +	unsigned char passwd_hash[16];
> +	unsigned char pwdnull;
> +	unsigned char vendid;
> +	unsigned char ts_ref;
> +	unsigned char ts_signoff;
> +	unsigned char reserved[11];
> +	unsigned char debugaccess;
> +	unsigned short prid;
> +	unsigned int  serviceflag;
> +	unsigned int  ipaddr;
> +	unsigned int  netmask;
> +	unsigned int  crc32;
> +};
> +
> +struct lasat_eeprom_struct_pre7 {
> +	unsigned int  version;
> +	unsigned int  flags[3];
> +	unsigned char hwaddr0[6];
> +	unsigned char hwaddr1[6];
> +	unsigned char print_partno[9];
> +	unsigned char term0;
> +	unsigned char print_serial[14];
> +	unsigned char term1;
> +	unsigned char prod_partno[9];
> +	unsigned char term2;
> +	unsigned char prod_serial[14];
> +	unsigned char term3;
> +	unsigned char passwd_hash[24];
> +	unsigned char pwdnull;
> +	unsigned char vendor;
> +	unsigned char ts_ref;
> +	unsigned char ts_signoff;
> +	unsigned char reserved[6];
> +	unsigned int  writecount;
> +	unsigned int  ipaddr;
> +	unsigned int  netmask;
> +	unsigned int  crc32;
> +};
> +
> +/* Configuration descriptor encoding - see the doc for details */
> +
> +#define LASAT_W0_DSCTYPE(v)		( ( (v)         ) & 0xf )
> +#define LASAT_W0_BMID(v)		( ( (v) >> 0x04 ) & 0xf )
> +#define LASAT_W0_CPUTYPE(v)		( ( (v) >> 0x08 ) & 0xf )
> +#define LASAT_W0_BUSSPEED(v)		( ( (v) >> 0x0c ) & 0xf )
> +#define LASAT_W0_CPUCLK(v)		( ( (v) >> 0x10 ) & 0xf )
> +#define LASAT_W0_SDRAMBANKSZ(v)		( ( (v) >> 0x14 ) & 0xf )
> +#define LASAT_W0_SDRAMBANKS(v)		( ( (v) >> 0x18 ) & 0xf )
> +#define LASAT_W0_L2CACHE(v)		( ( (v) >> 0x1c ) & 0xf )
> +
> +#define LASAT_W1_EDHAC(v)		( ( (v)         ) & 0xf )
> +#define LASAT_W1_HIFN(v)		( ( (v) >> 0x04 ) & 0x1 )
> +#define LASAT_W1_ISDN(v)		( ( (v) >> 0x05 ) & 0x1 )
> +#define LASAT_W1_IDE(v)			( ( (v) >> 0x06 ) & 0x1 )
> +#define LASAT_W1_HDLC(v)		( ( (v) >> 0x07 ) & 0x1 )
> +#define LASAT_W1_USVERSION(v)		( ( (v) >> 0x08 ) & 0x1 )
> +#define LASAT_W1_4MACS(v)		( ( (v) >> 0x09 ) & 0x1 )
> +#define LASAT_W1_EXTSERIAL(v)		( ( (v) >> 0x0a ) & 0x1 )
> +#define LASAT_W1_FLASHSIZE(v)		( ( (v) >> 0x0c ) & 0xf )
> +#define LASAT_W1_PCISLOTS(v)		( ( (v) >> 0x10 ) & 0xf )
> +#define LASAT_W1_PCI1OPT(v)		( ( (v) >> 0x14 ) & 0xf )
> +#define LASAT_W1_PCI2OPT(v)		( ( (v) >> 0x18 ) & 0xf )
> +#define LASAT_W1_PCI3OPT(v)		( ( (v) >> 0x1c ) & 0xf )
> +
> +/* Routines specific to LASAT boards */
> +
> +#define LASAT_BMID_MASQUERADE2		0
> +#define LASAT_BMID_MASQUERADEPRO	1
> +#define LASAT_BMID_SAFEPIPE25			2
> +#define LASAT_BMID_SAFEPIPE50			3
> +#define LASAT_BMID_SAFEPIPE100		4
> +#define LASAT_BMID_SAFEPIPE5000		5
> +#define LASAT_BMID_SAFEPIPE7000		6
> +#define LASAT_BMID_SAFEPIPE1000		7
> +//#define LASAT_BMID_SAFEPIPE30		7
> +//#define LASAT_BMID_SAFEPIPE5100	8
> +//#define LASAT_BMID_SAFEPIPE7100	9
> +#define LASAT_BMID_UNKNOWN				0xf
> +#define LASAT_MAX_BMID_NAMES			9   // no larger than 15!
> +
> +#define LASAT_HAS_EDHAC			( 1 << 0 )
> +#define LASAT_EDHAC_FAST		( 1 << 1 )
> +#define LASAT_HAS_EADI			( 1 << 2 )
> +#define LASAT_HAS_HIFN			( 1 << 3 )
> +#define LASAT_HAS_ISDN			( 1 << 4 )
> +#define LASAT_HAS_LEASEDLINE_IF		( 1 << 5 )
> +#define LASAT_HAS_HDC			( 1 << 6 )
> +
> +#define LASAT_PRID_MASQUERADE2		0
> +#define LASAT_PRID_MASQUERADEPRO	1
> +#define LASAT_PRID_SAFEPIPE25			2
> +#define LASAT_PRID_SAFEPIPE50			3
> +#define LASAT_PRID_SAFEPIPE100		4
> +#define LASAT_PRID_SAFEPIPE5000		5
> +#define LASAT_PRID_SAFEPIPE7000		6
> +#define LASAT_PRID_SAFEPIPE30			7
> +#define LASAT_PRID_SAFEPIPE5100		8
> +#define LASAT_PRID_SAFEPIPE7100		9
> +
> +#define LASAT_PRID_SAFEPIPE1110		10
> +#define LASAT_PRID_SAFEPIPE3020		11
> +#define LASAT_PRID_SAFEPIPE3030		12
> +#define LASAT_PRID_SAFEPIPE5020		13
> +#define LASAT_PRID_SAFEPIPE5030		14
> +#define LASAT_PRID_SAFEPIPE1120		15
> +#define LASAT_PRID_SAFEPIPE1130		16
> +#define LASAT_PRID_SAFEPIPE6010		17
> +#define LASAT_PRID_SAFEPIPE6110		18
> +#define LASAT_PRID_SAFEPIPE6210		19
> +#define LASAT_PRID_SAFEPIPE1020		20
> +#define LASAT_PRID_SAFEPIPE1040		21
> +#define LASAT_PRID_SAFEPIPE1060		22
> +
> +struct lasat_info {
> +	unsigned int  li_cpu_hz;
> +	unsigned int  li_bus_hz;
> +	unsigned int  li_bmid;
> +	unsigned int  li_memsize;
> +	unsigned int  li_flash_size;
> +	unsigned int  li_prid;
> +	unsigned char li_bmstr[16];
> +	unsigned char li_namestr[32];
> +	unsigned char li_typestr[16];
> +	/* Info on the Flash layout */
> +	unsigned int  li_flash_base;
> +	unsigned long li_flashpart_base[LASAT_MTD_LAST];
> +	unsigned long li_flashpart_size[LASAT_MTD_LAST];
> +	struct lasat_eeprom_struct li_eeprom_info;
> +	unsigned int  li_eeprom_upgrade_version;
> +	unsigned int  li_debugaccess;
> +};
> +
> +extern struct lasat_info lasat_board_info;
> +
> +static inline unsigned long lasat_flash_partition_start(int partno)
> +{
> +	if (partno < 0 || partno >= LASAT_MTD_LAST)
> +		return 0;
> +
> +	return lasat_board_info.li_flashpart_base[partno];
> +}
> +
> +static inline unsigned long lasat_flash_partition_size(int partno)
> +{
> +	if (partno < 0 || partno >= LASAT_MTD_LAST)
> +		return 0;
> +
> +	return lasat_board_info.li_flashpart_size[partno];
> +}
> +
> +/* Called from setup() to initialize the global board_info struct */
> +extern int lasat_init_board_info(void);
> +
> +/* Write the modified EEPROM info struct */
> +extern void lasat_write_eeprom_info(void);
> +
> +#define N_MACHTYPES		2
> +/* for calibration of delays */
> +
> +/* the lasat_ndelay function is necessary because it is used at an
> + * early stage of the boot process where ndelay is not calibrated.
> + * It is used for the bit-banging rtc and eeprom drivers */
> +
> +#include <asm/delay.h>
> +/* calculating with the slowest board with 100 MHz clock */
> +#define LASAT_100_DIVIDER 20
> +/* All 200's run at 250 MHz clock */
> +#define LASAT_200_DIVIDER 8
> +
> +extern unsigned int lasat_ndelay_divider;
> +
> +static inline void lasat_ndelay(unsigned int ns)
> +{
> +            __delay(ns / lasat_ndelay_divider);
> +}
> +
> +#endif /* !defined (_LANGUAGE_ASSEMBLY) */
> +
> +#define LASAT_SERVICEMODE_MAGIC_1     0xdeadbeef
> +#define LASAT_SERVICEMODE_MAGIC_2     0xfedeabba
> +
> +/* Lasat 100 boards */
> +#define LASAT_GT_BASE           (KSEG1ADDR(0x14000000))
> +
> +/* Lasat 200 boards */
> +#define Vrc5074_PHYS_BASE       0x1fa00000
> +#define Vrc5074_BASE            (KSEG1ADDR(Vrc5074_PHYS_BASE))
> +#define PCI_WINDOW1             0x1a000000
> +
> +#endif /* _LASAT_H */
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
> +#define GT_ISA_IO_BASE	PCI_IO_BASE
> +
> +#endif /* _ASM_GT64120_LASAT_GT64120_DEP_H */
> diff --git a/include/asm-mips/nile4.h b/include/asm-mips/nile4.h
> new file mode 100644
> index 0000000..c3ca959
> --- /dev/null
> +++ b/include/asm-mips/nile4.h
> @@ -0,0 +1,310 @@
> +/*
> + *  asm-mips/nile4.h -- NEC Vrc-5074 Nile 4 definitions
> + *
> + *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
> + *                     Sony Software Development Center Europe (SDCE), Brussels
> + *
> + *  This file is based on the following documentation:
> + *
> + *	NEC Vrc 5074 System Controller Data Sheet, June 1998
> + */
> +
> +#ifndef _ASM_NILE4_H
> +#define _ASM_NILE4_H
> +
> +#define NILE4_BASE		0xbfa00000
> +#define NILE4_SIZE		0x00200000		/* 2 MB */
> +
> +
> +    /*
> +     *  Physical Device Address Registers (PDARs)
> +     */
> +
> +#define NILE4_SDRAM0	0x0000	/* SDRAM Bank 0 [R/W] */
> +#define NILE4_SDRAM1	0x0008	/* SDRAM Bank 1 [R/W] */
> +#define NILE4_DCS2	0x0010	/* Device Chip-Select 2 [R/W] */
> +#define NILE4_DCS3	0x0018	/* Device Chip-Select 3 [R/W] */
> +#define NILE4_DCS4	0x0020	/* Device Chip-Select 4 [R/W] */
> +#define NILE4_DCS5	0x0028	/* Device Chip-Select 5 [R/W] */
> +#define NILE4_DCS6	0x0030	/* Device Chip-Select 6 [R/W] */
> +#define NILE4_DCS7	0x0038	/* Device Chip-Select 7 [R/W] */
> +#define NILE4_DCS8	0x0040	/* Device Chip-Select 8 [R/W] */
> +#define NILE4_PCIW0	0x0060	/* PCI Address Window 0 [R/W] */
> +#define NILE4_PCIW1	0x0068	/* PCI Address Window 1 [R/W] */
> +#define NILE4_INTCS	0x0070	/* Controller Internal Registers and Devices */
> +				/* [R/W] */
> +#define NILE4_BOOTCS	0x0078	/* Boot ROM Chip-Select [R/W] */
> +
> +
> +    /*
> +     *  CPU Interface Registers
> +     */
> +
> +#define NILE4_CPUSTAT	0x0080	/* CPU Status [R/W] */
> +#define NILE4_INTCTRL	0x0088	/* Interrupt Control [R/W] */
> +#define NILE4_INTSTAT0	0x0090	/* Interrupt Status 0 [R] */
> +#define NILE4_INTSTAT1	0x0098	/* Interrupt Status 1 and CPU Interrupt */
> +				/* Enable [R/W] */
> +#define NILE4_INTCLR	0x00A0	/* Interrupt Clear [R/W] */
> +#define NILE4_INTPPES	0x00A8	/* PCI Interrupt Control [R/W] */
> +
> +
> +    /*
> +     *  Memory-Interface Registers
> +     */
> +
> +#define NILE4_MEMCTRL	0x00C0	/* Memory Control */
> +#define NILE4_ACSTIME	0x00C8	/* Memory Access Timing [R/W] */
> +#define NILE4_CHKERR	0x00D0	/* Memory Check Error Status [R] */
> +
> +
> +    /*
> +     *  PCI-Bus Registers
> +     */
> +
> +#define NILE4_PCICTRL	0x00E0	/* PCI Control [R/W] */
> +#define NILE4_PCIARB	0x00E8	/* PCI Arbiter [R/W] */
> +#define NILE4_PCIINIT0	0x00F0	/* PCI Master (Initiator) 0 [R/W] */
> +#define NILE4_PCIINIT1	0x00F8	/* PCI Master (Initiator) 1 [R/W] */
> +#define NILE4_PCIERR	0x00B8	/* PCI Error [R/W] */
> +
> +
> +    /*
> +     *  Local-Bus Registers
> +     */
> +
> +#define NILE4_LCNFG	0x0100	/* Local Bus Configuration [R/W] */
> +#define NILE4_LCST2	0x0110	/* Local Bus Chip-Select Timing 2 [R/W] */
> +#define NILE4_LCST3	0x0118	/* Local Bus Chip-Select Timing 3 [R/W] */
> +#define NILE4_LCST4	0x0120	/* Local Bus Chip-Select Timing 4 [R/W] */
> +#define NILE4_LCST5	0x0128	/* Local Bus Chip-Select Timing 5 [R/W] */
> +#define NILE4_LCST6	0x0130	/* Local Bus Chip-Select Timing 6 [R/W] */
> +#define NILE4_LCST7	0x0138	/* Local Bus Chip-Select Timing 7 [R/W] */
> +#define NILE4_LCST8	0x0140	/* Local Bus Chip-Select Timing 8 [R/W] */
> +#define NILE4_DCSFN	0x0150	/* Device Chip-Select Muxing and Output */
> +				/* Enables [R/W] */
> +#define NILE4_DCSIO	0x0158	/* Device Chip-Selects As I/O Bits [R/W] */
> +#define NILE4_BCST	0x0178	/* Local Boot Chip-Select Timing [R/W] */
> +
> +
> +    /*
> +     *  DMA Registers
> +     */
> +
> +#define NILE4_DMACTRL0	0x0180	/* DMA Control 0 [R/W] */
> +#define NILE4_DMASRCA0	0x0188	/* DMA Source Address 0 [R/W] */
> +#define NILE4_DMADESA0	0x0190	/* DMA Destination Address 0 [R/W] */
> +#define NILE4_DMACTRL1	0x0198	/* DMA Control 1 [R/W] */
> +#define NILE4_DMASRCA1	0x01A0	/* DMA Source Address 1 [R/W] */
> +#define NILE4_DMADESA1	0x01A8	/* DMA Destination Address 1 [R/W] */
> +
> +
> +    /*
> +     *  Timer Registers
> +     */
> +
> +#define NILE4_T0CTRL	0x01C0	/* SDRAM Refresh Control [R/W] */
> +#define NILE4_T0CNTR	0x01C8	/* SDRAM Refresh Counter [R/W] */
> +#define NILE4_T1CTRL	0x01D0	/* CPU-Bus Read Time-Out Control [R/W] */
> +#define NILE4_T1CNTR	0x01D8	/* CPU-Bus Read Time-Out Counter [R/W] */
> +#define NILE4_T2CTRL	0x01E0	/* General-Purpose Timer Control [R/W] */
> +#define NILE4_T2CNTR	0x01E8	/* General-Purpose Timer Counter [R/W] */
> +#define NILE4_T3CTRL	0x01F0	/* Watchdog Timer Control [R/W] */
> +#define NILE4_T3CNTR	0x01F8	/* Watchdog Timer Counter [R/W] */
> +
> +
> +    /*
> +     *  PCI Configuration Space Registers
> +     */
> +
> +#define NILE4_PCI_BASE	0x0200
> +
> +#define NILE4_VID	0x0200	/* PCI Vendor ID [R] */
> +#define NILE4_DID	0x0202	/* PCI Device ID [R] */
> +#define NILE4_PCICMD	0x0204	/* PCI Command [R/W] */
> +#define NILE4_PCISTS	0x0206	/* PCI Status [R/W] */
> +#define NILE4_REVID	0x0208	/* PCI Revision ID [R] */
> +#define NILE4_CLASS	0x0209	/* PCI Class Code [R] */
> +#define NILE4_CLSIZ	0x020C	/* PCI Cache Line Size [R/W] */
> +#define NILE4_MLTIM	0x020D	/* PCI Latency Timer [R/W] */
> +#define NILE4_HTYPE	0x020E	/* PCI Header Type [R] */
> +#define NILE4_BIST	0x020F	/* BIST [R] (unimplemented) */
> +#define NILE4_BARC	0x0210	/* PCI Base Address Register Control [R/W] */
> +#define NILE4_BAR0	0x0218	/* PCI Base Address Register 0 [R/W] */
> +#define NILE4_BAR1	0x0220	/* PCI Base Address Register 1 [R/W] */
> +#define NILE4_CIS	0x0228	/* PCI Cardbus CIS Pointer [R] */
> +				/* (unimplemented) */
> +#define NILE4_SSVID	0x022C	/* PCI Sub-System Vendor ID [R/W] */
> +#define NILE4_SSID	0x022E	/* PCI Sub-System ID [R/W] */
> +#define NILE4_ROM	0x0230	/* Expansion ROM Base Address [R] */
> +				/* (unimplemented) */
> +#define NILE4_INTLIN	0x023C	/* PCI Interrupt Line [R/W] */
> +#define NILE4_INTPIN	0x023D	/* PCI Interrupt Pin [R] */
> +#define NILE4_MINGNT	0x023E	/* PCI Min_Gnt [R] (unimplemented) */
> +#define NILE4_MAXLAT	0x023F	/* PCI Max_Lat [R] (unimplemented) */
> +#define NILE4_BAR2	0x0240	/* PCI Base Address Register 2 [R/W] */
> +#define NILE4_BAR3	0x0248	/* PCI Base Address Register 3 [R/W] */
> +#define NILE4_BAR4	0x0250	/* PCI Base Address Register 4 [R/W] */
> +#define NILE4_BAR5	0x0258	/* PCI Base Address Register 5 [R/W] */
> +#define NILE4_BAR6	0x0260	/* PCI Base Address Register 6 [R/W] */
> +#define NILE4_BAR7	0x0268	/* PCI Base Address Register 7 [R/W] */
> +#define NILE4_BAR8	0x0270	/* PCI Base Address Register 8 [R/W] */
> +#define NILE4_BARB	0x0278	/* PCI Base Address Register BOOT [R/W] */
> +
> +
> +    /*
> +     *  Serial-Port Registers
> +     */
> +
> +#define NILE4_UART_BASE	0x0300
> +
> +#define NILE4_UARTRBR	0x0300	/* UART Receiver Data Buffer [R] */
> +#define NILE4_UARTTHR	0x0300	/* UART Transmitter Data Holding [W] */
> +#define NILE4_UARTIER	0x0308	/* UART Interrupt Enable [R/W] */
> +#define NILE4_UARTDLL	0x0300	/* UART Divisor Latch LSB [R/W] */
> +#define NILE4_UARTDLM	0x0308	/* UART Divisor Latch MSB [R/W] */
> +#define NILE4_UARTIIR	0x0310	/* UART Interrupt ID [R] */
> +#define NILE4_UARTFCR	0x0310	/* UART FIFO Control [W] */
> +#define NILE4_UARTLCR	0x0318	/* UART Line Control [R/W] */
> +#define NILE4_UARTMCR	0x0320	/* UART Modem Control [R/W] */
> +#define NILE4_UARTLSR	0x0328	/* UART Line Status [R/W] */
> +#define NILE4_UARTMSR	0x0330	/* UART Modem Status [R/W] */
> +#define NILE4_UARTSCR	0x0338	/* UART Scratch [R/W] */
> +
> +#define NILE4_UART_BASE_BAUD	520833	/* 100 MHz / 12 / 16 */
> +
> +
> +    /*
> +     *  Interrupt Lines
> +     */
> +
> +#define NILE4_INT_CPCE	0	/* CPU-Interface Parity-Error Interrupt */
> +#define NILE4_INT_CNTD	1	/* CPU No-Target Decode Interrupt */
> +#define NILE4_INT_MCE	2	/* Memory-Check Error Interrupt */
> +#define NILE4_INT_DMA	3	/* DMA Controller Interrupt */
> +#define NILE4_INT_UART	4	/* UART Interrupt */
> +#define NILE4_INT_WDOG	5	/* Watchdog Timer Interrupt */
> +#define NILE4_INT_GPT	6	/* General-Purpose Timer Interrupt */
> +#define NILE4_INT_LBRTD	7	/* Local-Bus Ready Timer Interrupt */
> +#define NILE4_INT_INTA	8	/* PCI Interrupt Signal INTA# */
> +#define NILE4_INT_INTB	9	/* PCI Interrupt Signal INTB# */
> +#define NILE4_INT_INTC	10	/* PCI Interrupt Signal INTC# */
> +#define NILE4_INT_INTD	11	/* PCI Interrupt Signal INTD# */
> +#define NILE4_INT_INTE	12	/* PCI Interrupt Signal INTE# (ISA cascade) */
> +#define NILE4_INT_RESV	13	/* Reserved */
> +#define NILE4_INT_PCIS	14	/* PCI SERR# Interrupt */
> +#define NILE4_INT_PCIE	15	/* PCI Internal Error Interrupt */
> +
> +
> +    /*
> +     *  Nile 4 Register Access
> +     */
> +
> +static inline void nile4_sync(void)
> +{
> +    volatile u32 *p = (volatile u32 *)0xbfc00000;
> +    (void)(*p);
> +}
> +
> +static inline void nile4_out32(u32 offset, u32 val)
> +{
> +    *(volatile u32 *)(NILE4_BASE+offset) = val;
> +    nile4_sync();
> +}
> +
> +static inline u32 nile4_in32(u32 offset)
> +{
> +    u32 val = *(volatile u32 *)(NILE4_BASE+offset);
> +    nile4_sync();
> +    return val;
> +}
> +
> +static inline void nile4_out16(u32 offset, u16 val)
> +{
> +    *(volatile u16 *)(NILE4_BASE+offset) = val;
> +    nile4_sync();
> +}
> +
> +static inline u16 nile4_in16(u32 offset)
> +{
> +    u16 val = *(volatile u16 *)(NILE4_BASE+offset);
> +    nile4_sync();
> +    return val;
> +}
> +
> +static inline void nile4_out8(u32 offset, u8 val)
> +{
> +    *(volatile u8 *)(NILE4_BASE+offset) = val;
> +    nile4_sync();
> +}
> +
> +static inline u8 nile4_in8(u32 offset)
> +{
> +    u8 val = *(volatile u8 *)(NILE4_BASE+offset);
> +    nile4_sync();
> +    return val;
> +}
> +
> +
> +    /*
> +     *  Physical Device Address Registers
> +     */
> +
> +extern void nile4_set_pdar(u32 pdar, u32 phys, u32 size, int width,
> +			   int on_memory_bus, int visible);
> +
> +
> +    /*
> +     *  PCI Master Registers
> +     */
> +
> +#define NILE4_PCICMD_IACK	0	/* PCI Interrupt Acknowledge */
> +#define NILE4_PCICMD_IO		1	/* PCI I/O Space */
> +#define NILE4_PCICMD_MEM	3	/* PCI Memory Space */
> +#define NILE4_PCICMD_CFG	5	/* PCI Configuration Space */
> +
> +
> +    /*
> +     *  PCI Address Spaces
> +     *
> +     *  Note that these are multiplexed using PCIINIT[01]!
> +     */
> +
> +#define NILE4_PCI_IO_BASE	0xa6000000
> +#define NILE4_PCI_MEM_BASE	0xa8000000
> +#define NILE4_PCI_CFG_BASE	NILE4_PCI_MEM_BASE
> +#define NILE4_PCI_IACK_BASE	NILE4_PCI_IO_BASE
> +
> +
> +extern void nile4_set_pmr(u32 pmr, u32 type, u32 addr);
> +
> +
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
> +
> +#endif

There also was record breaking pile of modpost messages:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x102b04): Section mismatch: reference to .init.text:pcibios_fixup_bus (between 'pci_scan_child_bus' and 'pci_scan_bus_parented')
WARNING: vmlinux.o(.text+0x10775c): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_map_rom' and 'pci_map_rom_copy')
WARNING: vmlinux.o(.text+0x107ab4): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_update_resource' and 'pci_claim_resource')
WARNING: vmlinux.o(.text+0x108974): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_setup_cardbus' and 'pci_bus_assign_resources')
WARNING: vmlinux.o(.text+0x1089d4): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_setup_cardbus' and 'pci_bus_assign_resources')
WARNING: vmlinux.o(.text+0x108a34): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_setup_cardbus' and 'pci_bus_assign_resources')
WARNING: vmlinux.o(.text+0x108a94): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_setup_cardbus' and 'pci_bus_assign_resources')
WARNING: vmlinux.o(.text+0x108c7c): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_bus_assign_resources' and 'pbus_size_mem')
WARNING: vmlinux.o(.text+0x108d50): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_bus_assign_resources' and 'pbus_size_mem')
WARNING: vmlinux.o(.text+0x108de0): Section mismatch: reference to .init.text:pcibios_resource_to_bus (between 'pci_bus_assign_resources' and 'pbus_size_mem')

Which isn't your patch's fault it's just yet more brokeness for the
CONFIG_PCI && !CONFIG_HOTPLUG case.

So with plenty of fixes your code is now in the -queue tree and you may
want to test if it's still in good working order and as usual there is
always a little more that could be cleaned and polished ...

  Ralf
