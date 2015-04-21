Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:58:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34292 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025968AbbDUO5uRjtKl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:57:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B3500609BD6BD;
        Tue, 21 Apr 2015 15:57:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:57:44 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:57:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 36/37] MIPS: ingenic: initial JZ4780 support
Date:   Tue, 21 Apr 2015 15:47:03 +0100
Message-ID: <1429627624-30525-37-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46994
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

Support the Ingenic JZ4780 SoC using the existing code under
arch/mips/jz4740 now that it has been generalised sufficiently.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Changes in v3:
  - Rebase, dropping serial.h & relocating behind CONFIG_MACH_INGENIC.

Changes in v2:
  - None.
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi             | 101 +++++++++++++++++++++
 arch/mips/include/asm/cpu-type.h                   |   2 +-
 .../asm/mach-jz4740/cpu-feature-overrides.h        |   3 -
 arch/mips/include/asm/mach-jz4740/irq.h            |   4 +
 arch/mips/jz4740/Kconfig                           |   6 ++
 arch/mips/jz4740/Makefile                          |   4 +-
 arch/mips/jz4740/setup.c                           |   3 +
 arch/mips/jz4740/time.c                            |   7 +-
 8 files changed, 124 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/boot/dts/ingenic/jz4780.dtsi

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
new file mode 100644
index 0000000..5e44dd6
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -0,0 +1,101 @@
+#include <dt-bindings/clock/jz4780-cgu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ingenic,jz4780";
+
+	cpuintc: interrupt-controller {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: interrupt-controller@10001000 {
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
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 33f3cab..d41e8e2 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -32,12 +32,12 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_4KC:
 	case CPU_ALCHEMY:
 	case CPU_PR4450:
-	case CPU_JZRISC:
 #endif
 
 #if defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) || \
     defined(CONFIG_SYS_HAS_CPU_MIPS32_R2)
 	case CPU_4KEC:
+	case CPU_JZRISC:
 #endif
 
 #ifdef CONFIG_SYS_HAS_CPU_MIPS32_R2
diff --git a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h b/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
index a225baa..0933f94 100644
--- a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
@@ -12,8 +12,6 @@
 #define cpu_has_3k_cache	0
 #define cpu_has_4k_cache	1
 #define cpu_has_tx39_cache	0
-#define cpu_has_fpu		0
-#define cpu_has_32fpr	0
 #define cpu_has_counter		0
 #define cpu_has_watch		1
 #define cpu_has_divec		1
@@ -34,7 +32,6 @@
 #define cpu_has_ic_fills_f_dc	0
 #define cpu_has_pindexed_dcache 0
 #define cpu_has_mips32r1	1
-#define cpu_has_mips32r2	0
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	0
 #define cpu_has_dsp		0
diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index b218f76..9b439fc 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -21,6 +21,8 @@
 
 #ifdef CONFIG_MACH_JZ4740
 # define NR_INTC_IRQS	32
+#else
+# define NR_INTC_IRQS	64
 #endif
 
 /* 1st-level interrupts */
@@ -48,6 +50,8 @@
 #define JZ4740_IRQ_IPU		JZ4740_IRQ(29)
 #define JZ4740_IRQ_LCD		JZ4740_IRQ(30)
 
+#define JZ4780_IRQ_TCU2		JZ4740_IRQ(25)
+
 /* 2nd-level interrupts */
 #define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(NR_INTC_IRQS) + (x))
 
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index dff0966..21adcea 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -12,3 +12,9 @@ endchoice
 config MACH_JZ4740
 	bool
 	select SYS_HAS_CPU_MIPS32_R1
+
+config MACH_JZ4780
+	bool
+	select MIPS_CPU_SCACHE
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_HIGHMEM
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 89ce401..39d70bd 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,9 @@
 # Object file lists.
 
 obj-y += prom.o time.o reset.o setup.o \
-	gpio.o platform.o timer.o
+	platform.o timer.o
+
+obj-$(CONFIG_MACH_JZ4740) += gpio.o
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 1bed3cb..510fc0d 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -83,6 +83,9 @@ arch_initcall(populate_machine);
 
 const char *get_system_type(void)
 {
+	if (config_enabled(CONFIG_MACH_JZ4780))
+		return "JZ4780";
+
 	return "JZ4740";
 }
 
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 9172553..7ab47fe 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -102,7 +102,12 @@ static struct clock_event_device jz4740_clockevent = {
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
@@ -144,7 +149,7 @@ void __init plat_time_init(void)
 
 	sched_clock_register(jz4740_read_sched_clock, 16, clk_rate);
 
-	setup_irq(JZ4740_IRQ_TCU0, &timer_irqaction);
+	setup_irq(jz4740_clockevent.irq, &timer_irqaction);
 
 	ctrl = JZ_TIMER_CTRL_PRESCALE_16 | JZ_TIMER_CTRL_SRC_EXT;
 
-- 
2.3.5
