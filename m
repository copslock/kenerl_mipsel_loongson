Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:44:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9440 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011723AbbARWnKl2fn6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:43:10 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 04A364660DD6E;
        Sun, 18 Jan 2015 22:43:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:43:03 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:43:00 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 34/36] MIPS: initial Ingenic jz4780 support
Date:   Sun, 18 Jan 2015 14:42:57 -0800
Message-ID: <1421620977-25723-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Support the Ingenic jz4780 SoC using the code under arch/mips/jz4740 now
that it has been generalised sufficiently. This is left unselectable in
Kconfig until a jz4780 based board is added in a later commit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/Kconfig                          |  16 +++++
 arch/mips/boot/dts/jz4780.dtsi             | 101 +++++++++++++++++++++++++++++
 arch/mips/include/asm/mach-jz4740/irq.h    |   5 ++
 arch/mips/include/asm/mach-jz4740/serial.h |   8 ++-
 arch/mips/jz4740/Makefile                  |   4 +-
 arch/mips/jz4740/Platform                  |   4 ++
 arch/mips/jz4740/time.c                    |   7 +-
 7 files changed, 142 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/boot/dts/jz4780.dtsi

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 622d0aa..296bafb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -291,6 +291,22 @@ config MACH_JZ4740
 	select USE_OF
 	select LIBFDT
 
+config MACH_JZ4780
+	bool
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_ZBOOT_UART16550
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	select BUILTIN_DTB
+	select USE_OF
+	select LIBFDT
+	select MIPS_CPU_SCACHE
+
 config LANTIQ
 	bool "Lantiq based platforms"
 	select DMA_NONCOHERENT
diff --git a/arch/mips/boot/dts/jz4780.dtsi b/arch/mips/boot/dts/jz4780.dtsi
new file mode 100644
index 0000000..d9b696f
--- /dev/null
+++ b/arch/mips/boot/dts/jz4780.dtsi
@@ -0,0 +1,101 @@
+#include <dt-bindings/clock/jz4780-cgu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ingenic,jz4780";
+
+	cpuintc: cpuintc@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: intc@10001000 {
+		compatible = "ingenic,jz4780-intc";
+		reg = <0x10001000 0x50>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	rtc: rtc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	cgu: jz4780-cgu@10000000 {
+		compatible = "ingenic,jz4780-cgu";
+		reg = <0x10000000 0x100>;
+
+		clocks = <&ext>, <&rtc>;
+		clock-names = "ext", "rtc";
+
+		#clock-cells = <1>;
+	};
+
+	uart0: serial@10030000 {
+		compatible = "ingenic,jz4780-uart";
+		reg = <0x10030000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <51>;
+
+		clocks = <&ext>, <&cgu JZ4780_CLK_UART0>;
+		clock-names = "baud", "module";
+	};
+
+	uart1: serial@10031000 {
+		compatible = "ingenic,jz4780-uart";
+		reg = <0x10031000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <50>;
+
+		clocks = <&ext>, <&cgu JZ4780_CLK_UART1>;
+		clock-names = "baud", "module";
+	};
+
+	uart2: serial@10032000 {
+		compatible = "ingenic,jz4780-uart";
+		reg = <0x10032000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <49>;
+
+		clocks = <&ext>, <&cgu JZ4780_CLK_UART2>;
+		clock-names = "baud", "module";
+	};
+
+	uart3: serial@10033000 {
+		compatible = "ingenic,jz4780-uart";
+		reg = <0x10033000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <48>;
+
+		clocks = <&ext>, <&cgu JZ4780_CLK_UART3>;
+		clock-names = "baud", "module";
+	};
+
+	uart4: serial@10034000 {
+		compatible = "ingenic,jz4780-uart";
+		reg = <0x10034000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <34>;
+
+		clocks = <&ext>, <&cgu JZ4780_CLK_UART4>;
+		clock-names = "baud", "module";
+	};
+};
diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index b218f76..7e4ec21 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -22,6 +22,9 @@
 #ifdef CONFIG_MACH_JZ4740
 # define NR_INTC_IRQS	32
 #endif
+#ifdef CONFIG_MACH_JZ4780
+# define NR_INTC_IRQS	64
+#endif
 
 /* 1st-level interrupts */
 #define JZ4740_IRQ(x)		(JZ4740_IRQ_BASE + (x))
@@ -48,6 +51,8 @@
 #define JZ4740_IRQ_IPU		JZ4740_IRQ(29)
 #define JZ4740_IRQ_LCD		JZ4740_IRQ(30)
 
+#define JZ4780_IRQ_TCU2		JZ4740_IRQ(25)
+
 /* 2nd-level interrupts */
 #define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(NR_INTC_IRQS) + (x))
 
diff --git a/arch/mips/include/asm/mach-jz4740/serial.h b/arch/mips/include/asm/mach-jz4740/serial.h
index 4e4db4b..6d51478 100644
--- a/arch/mips/include/asm/mach-jz4740/serial.h
+++ b/arch/mips/include/asm/mach-jz4740/serial.h
@@ -20,6 +20,12 @@
 #ifndef __JZ4740_SERIAL_H__
 #define __JZ4740_SERIAL_H__
 
-#define BASE_BAUD (12000000 / 16)
+#ifdef CONFIG_MACH_JZ4740
+# define BASE_BAUD (12000000 / 16)
+#endif
+
+#ifdef CONFIG_MACH_JZ4780
+# define BASE_BAUD (48000000 / 16)
+#endif
 
 #endif /* __JZ4740_SERIAL_H__ */
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index ae72346..03e9f0a 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,9 @@
 # Object file lists.
 
 obj-y += prom.o irq.o time.o reset.o setup.o \
-	gpio.o platform.o timer.o
+	platform.o timer.o
+
+obj-$(CONFIG_MACH_JZ4740) += gpio.o
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index ba91be9..ad1b443 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,3 +1,7 @@
 platform-$(CONFIG_MACH_JZ4740)	+= jz4740/
 cflags-$(CONFIG_MACH_JZ4740)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4740
 load-$(CONFIG_MACH_JZ4740)	+= 0xffffffff80010000
+
+platform-$(CONFIG_MACH_JZ4780)	+= jz4740/
+cflags-$(CONFIG_MACH_JZ4780)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4740
+load-$(CONFIG_MACH_JZ4780)	+= 0xffffffff80010000
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 121ec3a..e4e440d 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -96,7 +96,12 @@ static struct clock_event_device jz4740_clockevent = {
 	.set_next_event = jz4740_clockevent_set_next,
 	.set_mode = jz4740_clockevent_set_mode,
 	.rating = 200,
+#ifdef CONFIG_MACH_JZ4740
 	.irq = JZ4740_IRQ_TCU0,
+#endif
+#ifdef CONFIG_MACH_JZ4780
+	.irq = JZ4780_IRQ_TCU2,
+#endif
 };
 
 static struct irqaction timer_irqaction = {
@@ -136,7 +141,7 @@ void __init plat_time_init(void)
 	if (ret)
 		printk(KERN_ERR "Failed to register clocksource: %d\n", ret);
 
-	setup_irq(JZ4740_IRQ_TCU0, &timer_irqaction);
+	setup_irq(jz4740_clockevent.irq, &timer_irqaction);
 
 	ctrl = JZ_TIMER_CTRL_PRESCALE_16 | JZ_TIMER_CTRL_SRC_EXT;
 
-- 
2.2.1
