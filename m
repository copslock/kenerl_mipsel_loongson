Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 16:44:31 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.248]:12974 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022132AbXITPoU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 16:44:20 +0100
Received: by an-out-0708.google.com with SMTP id d26so83523and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 08:44:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=Fj3Sr75g0pQde5lY8PIzDA4IqXsK8krrfBbZY74RtzM=;
        b=oLRgN3yB1IZcB1Zy8FGHXQC3+gCkrK8/3fGwU+PGW3yspRdbrcgoNouRoV6hK0Z/tjQ8Bi/43z4DMAy+3jqjCcIytKKvwq+I0yQyKpscuDl/dsFr878yL9GNywAdPHuWQm/R6r98eHxI/03t0HW2MXo1MYEF01qw09xcpaLfH/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=SFFs32QZgEGDYdma65/yxc4j+H9OJpfP3i8FgEu6ttG2de3j47ShJTurnlBjfkjQ98NOJRUzlG3X8A0XzgZFyzUOZRHhKKzh+Xuja6GIjyxcsPrTNZCM5JJJGh/+t5BkEOlInd131nyE0P2TPovTHQ/79PJtGhg7FewVSPymZDc=
Received: by 10.100.165.9 with SMTP id n9mr3979778ane.1190303041244;
        Thu, 20 Sep 2007 08:44:01 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id 30sm1438517hso.2007.09.20.08.43.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 08:43:59 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][1/7] AR7: core support
Date:	Thu, 20 Sep 2007 17:43:46 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	Nicolas Thill <nico@openwrt.org>, ralf@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200709201728.10866.technoboy85@gmail.com>
In-Reply-To: <200709201728.10866.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200709201743.48164.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Support for memory mapping, clock and the vlynq bus

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3b807b4..10a95eb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -15,6 +15,22 @@ choice
 	prompt "System type"
 	default SGI_IP22
 
+config AR7
+	bool "Texas Instruments AR7"
+	select BOOT_ELF32
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_KGDB
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select GENERIC_GPIO
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 32c1c8f..3989a8b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -161,6 +161,13 @@ libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/sibyte/cfe/
 #
 
 #
+# Texas Instruments AR7
+#
+core-$(CONFIG_AR7)		+= arch/mips/ar7/
+cflags-$(CONFIG_AR7)		+= -Iinclude/asm-mips/ar7
+load-$(CONFIG_AR7)		+= 0xffffffff94100000
+
+#
 # Acer PICA 61, Mips Magnum 4000 and Olivetti M700.
 #
 core-$(CONFIG_MACH_JAZZ)	+= arch/mips/jazz/
