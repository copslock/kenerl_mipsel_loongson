Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2007 16:05:42 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.226]:4300 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021705AbXHTPEx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Aug 2007 16:04:53 +0100
Received: by wx-out-0506.google.com with SMTP id h30so1465136wxd
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2007 08:04:32 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=Ebve3luhkhjoSgjPmg6+ClIpQhX57etQPwLVFbuEK7z662DKdgYJLnKEElfSZAAADd63dYz7INUfwjYnT00P8qLzF0uVAkECzP+KXa/FjWNbonAB4B6o72IenzFu0yyrlFF2fzLLWbOgm7auN3w0zhFhadfy7peRICZ7+29C5hY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=cpTIIYgXsgBavnqPy7pS+imnNvw6BwhJu20B1VIC5IdwxhQJSBk3p1r6kVJ/VBDilMT3r2Q2gRQqk7YKGEjGWI3bH2375gJ3qZnG14jRUgcMRqra/ip6RjVbOjT8oAYBOvk+2FUx90oVOsKnvY8OKtXkheOZqOq6ipteRL3Bv8s=
Received: by 10.70.16.6 with SMTP id 6mr10796686wxp.1187622270240;
        Mon, 20 Aug 2007 08:04:30 -0700 (PDT)
Received: from raver.cocorico ( [87.18.114.39])
        by mx.google.com with ESMTPS id i17sm7771206wxd.2007.08.20.08.04.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2007 08:04:26 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 1/1] AR7 port
Date:	Mon, 20 Aug 2007 17:04:10 +0200
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200708201704.11529.technoboy85@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16227
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
I made a diff for the AR7 port, hoping that it will go in the mainstream 
kernel.
I cared about don't including buggy or non free drivers and code.
Also we have to surround the code in arch/mips/kernel/traps.c by some #ifdef 
since
the actual code will break other archs.
The code was taken from the OpenWrt project, is quite good, many people uses 
it daily.

Cheers

Signed-off-by: Matteo Croce <technoboy85@gmail.com>