diff --git a/arch/mips/ar7/Makefile b/arch/mips/ar7/Makefile
new file mode 100644
index 0000000..bd10957
--- /dev/null
+++ b/arch/mips/ar7/Makefile
@@ -0,0 +1,14 @@
+
+obj-y := \
+	prom.o \
+	setup.o \
+	memory.o \
+	irq.o \
+	time.o \
+	platform.o \
+	gpio.o \
+	clock.o \
+	vlynq.o
+
+obj-$(CONFIG_PCI) += \
+	vlynq-pci.o
diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
new file mode 100644
index 0000000..ecbcbf0
--- /dev/null
+++ b/arch/mips/ar7/clock.c
@@ -0,0 +1,485 @@
+/*
+ * Copyright (C) 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/ar7/ar7.h>
+
+#define BOOT_PLL_SOURCE_MASK	0x3
+#define CPU_PLL_SOURCE_SHIFT	16
+#define BUS_PLL_SOURCE_SHIFT	14
+#define USB_PLL_SOURCE_SHIFT	18
+#define DSP_PLL_SOURCE_SHIFT	22
+#define BOOT_PLL_SOURCE_AFE	0
+#define BOOT_PLL_SOURCE_BUS	0
+#define BOOT_PLL_SOURCE_REF	1
+#define BOOT_PLL_SOURCE_XTAL	2
+#define BOOT_PLL_SOURCE_CPU	3
+#define BOOT_PLL_BYPASS		0x00000020
+#define BOOT_PLL_ASYNC_MODE	0x02000000
+#define BOOT_PLL_2TO1_MODE	0x00008000
+
+#define TNETD7200_CLOCK_ID_CPU	0
+#define TNETD7200_CLOCK_ID_DSP	1
+#define TNETD7200_CLOCK_ID_USB	2
+
+#define TNETD7200_DEF_CPU_CLK	211000000
+#define TNETD7200_DEF_DSP_CLK	125000000
+#define TNETD7200_DEF_USB_CLK	48000000
+
+struct tnetd7300_clock {
+	volatile u32 ctrl;
+#define PREDIV_MASK	0x001f0000
+#define PREDIV_SHIFT	16
+#define POSTDIV_MASK	0x0000001f
+	u32 unused1[3];
+	volatile u32 pll;
+#define MUL_MASK	0x0000f000
+#define MUL_SHIFT	12
+#define PLL_MODE_MASK	0x00000001
+#define PLL_NDIV	0x00000800
+#define PLL_DIV		0x00000002
+#define PLL_STATUS	0x00000001
+	u32 unused2[3];
+} __packed;
+
+struct tnetd7300_clocks {
+	struct tnetd7300_clock bus;
+	struct tnetd7300_clock cpu;
+	struct tnetd7300_clock usb;
+	struct tnetd7300_clock dsp;
+} __packed;
+
+struct tnetd7200_clock {
+	volatile u32 ctrl;
+	u32 unused1[3];
+#define DIVISOR_ENABLE_MASK 0x00008000
+	volatile u32 mul;
+	volatile u32 prediv;
+	volatile u32 postdiv;
+	volatile u32 postdiv2;
+	u32 unused2[6];
+	volatile u32 cmd;
+	volatile u32 status;
+	volatile u32 cmden;
+	u32 padding[15];
+} __packed;
+
+struct tnetd7200_clocks {
+	struct tnetd7200_clock cpu;
+	struct tnetd7200_clock dsp;
+	struct tnetd7200_clock usb;
+} __packed;
+
+int ar7_cpu_clock = 150000000;
+EXPORT_SYMBOL(ar7_cpu_clock);
+int ar7_bus_clock = 125000000;
+EXPORT_SYMBOL(ar7_bus_clock);
+int ar7_dsp_clock;
+EXPORT_SYMBOL(ar7_dsp_clock);
+
+static int gcd(int a, int b)
+{
+	int c;
+
+	if (a < b) {
+		c = a;
+		a = b;
+		b = c;
+	}
+	while ((c = (a % b))) {
+		a = b;
+		b = c;
+	}
+	return b;
+}
+
+static void approximate(int base, int target, int *prediv,
+			int *postdiv, int *mul)
+{
+	int i, j, k, freq, res = target;
+	for (i = 1; i <= 16; i++)
+		for (j = 1; j <= 32; j++)
+			for (k = 1; k <= 32; k++) {
+				freq = abs(base / j * i / k - target);
+				if (freq < res) {
+					res = freq;
+					*mul = i;
+					*prediv = j;
+					*postdiv = k;
+				}
+			}
+}
+
+static void calculate(int base, int target, int *prediv, int *postdiv,
+	int *mul)
+{
+	int tmp_gcd, tmp_base, tmp_freq;
+
+	for (*prediv = 1; *prediv <= 32; (*prediv)++) {
+		tmp_base = base / *prediv;
+		tmp_gcd = gcd(target, tmp_base);
+		*mul = target / tmp_gcd;
+		*postdiv = tmp_base / tmp_gcd;
+		if ((*mul < 1) || (*mul >= 16))
+			continue;
+		if ((*postdiv > 0) & (*postdiv <= 32))
+			break;
+	}
+
+	if (base / (*prediv) * (*mul) / (*postdiv) != target) {
+		approximate(base, target, prediv, postdiv, mul);
+		tmp_freq = base / (*prediv) * (*mul) / (*postdiv);
+		printk(KERN_WARNING
+		       "Adjusted requested frequency %d to %d\n",
+		       target, tmp_freq);
+	}
+
+	printk(KERN_DEBUG "Clocks: prediv: %d, postdiv: %d, mul: %d\n",
+	       *prediv, *postdiv, *mul);
+}
+
+static int tnetd7300_dsp_clock(void)
+{
+	u32 didr1, didr2;
+	u8 rev = ar7_chip_rev();
+	didr1 = readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x18));
+	didr2 = readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x1c));
+	if (didr2 & (1 << 23))
+		return 0;
+	if ((rev >= 0x23) && (rev != 0x57))
+		return 250000000;
+	if ((((didr2 & 0x1fff) << 10) | ((didr1 & 0xffc00000) >> 22))
+	    > 4208000)
+		return 250000000;
+	return 0;
+}
+
+static int tnetd7300_get_clock(u32 shift, struct tnetd7300_clock *clock,
+	u32 *bootcr, u32 bus_clock)
+{
+	int product;
+	int base_clock = AR7_REF_CLOCK;
+	u32 ctrl = clock->ctrl;
+	u32 pll = clock->pll;
+	int prediv = ((ctrl & PREDIV_MASK) >> PREDIV_SHIFT) + 1;
+	int postdiv = (ctrl & POSTDIV_MASK) + 1;
+	int divisor = prediv * postdiv;
+	int mul = ((pll & MUL_MASK) >> MUL_SHIFT) + 1;
+
+	switch ((*bootcr & (BOOT_PLL_SOURCE_MASK << shift)) >> shift) {
+	case BOOT_PLL_SOURCE_BUS:
+		base_clock = bus_clock;
+		break;
+	case BOOT_PLL_SOURCE_REF:
+		base_clock = AR7_REF_CLOCK;
+		break;
+	case BOOT_PLL_SOURCE_XTAL:
+		base_clock = AR7_XTAL_CLOCK;
+		break;
+	case BOOT_PLL_SOURCE_CPU:
+		base_clock = ar7_cpu_clock;
+		break;
+	}
+
+	if (*bootcr & BOOT_PLL_BYPASS)
+		return base_clock / divisor;
+
+	if ((pll & PLL_MODE_MASK) == 0)
+		return (base_clock >> (mul / 16 + 1)) / divisor;
+
+	if ((pll & (PLL_NDIV | PLL_DIV)) == (PLL_NDIV | PLL_DIV)) {
+		product = (mul & 1) ?
+			(base_clock * mul) >> 1 :
+			(base_clock * (mul - 1)) >> 2;
+		return product / divisor;
+	}
+
+	if (mul == 16)
+		return base_clock / divisor;
+
+	return base_clock * mul / divisor;
+}
+
+static void tnetd7300_set_clock(u32 shift, struct tnetd7300_clock *clock,
+	u32 *bootcr, u32 frequency)
+{
+	u32 status;
+	int prediv, postdiv, mul;
+	int base_clock = ar7_bus_clock;
+
+	switch ((*bootcr & (BOOT_PLL_SOURCE_MASK << shift)) >> shift) {
+	case BOOT_PLL_SOURCE_BUS:
+		base_clock = ar7_bus_clock;
+		break;
+	case BOOT_PLL_SOURCE_REF:
+		base_clock = AR7_REF_CLOCK;
+		break;
+	case BOOT_PLL_SOURCE_XTAL:
+		base_clock = AR7_XTAL_CLOCK;
+		break;
+	case BOOT_PLL_SOURCE_CPU:
+		base_clock = ar7_cpu_clock;
+		break;
+	}
+
+	calculate(base_clock, frequency, &prediv, &postdiv, &mul);
+
+	clock->ctrl = ((prediv - 1) << PREDIV_SHIFT) | (postdiv - 1);
+	mdelay(1);
+	clock->pll = 4;
+	do
+		status = clock->pll;
+	while (status & PLL_STATUS);
+	clock->pll = ((mul - 1) << MUL_SHIFT) | (0xff << 3) | 0x0e;
+	mdelay(75);
+}
+
+static void __init tnetd7300_init_clocks(void)
+{
+	u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
+	struct tnetd7300_clocks *clocks =
+					(struct tnetd7300_clocks *)
+					ioremap_nocache(AR7_REGS_POWER + 0x20,
+					sizeof(struct tnetd7300_clocks));
+
+	ar7_bus_clock = tnetd7300_get_clock(BUS_PLL_SOURCE_SHIFT,
+		&clocks->bus, bootcr, AR7_AFE_CLOCK);
+
+	if (*bootcr & BOOT_PLL_ASYNC_MODE)
+		ar7_cpu_clock = tnetd7300_get_clock(CPU_PLL_SOURCE_SHIFT,
+			&clocks->cpu, bootcr, AR7_AFE_CLOCK);
+	else
+		ar7_cpu_clock = ar7_bus_clock;
+/*
+	tnetd7300_set_clock(USB_PLL_SOURCE_SHIFT, &clocks->usb,
+		bootcr, 48000000);
+*/
+	if (ar7_dsp_clock == 250000000)
+		tnetd7300_set_clock(DSP_PLL_SOURCE_SHIFT, &clocks->dsp,
+			bootcr, ar7_dsp_clock);
+
+	iounmap(clocks);
+	iounmap(bootcr);
+}
+
+static int tnetd7200_get_clock(int base, struct tnetd7200_clock *clock,
+	u32 *bootcr, u32 bus_clock)
+{
+	int divisor = ((clock->prediv & 0x1f) + 1) *
+		((clock->postdiv & 0x1f) + 1);
+
+	if (*bootcr & BOOT_PLL_BYPASS)
+		return base / divisor;
+
+	return base * ((clock->mul & 0xf) + 1) / divisor;
+}
+
+
+static void tnetd7200_set_clock(int base, struct tnetd7200_clock *clock,
+	int prediv, int postdiv, int postdiv2, int mul, u32 frequency)
+{
+	printk(KERN_INFO
+		"Clocks: base = %d, frequency = %u, prediv = %d, "
+		"postdiv = %d, postdiv2 = %d, mul = %d\n",
+		base, frequency, prediv, postdiv, postdiv2, mul);
+
+	clock->ctrl = 0;
+	clock->prediv = DIVISOR_ENABLE_MASK | ((prediv - 1) & 0x1F);
+	clock->mul = ((mul - 1) & 0xF);
+
+	for (mul = 0; mul < 2000; mul++) /* nop */;
+
+	while (clock->status & 0x1) /* nop */;
+
+	clock->postdiv = DIVISOR_ENABLE_MASK | ((postdiv - 1) & 0x1F);
+
+	clock->cmden |= 1;
+	clock->cmd |= 1;
+
+	while (clock->status & 0x1) /* nop */;
+
+	clock->postdiv2 = DIVISOR_ENABLE_MASK | ((postdiv2 - 1) & 0x1F);
+
+	clock->cmden |= 1;
+	clock->cmd |= 1;
+
+	while (clock->status & 0x1) /* nop */;
+
+	clock->ctrl |= 1;
+}
+
+static int tnetd7200_get_clock_base(int clock_id, u32 *bootcr)
+{
+	if (*bootcr & BOOT_PLL_ASYNC_MODE)
+		/* Async */
+		switch (clock_id) {
+		case TNETD7200_CLOCK_ID_DSP:
+			return AR7_REF_CLOCK;
+		default:
+			return AR7_AFE_CLOCK;
+		}
+	else
+		/* Sync */
+		if (*bootcr & BOOT_PLL_2TO1_MODE)
+			/* 2:1 */
+			switch (clock_id) {
+			case TNETD7200_CLOCK_ID_DSP:
+				return AR7_REF_CLOCK;
+			default:
+				return AR7_AFE_CLOCK;
+			}
+		else
+			/* 1:1 */
+			return AR7_REF_CLOCK;
+}
+
+
+static void __init tnetd7200_init_clocks(void)
+{
+	u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
+	struct tnetd7200_clocks *clocks =
+					(struct tnetd7200_clocks *)
+					ioremap_nocache(AR7_REGS_POWER + 0x80,
+					sizeof(struct tnetd7200_clocks));
+	int cpu_base, cpu_mul, cpu_prediv, cpu_postdiv;
+	int dsp_base, dsp_mul, dsp_prediv, dsp_postdiv;
+	int usb_base, usb_mul, usb_prediv, usb_postdiv;
+
+/*
+	Log from Fritz!Box 7170 Annex B:
+
+	CPU revision is: 00018448
+	Clocks: Async mode
+	Clocks: Setting DSP clock
+	Clocks: prediv: 1, postdiv: 1, mul: 5
+	Clocks: base = 25000000, frequency = 125000000, prediv = 1,
+			postdiv = 2, postdiv2 = 1, mul = 10
+	Clocks: Setting CPU clock
+	Adjusted requested frequency 211000000 to 211968000
+	Clocks: prediv: 1, postdiv: 1, mul: 6
+	Clocks: base = 35328000, frequency = 211968000, prediv = 1,
+			postdiv = 1, postdiv2 = -1, mul = 6
+	Clocks: Setting USB clock
+	Adjusted requested frequency 48000000 to 48076920
+	Clocks: prediv: 13, postdiv: 1, mul: 5
+	Clocks: base = 125000000, frequency = 48000000, prediv = 13,
+			postdiv = 1, postdiv2 = -1, mul = 5
+
+	DSL didn't work if you didn't set the postdiv 2:1 postdiv2 combination,
+	driver hung on startup.
+	Haven't tested this on a synchronous board,
+	neither do i know what to do with ar7_dsp_clock
+*/
+
+	cpu_base = tnetd7200_get_clock_base(TNETD7200_CLOCK_ID_CPU, bootcr);
+	dsp_base = tnetd7200_get_clock_base(TNETD7200_CLOCK_ID_DSP, bootcr);
+
+	if (*bootcr & BOOT_PLL_ASYNC_MODE) {
+		printk(KERN_INFO "Clocks: Async mode\n");
+
+		printk(KERN_INFO "Clocks: Setting DSP clock\n");
+		calculate(dsp_base, TNETD7200_DEF_DSP_CLK,
+			&dsp_prediv, &dsp_postdiv, &dsp_mul);
+		ar7_bus_clock =
+			((dsp_base / dsp_prediv) * dsp_mul) / dsp_postdiv;
+		tnetd7200_set_clock(dsp_base, &clocks->dsp,
+			dsp_prediv, dsp_postdiv * 2, dsp_postdiv, dsp_mul * 2,
+			ar7_bus_clock);
+
+		printk(KERN_INFO "Clocks: Setting CPU clock\n");
+		calculate(cpu_base, TNETD7200_DEF_CPU_CLK, &cpu_prediv,
+			&cpu_postdiv, &cpu_mul);
+		ar7_cpu_clock =
+			((cpu_base / cpu_prediv) * cpu_mul) / cpu_postdiv;
+		tnetd7200_set_clock(cpu_base, &clocks->cpu,
+			cpu_prediv, cpu_postdiv, -1, cpu_mul,
+			ar7_cpu_clock);
+
+	} else
+		if (*bootcr & BOOT_PLL_2TO1_MODE) {
+			printk(KERN_INFO "Clocks: Sync 2:1 mode\n");
+
+			printk(KERN_INFO "Clocks: Setting CPU clock\n");
+			calculate(cpu_base, TNETD7200_DEF_CPU_CLK, &cpu_prediv,
+				&cpu_postdiv, &cpu_mul);
+			ar7_cpu_clock = ((cpu_base / cpu_prediv) * cpu_mul)
+								/ cpu_postdiv;
+			tnetd7200_set_clock(cpu_base, &clocks->cpu,
+				cpu_prediv, cpu_postdiv, -1, cpu_mul,
+				ar7_cpu_clock);
+
+			printk(KERN_INFO "Clocks: Setting DSP clock\n");
+			calculate(dsp_base, TNETD7200_DEF_DSP_CLK, &dsp_prediv,
+				&dsp_postdiv, &dsp_mul);
+			ar7_bus_clock = ar7_cpu_clock / 2;
+			tnetd7200_set_clock(dsp_base, &clocks->dsp,
+				dsp_prediv, dsp_postdiv * 2, dsp_postdiv,
+				dsp_mul * 2, ar7_bus_clock);
+		} else {
+			printk(KERN_INFO "Clocks: Sync 1:1 mode\n");
+
+			printk(KERN_INFO "Clocks: Setting DSP clock\n");
+			calculate(dsp_base, TNETD7200_DEF_CPU_CLK, &dsp_prediv,
+				&dsp_postdiv, &dsp_mul);
+			ar7_bus_clock = ((dsp_base / dsp_prediv) * dsp_mul)
+								/ dsp_postdiv;
+			tnetd7200_set_clock(dsp_base, &clocks->dsp,
+				dsp_prediv, dsp_postdiv * 2, dsp_postdiv,
+				dsp_mul * 2, ar7_bus_clock);
+
+			ar7_cpu_clock = ar7_bus_clock;
+		}
+
+	printk(KERN_INFO "Clocks: Setting USB clock\n");
+	usb_base = ar7_bus_clock;
+	calculate(usb_base, TNETD7200_DEF_USB_CLK, &usb_prediv,
+		&usb_postdiv, &usb_mul);
+	tnetd7200_set_clock(usb_base, &clocks->usb,
+		usb_prediv, usb_postdiv, -1, usb_mul,
+		TNETD7200_DEF_USB_CLK);
+
+	#warning FIXME
+	ar7_dsp_clock = ar7_cpu_clock;
+
+	iounmap(clocks);
+	iounmap(bootcr);
+}
+
+void __init ar7_init_clocks(void)
+{
+	switch (ar7_chip_id()) {
+	case AR7_CHIP_7100:
+#warning FIXME: Check if the new 7200 clock init works for 7100
+		tnetd7200_init_clocks();
+		break;
+	case AR7_CHIP_7200:
+		tnetd7200_init_clocks();
+		break;
+	case AR7_CHIP_7300:
+		ar7_dsp_clock = tnetd7300_dsp_clock();
+		tnetd7300_init_clocks();
+		break;
+	default:
+		break;
+	}
+}
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
new file mode 100644
index 0000000..83ba1fd
--- /dev/null
+++ b/arch/mips/ar7/gpio.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+
+#include <asm/ar7/gpio.h>
+
+static char *ar7_gpio_list[AR7_GPIO_MAX] = { 0, };
+
+int gpio_request(unsigned gpio, char *label)
+{
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	if (ar7_gpio_list[gpio])
+		return -EBUSY;
+
+	if (label) {
+		ar7_gpio_list[gpio] = label;
+	} else {
+		ar7_gpio_list[gpio] = "busy";
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(gpio_request);
+
+void gpio_free(unsigned gpio)
+{
+	BUG_ON(!ar7_gpio_list[gpio]);
+	ar7_gpio_list[gpio] = NULL;
+}
+EXPORT_SYMBOL(gpio_free);
diff --git a/arch/mips/ar7/irq.c b/arch/mips/ar7/irq.c
new file mode 100644
index 0000000..e9e0b15
--- /dev/null
+++ b/arch/mips/ar7/irq.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2006, 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/ar7/ar7.h>
+
+#define EXCEPT_OFFSET	0x80
+#define PACE_OFFSET	0xA0
+#define CHNLS_OFFSET	0x200
+
+#define REG_OFFSET(irq, reg)	((irq) / 32 * 0x4 + reg * 0x10)
+#define SEC_REG_OFFSET(reg)	(EXCEPT_OFFSET + reg * 0x8)
+#define SEC_SR_OFFSET		(SEC_REG_OFFSET(0))	/* 0x80 */
+#define CR_OFFSET(irq)		(REG_OFFSET(irq, 1))	/* 0x10 */
+#define SEC_CR_OFFSET		(SEC_REG_OFFSET(1))	/* 0x88 */
+#define ESR_OFFSET(irq)		(REG_OFFSET(irq, 2))	/* 0x20 */
+#define SEC_ESR_OFFSET		(SEC_REG_OFFSET(2))	/* 0x90 */
+#define ECR_OFFSET(irq)		(REG_OFFSET(irq, 3))	/* 0x30 */
+#define SEC_ECR_OFFSET		(SEC_REG_OFFSET(3))	/* 0x98 */
+#define PIR_OFFSET		(0x40)
+#define MSR_OFFSET		(0x44)
+#define PM_OFFSET(irq)		(REG_OFFSET(irq, 5))	/* 0x50 */
+#define TM_OFFSET(irq)		(REG_OFFSET(irq, 6))	/* 0x60 */
+
+#define REG(addr) ((u32 *)(KSEG1ADDR(AR7_REGS_IRQ) + addr))
+
+#define CHNL_OFFSET(chnl) (CHNLS_OFFSET + (chnl * 4))
+
+static void ar7_unmask_irq(unsigned int irq_nr);
+static void ar7_mask_irq(unsigned int irq_nr);
+static void ar7_ack_irq(unsigned int irq_nr);
+static void ar7_unmask_sec_irq(unsigned int irq_nr);
+static void ar7_mask_sec_irq(unsigned int irq_nr);
+static void ar7_ack_sec_irq(unsigned int irq_nr);
+static void ar7_cascade(void);
+static void ar7_irq_init(int base);
+static int ar7_irq_base;
+
+static struct irq_chip ar7_irq_type = {
+	.name = "AR7",
+	.unmask = ar7_unmask_irq,
+	.mask = ar7_mask_irq,
+	.ack = ar7_ack_irq
+};
+
+static struct irq_chip ar7_sec_irq_type = {
+	.name = "AR7",
+	.unmask = ar7_unmask_sec_irq,
+	.mask = ar7_mask_sec_irq,
+	.ack = ar7_ack_sec_irq,
+};
+
+static struct irqaction ar7_cascade_action = {
+	.handler = no_action,
+	.name = "AR7 cascade interrupt"
+};
+
+static void ar7_unmask_irq(unsigned int irq)
+{
+	writel(1 << ((irq - ar7_irq_base) % 32),
+	       REG(ESR_OFFSET(irq - ar7_irq_base)));
+}
+
+static void ar7_mask_irq(unsigned int irq)
+{
+	writel(1 << ((irq - ar7_irq_base) % 32),
+	       REG(ECR_OFFSET(irq - ar7_irq_base)));
+}
+
+static void ar7_ack_irq(unsigned int irq)
+{
+	writel(1 << ((irq - ar7_irq_base) % 32),
+	       REG(CR_OFFSET(irq - ar7_irq_base)));
+}
+
+static void ar7_unmask_sec_irq(unsigned int irq)
+{
+	writel(1 << (irq - ar7_irq_base - 40), REG(SEC_ESR_OFFSET));
+}
+
+static void ar7_mask_sec_irq(unsigned int irq)
+{
+	writel(1 << (irq - ar7_irq_base - 40), REG(SEC_ECR_OFFSET));
+}
+
+static void ar7_ack_sec_irq(unsigned int irq)
+{
+	writel(1 << (irq - ar7_irq_base - 40), REG(SEC_CR_OFFSET));
+}
+
+void __init arch_init_irq(void) {
+	mips_cpu_irq_init();
+	ar7_irq_init(8);
+}
+
+static void __init ar7_irq_init(int base)
+{
+	int i;
+	/*
+	 * Disable interrupts and clear pending
+	 */
+	writel(0xffffffff, REG(ECR_OFFSET(0)));
+	writel(0xff, REG(ECR_OFFSET(32)));
+	writel(0xffffffff, REG(SEC_ECR_OFFSET));
+	writel(0xffffffff, REG(CR_OFFSET(0)));
+	writel(0xff, REG(CR_OFFSET(32)));
+	writel(0xffffffff, REG(SEC_CR_OFFSET));
+
+	ar7_irq_base = base;
+
+	for (i = 0; i < 40; i++) {
+		writel(i, REG(CHNL_OFFSET(i)));
+		/* Primary IRQ's */
+		set_irq_chip_and_handler(base + i, &ar7_irq_type,
+					 handle_level_irq);
+		/* Secondary IRQ's */
+		if (i < 32)
+			set_irq_chip_and_handler(base + i + 40,
+						 &ar7_sec_irq_type,
+						 handle_level_irq);
+	}
+
+	setup_irq(2, &ar7_cascade_action);
+	setup_irq(ar7_irq_base, &ar7_cascade_action);
+	set_c0_status(IE_IRQ0);
+}
+
+static void ar7_cascade(void)
+{
+	u32 status;
+	int i, irq;
+
+	/* Primary IRQ's */
+	irq = readl(REG(PIR_OFFSET)) & 0x3f;
+	if (irq) {
+		do_IRQ(ar7_irq_base + irq);
+		return;
+	}
+
+	/* Secondary IRQ's are cascaded through primary '0' */
+	writel(1, REG(CR_OFFSET(irq)));
+	status = readl(REG(SEC_SR_OFFSET));
+	for (i = 0; i < 32; i++) {
+		if (status & 1) {
+			do_IRQ(ar7_irq_base + i + 40);
+			return;
+		}
+		status >>= 1;
+	}
+
+	spurious_interrupt();
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
+	if (pending & STATUSF_IP7)		/* cpu timer */
+		do_IRQ(7);
+	else if (pending & STATUSF_IP2)		/* int0 hardware line */
+		ar7_cascade();
+	else
+		spurious_interrupt();
+}
diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
new file mode 100644
index 0000000..65a094c
--- /dev/null
+++ b/arch/mips/ar7/memory.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2007 OpenWrt.org
+ *
+ * Based on arch/mips/mm/init.c
+ * Copyright (C) 1994 - 2000 Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pfn.h>
+#include <linux/proc_fs.h>
+#include <linux/string.h>
+#include <linux/swap.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <asm/mips-boards/prom.h>
+
+static int __init memsize(void)
+{
+	u32 size = (64 << 20);
+	volatile u32 *addr = (u32 *)KSEG1ADDR(0x14000000 + size - 4);
+	u32 *kernel_end = (u32 *)KSEG1ADDR(CPHYSADDR((u32)&_end));
+
+	while (addr > kernel_end) {
+		*addr = (u32)addr;
+		size >>= 1;
+		addr -= size >> 2;
+	}
+
+	do {
+		addr += size >> 2;
+		if (*addr != (u32)addr)
+			break;
+		size <<= 1;
+	} while (size < (64 << 20));
+
+	return size;
+}
+
+void __init prom_meminit(void)
+{
+	unsigned long pages;
+
+	pages = memsize() >> PAGE_SHIFT;
+	add_memory_region(PHYS_OFFSET, pages << PAGE_SHIFT,
+			  BOOT_MEM_RAM);
+}
+
+void __init prom_free_prom_memory(void)
+{
+	return;
+}
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
new file mode 100644
index 0000000..c8e022a
--- /dev/null
+++ b/arch/mips/ar7/platform.c
@@ -0,0 +1,418 @@
+/*
+ * Copyright (C) 2006, 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/autoconf.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+
+#include <asm/addrspace.h>
+#include <asm/ar7/ar7.h>
+#include <asm/ar7/gpio.h>
+#include <asm/ar7/prom.h>
+#include <asm/ar7/vlynq.h>
+
+struct plat_vlynq_data {
+	struct plat_vlynq_ops ops;
+	int gpio_bit;
+	int reset_bit;
+};
+
+
+static int vlynq_on(struct vlynq_device *dev)
+{
+	int result;
+	struct plat_vlynq_data *pdata = dev->dev.platform_data;
+
+	if ((result = gpio_request(pdata->gpio_bit, "vlynq")))
+		goto out;
+
+	ar7_device_reset(pdata->reset_bit);
+
+	if ((result = ar7_gpio_disable(pdata->gpio_bit)))
+		goto out_enabled;
+
+	if ((result = ar7_gpio_enable(pdata->gpio_bit)))
+		goto out_enabled;
+
+	if ((result = gpio_direction_output(pdata->gpio_bit)))
+		goto out_gpio_enabled;
+
+	gpio_set_value(pdata->gpio_bit, 0);
+	mdelay(50);
+
+	gpio_set_value(pdata->gpio_bit, 1);
+	mdelay(50);
+
+	return 0;
+
+out_gpio_enabled:
+	ar7_gpio_disable(pdata->gpio_bit);
+out_enabled:
+	ar7_device_disable(pdata->reset_bit);
+	gpio_free(pdata->gpio_bit);
+out:
+	return result;
+}
+
+static void vlynq_off(struct vlynq_device *dev)
+{
+	struct plat_vlynq_data *pdata = dev->dev.platform_data;
+	ar7_gpio_disable(pdata->gpio_bit);
+	gpio_free(pdata->gpio_bit);
+	ar7_device_disable(pdata->reset_bit);
+}
+
+static struct resource physmap_flash_resource = {
+	.name = "mem",
+	.flags = IORESOURCE_MEM,
+	.start = 0x10000000,
+	.end = 0x107fffff,
+};
+
+static struct resource cpmac_low_res[] = {
+	{
+		.name = "regs",
+		.flags = IORESOURCE_MEM,
+		.start = AR7_REGS_MAC0,
+		.end = AR7_REGS_MAC0 + 0x7ff,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 27,
+		.end = 27,
+	},
+};
+
+static struct resource cpmac_high_res[] = {
+	{
+		.name = "regs",
+		.flags = IORESOURCE_MEM,
+		.start = AR7_REGS_MAC1,
+		.end = AR7_REGS_MAC1 + 0x7ff,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 41,
+		.end = 41,
+	},
+};
+
+static struct resource vlynq_low_res[] = {
+	{
+		.name = "regs",
+		.flags = IORESOURCE_MEM,
+		.start = AR7_REGS_VLYNQ0,
+		.end = AR7_REGS_VLYNQ0 + 0xff,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 29,
+		.end = 29,
+	},
+	{
+		.name = "mem",
+		.flags = IORESOURCE_MEM,
+		.start = 0x04000000,
+		.end = 0x04ffffff,
+	},
+	{
+		.name = "devirq",
+		.flags = IORESOURCE_IRQ,
+		.start = 80,
+		.end = 111,
+	},
+};
+
+static struct resource vlynq_high_res[] = {
+	{
+		.name = "regs",
+		.flags = IORESOURCE_MEM,
+		.start = AR7_REGS_VLYNQ1,
+		.end = AR7_REGS_VLYNQ1 + 0xff,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 33,
+		.end = 33,
+	},
+	{
+		.name = "mem",
+		.flags = IORESOURCE_MEM,
+		.start = 0x0c000000,
+		.end = 0x0cffffff,
+	},
+	{
+		.name = "devirq",
+		.flags = IORESOURCE_IRQ,
+		.start = 112,
+		.end = 143,
+	},
+};
+
+static struct physmap_flash_data physmap_flash_data = {
+	.width = 2,
+};
+
+static struct plat_cpmac_data cpmac_low_data = {
+	.reset_bit = 17,
+	.power_bit = 20,
+	.phy_mask = 0x80000000,
+};
+
+static struct plat_cpmac_data cpmac_high_data = {
+	.reset_bit = 21,
+	.power_bit = 22,
+	.phy_mask = 0x7fffffff,
+};
+
+static struct plat_vlynq_data vlynq_low_data = {
+	.ops.on = vlynq_on,
+	.ops.off = vlynq_off,
+	.reset_bit = 20,
+	.gpio_bit = 18,
+};
+
+static struct plat_vlynq_data vlynq_high_data = {
+	.ops.on = vlynq_on,
+	.ops.off = vlynq_off,
+	.reset_bit = 16,
+	.gpio_bit = 19,
+};
+
+static struct platform_device physmap_flash = {
+	.id = 0,
+	.name = "physmap-flash",
+	.dev.platform_data = &physmap_flash_data,
+	.resource = &physmap_flash_resource,
+	.num_resources = 1,
+};
+
+static u64 cpmac_dma_mask = DMA_32BIT_MASK;
+static struct platform_device cpmac_low = {
+	.id = 0,
+	.name = "cpmac",
+	.dev = {
+		.dma_mask = &cpmac_dma_mask,
+		.coherent_dma_mask = DMA_32BIT_MASK,
+		.platform_data = &cpmac_low_data,
+	},
+	.resource = cpmac_low_res,
+	.num_resources = ARRAY_SIZE(cpmac_low_res),
+};
+
+static struct platform_device cpmac_high = {
+	.id = 1,
+	.name = "cpmac",
+	.dev = {
+		.dma_mask = &cpmac_dma_mask,
+		.coherent_dma_mask = DMA_32BIT_MASK,
+		.platform_data = &cpmac_high_data,
+	},
+	.resource = cpmac_high_res,
+	.num_resources = ARRAY_SIZE(cpmac_high_res),
+};
+
+static struct platform_device vlynq_low = {
+	.id = 0,
+	.name = "vlynq",
+	.dev.platform_data = &vlynq_low_data,
+	.resource = vlynq_low_res,
+	.num_resources = ARRAY_SIZE(vlynq_low_res),
+};
+
+static struct platform_device vlynq_high = {
+	.id = 1,
+	.name = "vlynq",
+	.dev.platform_data = &vlynq_high_data,
+	.resource = vlynq_high_res,
+	.num_resources = ARRAY_SIZE(vlynq_high_res),
+};
+
+
+/* This is proper way to define uart ports, but they are then detected
+ * as xscale and, obviously, don't work...
+ */
+#if !defined(CONFIG_SERIAL_8250)
+
+static struct plat_serial8250_port uart0_data = {
+	.mapbase = AR7_REGS_UART0,
+	.irq = AR7_IRQ_UART0,
+	.regshift = 2,
+	.iotype = UPIO_MEM,
+	.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+};
+
+static struct plat_serial8250_port uart1_data = {
+	.mapbase = UR8_REGS_UART1,
+	.irq = AR7_IRQ_UART1,
+	.regshift = 2,
+	.iotype = UPIO_MEM,
+	.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+};
+
+static struct plat_serial8250_port uart_data[] = {
+	uart0_data,
+	uart1_data,
+	{ .flags = 0 }
+};
+
+static struct plat_serial8250_port uart_data_single[] = {
+	uart0_data,
+	{ .flags = 0 }
+};
+
+static struct platform_device uart = {
+	.id = 0,
+	.name = "serial8250",
+	.dev.platform_data = uart_data_single
+};
+#endif
+
+static inline unsigned char char2hex(char h)
+{
+	switch (h) {
+	case '0': case '1': case '2': case '3': case '4':
+	case '5': case '6': case '7': case '8': case '9':
+		return h - '0';
+	case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
+		return h - 'A' + 10;
+	case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
+		return h - 'a' + 10;
+	default:
+		return 0;
+	}
+}
+
+static void cpmac_get_mac(int instance, unsigned char *dev_addr)
+{
+	int i;
+	char name[5], default_mac[] = "00:00:00:12:34:56", *mac;
+
+	mac = NULL;
+	sprintf(name, "mac%c", 'a' + instance);
+	mac = prom_getenv(name);
+	if (!mac) {
+		sprintf(name, "mac%c", 'a');
+		mac = prom_getenv(name);
+	}
+	if (!mac)
+		mac = default_mac;
+	for (i = 0; i < 6; i++)
+		dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
+			char2hex(mac[i * 3 + 1]);
+}
+
+static int __init ar7_register_devices(void)
+{
+	int res;
+
+#ifdef CONFIG_SERIAL_8250
+
+	static struct uart_port uart_port[2];
+
+	memset(uart_port, 0, sizeof(struct uart_port) * 2);
+
+	uart_port[0].type = PORT_AR7;
+	uart_port[0].line = 0;
+	uart_port[0].irq = AR7_IRQ_UART0;
+	uart_port[0].uartclk = ar7_bus_freq() / 2;
+	uart_port[0].iotype = UPIO_MEM;
+	uart_port[0].mapbase = AR7_REGS_UART0;
+	uart_port[0].membase = ioremap(uart_port[0].mapbase, 256);
+	uart_port[0].regshift = 2;
+	res = early_serial_setup(&uart_port[0]);
+	if (res)
+		return res;
+
+
+	/* Only TNETD73xx have a second serial port */
+	if (ar7_has_second_uart()) {
+		uart_port[1].type = PORT_AR7;
+		uart_port[1].line = 1;
+		uart_port[1].irq = AR7_IRQ_UART1;
+		uart_port[1].uartclk = ar7_bus_freq() / 2;
+		uart_port[1].iotype = UPIO_MEM;
+		uart_port[1].mapbase = UR8_REGS_UART1;
+		uart_port[1].membase = ioremap(uart_port[1].mapbase, 256);
+		uart_port[1].regshift = 2;
+		res = early_serial_setup(&uart_port[1]);
+		if (res)
+			return res;
+	}
+
+#else /* !CONFIG_SERIAL_8250 */
+
+	uart_data[0].uartclk = ar7_bus_freq() / 2;
+	uart_data[1].uartclk = uart_data[0].uartclk;
+
+	/* Only TNETD73xx have a second serial port */
+	if (ar7_has_second_uart())
+		uart.dev.platform_data = uart_data;
+
+	res = platform_device_register(&uart);
+	if (res)
+		return res;
+
+#endif /* CONFIG_SERIAL_8250 */
+
+	res = platform_device_register(&physmap_flash);
+	if (res)
+		return res;
+
+	res = platform_device_register(&vlynq_low);
+	if (res)
+		return res;
+
+	ar7_device_disable(vlynq_low_data.reset_bit);
+	if (ar7_has_high_vlynq()) {
+		ar7_device_disable(vlynq_high_data.reset_bit);
+		res = platform_device_register(&vlynq_high);
+		if (res)
+			return res;
+	}
+
+	if (ar7_has_high_cpmac()) {
+		cpmac_get_mac(1, cpmac_high_data.dev_addr);
+		res = platform_device_register(&cpmac_high);
+		if (res)
+			return res;
+	} else {
+		cpmac_low_data.phy_mask = 0xffffffff;
+	}
+
+	cpmac_get_mac(0, cpmac_low_data.dev_addr);
+	res = platform_device_register(&cpmac_low);
+
+	return res;
+}
+
+
+arch_initcall(ar7_register_devices);
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
new file mode 100644
index 0000000..a560c55
--- /dev/null
+++ b/arch/mips/ar7/prom.c
@@ -0,0 +1,322 @@
+/*
+ * Copyright (C) 2006, 2007 OpenWrt.org
+ *
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Putting things on the screen/serial line using YAMONs facilities.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/serial_reg.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/io.h>
+#include <asm/bootinfo.h>
+#include <asm/gdb-stub.h>
+
+#include <asm/ar7/ar7.h>
+#include <asm/ar7/prom.h>
+
+#define MAX_ENTRY 80
+
+struct env_var {
+	char *name;
+	char *value;
+};
+
+static struct env_var adam2_env[MAX_ENTRY] = { { 0, }, };
+
+char *prom_getenv(char *name)
+{
+	int i;
+	for (i = 0; (i < MAX_ENTRY) && adam2_env[i].name; i++)
+		if (!strcmp(name, adam2_env[i].name))
+			return adam2_env[i].value;
+
+	return NULL;
+}
+EXPORT_SYMBOL(prom_getenv);
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+static void  __init ar7_init_cmdline(int argc, char *argv[])
+{
+	char *cp;
+	int actr;
+
+	actr = 1; /* Always ignore argv[0] */
+
+	cp = &(arcs_cmdline[0]);
+	while (actr < argc) {
+		strcpy(cp, argv[actr]);
+		cp += strlen(argv[actr]);
+		*cp++ = ' ';
+		actr++;
+	}
+	if (cp != &(arcs_cmdline[0])) {
+		/* get rid of trailing space */
+		--cp;
+		*cp = '\0';
+	}
+}
+
+struct psbl_rec {
+	u32 psbl_size;
+	u32 env_base;
+	u32 env_size;
+	u32 ffs_base;
+	u32 ffs_size;
+};
+
+static __initdata char psp_env_version[] = "TIENV0.8";
+
+struct psp_env_chunk {
+	u8 num;
+	u8 ctrl;
+	u16 csum;
+	u8 len;
+	char data[11];
+} __attribute__ ((packed));
+
+struct psp_var_map_entry {
+	u8 num;
+	char *value;
+};
+
+static struct psp_var_map_entry psp_var_map[] = {
+	{ 1, "cpufrequency" },
+	{ 2, "memsize" },
+	{ 3, "flashsize" },
+	{ 4, "modetty0" },
+	{ 5, "modetty1" },
+	{ 8, "maca" },
+	{ 9, "macb" },
+	{ 28, "sysfrequency" },
+	{ 38, "mipsfrequency" },
+};
+
+/*
+
+Well-known variable (num is looked up in table above for matching variable name)
+Example: cpufrequency=211968000
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+| 01 |CTRL|CHECKSUM | 01 | _2 | _1 | _1 | _9 | _6 | _8 | _0 | _0 | _0 | \0 | FF
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+
+Name=Value pair in a single chunk
+Example: NAME=VALUE
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+| 00 |CTRL|CHECKSUM | 01 | _N | _A | _M | _E | _0 | _V | _A | _L | _U | _E | \0
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+
+Name=Value pair in 2 chunks (len is the number of chunks)
+Example: bootloaderVersion=1.3.7.15
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+| 00 |CTRL|CHECKSUM | 02 | _b | _o | _o | _t | _l | _o | _a | _d | _e | _r | _V
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+| _e | _r | _s | _i | _o | _n | \0 | _1 | _. | _3 | _. | _7 | _. | _1 | _5 | \0
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+---
+
+Data is padded with 0xFF
+
+*/
+
+#define PSP_ENV_SIZE  4096
+
+static char psp_env_data[PSP_ENV_SIZE] = { 0, };
+
+static char * __init lookup_psp_var_map(u8 num)
+{
+	int i;
+
+	for (i = 0; i < sizeof(psp_var_map); i++)
+		if (psp_var_map[i].num == num)
+			return psp_var_map[i].value;
+
+	return NULL;
+}
+
+static void __init add_adam2_var(char *name, char *value)
+{
+	int i;
+	for (i = 0; i < MAX_ENTRY; i++) {
+		if (!adam2_env[i].name) {
+			adam2_env[i].name = name;
+			adam2_env[i].value = value;
+			return;
+		} else if (!strcmp(adam2_env[i].name, name)) {
+			adam2_env[i].value = value;
+			return;
+		}
+	}
+}
+
+static int __init parse_psp_env(void *psp_env_base)
+{
+	int i, n;
+	char *name, *value;
+	struct psp_env_chunk *chunks = (struct psp_env_chunk *)psp_env_data;
+
+	memcpy_fromio(chunks, psp_env_base, PSP_ENV_SIZE);
+
+	i = 1;
+	n = PSP_ENV_SIZE / sizeof(struct psp_env_chunk);
+	while (i < n) {
+		if ((chunks[i].num == 0xff) || ((i + chunks[i].len) > n))
+			break;
+		value = chunks[i].data;
+		if (chunks[i].num) {
+			name = lookup_psp_var_map(chunks[i].num);
+		} else {
+			name = value;
+			value += strlen(name) + 1;
+		}
+		if (name)
+			add_adam2_var(name, value);
+		i += chunks[i].len;
+	}
+	return 0;
+}
+
+static void __init ar7_init_env(struct env_var *env)
+{
+	int i;
+	struct psbl_rec *psbl = (struct psbl_rec *)(KSEG1ADDR(0x14000300));
+	void *psp_env = (void *)KSEG1ADDR(psbl->env_base);
+
+	if (strcmp(psp_env, psp_env_version) == 0) {
+		parse_psp_env(psp_env);
+	} else {
+		for (i = 0; i < MAX_ENTRY; i++, env++)
+			if (env->name)
+				add_adam2_var(env->name, env->value);
+	}
+}
+
+static void __init console_config(void)
+{
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	char console_string[40];
+	int baud = 0;
+	char parity = '\0', bits = '\0', flow = '\0';
+	char *s, *p;
+
+	if (strstr(prom_getcmdline(), "console="))
+		return;
+
+#ifdef CONFIG_KGDB
+	if (!strstr(prom_getcmdline(), "nokgdb")) {
+		strcat(prom_getcmdline(), " console=kgdb");
+		kgdb_enabled = 1;
+		return;
+	}
+#endif
+
+	if ((s = prom_getenv("modetty0"))) {
+		baud = simple_strtoul(s, &p, 10);
+		s = p;
+		if (*s == ',') s++;
+		if (*s) parity = *s++;
+		if (*s == ',') s++;
+		if (*s) bits = *s++;
+		if (*s == ',') s++;
+		if (*s == 'h') flow = 'r';
+	}
+
+	if (baud == 0)
+		baud = 38400;
+	if (parity != 'n' && parity != 'o' && parity != 'e')
+		parity = 'n';
+	if (bits != '7' && bits != '8')
+		bits = '8';
+	if (flow == '\0')
+		flow = 'r';
+
+	sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
+		parity, bits, flow);
+	strcat(prom_getcmdline(), console_string);
+#endif
+}
+
+void __init prom_init(void)
+{
+	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
+	ar7_init_env((struct env_var *)fw_arg2);
+	console_config();
+}
+
+#define PORT(offset) (KSEG1ADDR(AR7_REGS_UART0 + (offset * 4)))
+static inline unsigned int serial_in(int offset)
+{
+	return readb((void *)PORT(offset));
+}
+
+static inline void serial_out(int offset, int value)
+{
+	writeb(value, (void *)PORT(offset));
+}
+
+char prom_getchar(void)
+{
+	while (!(serial_in(UART_LSR) & UART_LSR_DR));
+	return serial_in(UART_RX);
+}
+
+int prom_putchar(char c)
+{
+	while ((serial_in(UART_LSR) & UART_LSR_TEMT) == 0);
+	serial_out(UART_TX, c);
+	return 1;
+}
+
+/* from adm5120/prom.c */
+void prom_printf(char *fmt, ...)
+{
+	va_list args;
+	int l;
+	char *p, *buf_end;
+	char buf[1024];
+
+	va_start(args, fmt);
+	l = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf) */
+	va_end(args);
+
+	buf_end = buf + l;
+
+	for (p = buf; p < buf_end; p++) {
+		/* Crude cr/nl handling is better than none */
+		if (*p == '\n')
+			prom_putchar('\r');
+		prom_putchar(*p);
+	}
+}
+
+#ifdef CONFIG_KGDB
+int putDebugChar(char c)
+{
+	return prom_putchar(c);
+}
+
+char getDebugChar(void)
+{
+       return prom_getchar();
+}
+#endif
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
new file mode 100644
index 0000000..793f37c
--- /dev/null
+++ b/arch/mips/ar7/setup.c
@@ -0,0 +1,106 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/pm.h>
+
+#include <asm/mips-boards/prom.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/ar7/ar7.h>
+
+extern void ar7_time_init(void);
+static void ar7_machine_restart(char *command);
+static void ar7_machine_halt(void);
+static void ar7_machine_power_off(void);
+
+static void ar7_machine_restart(char *command)
+{
+	u32 *softres_reg = (u32 *)ioremap(AR7_REGS_RESET +
+					  AR7_RESET_SOFTWARE, 1);
+	writel(1, softres_reg);
+}
+
+static void ar7_machine_halt(void)
+{
+	while (1);
+}
+
+static void ar7_machine_power_off(void)
+{
+	u32 *power_reg = (u32 *)ioremap(AR7_REGS_POWER, 1);
+	u32 power_state = readl(power_reg) | (3 << 30);
+	writel(power_state, power_reg);
+	ar7_machine_halt();
+}
+
+const char *get_system_type(void)
+{
+	u16 chip_id = ar7_chip_id();
+	switch (chip_id) {
+	case AR7_CHIP_7300:
+		return "TI AR7 (TNETD7300)";
+	case AR7_CHIP_7100:
+		return "TI AR7 (TNETD7100)";
+	case AR7_CHIP_7200:
+		return "TI AR7 (TNETD7200)";
+	default:
+		return "TI AR7 (Unknown)";
+	}
+}
+
+static int __init ar7_init_console(void)
+{
+	return 0;
+}
+
+/*
+ * Initializes basic routines and structures pointers, memory size (as
+ * given by the bios and saves the command line.
+ */
+
+extern void ar7_init_clocks(void);
+
+void __init plat_mem_setup(void)
+{
+	unsigned long io_base;
+
+	_machine_restart = ar7_machine_restart;
+	_machine_halt = ar7_machine_halt;
+	pm_power_off = ar7_machine_power_off;
+	board_time_init = ar7_time_init;
+	panic_timeout = 3;
+
+	io_base = (unsigned long)ioremap(AR7_REGS_BASE, 0x10000);
+	if (!io_base) panic("Can't remap IO base!\n");
+	set_io_port_base(io_base);
+
+	prom_meminit();
+	ar7_init_clocks();
+
+	ioport_resource.start = 0;
+	ioport_resource.end   = ~0;
+	iomem_resource.start  = 0;
+	iomem_resource.end    = ~0;
+
+	printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
+					get_system_type(),
+		ar7_chip_id(), ar7_chip_rev());
+}
+
+console_initcall(ar7_init_console);
diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
new file mode 100644
index 0000000..4be2895
--- /dev/null
+++ b/arch/mips/ar7/time.c
@@ -0,0 +1,32 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Setting up the clock on the MIPS boards.
+ */
+
+#include <asm/time.h>
+#include <asm/ar7/ar7.h>
+
+void __init ar7_time_init(void)
+{
+	mips_hpt_frequency = ar7_cpu_freq() / 2;
+}
+
+void __init plat_timer_setup(struct irqaction *irq)
+{
+	setup_irq(7, irq);
+}
diff --git a/arch/mips/ar7/vlynq-pci.c b/arch/mips/ar7/vlynq-pci.c
new file mode 100644
index 0000000..bffea51
--- /dev/null
+++ b/arch/mips/ar7/vlynq-pci.c
@@ -0,0 +1,436 @@
+/*
+ * Copyright (C) 2006, 2007 OpenWrt.org
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/ar7/vlynq.h>
+
+#define VLYNQ_PCI_SLOTS 2
+
+struct vlynq_reg_config {
+	u32 offset;
+	u32 value;
+};
+
+struct vlynq_pci_config {
+	u32 chip_id;
+	char name[32];
+	struct vlynq_mapping rx_mapping[4];
+	int irq;
+	int irq_type;
+	u32 chip;
+	u32 class;
+	int num_regs;
+	struct vlynq_reg_config regs[10];
+};
+
+struct vlynq_pci_private {
+	u32 latency;
+	u32 cache_line;
+	u32 command;
+	u32 sz_mask;
+	struct vlynq_pci_config *config;
+};
+
+static struct vlynq_pci_config known_devices[] = {
+	{
+		.chip_id = 0x00000009, .name = "TI TNETW1130",
+		.rx_mapping = {
+			{ .size = 0x22000, .offset = 0xf0000000 },
+			{ .size = 0x40000, .offset = 0xc0000000 },
+			{ .size = 0x0, .offset = 0x0 },
+			{ .size = 0x0, .offset = 0x0 },
+		},
+		.irq = 0, .chip = 0x9066104c,
+		.irq_type = IRQ_TYPE_EDGE_RISING,
+		.class = PCI_CLASS_NETWORK_OTHER,
+		.num_regs = 5,
+		.regs = {
+			{
+				.offset = 0x790,
+				.value = (0xd0000000 - PHYS_OFFSET)
+			},
+			{
+				.offset = 0x794,
+				.value = (0xd0000000 - PHYS_OFFSET)
+			},
+			{ .offset = 0x740, .value = 0 },
+			{ .offset = 0x744, .value = 0x00010000 },
+			{ .offset = 0x764, .value = 0x00010000 },
+		},
+	},
+	{
+		.chip_id = 0x00000029, .name = "TI TNETW1350",
+		.rx_mapping = {
+			{ .size = 0x100000, .offset = 0x00300000 },
+			{ .size = 0x80000, .offset = 0x00000000 },
+			{ .size = 0x0, .offset = 0x0 },
+			{ .size = 0x0, .offset = 0x0 },
+		},
+		.irq = 0, .chip = 0x9066104c,
+		.irq_type = IRQ_TYPE_EDGE_RISING,
+		.class = PCI_CLASS_NETWORK_OTHER,
+		.num_regs = 5,
+		.regs = {
+			{
+				.offset = 0x790,
+				.value = (0x60000000 - PHYS_OFFSET)
+			},
+			{
+				.offset = 0x794,
+				.value = (0x60000000 - PHYS_OFFSET)
+			},
+			{ .offset = 0x740, .value = 0 },
+			{ .offset = 0x744, .value = 0x00010000 },
+			{ .offset = 0x764, .value = 0x00010000 },
+		},
+	},
+};
+
+static struct vlynq_device *slots[VLYNQ_PCI_SLOTS] = { NULL, };
+
+static struct resource vlynq_io_resource = {
+	.start	= 0x00000000,
+	.end	= 0x00000000,
+	.name	= "pci IO space",
+	.flags	= IORESOURCE_IO
+};
+
+static struct resource vlynq_mem_resource = {
+	.start	= 0x00000000,
+	.end	= 0x00000000,
+	.name	= "pci memory space",
+	.flags	= IORESOURCE_MEM
+};
+
+static inline u32 vlynq_get_mapped(struct vlynq_device *dev, int res)
+{
+	int i;
+	struct vlynq_pci_private *priv = dev->priv;
+	u32 ret = dev->mem_start;
+	if (!priv->config->rx_mapping[res].size) return 0;
+	for (i = 0; i < res; i++)
+		ret += priv->config->rx_mapping[i].size;
+
+	return ret;
+}
+
+static inline u32 vlynq_read(u32 val, int size)
+{
+	switch (size) {
+	case 1:
+		return *(u8 *)&val;
+	case 2:
+		return *(u16 *)&val;
+	}
+	return val;
+}
+
+static int vlynq_config_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *val)
+{
+	struct vlynq_device *dev;
+	struct vlynq_pci_private *priv;
+	int resno, slot = PCI_SLOT(devfn);
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (slot >= VLYNQ_PCI_SLOTS)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dev = slots[slot];
+
+	if (!dev || (PCI_FUNC(devfn) > 0))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	priv = dev->priv;
+
+	switch (where) {
+	case PCI_VENDOR_ID:
+		*val = vlynq_read(priv->config->chip, size);
+		break;
+	case PCI_DEVICE_ID:
+		*val = priv->config->chip & 0xffff;
+	case PCI_COMMAND:
+		*val = priv->command;
+	case PCI_STATUS:
+/*		*val = PCI_STATUS_CAP_LIST;*/
+		*val = 0;
+		break;
+	case PCI_CLASS_REVISION:
+		*val = priv->config->class;
+		break;
+	case PCI_LATENCY_TIMER:
+		*val = priv->latency;
+		break;
+	case PCI_HEADER_TYPE:
+		*val = PCI_HEADER_TYPE_NORMAL;
+		break;
+	case PCI_CACHE_LINE_SIZE:
+		*val = priv->cache_line;
+		break;
+	case PCI_BASE_ADDRESS_0:
+	case PCI_BASE_ADDRESS_1:
+	case PCI_BASE_ADDRESS_2:
+	case PCI_BASE_ADDRESS_3:
+		resno = (where - PCI_BASE_ADDRESS_0) >> 2;
+		if (priv->sz_mask & (1 << resno)) {
+			priv->sz_mask &= ~(1 << resno);
+			*val = priv->config->rx_mapping[resno].size;
+		} else {
+			*val = vlynq_get_mapped(dev, resno);
+		}
+		break;
+	case PCI_BASE_ADDRESS_4:
+	case PCI_BASE_ADDRESS_5:
+	case PCI_SUBSYSTEM_VENDOR_ID:
+	case PCI_SUBSYSTEM_ID:
+	case PCI_ROM_ADDRESS:
+	case PCI_INTERRUPT_LINE:
+	case PCI_CARDBUS_CIS:
+	case PCI_CAPABILITY_LIST:
+		*val = 0;
+		break;
+	case PCI_INTERRUPT_PIN:
+		*val = 1;
+		break;
+	default:
+		printk(KERN_NOTICE "%s: Read of unknown register 0x%x "
+		       "(size %d)\n", dev->dev.bus_id, where, size);
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int vlynq_config_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 val)
+{
+	struct vlynq_device *dev;
+	struct vlynq_pci_private *priv;
+	int resno, slot = PCI_SLOT(devfn);
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (slot >= VLYNQ_PCI_SLOTS)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dev = slots[slot];
+
+	if (!dev || (PCI_FUNC(devfn) > 0))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	priv = dev->priv;
+
+	switch (where) {
+	case PCI_VENDOR_ID:
+	case PCI_DEVICE_ID:
+	case PCI_STATUS:
+	case PCI_CLASS_REVISION:
+	case PCI_HEADER_TYPE:
+	case PCI_CACHE_LINE_SIZE:
+	case PCI_SUBSYSTEM_VENDOR_ID:
+	case PCI_SUBSYSTEM_ID:
+	case PCI_INTERRUPT_LINE:
+	case PCI_INTERRUPT_PIN:
+	case PCI_CARDBUS_CIS:
+	case PCI_CAPABILITY_LIST:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	case PCI_COMMAND:
+		priv->command = val;
+	case PCI_LATENCY_TIMER:
+		priv->latency = val;
+		break;
+	case PCI_BASE_ADDRESS_0:
+	case PCI_BASE_ADDRESS_1:
+	case PCI_BASE_ADDRESS_2:
+	case PCI_BASE_ADDRESS_3:
+		if (val == 0xffffffff) {
+			resno = (where - PCI_BASE_ADDRESS_0) >> 2;
+			priv->sz_mask |= (1 << resno);
+			break;
+		}
+	case PCI_BASE_ADDRESS_4:
+	case PCI_BASE_ADDRESS_5:
+	case PCI_ROM_ADDRESS:
+		break;
+	default:
+		printk(KERN_NOTICE "%s: Write to unknown register 0x%x "
+		       "(size %d) value=0x%x\n", dev->dev.bus_id, where, size,
+		       val);
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops vlynq_pci_ops = {
+	vlynq_config_read,
+	vlynq_config_write
+};
+
+static struct pci_controller vlynq_controller = {
+	.pci_ops	= &vlynq_pci_ops,
+	.io_resource	= &vlynq_io_resource,
+	.mem_resource	= &vlynq_mem_resource,
+};
+
+static int vlynq_pci_probe(struct vlynq_device *dev)
+{
+	int result, i;
+	u32 chip_id, addr;
+	struct vlynq_pci_private *priv;
+	struct vlynq_mapping mapping[4] = { { 0, }, };
+	struct vlynq_pci_config *config = NULL;
+
+	result = vlynq_set_local_irq(dev, 31);
+	if (result)
+		return result;
+
+	result = vlynq_set_remote_irq(dev, 30);
+	if (result)
+		return result;
+
+	dev->divisor = vlynq_ldiv4;
+	result = vlynq_device_enable(dev);
+	if (result)
+		return result;
+
+	chip_id = vlynq_remote_id(dev);
+	for (i = 0; i < ARRAY_SIZE(known_devices); i++)
+		if (chip_id == known_devices[i].chip_id)
+			config = &known_devices[i];
+
+	if (!config) {
+		printk(KERN_DEBUG "vlynq-pci: skipping unknown device "
+		       "%04x:%04x at %s\n", chip_id >> 16,
+		       chip_id & 0xffff, dev->dev.bus_id);
+		result = -ENODEV;
+		goto fail;
+	}
+
+	printk(KERN_NOTICE "vlynq-pci: attaching device %s at %s\n",
+	       config->name, dev->dev.bus_id);
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		printk(KERN_ERR "%s: failed to allocate private data\n",
+		       dev->dev.bus_id);
+		result = -ENOMEM;
+		goto fail;
+	}
+
+	priv->latency = 64;
+	priv->cache_line = 32;
+	priv->config = config;
+
+	mapping[0].offset = ARCH_PFN_OFFSET << PAGE_SHIFT;
+	mapping[0].size = 0x02000000;
+	vlynq_set_local_mapping(dev, dev->mem_start, mapping);
+	vlynq_set_remote_mapping(dev, 0, config->rx_mapping);
+
+	set_irq_type(vlynq_virq_to_irq(dev, config->irq), config->irq_type);
+
+	addr = (u32)ioremap_nocache(dev->mem_start, 0x10000);
+	if (!addr) {
+		printk(KERN_ERR "%s: failed to remap io memory\n",
+		       dev->dev.bus_id);
+		result = -ENXIO;
+		goto fail;
+	}
+
+	for (i = 0; i < config->num_regs; i++)
+		iowrite32(config->regs[i].value,
+			  (u32 *)(addr + config->regs[i].offset));
+
+	dev->priv = priv;
+	for (i = 0; i < VLYNQ_PCI_SLOTS; i++) {
+		if (!slots[i]) {
+			slots[i] = dev;
+			break;
+		}
+	}
+
+	return 0;
+
+fail:
+	vlynq_device_disable(dev);
+
+	return result;
+}
+
+static int vlynq_pci_remove(struct vlynq_device *dev)
+{
+	int i;
+	struct vlynq_pci_private *priv = dev->priv;
+
+	for (i = 0; i < VLYNQ_PCI_SLOTS; i++)
+		if (slots[i] == dev)
+			slots[i] = NULL;
+
+	vlynq_device_disable(dev);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct vlynq_driver vlynq_pci = {
+	.name = "PCI over VLYNQ emulation",
+	.probe = vlynq_pci_probe,
+	.remove = vlynq_pci_remove,
+};
+
+int vlynq_pci_init(void)
+{
+	int res;
+	res = vlynq_register_driver(&vlynq_pci);
+	if (res)
+		return res;
+
+	register_pci_controller(&vlynq_controller);
+
+	return 0;
+}
+
+int pcibios_map_irq(struct pci_dev *pdev, u8 slot, u8 pin)
+{
+	struct vlynq_device *dev;
+	struct vlynq_pci_private *priv;
+
+	dev = slots[slot];
+
+	if (!dev)
+		return 0;
+
+	priv = dev->priv;
+
+	return vlynq_virq_to_irq(dev, priv->config->irq);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff --git a/arch/mips/ar7/vlynq.c b/arch/mips/ar7/vlynq.c
new file mode 100644
index 0000000..c4026c5
--- /dev/null
+++ b/arch/mips/ar7/vlynq.c
@@ -0,0 +1,653 @@
+/*
+ * Copyright (C) 2006, 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/io.h>
+
+#include <asm/ar7/vlynq.h>
+
+#define PER_DEVICE_IRQS			32
+
+#define VLYNQ_CTRL_PM_ENABLE		0x80000000
+#define VLYNQ_CTRL_CLOCK_INT		0x00008000
+#define VLYNQ_CTRL_CLOCK_DIV(x)		(((x) & 7) << 16)
+#define VLYNQ_CTRL_INT_LOCAL		0x00004000
+#define VLYNQ_CTRL_INT_ENABLE		0x00002000
+#define VLYNQ_CTRL_INT_VECTOR(x)	(((x) & 0x1f) << 8)
+#define VLYNQ_CTRL_INT2CFG		0x00000080
+#define VLYNQ_CTRL_RESET		0x00000001
+
+#define VLYNQ_INT_OFFSET		0x00000014
+#define VLYNQ_REMOTE_OFFSET		0x00000080
+
+#define VLYNQ_STATUS_LINK		0x00000001
+#define VLYNQ_STATUS_LERROR		0x00000080
+#define VLYNQ_STATUS_RERROR		0x00000100
+
+#define VINT_ENABLE			0x00000100
+#define VINT_TYPE_EDGE			0x00000080
+#define VINT_LEVEL_LOW			0x00000040
+#define VINT_VECTOR(x)			((x) & 0x1f)
+#define VINT_OFFSET(irq)		(8 * ((irq) % 4))
+
+#define VLYNQ_AUTONEGO_V2		0x00010000
+
+struct vlynq_regs {
+	u32 revision;
+	u32 control;
+	u32 status;
+	u32 int_prio;
+	u32 int_status;
+	u32 int_pending;
+	u32 int_ptr;
+	u32 tx_offset;
+	struct vlynq_mapping rx_mapping[4];
+	u32 chip;
+	u32 autonego;
+	u32 unused[6];
+	u32 int_device[8];
+} __attribute__ ((packed));
+
+#define vlynq_reg_read(reg) readl(&(reg))
+#define vlynq_reg_write(reg, val)  writel(val, &(reg))
+
+#ifdef VLYNQ_DEBUG
+static void vlynq_dump_regs(struct vlynq_device *dev)
+{
+	int i;
+	printk(KERN_DEBUG "VLYNQ local=%p remote=%p\n",
+			dev->local, dev->remote);
+	for (i = 0; i < 32; i++) {
+		printk(KERN_DEBUG "VLYNQ: local %d: %08x\n",
+			i + 1, ((u32 *)dev->local)[i]);
+		printk(KERN_DEBUG "VLYNQ: remote %d: %08x\n",
+			i + 1, ((u32 *)dev->remote)[i]);
+	}
+}
+
+static void vlynq_dump_mem(u32 *base, int count)
+{
+	int i;
+	for (i = 0; i < (count + 3) / 4; i++) {
+		if (i % 4 == 0) printk(KERN_DEBUG "\nMEM[0x%04x]:", i * 4);
+		printk(KERN_DEBUG " 0x%08x", *(base + i));
+	}
+	printk(KERN_DEBUG "\n");
+}
+#endif
+
+int vlynq_linked(struct vlynq_device *dev)
+{
+	int i;
+
+	for (i = 0; i < 100; i++)
+		if (vlynq_reg_read(dev->local->status) & VLYNQ_STATUS_LINK)
+			return 1;
+		else
+			cpu_relax();
+
+	return 0;
+}
+
+static void vlynq_irq_unmask(unsigned int irq)
+{
+	u32 val;
+	struct vlynq_device *dev = get_irq_chip_data(irq);
+	int virq;
+
+	BUG_ON(!dev);
+	virq = irq - dev->irq_start;
+	val = vlynq_reg_read(dev->remote->int_device[virq >> 2]);
+	val |= (VINT_ENABLE | virq) << VINT_OFFSET(virq);
+	vlynq_reg_write(dev->remote->int_device[virq >> 2], val);
+}
+
+static void vlynq_irq_mask(unsigned int irq)
+{
+	u32 val;
+	struct vlynq_device *dev = get_irq_chip_data(irq);
+	int virq;
+
+	BUG_ON(!dev);
+	virq = irq - dev->irq_start;
+	val = vlynq_reg_read(dev->remote->int_device[virq >> 2]);
+	val &= ~(VINT_ENABLE << VINT_OFFSET(virq));
+	vlynq_reg_write(dev->remote->int_device[virq >> 2], val);
+}
+
+static int vlynq_irq_type(unsigned int irq, unsigned int flow_type)
+{
+	u32 val;
+	struct vlynq_device *dev = get_irq_chip_data(irq);
+	int virq;
+
+	BUG_ON(!dev);
+	virq = irq - dev->irq_start;
+	val = vlynq_reg_read(dev->remote->int_device[virq >> 2]);
+	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		val |= VINT_TYPE_EDGE << VINT_OFFSET(virq);
+		val &= ~(VINT_LEVEL_LOW << VINT_OFFSET(virq));
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		val &= ~(VINT_TYPE_EDGE << VINT_OFFSET(virq));
+		val &= ~(VINT_LEVEL_LOW << VINT_OFFSET(virq));
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val &= ~(VINT_TYPE_EDGE << VINT_OFFSET(virq));
+		val |= VINT_LEVEL_LOW << VINT_OFFSET(virq);
+		break;
+	default:
+		return -EINVAL;
+	}
+	vlynq_reg_write(dev->remote->int_device[virq >> 2], val);
+	return 0;
+}
+
+static void vlynq_local_ack(unsigned int irq)
+{
+	struct vlynq_device *dev = get_irq_chip_data(irq);
+	u32 status = vlynq_reg_read(dev->local->status);
+	if (printk_ratelimit())
+		printk(KERN_DEBUG "%s: local status: 0x%08x\n",
+		       dev->dev.bus_id, status);
+	vlynq_reg_write(dev->local->status, status);
+}
+
+static void vlynq_remote_ack(unsigned int irq)
+{
+	struct vlynq_device *dev = get_irq_chip_data(irq);
+	u32 status = vlynq_reg_read(dev->remote->status);
+	if (printk_ratelimit())
+		printk(KERN_DEBUG "%s: remote status: 0x%08x\n",
+		       dev->dev.bus_id, status);
+	vlynq_reg_write(dev->remote->status, status);
+}
+
+#warning FIXME: process one irq per call
+static irqreturn_t vlynq_irq(int irq, void *dev_id)
+{
+	struct vlynq_device *dev = dev_id;
+	u32 status;
+	int virq = 0;
+
+	status = vlynq_reg_read(dev->local->int_status);
+	vlynq_reg_write(dev->local->int_status, status);
+
+	if (unlikely(!status))
+		spurious_interrupt();
+
+	while (status) {
+		if (status & 1)
+			do_IRQ(dev->irq_start + virq);
+		status >>= 1;
+		virq++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip vlynq_irq_chip = {
+	.name = "vlynq",
+	.unmask = vlynq_irq_unmask,
+	.mask = vlynq_irq_mask,
+	.set_type = vlynq_irq_type,
+};
+
+static struct irq_chip vlynq_local_chip = {
+	.name = "vlynq local error",
+	.unmask = vlynq_irq_unmask,
+	.mask = vlynq_irq_mask,
+	.ack = vlynq_local_ack,
+};
+
+static struct irq_chip vlynq_remote_chip = {
+	.name = "vlynq local error",
+	.unmask = vlynq_irq_unmask,
+	.mask = vlynq_irq_mask,
+	.ack = vlynq_remote_ack,
+};
+
+static int vlynq_setup_irq(struct vlynq_device *dev)
+{
+	u32 val;
+	int i;
+
+	if (dev->local_irq == dev->remote_irq) {
+		printk(KERN_ERR
+		       "%s: local vlynq irq should be different from remote\n",
+		       dev->dev.bus_id);
+		return -EINVAL;
+	}
+
+	/* Clear local and remote error bits */
+	vlynq_reg_write(dev->local->status, vlynq_reg_read(dev->local->status));
+	vlynq_reg_write(dev->remote->status,
+			vlynq_reg_read(dev->remote->status));
+
+	/* Now setup interrupts */
+	val = VLYNQ_CTRL_INT_VECTOR(dev->local_irq);
+	val |= VLYNQ_CTRL_INT_ENABLE | VLYNQ_CTRL_INT_LOCAL |
+		VLYNQ_CTRL_INT2CFG;
+	val |= vlynq_reg_read(dev->local->control);
+	vlynq_reg_write(dev->local->int_ptr, VLYNQ_INT_OFFSET);
+	vlynq_reg_write(dev->local->control, val);
+
+	val = VLYNQ_CTRL_INT_VECTOR(dev->remote_irq);
+	val |= VLYNQ_CTRL_INT_ENABLE;
+	val |= vlynq_reg_read(dev->remote->control);
+	vlynq_reg_write(dev->remote->int_ptr, VLYNQ_INT_OFFSET);
+	vlynq_reg_write(dev->remote->control, val);
+
+	for (i = 0; i < PER_DEVICE_IRQS; i++) {
+		if (i == dev->local_irq) {
+			set_irq_chip_and_handler(dev->irq_start + i,
+						 &vlynq_local_chip,
+						 handle_level_irq);
+			set_irq_chip_data(dev->irq_start + i, dev);
+		} else if (i == dev->remote_irq) {
+			set_irq_chip_and_handler(dev->irq_start + i,
+						 &vlynq_remote_chip,
+						 handle_level_irq);
+			set_irq_chip_data(dev->irq_start + i, dev);
+		} else {
+			set_irq_chip_and_handler(dev->irq_start + i,
+						 &vlynq_irq_chip,
+						 handle_simple_irq);
+			set_irq_chip_data(dev->irq_start + i, dev);
+			vlynq_reg_write(dev->remote->int_device[i >> 2], 0);
+		}
+	}
+
+	if (request_irq(dev->irq, vlynq_irq, IRQF_SHARED, "vlynq", dev)) {
+		printk(KERN_ERR "%s: request_irq failed\n", dev->dev.bus_id);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void vlynq_free_irq(struct vlynq_device *dev)
+{
+	free_irq(dev->irq, dev);
+}
+
+static void vlynq_device_release(struct device *dev)
+{
+	struct vlynq_device *vdev = to_vlynq_device(dev);
+	kfree(vdev);
+}
+
+static int vlynq_device_probe(struct device *dev)
+{
+	struct vlynq_driver *drv = to_vlynq_driver(dev->driver);
+	if (drv->probe)
+		return drv->probe(to_vlynq_device(dev));
+	return 0;
+}
+
+static int vlynq_device_remove(struct device *dev)
+{
+	struct vlynq_driver *drv = to_vlynq_driver(dev->driver);
+	if (drv->remove)
+		return drv->remove(to_vlynq_device(dev));
+	return 0;
+}
+
+int __vlynq_register_driver(struct vlynq_driver *driver, struct module *owner)
+{
+	driver->driver.name = driver->name;
+	driver->driver.bus = &vlynq_bus_type;
+	return driver_register(&driver->driver);
+}
+EXPORT_SYMBOL(__vlynq_register_driver);
+
+void vlynq_unregister_driver(struct vlynq_driver *driver)
+{
+	driver_unregister(&driver->driver);
+}
+EXPORT_SYMBOL(vlynq_unregister_driver);
+
+int vlynq_device_enable(struct vlynq_device *dev)
+{
+	int i, result;
+	struct plat_vlynq_ops *ops = dev->dev.platform_data;
+
+	result = ops->on(dev);
+	if (result)
+		return result;
+
+	switch (dev->divisor) {
+	case vlynq_div_auto:
+		/* First try locally supplied clock */
+		vlynq_reg_write(dev->remote->control, 0);
+		for (i = vlynq_ldiv1; i <= vlynq_ldiv8; i++) {
+			vlynq_reg_write(dev->local->control,
+					VLYNQ_CTRL_CLOCK_INT |
+					VLYNQ_CTRL_CLOCK_DIV(i - vlynq_ldiv1));
+			if (vlynq_linked(dev)) {
+				printk(KERN_DEBUG
+				       "%s: using local clock divisor %d\n",
+				       dev->dev.bus_id, i - vlynq_ldiv1 + 1);
+				return vlynq_setup_irq(dev);
+			}
+		}
+		/* Then remotely supplied clock */
+		vlynq_reg_write(dev->local->control, 0);
+		for (i = vlynq_rdiv1; i <= vlynq_rdiv8; i++) {
+			vlynq_reg_write(dev->remote->control,
+					VLYNQ_CTRL_CLOCK_INT |
+					VLYNQ_CTRL_CLOCK_DIV(i - vlynq_rdiv1));
+			if (vlynq_linked(dev)) {
+				printk(KERN_DEBUG
+				       "%s: using remote clock divisor %d\n",
+				       dev->dev.bus_id, i - vlynq_rdiv1 + 1);
+				return vlynq_setup_irq(dev);
+			}
+		}
+		/* At last, externally supplied clock */
+		vlynq_reg_write(dev->remote->control, 0);
+		if (vlynq_linked(dev)) {
+			printk(KERN_DEBUG "%s: using external clock\n",
+			       dev->dev.bus_id);
+			return vlynq_setup_irq(dev);
+		}
+		break;
+	case vlynq_ldiv1: case vlynq_ldiv2: case vlynq_ldiv3: case vlynq_ldiv4:
+	case vlynq_ldiv5: case vlynq_ldiv6: case vlynq_ldiv7: case vlynq_ldiv8:
+		vlynq_reg_write(dev->remote->control, 0);
+		vlynq_reg_write(dev->local->control,
+				VLYNQ_CTRL_CLOCK_INT |
+				VLYNQ_CTRL_CLOCK_DIV(dev->divisor -
+						     vlynq_ldiv1));
+		if (vlynq_linked(dev)) {
+			printk(KERN_DEBUG
+			       "%s: using local clock divisor %d\n",
+			       dev->dev.bus_id, dev->divisor - vlynq_ldiv1 + 1);
+			return vlynq_setup_irq(dev);
+		}
+		break;
+	case vlynq_rdiv1: case vlynq_rdiv2: case vlynq_rdiv3: case vlynq_rdiv4:
+	case vlynq_rdiv5: case vlynq_rdiv6: case vlynq_rdiv7: case vlynq_rdiv8:
+		vlynq_reg_write(dev->local->control, 0);
+		vlynq_reg_write(dev->remote->control,
+				VLYNQ_CTRL_CLOCK_INT |
+				VLYNQ_CTRL_CLOCK_DIV(dev->divisor -
+						     vlynq_rdiv1));
+		if (vlynq_linked(dev)) {
+			printk(KERN_DEBUG
+			       "%s: using remote clock divisor %d\n",
+			       dev->dev.bus_id, dev->divisor - vlynq_rdiv1 + 1);
+			return vlynq_setup_irq(dev);
+		}
+		break;
+	case vlynq_div_external:
+		vlynq_reg_write(dev->local->control, 0);
+		vlynq_reg_write(dev->remote->control, 0);
+		if (vlynq_linked(dev)) {
+			printk(KERN_DEBUG "%s: using external clock\n",
+			       dev->dev.bus_id);
+			return vlynq_setup_irq(dev);
+		}
+		break;
+	}
+
+	return -ENODEV;
+}
+
+void vlynq_device_disable(struct vlynq_device *dev)
+{
+	struct plat_vlynq_ops *ops = dev->dev.platform_data;
+
+	vlynq_free_irq(dev);
+	ops->off(dev);
+}
+
+u32 vlynq_remote_id(struct vlynq_device *dev)
+{
+	return vlynq_reg_read(dev->remote->chip);
+}
+
+void vlynq_set_local_mapping(struct vlynq_device *dev, u32 tx_offset,
+			     struct vlynq_mapping *mapping)
+{
+	int i;
+
+	vlynq_reg_write(dev->local->tx_offset, tx_offset);
+	for (i = 0; i < 4; i++) {
+		vlynq_reg_write(dev->local->rx_mapping[i].offset,
+							mapping[i].offset);
+		vlynq_reg_write(dev->local->rx_mapping[i].size,
+							mapping[i].size);
+	}
+}
+
+void vlynq_set_remote_mapping(struct vlynq_device *dev, u32 tx_offset,
+			      struct vlynq_mapping *mapping)
+{
+	int i;
+
+	vlynq_reg_write(dev->remote->tx_offset, tx_offset);
+	for (i = 0; i < 4; i++) {
+		vlynq_reg_write(dev->remote->rx_mapping[i].offset,
+							mapping[i].offset);
+		vlynq_reg_write(dev->remote->rx_mapping[i].size,
+							mapping[i].size);
+	}
+}
+
+int vlynq_virq_to_irq(struct vlynq_device *dev, int virq)
+{
+	if ((virq < 0) || (virq >= PER_DEVICE_IRQS))
+		return -EINVAL;
+
+	return dev->irq_start + virq;
+}
+
+int vlynq_irq_to_virq(struct vlynq_device *dev, int irq)
+{
+	if ((irq < dev->irq_start) || (irq >= dev->irq_start + PER_DEVICE_IRQS))
+		return -EINVAL;
+
+	return irq - dev->irq_start;
+}
+
+int vlynq_set_local_irq(struct vlynq_device *dev, int virq)
+{
+	if ((virq < 0) || (virq >= PER_DEVICE_IRQS))
+		return -EINVAL;
+
+	if (virq == dev->remote_irq)
+		return -EINVAL;
+
+	dev->local_irq = virq;
+
+	return 0;
+}
+
+int vlynq_set_remote_irq(struct vlynq_device *dev, int virq)
+{
+	if ((virq < 0) || (virq >= PER_DEVICE_IRQS))
+		return -EINVAL;
+
+	if (virq == dev->local_irq)
+		return -EINVAL;
+
+	dev->remote_irq = virq;
+
+	return 0;
+}
+
+static int vlynq_probe(struct platform_device *pdev)
+{
+	struct vlynq_device *dev;
+	struct resource *regs_res, *mem_res, *irq_res;
+	int len, result;
+
+	if (strcmp(pdev->name, "vlynq"))
+		return -ENODEV;
+
+	regs_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!regs_res)
+		return -ENODEV;
+
+	mem_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
+	if (!mem_res)
+		return -ENODEV;
+
+	irq_res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "devirq");
+	if (!irq_res)
+		return -ENODEV;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR
+		       "vlynq: failed to allocate device structure\n");
+		return -ENOMEM;
+	}
+
+	dev->id = pdev->id;
+	dev->dev.bus = &vlynq_bus_type;
+	dev->dev.parent = &pdev->dev;
+	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "vlynq%d", dev->id);
+	dev->dev.bus_id[BUS_ID_SIZE - 1] = 0;
+	dev->dev.platform_data = pdev->dev.platform_data;
+	dev->dev.release = vlynq_device_release;
+
+	dev->regs_start = regs_res->start;
+	dev->regs_end = regs_res->end;
+	dev->mem_start = mem_res->start;
+	dev->mem_end = mem_res->end;
+
+	len = regs_res->end - regs_res->start;
+	if (!request_mem_region(regs_res->start, len, dev->dev.bus_id)) {
+		printk(KERN_ERR "%s: Can't request vlynq registers\n",
+		       dev->dev.bus_id);
+		result = -ENXIO;
+		goto fail_request;
+	}
+
+	dev->local = ioremap(regs_res->start, len);
+	if (!dev->local) {
+		printk(KERN_ERR "%s: Can't remap vlynq registers\n",
+		       dev->dev.bus_id);
+		result = -ENXIO;
+		goto fail_remap;
+	}
+
+	dev->remote = (struct vlynq_regs *)((u32)dev->local +
+					    VLYNQ_REMOTE_OFFSET);
+
+	dev->irq = platform_get_irq_byname(pdev, "irq");
+	dev->irq_start = irq_res->start;
+	dev->irq_end = irq_res->end;
+	dev->local_irq = 31;
+	dev->remote_irq = 30;
+
+	if (device_register(&dev->dev))
+		goto fail_register;
+	platform_set_drvdata(pdev, dev);
+
+	printk(KERN_INFO "%s: regs 0x%p, irq %d, mem 0x%p\n",
+	       dev->dev.bus_id, (void *)dev->regs_start, dev->irq,
+	       (void *)dev->mem_start);
+
+	return 0;
+
+fail_register:
+	iounmap(dev->local);
+fail_remap:
+fail_request:
+	release_mem_region(regs_res->start, len);
+	kfree(dev);
+	return result;
+}
+
+static int vlynq_remove(struct platform_device *pdev)
+{
+	struct vlynq_device *dev = platform_get_drvdata(pdev);
+
+	device_unregister(&dev->dev);
+	iounmap(dev->local);
+	release_mem_region(dev->regs_start, dev->regs_end - dev->regs_start);
+
+	kfree(dev);
+
+	return 0;
+}
+
+static struct platform_driver vlynq_driver = {
+	.driver.name = "vlynq",
+	.probe = vlynq_probe,
+	.remove = vlynq_remove,
+};
+
+struct bus_type vlynq_bus_type = {
+	.name = "vlynq",
+	.probe = vlynq_device_probe,
+	.remove = vlynq_device_remove,
+};
+EXPORT_SYMBOL(vlynq_bus_type);
+
+#ifdef CONFIG_PCI
+extern void vlynq_pci_init(void);
+#endif
+static int __init vlynq_init(void)
+{
+	int res = 0;
+
+	res = bus_register(&vlynq_bus_type);
+	if (res)
+		goto fail_bus;
+
+	res = platform_driver_register(&vlynq_driver);
+	if (res)
+		goto fail_platform;
+
+#ifdef CONFIG_PCI
+	vlynq_pci_init();
+#endif
+
+	return 0;
+
+fail_platform:
+	bus_unregister(&vlynq_bus_type);
+fail_bus:
+	return res;
+}
+
+/* Add this back when vlynq-pci crap is gone */
+#if 0
+static void __devexit vlynq_exit(void)
+{
+	platform_driver_unregister(&vlynq_driver);
+	bus_unregister(&vlynq_bus_type);
+}
+#endif
+
+subsys_initcall(vlynq_init);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6379003..577fc3d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1074,11 +1074,23 @@ void *set_except_vector(int n, void *addr)
 	unsigned long old_handler = exception_handlers[n];
 
 	exception_handlers[n] = handler;
-	if (n == 0 && cpu_has_divec) {
-		*(volatile u32 *)(ebase + 0x200) = 0x08000000 |
-		                                 (0x03ffffff & (handler >> 2));
-		flush_icache_range(ebase + 0x200, ebase + 0x204);
-	}
+	if (n == 0 && cpu_has_divec)
+		if ((handler ^ (ebase + 4)) & 0xfc000000) {
+			/* lui k0, 0x0000 */
+			*(u32 *)(ebase + 0x200) = 0x3c1a0000 | (handler >> 16);
+			/* ori k0, 0x0000 */
+			*(u32 *)(ebase + 0x204) =
+					0x375a0000 | (handler & 0xffff);
+			/* jr k0 */
+			*(u32 *)(ebase + 0x208) = 0x03400008;
+			/* nop */
+			*(u32 *)(ebase + 0x20C) = 0x00000000;
+			flush_icache_range(ebase + 0x200, ebase + 0x210);
+		} else {
+			*(volatile u32 *)(ebase + 0x200) =
+				0x08000000 | (0x03ffffff & (handler >> 2));
+			flush_icache_range(ebase + 0x200, ebase + 0x204);
+		}
 	return (void *)old_handler;
 }
 
diff --git a/include/asm-mips/ar7/ar7.h b/include/asm-mips/ar7/ar7.h
new file mode 100644
index 0000000..d21ab49
--- /dev/null
+++ b/include/asm-mips/ar7/ar7.h
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2006, 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __AR7_H__
+#define __AR7_H__
+
+#include <linux/delay.h>
+#include <asm/addrspace.h>
+#include <linux/io.h>
+
+#define AR7_REGS_BASE	0x08610000
+
+#define AR7_REGS_MAC0	(AR7_REGS_BASE + 0x0000)
+#define AR7_REGS_GPIO	(AR7_REGS_BASE + 0x0900)
+/* 0x08610A00 - 0x08610BFF (512 bytes, 128 bytes / clock) */
+#define AR7_REGS_POWER	(AR7_REGS_BASE + 0x0a00)
+#define AR7_REGS_UART0	(AR7_REGS_BASE + 0x0e00)
+#define AR7_REGS_RESET	(AR7_REGS_BASE + 0x1600)
+#define AR7_REGS_VLYNQ0	(AR7_REGS_BASE + 0x1800)
+#define AR7_REGS_DCL	(AR7_REGS_BASE + 0x1a00)
+#define AR7_REGS_VLYNQ1	(AR7_REGS_BASE + 0x1c00)
+#define AR7_REGS_MDIO	(AR7_REGS_BASE + 0x1e00)
+#define AR7_REGS_IRQ	(AR7_REGS_BASE + 0x2400)
+#define AR7_REGS_MAC1	(AR7_REGS_BASE + 0x2800)
+
+#define AR7_REGS_WDT	(AR7_REGS_BASE + 0x1f00)
+#define UR8_REGS_WDT	(AR7_REGS_BASE + 0x0b00)
+#define UR8_REGS_UART1	(AR7_REGS_BASE + 0x0f00)
+
+#define AR7_RESET_PEREPHERIAL	0x0
+#define AR7_RESET_SOFTWARE	0x4
+#define AR7_RESET_STATUS	0x8
+
+#define AR7_RESET_BIT_CPMAC_LO	17
+#define AR7_RESET_BIT_CPMAC_HI	21
+#define AR7_RESET_BIT_MDIO	22
+#define AR7_RESET_BIT_EPHY	26
+
+/* GPIO control registers */
+#define AR7_GPIO_INPUT	0x0
+#define AR7_GPIO_OUTPUT	0x4
+#define AR7_GPIO_DIR	0x8
+#define AR7_GPIO_ENABLE	0xc
+
+#define AR7_CHIP_7100	0x18
+#define AR7_CHIP_7200	0x2b
+#define AR7_CHIP_7300	0x05
+
+/* Interrupts */
+#define AR7_IRQ_UART0	15
+#define AR7_IRQ_UART1	16
+
+/* Clocks */
+#define AR7_AFE_CLOCK	35328000
+#define AR7_REF_CLOCK	25000000
+#define AR7_XTAL_CLOCK	24000000
+
+struct plat_cpmac_data {
+	int reset_bit;
+	int power_bit;
+	u32 phy_mask;
+	char dev_addr[6];
+};
+
+struct plat_dsl_data {
+	int reset_bit_dsl;
+	int reset_bit_sar;
+};
+
+extern int ar7_cpu_clock, ar7_bus_clock, ar7_dsp_clock;
+
+static inline u16 ar7_chip_id(void)
+{
+	return readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x14)) & 0xffff;
+}
+
+static inline u8 ar7_chip_rev(void)
+{
+	return (readl((void *)KSEG1ADDR(AR7_REGS_GPIO + 0x14)) >> 16) & 0xff;
+}
+
+static inline int ar7_cpu_freq(void)
+{
+	return ar7_cpu_clock;
+}
+
+static inline int ar7_bus_freq(void)
+{
+	return ar7_bus_clock;
+}
+
+static inline int ar7_vbus_freq(void)
+{
+	return ar7_bus_clock / 2;
+}
+#define ar7_cpmac_freq ar7_vbus_freq
+
+static inline int ar7_dsp_freq(void)
+{
+	return ar7_dsp_clock;
+}
+
+static inline int ar7_has_high_cpmac(void)
+{
+	u16 chip_id = ar7_chip_id();
+	switch (chip_id) {
+	case AR7_CHIP_7100:
+	case AR7_CHIP_7200:
+		return 0;
+	default:
+		return 1;
+	}
+}
+#define ar7_has_high_vlynq ar7_has_high_cpmac
+#define ar7_has_second_uart ar7_has_high_cpmac
+
+static inline void ar7_device_enable(u32 bit)
+{
+	void *reset_reg =
+		(void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PEREPHERIAL);
+	writel(readl(reset_reg) | (1 << bit), reset_reg);
+	mdelay(20);
+}
+
+static inline void ar7_device_disable(u32 bit)
+{
+	void *reset_reg =
+		(void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PEREPHERIAL);
+	writel(readl(reset_reg) & ~(1 << bit), reset_reg);
+	mdelay(20);
+}
+
+static inline void ar7_device_reset(u32 bit)
+{
+	ar7_device_disable(bit);
+	ar7_device_enable(bit);
+}
+
+static inline void ar7_device_on(u32 bit)
+{
+	void *power_reg = (void *)KSEG1ADDR(AR7_REGS_POWER);
+	writel(readl(power_reg) | (1 << bit), power_reg);
+	mdelay(20);
+}
+
+static inline void ar7_device_off(u32 bit)
+{
+	void *power_reg = (void *)KSEG1ADDR(AR7_REGS_POWER);
+	writel(readl(power_reg) & ~(1 << bit), power_reg);
+	mdelay(20);
+}
+
+#endif /* __AR7_H__ */
diff --git a/include/asm-mips/ar7/gpio.h b/include/asm-mips/ar7/gpio.h
new file mode 100644
index 0000000..1b5d3aa
--- /dev/null
+++ b/include/asm-mips/ar7/gpio.h
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2007 Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __AR7_GPIO_H__
+#define __AR7_GPIO_H__
+#include <asm/ar7/ar7.h>
+
+#define AR7_GPIO_MAX 32
+
+extern int gpio_request(unsigned gpio, char *label);
+extern void gpio_free(unsigned gpio);
+
+/* Common GPIO layer */
+static inline int gpio_direction_input(unsigned gpio)
+{
+	void __iomem *gpio_dir =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_DIR);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	writel(readl(gpio_dir) | (1 << gpio), gpio_dir);
+
+	return 0;
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	void __iomem *gpio_dir =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_DIR);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	writel(readl(gpio_dir) & ~(1 << gpio), gpio_dir);
+
+	return 0;
+}
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	void __iomem *gpio_in =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_INPUT);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	return ((readl(gpio_in) & (1 << gpio)) != 0);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	void __iomem *gpio_out =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_OUTPUT);
+	volatile unsigned tmp;
+
+	if (gpio >= AR7_GPIO_MAX)
+		return;
+
+	tmp = readl(gpio_out) & ~(1 << gpio);
+	if (value)
+		tmp |= 1 << gpio;
+	writel(tmp, gpio_out);
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+
+/* Board specific GPIO functions */
+static inline int ar7_gpio_enable(unsigned gpio)
+{
+	void __iomem *gpio_en =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_ENABLE);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	writel(readl(gpio_en) | (1 << gpio), gpio_en);
+
+	return 0;
+}
+
+static inline int ar7_gpio_disable(unsigned gpio)
+{
+	void __iomem *gpio_en =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_ENABLE);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	writel(readl(gpio_en) & ~(1 << gpio), gpio_en);
+
+	return 0;
+}
+
+#include <asm-generic/gpio.h>
+
+#endif
diff --git a/include/asm-mips/ar7/prom.h b/include/asm-mips/ar7/prom.h
new file mode 100644
index 0000000..62d7d5c
--- /dev/null
+++ b/include/asm-mips/ar7/prom.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2006, 2007 Florian Fainelli <florian@openwrt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __PROM_H__
+#define __PROM_H__
+
+extern char *prom_getenv(char *name);
+extern void prom_printf(char *fmt, ...);
+
+#endif /* __PROM_H__ */
diff --git a/include/asm-mips/ar7/spaces.h b/include/asm-mips/ar7/spaces.h
new file mode 100644
index 0000000..f4d1237
--- /dev/null
+++ b/include/asm-mips/ar7/spaces.h
@@ -0,0 +1,32 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_AR7_SPACES_H
+#define _ASM_AR7_SPACES_H
+
+#define CAC_BASE		0x80000000
+#define IO_BASE			0xa0000000
+#define UNCAC_BASE		0xa0000000
+#define MAP_BASE		0xc0000000
+
+/*
+ * This handles the memory map.
+ * We handle pages at KSEG0 for kernels with 32 bit address space.
+ */
+#define PAGE_OFFSET		0x94000000UL
+#define PHYS_OFFSET		0x14000000UL
+
+/*
+ * Memory above this physical address will be considered highmem.
+ */
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		0x40000000UL
+#endif
+
+#endif /* __ASM_AR7_SPACES_H */
diff --git a/include/asm-mips/ar7/vlynq.h b/include/asm-mips/ar7/vlynq.h
new file mode 100644
index 0000000..41c4fcd
--- /dev/null
+++ b/include/asm-mips/ar7/vlynq.h
@@ -0,0 +1,109 @@
+/*
+ * Copyright (C) 2006, 2007 Felix Fietkau, Eugene Konev
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __VLYNQ_H__
+#define __VLYNQ_H__
+
+struct vlynq_mapping {
+	u32 size;
+	u32 offset;
+} __attribute__ ((packed));
+
+struct vlynq_device_id {
+	u32 id;
+};
+
+enum vlynq_divisor {
+	vlynq_div_auto = 0,
+	vlynq_ldiv1,
+	vlynq_ldiv2,
+	vlynq_ldiv3,
+	vlynq_ldiv4,
+	vlynq_ldiv5,
+	vlynq_ldiv6,
+	vlynq_ldiv7,
+	vlynq_ldiv8,
+	vlynq_rdiv1,
+	vlynq_rdiv2,
+	vlynq_rdiv3,
+	vlynq_rdiv4,
+	vlynq_rdiv5,
+	vlynq_rdiv6,
+	vlynq_rdiv7,
+	vlynq_rdiv8,
+	vlynq_div_external
+};
+
+struct vlynq_regs;
+struct vlynq_device {
+	u32 id;
+	int irq;
+	int local_irq;
+	int remote_irq;
+	enum vlynq_divisor divisor;
+	u32 regs_start, regs_end;
+	u32 mem_start, mem_end;
+	u32 irq_start, irq_end;
+	void *priv;
+	struct vlynq_regs *local;
+	struct vlynq_regs *remote;
+	struct device dev;
+};
+
+struct vlynq_driver {
+	char *name;
+	int (*probe)(struct vlynq_device *dev);
+	int (*remove)(struct vlynq_device *dev);
+	struct device_driver driver;
+};
+
+#define to_vlynq_driver(drv) container_of(drv, struct vlynq_driver, driver)
+
+struct plat_vlynq_ops {
+	int (*on)(struct vlynq_device *dev);
+	void (*off)(struct vlynq_device *dev);
+};
+
+#define to_vlynq_device(device) container_of(device, struct vlynq_device, dev)
+
+extern struct bus_type vlynq_bus_type;
+
+extern int __vlynq_register_driver(struct vlynq_driver *driver,
+				   struct module *owner);
+
+static inline int vlynq_register_driver(struct vlynq_driver *driver)
+{
+	return __vlynq_register_driver(driver, THIS_MODULE);
+}
+
+extern void vlynq_unregister_driver(struct vlynq_driver *driver);
+extern int vlynq_device_enable(struct vlynq_device *dev);
+extern void vlynq_device_disable(struct vlynq_device *dev);
+extern u32 vlynq_remote_id(struct vlynq_device *dev);
+extern void vlynq_set_local_mapping(struct vlynq_device *dev,
+				    u32 tx_offset,
+				    struct vlynq_mapping *mapping);
+extern void vlynq_set_remote_mapping(struct vlynq_device *dev,
+				     u32 tx_offset,
+				     struct vlynq_mapping *mapping);
+extern int vlynq_virq_to_irq(struct vlynq_device *dev, int virq);
+extern int vlynq_irq_to_virq(struct vlynq_device *dev, int irq);
+extern int vlynq_set_local_irq(struct vlynq_device *dev, int virq);
+extern int vlynq_set_remote_irq(struct vlynq_device *dev, int virq);
+
+#endif /* __VLYNQ_H__ */