diff -urN linux-2.6.22.1/arch/mips/ar7/clock.c linux-ar7/arch/mips/ar7/clock.c
--- linux-2.6.22.1/arch/mips/ar7/clock.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/clock.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,472 @@
+/*
+ * $Id: clock.c 8036 2007-07-18 13:42:24Z florian $
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+#define BOOT_PLL_SOURCE_MASK 0x3
+#define CPU_PLL_SOURCE_SHIFT 16
+#define BUS_PLL_SOURCE_SHIFT 14
+#define USB_PLL_SOURCE_SHIFT 18
+#define DSP_PLL_SOURCE_SHIFT 22
+#define BOOT_PLL_SOURCE_AFE 0
+#define BOOT_PLL_SOURCE_BUS 0
+#define BOOT_PLL_SOURCE_REF 1
+#define BOOT_PLL_SOURCE_XTAL 2
+#define BOOT_PLL_SOURCE_CPU 3
+#define BOOT_PLL_BYPASS 0x00000020
+#define BOOT_PLL_ASYNC_MODE 0x02000000
+#define BOOT_PLL_2TO1_MODE 0x00008000
+
+#define TNETD7200_CLOCK_ID_CPU 0
+#define TNETD7200_CLOCK_ID_DSP 1
+#define TNETD7200_CLOCK_ID_USB 2
+
+#define TNETD7200_DEF_CPU_CLK 211000000
+#define TNETD7200_DEF_DSP_CLK 125000000
+#define TNETD7200_DEF_USB_CLK 48000000
+
+struct tnetd7300_clock {
+	volatile u32 ctrl;
+#define PREDIV_MASK 0x001f0000
+#define PREDIV_SHIFT 16
+#define POSTDIV_MASK 0x0000001f
+	u32 unused1[3];
+	volatile u32 pll;
+#define MUL_MASK 0x0000f000
+#define MUL_SHIFT 12
+#define PLL_MODE_MASK 0x00000001
+#define PLL_NDIV 0x00000800
+#define PLL_DIV 0x00000002
+#define PLL_STATUS 0x00000001
+	u32 unused2[3];
+} __attribute__ ((packed));
+
+struct tnetd7300_clocks {
+	struct tnetd7300_clock bus;
+	struct tnetd7300_clock cpu;
+	struct tnetd7300_clock usb;
+	struct tnetd7300_clock dsp;
+} __attribute__ ((packed));
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
+} __attribute__ ((packed));
+
+struct tnetd7200_clocks {
+	struct tnetd7200_clock cpu;
+	struct tnetd7200_clock dsp;
+	struct tnetd7200_clock usb;
+} __attribute__ ((packed));
+
+int ar7_afe_clock = 35328000;
+int ar7_ref_clock = 25000000;
+int ar7_xtal_clock = 24000000;
+
+int ar7_cpu_clock = 150000000;
+EXPORT_SYMBOL(ar7_cpu_clock);
+int ar7_bus_clock = 125000000;
+EXPORT_SYMBOL(ar7_bus_clock);
+int ar7_dsp_clock = 0;
+EXPORT_SYMBOL(ar7_dsp_clock);
+
+static int gcd(int x, int y)
+{
+	if (x > y)
+		return (x % y) ? gcd(y, x % y) : y;
+	return (y % x) ? gcd(x, y % x) : x;
+}
+
+static inline int ABS(int x)
+{
+	return (x >= 0) ? x : -x;
+}
+
+static void approximate(int base, int target, int *prediv,
+			int *postdiv, int *mul)
+{
+	int i, j, k, freq, res = target;
+	for (i = 1; i <= 16; i++) {
+		for (j = 1; j <= 32; j++) {
+			for (k = 1; k <= 32; k++) {
+				freq = ABS(base / j * i / k - target);
+				if (freq < res) {
+					res = freq;
+					*mul = i;
+					*prediv = j;
+					*postdiv = k;
+				}
+			}
+		}
+	}
+}
+
+static void calculate(int base, int target, int *prediv, int *postdiv,
+		      int *mul)
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
+			       u32 *bootcr, u32 bus_clock)
+{
+	int product;
+	int base_clock = ar7_ref_clock;
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
+		base_clock = ar7_ref_clock;
+		break;
+	case BOOT_PLL_SOURCE_XTAL:
+		base_clock = ar7_xtal_clock;
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
+				u32 *bootcr, u32 frequency)
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
+		base_clock = ar7_ref_clock;
+		break;
+	case BOOT_PLL_SOURCE_XTAL:
+		base_clock = ar7_xtal_clock;
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
+	do {
+		status = clock->pll;
+	} while (status & PLL_STATUS);
+	clock->pll = ((mul - 1) << MUL_SHIFT) | (0xff << 3) | 0x0e;
+	mdelay(75);
+}
+
+static void __init tnetd7300_init_clocks(void)
+{
+	u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
+	struct tnetd7300_clocks *clocks = (struct tnetd7300_clocks 
*)ioremap_nocache(AR7_REGS_POWER + 0x20, sizeof(struct tnetd7300_clocks)); 
+
+	ar7_bus_clock = tnetd7300_get_clock(BUS_PLL_SOURCE_SHIFT, 
+					    &clocks->bus, bootcr,
+					    ar7_afe_clock);
+
+	if (*bootcr & BOOT_PLL_ASYNC_MODE) {
+		ar7_cpu_clock = tnetd7300_get_clock(CPU_PLL_SOURCE_SHIFT, 
+						    &clocks->cpu,
+						    bootcr, ar7_afe_clock);
+	} else {
+		ar7_cpu_clock = ar7_bus_clock;
+	}
+
+	tnetd7300_set_clock(USB_PLL_SOURCE_SHIFT, &clocks->usb,
+			    bootcr, 48000000);
+
+	if (ar7_dsp_clock == 250000000)
+		tnetd7300_set_clock(DSP_PLL_SOURCE_SHIFT, &clocks->dsp,
+				    bootcr, ar7_dsp_clock);
+
+	iounmap(clocks);
+	iounmap(bootcr);
+}
+
+static int tnetd7200_get_clock(int base, struct tnetd7200_clock *clock,
+			       u32 *bootcr, u32 bus_clock)
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
+				int prediv, int postdiv, int postdiv2, int mul, u32 frequency) 
+{
+    printk("Clocks: base = %d, frequency = %u, prediv = %d, postdiv = %d, 
postdiv2 = %d, mul = %d\n",
+        base, frequency, prediv, postdiv, postdiv2, mul);
+
+    clock->ctrl = 0;
+	clock->prediv = DIVISOR_ENABLE_MASK | ((prediv - 1) & 0x1F);
+    clock->mul = ((mul - 1) & 0xF);
+
+    for(mul = 0; mul < 2000; mul++) /* nop */;
+
+    while(clock->status & 0x1) /* nop */;
+
+    clock->postdiv = DIVISOR_ENABLE_MASK | ((postdiv - 1) & 0x1F);
+
+    clock->cmden |= 1;
+    clock->cmd |= 1;
+
+    while(clock->status & 0x1) /* nop */;
+
+    clock->postdiv2 = DIVISOR_ENABLE_MASK | ((postdiv2 - 1) & 0x1F);
+
+    clock->cmden |= 1;
+    clock->cmd |= 1;
+
+    while(clock->status & 0x1) /* nop */;
+
+    clock->ctrl |= 1;
+}
+
+static int tnetd7200_get_clock_base(int clock_id, u32 *bootcr)
+{
+    if (*bootcr & BOOT_PLL_ASYNC_MODE) {
+        // Async
+        switch (clock_id) {
+        case TNETD7200_CLOCK_ID_DSP:
+            return ar7_ref_clock;
+        default:
+            return ar7_afe_clock;
+        }
+    } else {
+        // Sync
+		if (*bootcr & BOOT_PLL_2TO1_MODE) {
+            // 2:1
+            switch (clock_id) {
+            case TNETD7200_CLOCK_ID_DSP:
+                return ar7_ref_clock;
+            default:
+                return ar7_afe_clock;
+            }
+        } else {
+            // 1:1
+            return ar7_ref_clock;
+        }
+    }
+}
+
+
+static void __init tnetd7200_init_clocks(void)
+{
+	u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
+	struct tnetd7200_clocks *clocks = (struct tnetd7200_clocks 
*)ioremap_nocache(AR7_REGS_POWER + 0x80, sizeof(struct tnetd7200_clocks)); 
+    int cpu_base, cpu_mul, cpu_prediv, cpu_postdiv;
+    int dsp_base, dsp_mul, dsp_prediv, dsp_postdiv;
+    int usb_base, usb_mul, usb_prediv, usb_postdiv;
+
+    /*
+        Log from Fritz!Box 7170 Annex B:
+
+        CPU revision is: 00018448
+        Clocks: Async mode
+        Clocks: Setting DSP clock
+        Clocks: prediv: 1, postdiv: 1, mul: 5
+        Clocks: base = 25000000, frequency = 125000000, prediv = 1, postdiv = 
2, postdiv2 = 1, mul = 10
+        Clocks: Setting CPU clock
+        Adjusted requested frequency 211000000 to 211968000
+        Clocks: prediv: 1, postdiv: 1, mul: 6
+        Clocks: base = 35328000, frequency = 211968000, prediv = 1, postdiv = 
1, postdiv2 = -1, mul = 6
+        Clocks: Setting USB clock
+        Adjusted requested frequency 48000000 to 48076920
+        Clocks: prediv: 13, postdiv: 1, mul: 5
+        Clocks: base = 125000000, frequency = 48000000, prediv = 13, postdiv 
= 1, postdiv2 = -1, mul = 5
+
+        DSL didn't work if you didn't set the postdiv 2:1 postdiv2 
combination, driver hung on startup.
+        Haven't tested this on a synchronous board, neither do i know what to 
do with ar7_dsp_clock
+    */
+
+    cpu_base = tnetd7200_get_clock_base(TNETD7200_CLOCK_ID_CPU, bootcr);
+    dsp_base = tnetd7200_get_clock_base(TNETD7200_CLOCK_ID_DSP, bootcr);
+
+	if (*bootcr & BOOT_PLL_ASYNC_MODE) {
+        printk("Clocks: Async mode\n");
+
+        printk("Clocks: Setting DSP clock\n");
+        calculate(dsp_base, TNETD7200_DEF_DSP_CLK, &dsp_prediv, &dsp_postdiv, 
&dsp_mul);
+        ar7_bus_clock = ((dsp_base / dsp_prediv) * dsp_mul) / dsp_postdiv;
+        tnetd7200_set_clock(dsp_base, &clocks->dsp, 
+            dsp_prediv, dsp_postdiv * 2, dsp_postdiv, dsp_mul * 2, 
+            ar7_bus_clock);
+
+        printk("Clocks: Setting CPU clock\n");
+        calculate(cpu_base, TNETD7200_DEF_CPU_CLK, &cpu_prediv, &cpu_postdiv, 
&cpu_mul);
+        ar7_cpu_clock = ((cpu_base / cpu_prediv) * cpu_mul) / cpu_postdiv;
+        tnetd7200_set_clock(cpu_base, &clocks->cpu, 
+            cpu_prediv, cpu_postdiv, -1, cpu_mul, 
+            ar7_cpu_clock);
+
+	} else {
+		if (*bootcr & BOOT_PLL_2TO1_MODE) {
+            printk("Clocks: Sync 2:1 mode\n");
+
+            printk("Clocks: Setting CPU clock\n");
+            calculate(cpu_base, TNETD7200_DEF_CPU_CLK, &cpu_prediv, 
&cpu_postdiv, &cpu_mul);
+            ar7_cpu_clock = ((cpu_base / cpu_prediv) * cpu_mul) / 
cpu_postdiv;
+            tnetd7200_set_clock(cpu_base, &clocks->cpu, 
+                cpu_prediv, cpu_postdiv, -1, cpu_mul, 
+                ar7_cpu_clock);
+
+            printk("Clocks: Setting DSP clock\n");
+            calculate(dsp_base, TNETD7200_DEF_DSP_CLK, &dsp_prediv, 
&dsp_postdiv, &dsp_mul);
+            ar7_bus_clock = ar7_cpu_clock / 2;
+            tnetd7200_set_clock(dsp_base, &clocks->dsp, 
+                dsp_prediv, dsp_postdiv * 2, dsp_postdiv, dsp_mul * 2, 
+                ar7_bus_clock);
+		} else {
+            printk("Clocks: Sync 1:1 mode\n");
+
+            printk("Clocks: Setting DSP clock\n");
+            calculate(dsp_base, TNETD7200_DEF_CPU_CLK, &dsp_prediv, 
&dsp_postdiv, &dsp_mul);
+            ar7_bus_clock = ((dsp_base / dsp_prediv) * dsp_mul) / 
dsp_postdiv;
+            tnetd7200_set_clock(dsp_base, &clocks->dsp, 
+                dsp_prediv, dsp_postdiv * 2, dsp_postdiv, dsp_mul * 2, 
+                ar7_bus_clock);
+
+            ar7_cpu_clock = ar7_bus_clock;
+		}
+	}
+
+    printk("Clocks: Setting USB clock\n");
+    usb_base = ar7_bus_clock;
+    calculate(usb_base, TNETD7200_DEF_USB_CLK, &usb_prediv, &usb_postdiv, 
&usb_mul);
+    tnetd7200_set_clock(usb_base, &clocks->usb, 
+        usb_prediv, usb_postdiv, -1, usb_mul, 
+        TNETD7200_DEF_USB_CLK);
+
+#warning FIXME: ????! Hrmm
+    ar7_dsp_clock = ar7_cpu_clock;
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
diff -urN linux-2.6.22.1/arch/mips/ar7/gpio.c linux-ar7/arch/mips/ar7/gpio.c
--- linux-2.6.22.1/arch/mips/ar7/gpio.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/gpio.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,56 @@
+/*
+ * $Id: gpio.c 6600 2007-03-18 09:40:51Z ejka $
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+#include <linux/platform_device.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/ar7/ar7.h>
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
diff -urN linux-2.6.22.1/arch/mips/ar7/irq.c linux-ar7/arch/mips/ar7/irq.c
--- linux-2.6.22.1/arch/mips/ar7/irq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/irq.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,205 @@
+/*
+ * $Id: irq.c 7487 2007-06-04 09:46:30Z nbd $
+ * 
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
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/ar7/ar7.h>
+
+#define EXCEPT_OFFSET 0x80
+#define PACE_OFFSET   0xA0
+#define CHNLS_OFFSET  0x200
+
+#define REG_OFFSET(irq, reg) ((irq) / 32 * 0x4 + reg * 0x10)
+#define SEC_REG_OFFSET(reg) (EXCEPT_OFFSET + reg * 0x8)
+#define SEC_SR_OFFSET  (SEC_REG_OFFSET(0))      /* 0x80 */
+#define CR_OFFSET(irq)  (REG_OFFSET(irq, 1))    /* 0x10 */
+#define SEC_CR_OFFSET  (SEC_REG_OFFSET(1))      /* 0x88 */
+#define ESR_OFFSET(irq) (REG_OFFSET(irq, 2))    /* 0x20 */
+#define SEC_ESR_OFFSET  (SEC_REG_OFFSET(2))     /* 0x90 */
+#define ECR_OFFSET(irq) (REG_OFFSET(irq, 3))    /* 0x30 */
+#define SEC_ECR_OFFSET  (SEC_REG_OFFSET(3))     /* 0x98 */
+#define PIR_OFFSET      (0x40)
+#define MSR_OFFSET      (0x44)
+#define PM_OFFSET(irq)  (REG_OFFSET(irq, 5))    /* 0x50 */
+#define TM_OFFSET(irq)  (REG_OFFSET(irq, 6))    /* 0x60 */
+
+#define REG(addr) (*(volatile u32 *)(KSEG1ADDR(AR7_REGS_IRQ) + addr))
+
+#define CHNL_OFFSET(chnl) (CHNLS_OFFSET + (chnl * 4))
+
+static void ar7_unmask_irq(unsigned int irq_nr);
+static void ar7_mask_irq(unsigned int irq_nr);
+static void ar7_unmask_secondary_irq(unsigned int irq_nr);
+static void ar7_mask_secondary_irq(unsigned int irq_nr);
+static irqreturn_t ar7_cascade(int interrupt, void *dev);
+static irqreturn_t ar7_secondary_cascade(int interrupt, void *dev);
+static void ar7_irq_init(int base);
+static int ar7_irq_base;
+
+static struct irq_chip ar7_irq_type = {
+	.typename = "AR7",
+	.name = "AR7",
+	.unmask = ar7_unmask_irq,
+	.mask = ar7_mask_irq,
+};
+
+static struct irq_chip ar7_secondary_irq_type = {
+	.name = "AR7",
+	.unmask = ar7_unmask_secondary_irq,
+	.mask = ar7_mask_secondary_irq,
+};
+
+static struct irqaction ar7_cascade_action = {
+	.handler = ar7_cascade, 
+	.name = "AR7 cascade interrupt"
+};
+
+static struct irqaction ar7_secondary_cascade_action = {
+	.handler = ar7_secondary_cascade, 
+	.name = "AR7 secondary cascade interrupt"
+};
+
+static void ar7_unmask_irq(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	/* enable the interrupt channel  bit */
+	REG(ESR_OFFSET(irq)) = 1 << ((irq - ar7_irq_base) % 32);
+	local_irq_restore(flags);
+}
+
+static void ar7_mask_irq(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	/* disable the interrupt channel bit */
+	REG(ECR_OFFSET(irq)) = 1 << ((irq - ar7_irq_base) % 32);
+	local_irq_restore(flags);
+}
+
+static void ar7_unmask_secondary_irq(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	/* enable the interrupt channel  bit */
+	REG(SEC_ESR_OFFSET) = 1 << (irq - ar7_irq_base - 40);
+	local_irq_restore(flags);
+}
+
+static void ar7_mask_secondary_irq(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	/* disable the interrupt channel bit */
+	REG(SEC_ECR_OFFSET) = 1 << (irq - ar7_irq_base - 40);
+	local_irq_restore(flags);
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
+	    Disable interrupts and clear pending
+	*/
+	REG(ECR_OFFSET(0)) = 0xffffffff;
+	REG(ECR_OFFSET(32)) = 0xff;
+	REG(SEC_ECR_OFFSET) = 0xffffffff;
+	REG(CR_OFFSET(0)) = 0xffffffff;
+	REG(CR_OFFSET(32)) = 0xff;
+	REG(SEC_CR_OFFSET) = 0xffffffff;
+
+	ar7_irq_base = base;
+
+	for(i = 0; i < 40; i++) {
+		REG(CHNL_OFFSET(i)) = i;
+		/* Primary IRQ's */
+		irq_desc[i + base].status = IRQ_DISABLED;
+		irq_desc[i + base].action = NULL;
+		irq_desc[i + base].depth = 1;
+		irq_desc[i + base].chip = &ar7_irq_type;
+		/* Secondary IRQ's */
+		if (i < 32) {
+			irq_desc[i + base + 40].status = IRQ_DISABLED;
+			irq_desc[i + base + 40].action = NULL;
+			irq_desc[i + base + 40].depth = 1;
+			irq_desc[i + base + 40].chip = &ar7_secondary_irq_type;
+		}
+	}
+
+	setup_irq(2, &ar7_cascade_action);
+	setup_irq(ar7_irq_base, &ar7_secondary_cascade_action);
+	set_c0_status(IE_IRQ0);
+}
+
+static irqreturn_t ar7_cascade(int interrupt, void *dev)
+{
+	int irq;
+
+	irq = (REG(PIR_OFFSET) & 0x3F);
+	REG(CR_OFFSET(irq)) = 1 << (irq % 32);
+
+	do_IRQ(irq + ar7_irq_base);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ar7_secondary_cascade(int interrupt, void *dev)
+{
+	int irq = 0, i;
+	unsigned long status;
+
+	status = REG(SEC_SR_OFFSET);
+	if (unlikely(!status)) {
+		spurious_interrupt();
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < 32; i++)
+		if (status & (i << 1)) {
+			irq = i + 40;
+			REG(SEC_CR_OFFSET) = 1 << i;
+			break;
+		}
+
+	do_IRQ(irq + ar7_irq_base);
+
+	return IRQ_HANDLED;
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_status() & read_c0_cause();
+	if (pending & STATUSF_IP7)		/* cpu timer */
+		do_IRQ(7);
+	else if (pending & STATUSF_IP2)		/* int0 hardware line */
+		do_IRQ(2);
+	else 
+		spurious_interrupt();
+}
diff -urN linux-2.6.22.1/arch/mips/ar7/Makefile 
linux-ar7/arch/mips/ar7/Makefile
--- linux-2.6.22.1/arch/mips/ar7/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/Makefile	2007-08-09 16:27:10.000000000 +0200
@@ -0,0 +1,13 @@
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
+EXTRA_AFLAGS := $(CFLAGS)
diff -urN linux-2.6.22.1/arch/mips/ar7/memory.c 
linux-ar7/arch/mips/ar7/memory.c
--- linux-2.6.22.1/arch/mips/ar7/memory.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/memory.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,75 @@
+/*
+ * $Id: memory.c 8189 2007-07-27 03:07:52Z nico $
+ * 
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
+	add_memory_region(ARCH_PFN_OFFSET << PAGE_SHIFT, pages <<
+			  PAGE_SHIFT, BOOT_MEM_RAM);
+}
+
+void __init prom_free_prom_memory(void)
+{
+	return;
+}
diff -urN linux-2.6.22.1/arch/mips/ar7/platform.c 
linux-ar7/arch/mips/ar7/platform.c
--- linux-2.6.22.1/arch/mips/ar7/platform.c	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/arch/mips/ar7/platform.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,412 @@
+/*
+ * $Id: platform.c 8280 2007-07-31 15:52:06Z florian $
+ * 
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
+#include <linux/autoconf.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/ioport.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
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
+	.end = 0x103fffff,
+};	
+
+static struct resource cpmac_low_res[] = {
+	{
+		.name = "regs",
+		.flags = IORESOURCE_MEM,
+		.start = AR7_REGS_MAC0,
+		.end = AR7_REGS_MAC0 + 0x7FF,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 27,
+		.end = 27,
+        },
+};
+
+static struct resource cpmac_high_res[] = {
+	{
+		.name = "regs",
+		.flags = IORESOURCE_MEM,
+		.start = AR7_REGS_MAC1,
+		.end = AR7_REGS_MAC1 + 0x7FF,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 41,
+		.end = 41,
+        },
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
+        },
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
+		.end = AR7_REGS_VLYNQ1 + 0xFF,
+	},
+	{
+		.name = "irq",
+		.flags = IORESOURCE_IRQ,
+		.start = 33,
+		.end = 33,
+        },
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
+static struct platform_device cpmac_low = {
+	.id = 0,
+	.name = "cpmac",
+	.dev.platform_data = &cpmac_low_data,
+	.resource = cpmac_low_res,
+	.num_resources = ARRAY_SIZE(cpmac_low_res),
+};
+
+static struct platform_device cpmac_high = {
+	.id = 1,
+	.name = "cpmac",
+	.dev.platform_data = &cpmac_high_data,
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
+static struct plat_serial8250_port uart0_data =
+{
+	.mapbase = AR7_REGS_UART0,
+	.irq = AR7_IRQ_UART0,
+	.regshift = 2,
+	.iotype = UPIO_MEM,
+	.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+};
+
+static struct plat_serial8250_port uart1_data =
+{
+	.mapbase = UR8_REGS_UART1,
+	.irq = AR7_IRQ_UART1,
+	.regshift = 2,
+	.iotype = UPIO_MEM,
+	.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+};
+
+static struct plat_serial8250_port uart_data[] = {
+    uart0_data,
+    uart1_data,
+	{ .flags = 0 }
+};
+
+static struct plat_serial8250_port uart_data_single[] = {
+    uart0_data,
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
+    // Only TNETD73xx have a second serial port
+    if (ar7_has_second_uart()) {
+    	uart_port[1].type = PORT_AR7;
+    	uart_port[1].line = 1;
+    	uart_port[1].irq = AR7_IRQ_UART1;
+    	uart_port[1].uartclk = ar7_bus_freq() / 2;
+    	uart_port[1].iotype = UPIO_MEM;
+    	uart_port[1].mapbase = UR8_REGS_UART1;
+    	uart_port[1].membase = ioremap(uart_port[1].mapbase, 256);
+    	uart_port[1].regshift = 2;
+    	res = early_serial_setup(&uart_port[1]);
+    	if (res)
+    		return res;
+    }
+    
+#else // !CONFIG_SERIAL_8250
+
+	uart_data[0].uartclk = ar7_bus_freq() / 2;
+	uart_data[1].uartclk = uart_data[0].uartclk;
+
+    // Only TNETD73xx have a second serial port
+    if (ar7_has_second_uart()) {
+        uart.dev.platform_data = uart_data;
+    }
+
+	res = platform_device_register(&uart);
+	if (res)
+		return res;
+        
+#endif // CONFIG_SERIAL_8250
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
diff -urN linux-2.6.22.1/arch/mips/ar7/prom.c linux-ar7/arch/mips/ar7/prom.c
--- linux-2.6.22.1/arch/mips/ar7/prom.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/prom.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,327 @@
+/*
+ * $Id: prom.c 8189 2007-07-27 03:07:52Z nico $
+ * 
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
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/mips-boards/prom.h>
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
+char * prom_getenv(char *name)
+{
+	int i;
+	for (i = 0; (i < MAX_ENTRY) && adam2_env[i].name; i++)
+		if (!strcmp(name, adam2_env[i].name))
+			return adam2_env[i].value;
+
+	return NULL;
+}
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
+	while(actr < argc) {
+	        strcpy(cp, argv[actr]);
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
+Well-known variable (num is looked up in table above for matching variable 
name)
+Example: cpufrequency=211968000
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
+| 01 |CTRL|CHECKSUM | 01 | _2 | _1 | _1 | _9 | _6 | _8 | _0 | _0 | _0 | \0 | 
FF |
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
+
+Name=Value pair in a single chunk
+Example: NAME=VALUE
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
+| 00 |CTRL|CHECKSUM | 01 | _N | _A | _M | _E | _0 | _V | _A | _L | _U | _E | 
\0 |
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
+
+Name=Value pair in 2 chunks (len is the number of chunks)
+Example: bootloaderVersion=1.3.7.15
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
+| 00 |CTRL|CHECKSUM | 02 | _b | _o | _o | _t | _l | _o | _a | _d | _e | _r | 
_V |
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
+| _e | _r | _s | _i | _o | _n | \0 | _1 | _. | _3 | _. | _7 | _. | _1 | _5 | 
\0 |
++----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+ 
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
+	if(strcmp(psp_env, psp_env_version) == 0) {
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
+	if (!strstr(prom_getcmdline(), "nokgdb"))
+	{
+            strcat(prom_getcmdline(), " console=kgdb");
+            kgdb_enabled = 1;
+            return;
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
+// from adm5120/prom.c
+void prom_printf(char *fmt, ...)
+{
+    va_list args;
+    int l;
+    char *p, *buf_end;
+    char buf[1024];
+
+    va_start(args, fmt);
+    l = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf) */
+    va_end(args);
+
+    buf_end = buf + l;
+
+    for (p = buf; p < buf_end; p++) {
+        /* Crude cr/nl handling is better than none */
+        if (*p == '\n')
+            prom_putchar('\r');
+        prom_putchar(*p);
+    }
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
+
+EXPORT_SYMBOL(prom_getenv);
diff -urN linux-2.6.22.1/arch/mips/ar7/setup.c linux-ar7/arch/mips/ar7/setup.c
--- linux-2.6.22.1/arch/mips/ar7/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/setup.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,124 @@
+/*
+ * $Id: setup.c 8189 2007-07-27 03:07:52Z nico $
+ * 
+ * Copyright (C) 2006, 2007 OpenWrt.org
+ * 
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
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/tty.h>
+#include <linux/pm.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+
+#include <asm/cpu.h>
+#include <asm/irq.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/dma.h>
+#include <asm/time.h>
+#include <asm/traps.h>
+#include <asm/io.h>
+#include <asm/reboot.h>
+#include <asm/gdb-stub.h>
+#include <asm/ar7/ar7.h>
+
+extern void ar7_time_init(void);
+static void ar7_machine_restart(char *command);
+static void ar7_machine_halt(void);
+static void ar7_machine_power_off(void);
+
+static void ar7_machine_restart(char *command)
+{
+	volatile u32 *softres_reg = (u32 *)ioremap(AR7_REGS_RESET +
+						   AR7_RESET_SOFTWARE, 1);
+	*softres_reg = 1;
+}
+
+static void ar7_machine_halt(void)
+{
+	while (1);
+}
+
+static void ar7_machine_power_off(void)
+{
+        volatile u32 *power_reg = (u32 *)ioremap(AR7_REGS_POWER, 1);
+	u32 power_state = *power_reg | (3 << 30);
+	*power_reg = power_state;
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
+#warning FIXME: clock initialisation
+	ar7_init_clocks();
+
+	ioport_resource.start = 0;
+	ioport_resource.end   = ~0;
+	iomem_resource.start  = 0;
+	iomem_resource.end    = ~0;
+
+	printk("%s, ID: 0x%04x, Revision: 0x%02x\n", get_system_type(), 
+		ar7_chip_id(), ar7_chip_rev());
+}
+
+console_initcall(ar7_init_console);
diff -urN linux-2.6.22.1/arch/mips/ar7/time.c linux-ar7/arch/mips/ar7/time.c
--- linux-2.6.22.1/arch/mips/ar7/time.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/time.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,59 @@
+/*
+ * $Id: time.c 6600 2007-03-18 09:40:51Z ejka $
+ * 
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
+ * Setting up the clock on the MIPS boards.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/mc146818rtc.h>
+
+#include <asm/mipsregs.h>
+#include <asm/ptrace.h>
+#include <asm/hardirq.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+#include <asm/cpu.h>
+#include <asm/time.h>
+#include <asm/mc146818-time.h>
+#include <asm/msc01_ic.h>
+
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/mips-boards/maltaint.h>
+#include <asm/mc146818-time.h>
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
diff -urN linux-2.6.22.1/arch/mips/ar7/vlynq.c linux-ar7/arch/mips/ar7/vlynq.c
--- linux-2.6.22.1/arch/mips/ar7/vlynq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/arch/mips/ar7/vlynq.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,549 @@
+/*
+ * $Id: vlynq.c 8188 2007-07-27 00:59:50Z nico $
+ * 
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
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/ar7/ar7.h>
+#include <asm/ar7/vlynq.h>
+
+#define PER_DEVICE_IRQS 32
+
+#define VLYNQ_CTRL_PM_ENABLE       0x80000000
+#define VLYNQ_CTRL_CLOCK_INT       0x00008000
+#define VLYNQ_CTRL_CLOCK_DIV(x)    ((x & 7) << 16)
+#define VLYNQ_CTRL_INT_LOCAL       0x00004000
+#define VLYNQ_CTRL_INT_ENABLE      0x00002000
+#define VLYNQ_CTRL_INT_VECTOR(x)   ((x & 0x1f) << 8)
+#define VLYNQ_CTRL_INT2CFG         0x00000080
+#define VLYNQ_CTRL_RESET           0x00000001
+
+#define VLYNQ_STATUS_RERROR        0x00000100
+#define VLYNQ_STATUS_LERROR        0x00000080
+#define VLYNQ_STATUS_LINK          0x00000001
+
+#define VINT_ENABLE    0x00000100
+#define VINT_TYPE_EDGE 0x00000080
+#define VINT_LEVEL_LOW 0x00000040
+#define VINT_VECTOR(x) (x & 0x1f)
+#define VINT_OFFSET(irq) (8 * ((irq) % 4))
+
+#define VLYNQ_AUTONEGO_V2          0x00010000
+
+struct vlynq_regs {
+	volatile u32 revision;
+	volatile u32 control;
+	volatile u32 status;
+	volatile u32 int_prio;
+	volatile u32 int_status;
+	volatile u32 int_pending;
+	volatile u32 int_ptr;
+	volatile u32 tx_offset;
+	volatile struct vlynq_mapping rx_mapping[4];
+	volatile u32 chip;
+	volatile u32 autonego;
+	volatile u32 unused[6];
+	volatile u32 int_device[8];
+} __attribute__ ((packed));
+
+#ifdef VLYNQ_DEBUG
+static void vlynq_dump_regs(struct vlynq_device *dev)
+{
+	int i;
+	printk("VLYNQ local=%p remote=%p\n", dev->local, dev->remote);
+	for (i = 0; i < 32; i++) {
+		printk("VLYNQ: local %d: %08x\n", i + 1, ((u32 *)dev->local)[i]);
+		printk("VLYNQ: remote %d: %08x\n", i + 1, ((u32 *)dev->remote)[i]);
+	}
+}
+
+static void vlynq_dump_mem(u32 *base, int count)
+{
+	int i;
+	for (i = 0; i < (count + 3) / 4; i++) {
+		if (i % 4 == 0) printk("\nMEM[0x%04x]:", i * 4);
+		printk(" 0x%08x", *(base + i));
+	}
+	printk("\n");
+}
+#endif
+
+int vlynq_linked(struct vlynq_device *dev)
+{
+	int i;
+	for (i = 0; i < 10; i++)
+		if (dev->local->status & VLYNQ_STATUS_LINK) {
+			printk("%s: linked\n", dev->dev.bus_id);
+			return 1;
+		} else {
+			mdelay(1);
+		}
+	return 0;
+}
+
+static void vlynq_irq_unmask(unsigned int irq)
+{
+	volatile u32 val;
+	struct vlynq_device *dev = irq_desc[irq].chip_data;
+	int virq;
+
+	BUG_ON(!dev);
+	virq = irq - dev->irq_start;
+	val = dev->remote->int_device[virq >> 2];
+	val |= (VINT_ENABLE | virq) << VINT_OFFSET(virq);
+	dev->remote->int_device[virq >> 2] = val;
+}
+
+static void vlynq_irq_mask(unsigned int irq)
+{
+	volatile u32 val;
+	struct vlynq_device *dev = irq_desc[irq].chip_data;
+	int virq;
+
+	BUG_ON(!dev);
+	virq = irq - dev->irq_start;
+	val = dev->remote->int_device[virq >> 2];
+	val &= ~(VINT_ENABLE << VINT_OFFSET(virq));
+	dev->remote->int_device[virq >> 2] = val;
+}
+
+static int vlynq_irq_type(unsigned int irq, unsigned int flow_type)
+{
+	volatile u32 val;
+	struct vlynq_device *dev = irq_desc[irq].chip_data;
+	int virq;
+
+	BUG_ON(!dev);
+	virq = irq - dev->irq_start;
+	val = dev->remote->int_device[virq >> 2];
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
+	dev->remote->int_device[virq >> 2] = val;
+	return 0;
+}
+
+static irqreturn_t vlynq_irq(int irq, void *dev_id)
+{
+	struct vlynq_device *dev = dev_id;
+	u32 status, ack;
+	int virq = 0;
+
+	status = dev->local->int_status;
+	dev->local->int_status = status;
+
+	if (status & (1 << dev->local_irq)) { /* Local vlynq IRQ. Ack */
+		ack = dev->local->status;
+		dev->local->status = ack;
+	}
+
+	if (status & (1 << dev->remote_irq)) { /* Remote vlynq IRQ. Ack */
+		ack = dev->remote->status;
+		dev->remote->status = ack;
+	} 
+
+	status &= ~((1 << dev->local_irq) | (1 << dev->remote_irq));
+	while (status) {
+		if (status & 1) /* Remote device IRQ. Pass. */
+			do_IRQ(dev->irq_start + virq);
+		status >>= 1;
+		virq++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip vlynq_irq_chip = {
+        .typename = "VLYNQ",
+        .name = "vlynq",
+        .unmask = vlynq_irq_unmask,
+        .mask = vlynq_irq_mask,
+        .set_type = vlynq_irq_type,
+};
+
+static int vlynq_setup_irq(struct vlynq_device *dev)
+{
+	u32 val;
+	int i;
+
+	if (dev->local_irq == dev->remote_irq) {
+		printk("%s: local vlynq irq should be different from remote\n", 
+		       dev->dev.bus_id);
+		return -EINVAL;
+	}
+
+	val = VLYNQ_CTRL_INT_VECTOR(dev->local_irq);
+	val |= VLYNQ_CTRL_INT_ENABLE | VLYNQ_CTRL_INT_LOCAL |
+		VLYNQ_CTRL_INT2CFG;
+	dev->local->int_ptr = 0x14;
+	dev->local->control |= val;
+
+	val = VLYNQ_CTRL_INT_VECTOR(dev->remote_irq);
+	val |= VLYNQ_CTRL_INT_ENABLE;
+	dev->remote->int_ptr = 0x14;
+	dev->remote->control |= val;
+
+	for (i = 0; i < PER_DEVICE_IRQS; i++) {
+		if ((i == dev->local_irq) || (i == dev->remote_irq))
+			continue;
+		irq_desc[dev->irq_start + i].status = IRQ_DISABLED;
+		irq_desc[dev->irq_start + i].action = 0;
+		irq_desc[dev->irq_start + i].depth = 1;
+		irq_desc[dev->irq_start + i].chip = &vlynq_irq_chip;
+		irq_desc[dev->irq_start + i].chip_data = dev;
+		dev->remote->int_device[i >> 2] = 0;
+	}
+
+	if (request_irq(dev->irq, vlynq_irq, SA_SHIRQ, "vlynq", dev)) {
+		printk("%s: request_irq failed\n", dev->dev.bus_id);
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
+int __vlynq_register_driver(struct vlynq_driver *driver, struct module 
*owner)
+{
+	driver->driver.name = driver->name;
+	driver->driver.bus = &vlynq_bus_type;
+/*	driver->driver.owner = owner;*/
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
+	u32 val;
+	u32 div;
+	int result;
+	struct plat_vlynq_ops *ops = dev->dev.platform_data;
+
+	result = ops->on(dev);
+	if (result)
+		return result;
+
+	dev->local->control = 0;
+	dev->remote->control = 0;
+
+	printk("ar7_dsp_freq() = %d\n", ar7_dsp_freq());
+	if (vlynq_linked(dev)) 
+		return vlynq_setup_irq(dev);
+
+	for (val = 0; val < 8; val++) {
+		dev->local->control = VLYNQ_CTRL_CLOCK_DIV(val) |
+			VLYNQ_CTRL_CLOCK_INT;
+		if (vlynq_linked(dev)) 
+			return vlynq_setup_irq(dev);
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
+u32 vlynq_local_id(struct vlynq_device *dev)
+{
+	return dev->local->chip;
+}
+
+u32 vlynq_remote_id(struct vlynq_device *dev)
+{
+	return dev->remote->chip;
+}
+
+void vlynq_set_local_mapping(struct vlynq_device *dev, u32 tx_offset,
+			     struct vlynq_mapping *mapping)
+{
+	int i;
+
+	dev->local->tx_offset = tx_offset;
+	for (i = 0; i < 4; i++) {
+		dev->local->rx_mapping[i].offset = mapping[i].offset;
+		dev->local->rx_mapping[i].size = mapping[i].size;
+	}
+}
+
+void vlynq_set_remote_mapping(struct vlynq_device *dev, u32 tx_offset,
+			      struct vlynq_mapping *mapping)
+{
+	int i;
+
+	dev->remote->tx_offset = tx_offset;
+	for (i = 0; i < 4; i++) {
+		dev->remote->rx_mapping[i].offset = mapping[i].offset;
+		dev->remote->rx_mapping[i].size = mapping[i].size;
+	}
+}
+
+int vlynq_virq_to_irq(struct vlynq_device *dev, int virq)
+{
+	if ((virq < 0) || (virq >= PER_DEVICE_IRQS)) 
+		return -EINVAL;
+
+	if ((virq == dev->local_irq) || (virq == dev->remote_irq))
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
+	dev = kmalloc(sizeof(struct vlynq_device), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR "vlynq: failed to allocate device structure\n");
+		return -ENOMEM;
+	}
+
+	memset(dev, 0, sizeof(struct vlynq_device));
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
+		printk("%s: Can't request vlynq registers\n", dev->dev.bus_id);
+		result = -ENXIO;
+                goto fail_request;
+	}
+
+	dev->local = ioremap_nocache(regs_res->start, len);
+        if (!dev->local) {
+		printk("%s: Can't remap vlynq registers\n", dev->dev.bus_id);
+		result = -ENXIO;
+                goto fail_remap;
+	}
+
+	dev->remote = (struct vlynq_regs *)((u32)dev->local + 128);
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
+	printk("%s: regs 0x%p, irq %d, mem 0x%p\n",
+	       dev->dev.bus_id, (void *)dev->regs_start, dev->irq,
+	       (void *)dev->mem_start);
+
+	return 0;
+
+fail_register:
+fail_remap:
+	iounmap(dev->local);
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
+int __init vlynq_init(void)
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
+/*
+void __devexit vlynq_exit(void)
+{
+	platform_driver_unregister(&vlynq_driver);
+	bus_unregister(&vlynq_bus_type);
+}
+*/
+
+
+subsys_initcall(vlynq_init);
diff -urN linux-2.6.22.1/arch/mips/Kconfig linux-ar7/arch/mips/Kconfig
--- linux-2.6.22.1/arch/mips/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/arch/mips/Kconfig	2007-08-09 16:21:48.000000000 +0200
@@ -15,6 +15,20 @@
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
+	select GENERIC_GPIO
+
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
 
diff -urN linux-2.6.22.1/arch/mips/kernel/traps.c 
linux-ar7/arch/mips/kernel/traps.c
--- linux-2.6.22.1/arch/mips/kernel/traps.c	2007-07-10 20:56:30.000000000 
+0200
+++ linux-ar7/arch/mips/kernel/traps.c	2007-08-09 16:21:48.000000000 +0200
@@ -1051,11 +1051,6 @@
 unsigned long exception_handlers[32];
 unsigned long vi_handlers[64];
 
-/*
- * As a side effect of the way this is implemented we're limited
- * to interrupt handlers in the address range from
- * KSEG0 <= x < KSEG0 + 256mb on the Nevada.  Oh well ...
- */
 void *set_except_vector(int n, void *addr)
 {
 	unsigned long handler = (unsigned long) addr;
@@ -1063,9 +1058,15 @@
 
 	exception_handlers[n] = handler;
 	if (n == 0 && cpu_has_divec) {
-		*(volatile u32 *)(ebase + 0x200) = 0x08000000 |
-		                                 (0x03ffffff & (handler >> 2));
-		flush_icache_range(ebase + 0x200, ebase + 0x204);
+		/* lui k0, 0x0000 */
+		*(volatile u32 *)(CAC_BASE+0x200) = 0x3c1a0000 | (handler >> 16);
+		/* ori k0, 0x0000 */
+		*(volatile u32 *)(CAC_BASE+0x204) = 0x375a0000 | (handler & 0xffff);
+		/* jr k0 */
+		*(volatile u32 *)(CAC_BASE+0x208) = 0x03400008;
+		/* nop */
+		*(volatile u32 *)(CAC_BASE+0x20C) = 0x00000000;
+		flush_icache_range(CAC_BASE+0x200, CAC_BASE+0x210);
 	}
 	return (void *)old_handler;
 }
diff -urN linux-2.6.22.1/arch/mips/Makefile linux-ar7/arch/mips/Makefile
--- linux-2.6.22.1/arch/mips/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/arch/mips/Makefile	2007-08-09 16:21:48.000000000 +0200
@@ -158,6 +158,13 @@
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
diff -urN linux-2.6.22.1/drivers/char/ar7_gpio.c 
linux-ar7/drivers/char/ar7_gpio.c
--- linux-2.6.22.1/drivers/char/ar7_gpio.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/drivers/char/ar7_gpio.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,161 @@
+/*
+ * linux/drivers/char/ar7_gpio.c
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <gpio.h>
+
+#define DRVNAME "ar7_gpio"
+#define LONGNAME "TI AR7 GPIOs Driver"
+
+MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
+MODULE_DESCRIPTION(LONGNAME);
+MODULE_LICENSE("GPL");
+
+static int ar7_gpio_major = 0;
+
+static ssize_t ar7_gpio_write(struct file *file, const char __user *buf,
+	size_t len, loff_t *ppos)
+{
+	int pin = iminor(file->f_dentry->d_inode);
+	size_t i;
+
+	for (i = 0; i < len; ++i) {
+		char c;
+		if (get_user(c, buf + i))
+			return -EFAULT;
+		switch (c) {
+		case '0':
+			gpio_set_value(pin, 0);
+			break;
+		case '1':
+			gpio_set_value(pin, 1);
+			break;
+		case 'd':
+		case 'D':
+			ar7_gpio_disable(pin);
+			break;
+		case 'e':
+		case 'E':
+			ar7_gpio_enable(pin);
+			break;
+		case 'i':
+		case 'I':
+		case '<':
+			gpio_direction_input(pin);
+			break;
+		case 'o':
+		case 'O':
+		case '>':
+			gpio_direction_output(pin);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return len;
+}
+
+static ssize_t ar7_gpio_read(struct file *file, char __user * buf,
+	size_t len, loff_t * ppos)
+{
+	int pin = iminor(file->f_dentry->d_inode);
+	int value;
+
+	value = gpio_get_value(pin);
+	if (put_user(value ? '1' : '0', buf))
+		return -EFAULT;
+
+	return 1;
+}
+
+static int ar7_gpio_open(struct inode *inode, struct file *file)
+{
+	int m = iminor(inode);
+
+	if (m >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	return nonseekable_open(inode, file);
+}
+
+static int ar7_gpio_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations ar7_gpio_fops = {
+	.owner   = THIS_MODULE,
+	.write   = ar7_gpio_write,
+	.read    = ar7_gpio_read,
+	.open    = ar7_gpio_open,
+	.release = ar7_gpio_release,
+	.llseek  = no_llseek,
+};
+
+static struct platform_device *ar7_gpio_device;
+
+static int __init ar7_gpio_init(void)
+{
+	int rc;
+
+	ar7_gpio_device = platform_device_alloc(DRVNAME, -1);
+	if (!ar7_gpio_device)
+		return -ENOMEM;
+
+	rc = platform_device_add(ar7_gpio_device);
+	if (rc < 0)
+		goto out_put;
+
+	rc = register_chrdev(ar7_gpio_major, DRVNAME, &ar7_gpio_fops);
+	if (rc < 0)
+		goto out_put;
+
+	ar7_gpio_major = rc;
+
+	rc = 0;
+
+	goto out;
+
+out_put:
+	platform_device_put(ar7_gpio_device);
+out:
+	return rc;
+}
+
+static void __exit ar7_gpio_exit(void)
+{
+	unregister_chrdev(ar7_gpio_major, DRVNAME);
+	platform_device_unregister(ar7_gpio_device);
+}
+
+module_init(ar7_gpio_init);
+module_exit(ar7_gpio_exit);
diff -urN linux-2.6.22.1/drivers/char/Kconfig linux-ar7/drivers/char/Kconfig
--- linux-2.6.22.1/drivers/char/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/drivers/char/Kconfig	2007-08-09 16:48:22.000000000 +0200
@@ -946,6 +946,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called mwave.
 
+config AR7_GPIO
+	tristate "TI AR7 GPIO Support"
+	depends on AR7
+	help
+	  Give userspace access to the GPIO pins on the Texas Instruments AR7 
+	  processors.
+
+	  If compiled as a module, it will be called ar7_gpio.
+
 config SCx200_GPIO
 	tristate "NatSemi SCx200 GPIO Support"
 	depends on SCx200
diff -urN linux-2.6.22.1/drivers/char/Makefile linux-ar7/drivers/char/Makefile
--- linux-2.6.22.1/drivers/char/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/drivers/char/Makefile	2007-08-09 16:48:22.000000000 +0200
@@ -86,6 +86,7 @@
 obj-$(CONFIG_PPDEV)		+= ppdev.o
 obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
 obj-$(CONFIG_NWFLASH)		+= nwflash.o
+obj-$(CONFIG_AR7_GPIO)		+= ar7_gpio.o
 obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
 obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
 obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
diff -urN linux-2.6.22.1/drivers/leds/Kconfig linux-ar7/drivers/leds/Kconfig
--- linux-2.6.22.1/drivers/leds/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/drivers/leds/Kconfig	2007-08-09 16:48:37.000000000 +0200
@@ -20,6 +20,12 @@
 
 comment "LED drivers"
 
+config LEDS_AR7
+	tristate "LED Support for the TI AR7"
+	depends LEDS_CLASS && AR7
+	help
+	  This option enables support for the LEDs on TI AR7.
+
 config LEDS_CORGI
 	tristate "LED Support for the Sharp SL-C7x0 series"
 	depends on LEDS_CLASS && PXA_SHARP_C7xx
diff -urN linux-2.6.22.1/drivers/leds/leds-ar7.c 
linux-ar7/drivers/leds/leds-ar7.c
--- linux-2.6.22.1/drivers/leds/leds-ar7.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/drivers/leds/leds-ar7.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,132 @@
+/*
+ * linux/drivers/leds/leds-ar7.c
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <asm/io.h>
+#include <gpio.h>
+
+#define DRVNAME "ar7-leds"
+#define LONGNAME "TI AR7 LEDs driver"
+#define AR7_GPIO_BIT_STATUS_LED 8
+
+MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
+MODULE_DESCRIPTION(LONGNAME);
+MODULE_LICENSE("GPL");
+
+static void ar7_status_led_set(struct led_classdev *pled, 
+		enum led_brightness value)
+{
+	gpio_set_value(AR7_GPIO_BIT_STATUS_LED, value ? 0 : 1);
+}
+
+static struct led_classdev ar7_status_led = {
+	.name		= "ar7:status",
+	.brightness_set	= ar7_status_led_set,
+};
+
+#ifdef CONFIG_PM
+static int ar7_leds_suspend(struct platform_device *dev,
+		pm_message_t state)
+{
+	led_classdev_suspend(&ar7_status_led);
+	return 0;
+}
+
+static int ar7_leds_resume(struct platform_device *dev)
+{
+	led_classdev_resume(&ar7_status_led);
+	return 0;
+}
+#else /* CONFIG_PM */
+#define ar7_leds_suspend NULL
+#define ar7_leds_resume NULL
+#endif /* CONFIG_PM */
+
+static int ar7_leds_probe(struct platform_device *pdev)
+{
+	int rc;
+
+	rc = led_classdev_register(&pdev->dev, &ar7_status_led);
+	if (rc < 0 )
+		goto out;
+
+	ar7_gpio_enable(AR7_GPIO_BIT_STATUS_LED);
+	gpio_direction_output(AR7_GPIO_BIT_STATUS_LED);
+
+out:
+	return rc;
+}
+
+static int ar7_leds_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&ar7_status_led);
+
+	return 0;
+}
+
+static struct platform_device *ar7_leds_device;
+
+static struct platform_driver ar7_leds_driver = {
+	.probe		= ar7_leds_probe,
+	.remove		= ar7_leds_remove,
+	.suspend	= ar7_leds_suspend,
+	.resume		= ar7_leds_resume,
+	.driver		= {
+		.name		= DRVNAME,
+	},
+};
+
+static int __init ar7_leds_init(void)
+{
+	int rc;
+
+	ar7_leds_device = platform_device_alloc(DRVNAME, -1);
+	if (!ar7_leds_device)
+		return -ENOMEM;
+
+	rc = platform_device_add(ar7_leds_device);
+	if (rc < 0)
+		goto out_put;
+
+	rc = platform_driver_register(&ar7_leds_driver);
+	if (rc < 0)
+		goto out_put;
+
+	goto out;
+
+out_put:
+	platform_device_put(ar7_leds_device);
+out:
+	return rc;
+}
+
+static void __exit ar7_leds_exit(void)
+{
+	platform_driver_unregister(&ar7_leds_driver);
+	platform_device_unregister(ar7_leds_device);
+}
+
+module_init(ar7_leds_init);
+module_exit(ar7_leds_exit);
diff -urN linux-2.6.22.1/drivers/leds/Makefile linux-ar7/drivers/leds/Makefile
--- linux-2.6.22.1/drivers/leds/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/drivers/leds/Makefile	2007-08-09 16:48:37.000000000 +0200
@@ -5,6 +5,7 @@
 obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
 
 # LED Platform Drivers
+obj-$(CONFIG_LEDS_AR7)			+= leds-ar7.o
 obj-$(CONFIG_LEDS_CORGI)		+= leds-corgi.o
 obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
 obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.o
diff -urN linux-2.6.22.1/drivers/mtd/ar7part.c linux-ar7/drivers/mtd/ar7part.c
--- linux-2.6.22.1/drivers/mtd/ar7part.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/drivers/mtd/ar7part.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,140 @@
+/*
+ * $Id: ar7part.c 6948 2007-04-15 04:01:45Z ejka $
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+ *
+ * TI AR7 flash partition table.
+ * Based on ar7 map by Felix Fietkau.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/bootmem.h>
+#include <linux/squashfs_fs.h>
+
+struct ar7_bin_rec {
+	unsigned int checksum;
+	unsigned int length;
+	unsigned int address;
+};
+
+static struct mtd_partition ar7_parts[5];
+
+static int create_mtd_partitions(struct mtd_info *master, 
+				 struct mtd_partition **pparts, 
+				 unsigned long origin)
+{
+	struct ar7_bin_rec header;
+	unsigned int offset, len;
+	unsigned int pre_size = master->erasesize, post_size = 0,
+		root_offset = 0xe0000;
+	int retries = 10;
+
+	printk("Parsing AR7 partition map...\n");
+
+	ar7_parts[0].name = "loader";
+	ar7_parts[0].offset = 0;
+	ar7_parts[0].size = master->erasesize;
+	ar7_parts[0].mask_flags = MTD_WRITEABLE;
+
+	ar7_parts[1].name = "config";
+	ar7_parts[1].offset = 0;
+	ar7_parts[1].size = master->erasesize;
+	ar7_parts[1].mask_flags = 0;
+
+	do {
+		offset = pre_size;
+		master->read(master, offset, sizeof(header), &len, (u_char *)&header);
+		if (!strncmp((char *)&header, "TIENV0.8", 8))
+			ar7_parts[1].offset = pre_size;
+		if (header.checksum == 0xfeedfa42)
+			break;
+		if (header.checksum == 0xfeed1281)
+			break;
+		pre_size += master->erasesize;
+	} while (retries--);
+
+	pre_size = offset;
+
+	if (!ar7_parts[1].offset) {
+		ar7_parts[1].offset = master->size - master->erasesize;
+		post_size = master->erasesize;
+	}
+
+	switch (header.checksum) {
+	case 0xfeedfa42:
+		while (header.length) {
+			offset += sizeof(header) + header.length;
+			master->read(master, offset, sizeof(header),
+				     &len, (u_char *)&header); 
+		}
+		root_offset = offset + sizeof(header) + 4;
+		break;
+	case 0xfeed1281:
+		while (header.length) {
+			offset += sizeof(header) + header.length;
+			master->read(master, offset, sizeof(header),
+				     &len, (u_char *)&header); 
+		}
+		root_offset = offset + sizeof(header) + 4 + 0xff;
+		root_offset &= ~(u32)0xff;
+		break;
+	default:
+		printk("Unknown magic: %08x\n", header.checksum);
+		break;
+	}
+
+	master->read(master, root_offset, sizeof(header), &len, (u_char *)&header);
+	if (header.checksum != SQUASHFS_MAGIC) {
+		root_offset += master->erasesize - 1;
+		root_offset &= ~(master->erasesize - 1);
+	}
+
+	ar7_parts[2].name = "linux";
+	ar7_parts[2].offset = pre_size;
+	ar7_parts[2].size = master->size - pre_size - post_size;
+	ar7_parts[2].mask_flags = 0;
+
+	ar7_parts[3].name = "rootfs";
+	ar7_parts[3].offset = root_offset;
+	ar7_parts[3].size = master->size - root_offset - post_size;
+	ar7_parts[3].mask_flags = 0;
+
+	*pparts = ar7_parts;
+	return 4;
+}
+
+static struct mtd_part_parser ar7_parser = {
+	.owner = THIS_MODULE,
+	.parse_fn = create_mtd_partitions,
+	.name = "ar7part",
+};
+
+static int __init ar7_parser_init(void)
+{
+	return register_mtd_parser(&ar7_parser);
+}
+
+module_init(ar7_parser_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Felix Fietkau, Eugene Konev");
+MODULE_DESCRIPTION("MTD partitioning for TI AR7");
diff -urN linux-2.6.22.1/drivers/mtd/Kconfig linux-ar7/drivers/mtd/Kconfig
--- linux-2.6.22.1/drivers/mtd/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/drivers/mtd/Kconfig	2007-08-09 16:48:08.000000000 +0200
@@ -150,6 +150,12 @@
 	  for your particular device. It won't happen automatically. The
 	  'armflash' map driver (CONFIG_MTD_ARMFLASH) does this, for example.
 
+config MTD_AR7_PARTS
+	tristate "TI AR7 partitioning support"
+	depends on MTD_PARTITIONS
+	---help---
+	  TI AR7 partitioning support
+
 comment "User Modules And Translation Layers"
 
 config MTD_CHAR
diff -urN linux-2.6.22.1/drivers/mtd/Makefile linux-ar7/drivers/mtd/Makefile
--- linux-2.6.22.1/drivers/mtd/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-ar7/drivers/mtd/Makefile	2007-08-09 16:48:08.000000000 +0200
@@ -11,6 +11,7 @@
 obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
 obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
+obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
 
 # 'Users' - code which presents functionality to userspace.
 obj-$(CONFIG_MTD_CHAR)		+= mtdchar.o
diff -urN linux-2.6.22.1/drivers/mtd/maps/physmap.c 
linux-ar7/drivers/mtd/maps/physmap.c
--- linux-2.6.22.1/drivers/mtd/maps/physmap.c	2007-07-10 20:56:30.000000000 
+0200
+++ linux-ar7/drivers/mtd/maps/physmap.c	2007-08-09 16:48:08.000000000 +0200
@@ -74,7 +74,7 @@
 
 static const char *rom_probe_types[] = 
{ "cfi_probe", "jedec_probe", "map_rom", NULL };
 #ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
+static const char *part_probe_types[] = 
{ "cmdlinepart", "RedBoot", "ar7part", NULL };
 #endif
 
 static int physmap_flash_probe(struct platform_device *dev)
diff -urN linux-2.6.22.1/drivers/net/cpmac.c linux-ar7/drivers/net/cpmac.c
--- linux-2.6.22.1/drivers/net/cpmac.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-ar7/drivers/net/cpmac.c	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,1222 @@
+/*
+ * $Id: cpmac.c 8364 2007-08-07 07:37:47Z florian $
+ * 
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
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+
+#include <linux/sched.h>
+#include <linux/kernel.h> /* printk() */
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/version.h>
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/skbuff.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <asm/ar7/ar7.h>
+#include <gpio.h>
+
+MODULE_AUTHOR("Eugene Konev");
+MODULE_DESCRIPTION("TI AR7 ethernet driver (CPMAC)");
+MODULE_LICENSE("GPL");
+
+static int rx_ring_size = 64;
+static int disable_napi = 0;
+module_param(rx_ring_size, int, 64);
+module_param(disable_napi, int, 0);
+MODULE_PARM_DESC(rx_ring_size, "Size of rx ring (in skbs)");
+MODULE_PARM_DESC(disable_napi, "Disable NAPI polling");
+
+/* Register definitions */
+struct cpmac_control_regs {
+	volatile u32 revision;
+	volatile u32 control;
+	volatile u32 teardown;
+	volatile u32 unused;
+} __attribute__ ((packed));
+
+struct cpmac_int_regs {
+	volatile u32 stat_raw;
+	volatile u32 stat_masked;
+	volatile u32 enable;
+	volatile u32 clear;
+} __attribute__ ((packed));
+
+struct cpmac_stats {
+	volatile u32 good;
+	volatile u32 bcast;
+	volatile u32 mcast;
+	volatile u32 pause;
+	volatile u32 crc_error;
+	volatile u32 align_error;
+	volatile u32 oversized;
+	volatile u32 jabber;
+	volatile u32 undersized;
+	volatile u32 fragment;
+	volatile u32 filtered;
+	volatile u32 qos_filtered;
+	volatile u32 octets;
+} __attribute__ ((packed));
+
+struct cpmac_regs {
+	struct cpmac_control_regs tx_ctrl;
+	struct cpmac_control_regs rx_ctrl;
+	volatile u32 unused1[56];
+	volatile u32 mbp;
+/* MBP bits */
+#define MBP_RXPASSCRC         0x40000000
+#define MBP_RXQOS             0x20000000
+#define MBP_RXNOCHAIN         0x10000000
+#define MBP_RXCMF             0x01000000
+#define MBP_RXSHORT           0x00800000
+#define MBP_RXCEF             0x00400000
+#define MBP_RXPROMISC         0x00200000
+#define MBP_PROMISCCHAN(chan) (((chan) & 0x7) << 16)
+#define MBP_RXBCAST           0x00002000
+#define MBP_BCASTCHAN(chan)   (((chan) & 0x7) << 8)
+#define MBP_RXMCAST           0x00000020
+#define MBP_MCASTCHAN(chan)   ((chan) & 0x7)
+	volatile u32 unicast_enable;
+	volatile u32 unicast_clear;
+	volatile u32 max_len;
+	volatile u32 buffer_offset;
+	volatile u32 filter_flow_threshold;
+	volatile u32 unused2[2];
+	volatile u32 flow_thre[8];
+	volatile u32 free_buffer[8];
+	volatile u32 mac_control;
+#define MAC_TXPTYPE  0x00000200
+#define MAC_TXPACE   0x00000040
+#define MAC_MII      0x00000020
+#define MAC_TXFLOW   0x00000010
+#define MAC_RXFLOW   0x00000008
+#define MAC_MTEST    0x00000004
+#define MAC_LOOPBACK 0x00000002
+#define MAC_FDX      0x00000001
+	volatile u32 mac_status;
+#define MACST_QOS    0x4
+#define MACST_RXFLOW 0x2
+#define MACST_TXFLOW 0x1
+	volatile u32 emc_control;
+	volatile u32 unused3;
+	struct cpmac_int_regs tx_int;
+	volatile u32 mac_int_vector;
+/* Int Status bits */
+#define INTST_STATUS 0x80000
+#define INTST_HOST   0x40000
+#define INTST_RX     0x20000
+#define INTST_TX     0x10000
+	volatile u32 mac_eoi_vector;
+	volatile u32 unused4[2];
+	struct cpmac_int_regs rx_int;
+	volatile u32 mac_int_stat_raw;
+	volatile u32 mac_int_stat_masked;
+	volatile u32 mac_int_enable;
+	volatile u32 mac_int_clear;
+	volatile u32 mac_addr_low[8];
+	volatile u32 mac_addr_mid;
+	volatile u32 mac_addr_high;
+	volatile u32 mac_hash_low;
+	volatile u32 mac_hash_high;
+	volatile u32 boff_test;
+	volatile u32 pac_test;
+	volatile u32 rx_pause;
+	volatile u32 tx_pause;
+	volatile u32 unused5[2];
+	struct cpmac_stats rx_stats;
+	struct cpmac_stats tx_stats;
+	volatile u32 unused6[232];
+	volatile u32 tx_ptr[8];
+	volatile u32 rx_ptr[8];
+	volatile u32 tx_ack[8];
+	volatile u32 rx_ack[8];
+	
+} __attribute__ ((packed));
+
+struct cpmac_mdio_regs {
+	volatile u32 version;
+	volatile u32 control;
+#define MDIOC_IDLE        0x80000000
+#define MDIOC_ENABLE      0x40000000
+#define MDIOC_PREAMBLE    0x00100000
+#define MDIOC_FAULT       0x00080000
+#define MDIOC_FAULTDETECT 0x00040000
+#define MDIOC_INTTEST     0x00020000
+#define MDIOC_CLKDIV(div) ((div) & 0xff)
+	volatile u32 alive;
+	volatile u32 link;
+	struct cpmac_int_regs link_int;
+	struct cpmac_int_regs user_int;
+	u32 unused[20];
+	volatile u32 access;
+#define MDIO_BUSY       0x80000000
+#define MDIO_WRITE      0x40000000
+#define MDIO_REG(reg)   (((reg) & 0x1f) << 21)
+#define MDIO_PHY(phy)   (((phy) & 0x1f) << 16)
+#define MDIO_DATA(data) ((data) & 0xffff)
+	volatile u32 physel;
+} __attribute__ ((packed));
+
+/* Descriptor */
+struct cpmac_desc {
+	u32 hw_next;
+	u32 hw_data;
+	u16 buflen;
+	u16 bufflags;
+	u16 datalen;
+	u16 dataflags;
+/* Flags bits */
+#define CPMAC_SOP 0x8000
+#define CPMAC_EOP 0x4000
+#define CPMAC_OWN 0x2000
+#define CPMAC_EOQ 0x1000
+	struct sk_buff *skb;
+	struct cpmac_desc *next;
+} __attribute__ ((packed));
+
+struct cpmac_priv {
+	struct net_device_stats stats;
+	spinlock_t lock;
+	struct sk_buff *skb_pool;
+	int free_skbs;
+	struct cpmac_desc *rx_head;
+	int tx_head, tx_tail;
+	struct cpmac_desc *desc_ring;
+	struct cpmac_regs *regs;
+	struct mii_bus *mii_bus;
+	struct phy_device *phy;
+	char phy_name[BUS_ID_SIZE];
+	struct plat_cpmac_data *config;
+	int oldlink, oldspeed, oldduplex;
+	u32 msg_enable;
+	struct net_device *dev;
+	struct work_struct alloc_work;
+};
+
+static irqreturn_t cpmac_irq(int, void *);
+static void cpmac_reset(struct net_device *dev);
+static void cpmac_hw_init(struct net_device *dev);
+static int cpmac_stop(struct net_device *dev);
+static int cpmac_open(struct net_device *dev);
+
+#undef CPMAC_DEBUG
+#define CPMAC_LOW_THRESH 32
+#define CPMAC_ALLOC_SIZE 64
+#define CPMAC_SKB_SIZE 1518
+#define CPMAC_TX_RING_SIZE 8
+
+#ifdef CPMAC_DEBUG
+static void cpmac_dump_regs(u32 *base, int count)
+{
+	int i;
+	for (i = 0; i < (count + 3) / 4; i++) {
+		if (i % 4 == 0) printk("\nCPMAC[0x%04x]:", i * 4);
+		printk(" 0x%08x", *(base + i));
+	}
+	printk("\n");
+}
+
+static const char *cpmac_dump_buf(const uint8_t * buf, unsigned size)
+{
+    static char buffer[3 * 25 + 1];
+    char *p = &buffer[0];
+    if (size > 20)
+        size = 20;
+    while (size-- > 0) {
+        p += sprintf(p, " %02x", *buf++);
+    }
+    return buffer;
+}
+#endif
+
+static int cpmac_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
+{
+	struct cpmac_mdio_regs *regs = (struct cpmac_mdio_regs *)bus->priv;
+	volatile u32 val;
+
+	while ((val = regs->access) & MDIO_BUSY);
+	regs->access = MDIO_BUSY | MDIO_REG(regnum & 0x1f) |
+		MDIO_PHY(phy_id & 0x1f);
+	while ((val = regs->access) & MDIO_BUSY);
+
+	return val & 0xffff;
+}
+
+static int cpmac_mdio_write(struct mii_bus *bus, int phy_id, int regnum, u16 
val)
+{
+	struct cpmac_mdio_regs *regs = (struct cpmac_mdio_regs *)bus->priv;
+	volatile u32 tmp;
+
+	while ((tmp = regs->access) & MDIO_BUSY);
+	regs->access = MDIO_BUSY | MDIO_WRITE | 
+		MDIO_REG(regnum & 0x1f) | MDIO_PHY(phy_id & 0x1f) |
+		val;
+
+	return 0;
+}
+
+static int cpmac_mdio_reset(struct mii_bus *bus)
+{
+	struct cpmac_mdio_regs *regs = (struct cpmac_mdio_regs *)bus->priv;
+
+	ar7_device_reset(AR7_RESET_BIT_MDIO);
+	regs->control = MDIOC_ENABLE |
+		MDIOC_CLKDIV(ar7_cpmac_freq() / 2200000 - 1);
+
+	return 0;
+}
+
+static int mii_irqs[PHY_MAX_ADDR] = { PHY_POLL, };
+
+static struct mii_bus cpmac_mii = {
+	.name = "cpmac-mii",
+	.read = cpmac_mdio_read,
+	.write = cpmac_mdio_write,
+	.reset = cpmac_mdio_reset,
+	.irq = mii_irqs,
+};
+
+static int cpmac_config(struct net_device *dev, struct ifmap *map)
+{
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* Don't allow changing the I/O address */
+	if (map->base_addr != dev->base_addr)
+		return -EOPNOTSUPP;
+
+	/* ignore other fields */
+	return 0;
+}
+
+static int cpmac_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct sockaddr *sa = addr;
+
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	memcpy(dev->dev_addr, sa->sa_data, dev->addr_len);
+
+	return 0;
+}
+
+static void cpmac_set_multicast_list(struct net_device *dev)
+{
+	struct dev_mc_list *iter;
+	int i;
+	int hash, tmp;
+	int hashlo = 0, hashhi = 0;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if(dev->flags & IFF_PROMISC) {
+		priv->regs->mbp &= ~MBP_PROMISCCHAN(0); /* promisc channel 0 */
+		priv->regs->mbp |= MBP_RXPROMISC;
+        } else {
+		priv->regs->mbp &= ~MBP_RXPROMISC;
+		if(dev->flags & IFF_ALLMULTI) {
+			/* enable all multicast mode */
+			priv->regs->mac_hash_low = 0xffffffff;
+			priv->regs->mac_hash_high = 0xffffffff;
+		} else {
+			for(i = 0, iter = dev->mc_list; i < dev->mc_count;
+			    i++, iter = iter->next) {
+				hash = 0;
+				tmp = iter->dmi_addr[0];
+				hash  ^= (tmp >> 2) ^ (tmp << 4);
+				tmp = iter->dmi_addr[1];
+				hash  ^= (tmp >> 4) ^ (tmp << 2);
+				tmp = iter->dmi_addr[2];
+				hash  ^= (tmp >> 6) ^ tmp;
+				tmp = iter->dmi_addr[4];
+				hash  ^= (tmp >> 2) ^ (tmp << 4);
+				tmp = iter->dmi_addr[5];
+				hash  ^= (tmp >> 4) ^ (tmp << 2);
+				tmp = iter->dmi_addr[6];
+				hash  ^= (tmp >> 6) ^ tmp;
+				hash &= 0x3f;
+				if(hash < 32) {
+					hashlo |= 1<<hash;
+				} else {
+					hashhi |= 1<<(hash - 32);
+				}
+			}
+
+			priv->regs->mac_hash_low = hashlo;
+			priv->regs->mac_hash_high = hashhi;
+		}
+	}
+}
+
+static struct sk_buff *cpmac_get_skb(struct net_device *dev) 
+{
+	struct sk_buff *skb;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	skb = priv->skb_pool;
+	if (likely(skb)) {
+		priv->skb_pool = skb->next;
+	} else {
+		skb = dev_alloc_skb(CPMAC_SKB_SIZE + 2);
+		if (skb) {
+			skb->next = NULL;
+			skb_reserve(skb, 2);
+			skb->dev = priv->dev;
+		}
+	}
+
+	if (likely(priv->free_skbs))
+		priv->free_skbs--;
+
+	if (priv->free_skbs < CPMAC_LOW_THRESH)
+		schedule_work(&priv->alloc_work);
+
+	return skb;
+}
+
+static inline struct sk_buff *cpmac_rx_one(struct net_device *dev, 
+					   struct cpmac_priv *priv,
+					   struct cpmac_desc *desc)
+{
+	unsigned long flags;
+	char *data;
+	struct sk_buff *skb, *result = NULL;
+
+	priv->regs->rx_ack[0] = virt_to_phys(desc);
+	if (unlikely(!desc->datalen)) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: rx: spurious interrupt\n",
+			       dev->name);
+		priv->stats.rx_errors++;
+		return NULL;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+	skb = cpmac_get_skb(dev);
+	if (likely(skb)) {
+		data = (char *)phys_to_virt(desc->hw_data);
+		dma_cache_inv((u32)data, desc->datalen);
+		skb_put(desc->skb, desc->datalen);
+		desc->skb->protocol = eth_type_trans(desc->skb, dev);
+		desc->skb->ip_summed = CHECKSUM_NONE;
+		priv->stats.rx_packets++;
+		priv->stats.rx_bytes += desc->datalen;
+		result = desc->skb;
+		desc->skb = skb;
+	} else {
+#ifdef CPMAC_DEBUG
+		if (printk_ratelimit())
+			printk("%s: low on skbs, dropping packet\n",
+			       dev->name);
+#endif
+		priv->stats.rx_dropped++;
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	desc->hw_data = virt_to_phys(desc->skb->data);
+	desc->buflen = CPMAC_SKB_SIZE;
+	desc->dataflags = CPMAC_OWN;
+	dma_cache_wback((u32)desc, 16);
+
+	return result;
+}
+
+static void cpmac_rx(struct net_device *dev)
+{
+	struct sk_buff *skb;
+	struct cpmac_desc *desc;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	spin_lock(&priv->lock);
+	if (unlikely(!priv->rx_head)) {
+		spin_unlock(&priv->lock);
+		return;
+	}
+
+	desc = priv->rx_head;
+	dma_cache_inv((u32)desc, 16);
+#ifdef CPMAC_DEBUG
+                printk(KERN_DEBUG "%s: len=%d, %s\n", __func__, pkt->datalen,
+                      cpmac_dump_buf(data, pkt->datalen));
+#endif
+
+	while ((desc->dataflags & CPMAC_OWN) == 0) {
+		skb = cpmac_rx_one(dev, priv, desc);
+		if (likely(skb)) {
+			netif_rx(skb);
+		}
+		desc = desc->next;
+		dma_cache_inv((u32)desc, 16);
+	}
+
+	priv->rx_head = desc;
+	priv->regs->rx_ptr[0] = virt_to_phys(desc);
+	spin_unlock(&priv->lock);
+}
+
+static int cpmac_poll(struct net_device *dev, int *budget)
+{
+	struct sk_buff *skb;
+	struct cpmac_desc *desc;
+	int received = 0, quota = min(dev->quota, *budget);
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (unlikely(!priv->rx_head)) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: rx: polling, but no queue\n",
+			       dev->name);
+		netif_rx_complete(dev);
+		return 0;
+	}
+
+	desc = priv->rx_head;
+	dma_cache_inv((u32)desc, 16);
+	
+	while ((received < quota) && ((desc->dataflags & CPMAC_OWN) == 0)) {
+		skb = cpmac_rx_one(dev, priv, desc);
+		if (likely(skb)) {
+			netif_receive_skb(skb);
+			received++;
+		}
+		desc = desc->next;
+		priv->rx_head = desc;
+		dma_cache_inv((u32)desc, 16);
+	}
+
+	*budget -= received;
+	dev->quota -= received;
+#ifdef CPMAC_DEBUG
+	printk("%s: processed %d packets\n", dev->name, received);
+#endif
+	if (desc->dataflags & CPMAC_OWN) {
+		priv->regs->rx_ptr[0] = virt_to_phys(desc);
+		netif_rx_complete(dev);
+		priv->regs->rx_int.enable = 0x1;
+		priv->regs->rx_int.clear = 0xfe;
+		return 0;
+	}
+
+	return 1;
+}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 20)
+static void
+cpmac_alloc_skbs(struct work_struct *work)
+{
+        struct cpmac_priv *priv = container_of(work, struct cpmac_priv,
+					       alloc_work);
+#else
+static void
+cpmac_alloc_skbs(void *data)
+{
+        struct net_device *dev = (struct net_device*)data;
+	struct cpmac_priv *priv = netdev_priv(dev);
+#endif
+	unsigned long flags;
+	int i, num_skbs = 0;
+	struct sk_buff *skb, *skbs = NULL;
+
+	for (i = 0; i < CPMAC_ALLOC_SIZE; i++) {
+		skb = alloc_skb(CPMAC_SKB_SIZE + 2, GFP_KERNEL);
+		if (!skb)
+			break;
+		skb->next = skbs;
+		skb_reserve(skb, 2);
+		skb->dev = priv->dev;
+		num_skbs++;
+		skbs = skb;
+	}
+
+	if (skbs) {
+		spin_lock_irqsave(&priv->lock, flags);
+		for (skb = priv->skb_pool; skb && skb->next; skb = skb->next);
+		if (!skb) {
+			priv->skb_pool = skbs;
+		} else {
+			skb->next = skbs;
+		}
+		priv->free_skbs += num_skbs;
+		spin_unlock_irqrestore(&priv->lock, flags);
+#ifdef CPMAC_DEBUG
+		printk("%s: allocated %d skbs\n", priv->dev->name, num_skbs);
+#endif
+	}
+}
+
+static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned long flags;
+	int len, chan;
+	struct cpmac_desc *desc;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	len = skb->len;
+#ifdef CPMAC_DEBUG
+        printk(KERN_DEBUG "%s: len=%d\n", __func__, 
len); //cpmac_dump_buf(const uint8_t * buf, unsigned size)
+#endif
+	if (unlikely(len < ETH_ZLEN)) {
+		if (unlikely(skb_padto(skb, ETH_ZLEN))) {
+			if (printk_ratelimit())
+				printk(KERN_NOTICE "%s: padding failed, dropping\n",
+				       dev->name); 
+			spin_lock_irqsave(&priv->lock, flags);
+			priv->stats.tx_dropped++;
+			spin_unlock_irqrestore(&priv->lock, flags);
+			return -ENOMEM;
+		}
+		len = ETH_ZLEN;
+	}
+	spin_lock_irqsave(&priv->lock, flags);
+	chan = priv->tx_tail++;
+	priv->tx_tail %= 8;
+	if (priv->tx_tail == priv->tx_head)
+		netif_stop_queue(dev);
+
+	desc = &priv->desc_ring[chan];
+	dma_cache_inv((u32)desc, 16);
+	if (desc->dataflags & CPMAC_OWN) {
+		printk(KERN_NOTICE "%s: tx dma ring full, dropping\n", dev->name);
+		priv->stats.tx_dropped++;
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return -ENOMEM;
+	}
+
+	dev->trans_start = jiffies;
+	desc->dataflags = CPMAC_SOP | CPMAC_EOP | CPMAC_OWN;
+	desc->skb = skb;
+	desc->hw_data = virt_to_phys(skb->data);
+	dma_cache_wback((u32)skb->data, len);
+	desc->buflen = len;
+	desc->datalen = len;
+	desc->hw_next = 0;
+	dma_cache_wback((u32)desc, 16);
+	priv->regs->tx_ptr[chan] = virt_to_phys(desc);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void cpmac_end_xmit(struct net_device *dev, int channel)
+{
+	struct cpmac_desc *desc;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	spin_lock(&priv->lock);
+	desc = &priv->desc_ring[channel];
+	priv->regs->tx_ack[channel] = virt_to_phys(desc);
+	if (likely(desc->skb)) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += desc->skb->len;
+		dev_kfree_skb_irq(desc->skb);
+		if (netif_queue_stopped(dev))
+			netif_wake_queue(dev);
+	} else {
+		if (printk_ratelimit())
+			printk(KERN_NOTICE "%s: end_xmit: spurious interrupt\n",
+			       dev->name); 
+	}
+	spin_unlock(&priv->lock);
+}
+
+static void cpmac_reset(struct net_device *dev)
+{
+	int i;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	ar7_device_reset(priv->config->reset_bit);
+	priv->regs->rx_ctrl.control &= ~1;
+	priv->regs->tx_ctrl.control &= ~1;
+	for (i = 0; i < 8; i++) {
+		priv->regs->tx_ptr[i] = 0;
+		priv->regs->rx_ptr[i] = 0;
+	}
+	priv->regs->mac_control &= ~MAC_MII; /* disable mii */
+}
+
+static inline void cpmac_free_rx_ring(struct net_device *dev)
+{
+	struct cpmac_desc *desc;
+	int i;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (unlikely(!priv->rx_head))
+		return;
+
+	desc = priv->rx_head;
+	dma_cache_inv((u32)desc, 16);
+	
+	for (i = 0; i < rx_ring_size; i++) {
+		desc->buflen = CPMAC_SKB_SIZE;
+		if ((desc->dataflags & CPMAC_OWN) == 0) {
+			desc->dataflags = CPMAC_OWN;
+			priv->stats.rx_dropped++;
+		}
+		dma_cache_wback((u32)desc, 16);
+		desc = desc->next;
+		dma_cache_inv((u32)desc, 16);
+	}
+}
+
+static irqreturn_t cpmac_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct cpmac_priv *priv = netdev_priv(dev);
+	u32 status;
+
+	if (!dev)
+		return IRQ_NONE;
+
+	status = priv->regs->mac_int_vector;
+
+	if (status & INTST_TX) {
+		cpmac_end_xmit(dev, (status & 7));
+	}
+
+	if (status & INTST_RX) {
+		if (disable_napi) {
+			cpmac_rx(dev);
+		} else {
+			priv->regs->rx_int.enable = 0;
+			priv->regs->rx_int.clear = 0xff;
+			netif_rx_schedule(dev);
+		}
+	}
+
+	priv->regs->mac_eoi_vector = 0;
+
+	if (unlikely(status & (INTST_HOST | INTST_STATUS))) {
+		if (printk_ratelimit()) {
+			printk(KERN_ERR "%s: hw error, resetting...\n", dev->name);
+		}
+		spin_lock(&priv->lock);
+		phy_stop(priv->phy);
+		cpmac_reset(dev);
+		cpmac_free_rx_ring(dev);
+		cpmac_hw_init(dev);
+		spin_unlock(&priv->lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void cpmac_tx_timeout(struct net_device *dev)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+	struct cpmac_desc *desc;
+
+	priv->stats.tx_errors++;
+	desc = &priv->desc_ring[priv->tx_head++];
+	priv->tx_head %= 8;
+	printk("%s: transmit timeout\n", dev->name);
+	if (desc->skb)
+		dev_kfree_skb(desc->skb);
+	netif_wake_queue(dev);
+}
+
+static int cpmac_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+	if (!(netif_running(dev)))
+		return -EINVAL;
+	if (!priv->phy)
+		return -EINVAL;
+	if ((cmd == SIOCGMIIPHY) || (cmd == SIOCGMIIREG) || 
+	    (cmd == SIOCSMIIREG))
+		return phy_mii_ioctl(priv->phy, if_mii(ifr), cmd);
+
+	return -EINVAL;
+}
+
+static int cpmac_get_settings(struct net_device *dev, struct ethtool_cmd 
*cmd)
+{
+        struct cpmac_priv *priv = netdev_priv(dev);
+
+        if (priv->phy)
+                return phy_ethtool_gset(priv->phy, cmd);
+
+        return -EINVAL;
+}
+
+static int cpmac_set_settings(struct net_device *dev, struct ethtool_cmd 
*cmd)
+{
+        struct cpmac_priv *priv = netdev_priv(dev);
+
+        if (!capable(CAP_NET_ADMIN))
+                return -EPERM;
+
+        if (priv->phy)
+                return phy_ethtool_sset(priv->phy, cmd);
+
+        return -EINVAL;
+}
+
+static void cpmac_get_drvinfo(struct net_device *dev, 
+			      struct ethtool_drvinfo *info)
+{
+        strcpy(info->driver, "cpmac");
+        strcpy(info->version, "0.0.3");
+        info->fw_version[0] = '\0';
+        sprintf(info->bus_info, "%s", "cpmac");
+        info->regdump_len = 0;
+}
+
+static const struct ethtool_ops cpmac_ethtool_ops = {
+        .get_settings = cpmac_get_settings,
+        .set_settings = cpmac_set_settings,
+        .get_drvinfo = cpmac_get_drvinfo,
+        .get_link = ethtool_op_get_link,
+};
+
+static struct net_device_stats *cpmac_stats(struct net_device *dev)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	if (netif_device_present(dev))
+		return &priv->stats;
+
+	return NULL;
+}
+
+static int cpmac_change_mtu(struct net_device *dev, int mtu)
+{
+	unsigned long flags;
+	struct cpmac_priv *priv = netdev_priv(dev);
+	spinlock_t *lock = &priv->lock;
+    
+	if ((mtu < 68) || (mtu > 1500))
+		return -EINVAL;
+
+	spin_lock_irqsave(lock, flags);
+	dev->mtu = mtu;
+	spin_unlock_irqrestore(lock, flags);
+
+	return 0;
+}
+
+static void cpmac_adjust_link(struct net_device *dev)
+{
+	struct cpmac_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	int new_state = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->phy->link) {
+		if (priv->phy->duplex != priv->oldduplex) {
+			new_state = 1;
+			priv->oldduplex = priv->phy->duplex;
+		}
+
+		if (priv->phy->speed != priv->oldspeed) {
+			new_state = 1;
+			priv->oldspeed = priv->phy->speed;
+		}
+
+		if (!priv->oldlink) {
+			new_state = 1;
+			priv->oldlink = 1;
+			netif_schedule(dev);
+		}
+	} else if (priv->oldlink) {
+		new_state = 1;
+		priv->oldlink = 0;
+		priv->oldspeed = 0;
+		priv->oldduplex = -1;
+	}
+
+	if (new_state)
+		phy_print_status(priv->phy);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void cpmac_hw_init(struct net_device *dev)
+{
+	int i;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	for (i = 0; i < 8; i++)
+		priv->regs->tx_ptr[i] = 0;
+	priv->regs->rx_ptr[0] = virt_to_phys(priv->rx_head);
+
+	priv->regs->mbp = MBP_RXSHORT | MBP_RXBCAST | MBP_RXMCAST;
+	priv->regs->unicast_enable = 0x1;
+	priv->regs->unicast_clear = 0xfe;
+	priv->regs->buffer_offset = 0;
+	for (i = 0; i < 8; i++)
+		priv->regs->mac_addr_low[i] = dev->dev_addr[5];
+	priv->regs->mac_addr_mid = dev->dev_addr[4];
+	priv->regs->mac_addr_high = dev->dev_addr[0] | (dev->dev_addr[1] << 8)
+		| (dev->dev_addr[2] << 16) | (dev->dev_addr[3] << 24);
+	priv->regs->max_len = CPMAC_SKB_SIZE;
+	priv->regs->rx_int.enable = 0x1;
+	priv->regs->rx_int.clear = 0xfe;
+	priv->regs->tx_int.enable = 0xff;
+	priv->regs->tx_int.clear = 0;
+	priv->regs->mac_int_enable = 3;
+	priv->regs->mac_int_clear = 0xfc;
+
+	priv->regs->rx_ctrl.control |= 1;
+	priv->regs->tx_ctrl.control |= 1;
+	priv->regs->mac_control |= MAC_MII | MAC_FDX;
+
+	priv->phy->state = PHY_CHANGELINK;
+	phy_start(priv->phy);
+}
+
+static int cpmac_open(struct net_device *dev)
+{
+	int i, size, res;
+	struct cpmac_priv *priv = netdev_priv(dev);
+	struct cpmac_desc *desc;
+	struct sk_buff *skb;
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 20)
+	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link,
+				0, PHY_INTERFACE_MODE_MII);
+#else
+	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link, 0);
+#endif
+	if (IS_ERR(priv->phy)) {
+		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
+		return PTR_ERR(priv->phy);
+	}
+
+	if (!request_mem_region(dev->mem_start, dev->mem_end -
+				dev->mem_start, dev->name)) {
+		printk("%s: failed to request registers\n",
+		       dev->name); 
+		res = -ENXIO;
+		goto fail_reserve;
+	}
+
+	priv->regs = ioremap_nocache(dev->mem_start, dev->mem_end -
+				     dev->mem_start);
+	if (!priv->regs) {
+		printk("%s: failed to remap registers\n", dev->name);
+		res = -ENXIO;
+		goto fail_remap;
+	}
+
+	priv->rx_head = NULL;
+	size = sizeof(struct cpmac_desc) * (rx_ring_size +
+					    CPMAC_TX_RING_SIZE);
+	priv->desc_ring = (struct cpmac_desc *)kmalloc(size, GFP_KERNEL);
+	if (!priv->desc_ring) {
+		res = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	memset((char *)priv->desc_ring, 0, size);
+
+	priv->skb_pool = NULL;
+	priv->free_skbs = 0;
+	priv->rx_head = &priv->desc_ring[CPMAC_TX_RING_SIZE];
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 20)
+        INIT_WORK(&priv->alloc_work, cpmac_alloc_skbs);
+#else
+        INIT_WORK(&priv->alloc_work, cpmac_alloc_skbs, dev);
+#endif
+	schedule_work(&priv->alloc_work);
+	flush_scheduled_work();
+
+	for (i = 0; i < rx_ring_size; i++) {
+		desc = &priv->rx_head[i];
+		skb = cpmac_get_skb(dev);
+		if (!skb) {
+			res = -ENOMEM;
+			goto fail_desc;
+		}
+		desc->skb = skb;
+		desc->hw_data = virt_to_phys(skb->data);
+		desc->buflen = CPMAC_SKB_SIZE;
+		desc->dataflags = CPMAC_OWN;
+		desc->next = &priv->rx_head[(i + 1) % rx_ring_size];
+		desc->hw_next = virt_to_phys(desc->next);
+		dma_cache_wback((u32)desc, 16);
+	}
+
+	if((res = request_irq(dev->irq, cpmac_irq, SA_INTERRUPT,
+			      dev->name, dev))) {
+		printk("%s: failed to obtain irq\n", dev->name);
+		goto fail_irq;
+	}
+
+	cpmac_reset(dev);
+	cpmac_hw_init(dev);
+
+	netif_start_queue(dev);
+	return 0;
+
+fail_irq:
+fail_desc:
+	for (i = 0; i < rx_ring_size; i++)
+		if (priv->rx_head[i].skb)
+			kfree_skb(priv->rx_head[i].skb);
+fail_alloc:
+	kfree(priv->desc_ring);
+
+	for (skb = priv->skb_pool; skb; skb = priv->skb_pool) {
+		priv->skb_pool = skb->next;
+		kfree_skb(skb);
+	}
+
+	iounmap(priv->regs);
+
+fail_remap:
+	release_mem_region(dev->mem_start, dev->mem_end -
+			   dev->mem_start);
+
+fail_reserve:
+	phy_disconnect(priv->phy);
+
+	return res;
+}
+
+static int cpmac_stop(struct net_device *dev)
+{
+	int i;
+	struct sk_buff *skb;
+	struct cpmac_priv *priv = netdev_priv(dev);
+
+	netif_stop_queue(dev);
+
+	phy_stop(priv->phy);
+	phy_disconnect(priv->phy);
+	priv->phy = NULL;
+
+	cpmac_reset(dev);
+
+	for (i = 0; i < 8; i++) {
+		priv->regs->rx_ptr[i] = 0;
+		priv->regs->tx_ptr[i] = 0;
+		priv->regs->mbp = 0;
+	}
+
+	free_irq(dev->irq, dev);
+	release_mem_region(dev->mem_start, dev->mem_end -
+			   dev->mem_start);
+
+	cancel_delayed_work(&priv->alloc_work);
+	flush_scheduled_work();
+
+	priv->rx_head = &priv->desc_ring[CPMAC_TX_RING_SIZE];
+	for (i = 0; i < rx_ring_size; i++)
+		if (priv->rx_head[i].skb)
+			kfree_skb(priv->rx_head[i].skb);
+
+	kfree(priv->desc_ring);
+
+	for (skb = priv->skb_pool; skb; skb = priv->skb_pool) {
+		priv->skb_pool = skb->next;
+		kfree_skb(skb);
+	}
+
+	return 0;
+}
+
+static int external_switch = 0;
+
+static int __devinit cpmac_probe(struct platform_device *pdev)
+{
+	int i, rc, phy_id;
+	struct resource *res;
+	struct cpmac_priv *priv;
+	struct net_device *dev;
+	struct plat_cpmac_data *pdata;
+
+	if (strcmp(pdev->name, "cpmac") != 0)
+		return -ENODEV;
+
+	pdata = pdev->dev.platform_data;
+
+	for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
+		if (!(pdata->phy_mask & (1 << phy_id)))
+			continue;
+		if (!cpmac_mii.phy_map[phy_id])
+			continue;
+		break;
+	}
+
+	if (phy_id == PHY_MAX_ADDR) {
+		if (external_switch) {
+			phy_id = 0;
+		} else {
+			printk("cpmac: no PHY present\n");
+			return -ENODEV;
+		}
+	}
+
+	dev = alloc_etherdev(sizeof(struct cpmac_priv));
+
+	if (!dev) {
+		printk(KERN_ERR "cpmac: Unable to allocate net_device structure!\n");
+		return -ENOMEM;
+	}
+
+	SET_MODULE_OWNER(dev);
+	platform_set_drvdata(pdev, dev);
+	priv = netdev_priv(dev);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!res) {
+	        rc = -ENODEV;
+		goto fail;
+	}
+
+	dev->mem_start = res->start;
+	dev->mem_end = res->end;
+	dev->irq = platform_get_irq_byname(pdev, "irq");
+
+	dev->mtu                = 1500;
+	dev->open               = cpmac_open;
+	dev->stop               = cpmac_stop;
+	dev->set_config         = cpmac_config;
+	dev->hard_start_xmit    = cpmac_start_xmit;
+	dev->do_ioctl           = cpmac_ioctl;
+	dev->get_stats          = cpmac_stats;
+	dev->change_mtu         = cpmac_change_mtu;  
+	dev->set_mac_address    = cpmac_set_mac_address;  
+	dev->set_multicast_list = cpmac_set_multicast_list;
+	dev->tx_timeout         = cpmac_tx_timeout;
+	dev->ethtool_ops        = &cpmac_ethtool_ops;
+	if (!disable_napi) {
+		dev->poll = cpmac_poll;
+		dev->weight = min(rx_ring_size, 64);
+	}
+
+	memset(priv, 0, sizeof(struct cpmac_priv));
+	spin_lock_init(&priv->lock);
+	priv->msg_enable = netif_msg_init(NETIF_MSG_WOL, 0x3fff);
+	priv->config = pdata;
+	priv->dev = dev;
+	memcpy(dev->dev_addr, priv->config->dev_addr, sizeof(dev->dev_addr));
+	if (phy_id == 31) {
+		snprintf(priv->phy_name, BUS_ID_SIZE, PHY_ID_FMT,
+			 cpmac_mii.id, phy_id);
+	} else {
+		snprintf(priv->phy_name, BUS_ID_SIZE, "fixed@%d:%d", 100, 1);
+	}
+
+	if ((rc = register_netdev(dev))) {
+		printk("cpmac: error %i registering device %s\n",
+		       rc, dev->name);
+		goto fail;
+	}
+
+	printk("cpmac: device %s (regs: %p, irq: %d, phy: %s, mac: ",
+	       dev->name, (u32 *)dev->mem_start, dev->irq,
+	       priv->phy_name);
+	for (i = 0; i < 6; i++) {
+		printk("%02x", dev->dev_addr[i]);
+		if (i < 5) printk(":");
+		else printk(")\n");
+	}
+
+	return 0;
+
+fail:
+	free_netdev(dev);
+	return rc;
+}
+
+static int __devexit cpmac_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	unregister_netdev(dev);
+	free_netdev(dev);
+	return 0;
+}
+
+static struct platform_driver cpmac_driver = {
+	.driver.name = "cpmac",
+	.probe = cpmac_probe,
+	.remove = cpmac_remove,
+};
+
+int __devinit cpmac_init(void)
+{
+	volatile u32 mask;
+	int i, res;
+	cpmac_mii.priv = (struct cpmac_mdio_regs *)
+		ioremap_nocache(AR7_REGS_MDIO, sizeof(struct cpmac_mdio_regs));
+
+	if (!cpmac_mii.priv) {
+		printk("Can't ioremap mdio registers\n");
+		return -ENXIO;
+	}
+
+#warning FIXME: unhardcode gpio&reset bits
+	ar7_gpio_disable(26);
+	ar7_gpio_disable(27);
+	ar7_device_reset(AR7_RESET_BIT_CPMAC_LO);
+	ar7_device_reset(AR7_RESET_BIT_CPMAC_HI);
+	ar7_device_reset(AR7_RESET_BIT_EPHY);
+
+	cpmac_mii.reset(&cpmac_mii);
+
+	for (i = 0; i < 300000; i++) {
+		mask = ((struct cpmac_mdio_regs *)cpmac_mii.priv)->alive;
+		if (mask)
+			break;
+	}
+
+	mask &= 0x7fffffff;
+	if (mask & (mask - 1)) {
+		external_switch = 1;
+		mask = 0;
+	}
+
+	cpmac_mii.phy_mask = ~(mask | 0x80000000);
+
+	res = mdiobus_register(&cpmac_mii);
+	if (res)
+		goto fail_mii;
+
+	res = platform_driver_register(&cpmac_driver);
+	if (res)
+		goto fail_cpmac;
+
+	return 0;
+
+fail_cpmac:
+	mdiobus_unregister(&cpmac_mii);
+
+fail_mii:
+	iounmap(cpmac_mii.priv);
+
+	return res;
+}
+
+void __devexit cpmac_exit(void)
+{
+	platform_driver_unregister(&cpmac_driver);
+	mdiobus_unregister(&cpmac_mii);
+}
+
+module_init(cpmac_init);
+module_exit(cpmac_exit);
diff -urN linux-2.6.22.1/include/asm-mips/ar7/ar7.h 
linux-ar7/include/asm-mips/ar7/ar7.h
--- linux-2.6.22.1/include/asm-mips/ar7/ar7.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/include/asm-mips/ar7/ar7.h	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,162 @@
+/*
+ * $Id: ar7.h 8280 2007-07-31 15:52:06Z florian $
+ * 
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
+#ifndef __AR7_H__
+#define __AR7_H__
+
+#include <linux/delay.h>
+#include <asm/addrspace.h>
+#include <asm/io.h>
+
+#define AR7_REGS_BASE 0x08610000
+
+#define AR7_REGS_MAC0   (AR7_REGS_BASE + 0x0000)
+#define AR7_REGS_GPIO   (AR7_REGS_BASE + 0x0900)
+#define AR7_REGS_POWER  (AR7_REGS_BASE + 0x0a00) // 0x08610A00 - 0x08610BFF 
(512 bytes, 128 bytes / clock)
+#define AR7_REGS_UART0  (AR7_REGS_BASE + 0x0e00)
+#define AR7_REGS_RESET  (AR7_REGS_BASE + 0x1600)
+#define AR7_REGS_VLYNQ0 (AR7_REGS_BASE + 0x1800)
+#define AR7_REGS_DCL    (AR7_REGS_BASE + 0x1A00)
+#define AR7_REGS_VLYNQ1 (AR7_REGS_BASE + 0x1C00)
+#define AR7_REGS_MDIO   (AR7_REGS_BASE + 0x1E00)
+#define AR7_REGS_IRQ    (AR7_REGS_BASE + 0x2400)
+#define AR7_REGS_MAC1   (AR7_REGS_BASE + 0x2800)
+
+#define AR7_REGS_WDT    (AR7_REGS_BASE + 0x1f00)
+#define UR8_REGS_WDT    (AR7_REGS_BASE + 0x0b00)
+#define UR8_REGS_UART1  (AR7_REGS_BASE + 0x0f00)
+
+#define  AR7_RESET_PEREPHERIAL 0x0
+#define  AR7_RESET_SOFTWARE    0x4
+#define  AR7_RESET_STATUS      0x8
+
+#define AR7_RESET_BIT_CPMAC_LO 17
+#define AR7_RESET_BIT_CPMAC_HI 21
+#define AR7_RESET_BIT_MDIO     22
+#define AR7_RESET_BIT_EPHY     26
+
+/* GPIO control registers */
+#define  AR7_GPIO_INPUT  0x0
+#define  AR7_GPIO_OUTPUT 0x4
+#define  AR7_GPIO_DIR    0x8
+#define  AR7_GPIO_ENABLE 0xC
+
+#define AR7_CHIP_7100 0x18
+#define AR7_CHIP_7200 0x2b
+#define AR7_CHIP_7300 0x05
+
+/* Interrupts */
+#define AR7_IRQ_UART0  15
+#define AR7_IRQ_UART1  16
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
+	void *reset_reg = (void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PEREPHERIAL);
+	writel(readl(reset_reg) | (1 << bit), reset_reg);
+	mdelay(20);
+}
+
+static inline void ar7_device_disable(u32 bit)
+{
+	void *reset_reg = (void *)KSEG1ADDR(AR7_REGS_RESET + AR7_RESET_PEREPHERIAL);
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
diff -urN linux-2.6.22.1/include/asm-mips/ar7/gpio.h 
linux-ar7/include/asm-mips/ar7/gpio.h
--- linux-2.6.22.1/include/asm-mips/ar7/gpio.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/include/asm-mips/ar7/gpio.h	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,116 @@
+/*
+ * $Id: gpio.h 6693 2007-03-25 05:42:16Z ejka $
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+	void __iomem *gpio_dir = (void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + 
AR7_GPIO_DIR);
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
+	void __iomem *gpio_dir = (void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + 
AR7_GPIO_DIR);
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
+	void __iomem *gpio_in = (void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + 
AR7_GPIO_INPUT);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	return ((readl(gpio_in) & (1 << gpio)) != 0);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	void __iomem *gpio_out = (void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + 
AR7_GPIO_OUTPUT);
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
+	void __iomem *gpio_en =	(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + 
AR7_GPIO_ENABLE);
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
+	void __iomem *gpio_en =	(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + 
AR7_GPIO_ENABLE);
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
diff -urN linux-2.6.22.1/include/asm-mips/ar7/mmzone.h 
linux-ar7/include/asm-mips/ar7/mmzone.h
--- linux-2.6.22.1/include/asm-mips/ar7/mmzone.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/include/asm-mips/ar7/mmzone.h	2007-08-09 16:22:39.000000000 
+0200
@@ -0,0 +1,29 @@
+/*
+ * $Id: mmzone.h 6600 2007-03-18 09:40:51Z ejka $
+ * 
+ * Copyright (C) 2007 OpenWrt.org
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
+#ifndef _ASM_MACH_MMZONE_H
+#define _ASM_MACH_MMZONE_H
+
+extern pg_data_t __node_data[];
+#define NODE_DATA(nid)          (&__node_data[nid])
+#define NODE_MEM_MAP(nid)       (NODE_DATA(nid)->node_mem_map)
+#define pa_to_nid(addr) (((addr) >= ARCH_PFN_OFFSET << PAGE_SHIFT) ? 0 : -1)
+
+#endif /* _ASM_MACH_MMZONE_H */
diff -urN linux-2.6.22.1/include/asm-mips/ar7/prom.h 
linux-ar7/include/asm-mips/ar7/prom.h
--- linux-2.6.22.1/include/asm-mips/ar7/prom.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/include/asm-mips/ar7/prom.h	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,27 @@
+/*
+ * $Id: prom.h 8190 2007-07-27 03:48:54Z nico $
+ * 
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
+#ifndef __PROM_H__
+#define __PROM_H__
+
+extern char *prom_getenv(char *name);
+extern void prom_printf(char *fmt, ...);
+
+#endif /* __PROM_H__ */
diff -urN linux-2.6.22.1/include/asm-mips/ar7/spaces.h 
linux-ar7/include/asm-mips/ar7/spaces.h
--- linux-2.6.22.1/include/asm-mips/ar7/spaces.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/include/asm-mips/ar7/spaces.h	2007-08-09 16:22:39.000000000 
+0200
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
diff -urN linux-2.6.22.1/include/asm-mips/ar7/vlynq.h 
linux-ar7/include/asm-mips/ar7/vlynq.h
--- linux-2.6.22.1/include/asm-mips/ar7/vlynq.h	1970-01-01 01:00:00.000000000 
+0100
+++ linux-ar7/include/asm-mips/ar7/vlynq.h	2007-08-09 16:22:39.000000000 +0200
@@ -0,0 +1,92 @@
+/*
+ * $Id: vlynq.h 8190 2007-07-27 03:48:54Z nico $
+ * 
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
+struct vlynq_regs;
+struct vlynq_device {
+	u32 id;
+	int irq;
+	int local_irq;
+	int remote_irq;
+	int clock_div;
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
+#define to_vlynq_device(device) container_of(device, struct vlynq_device, 
dev)
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
+extern u32 vlynq_local_id(struct vlynq_device *dev);
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
