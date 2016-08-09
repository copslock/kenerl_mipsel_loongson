Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:37:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54444 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992640AbcHIMhDWY1U4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:37:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0826135BEF781;
        Tue,  9 Aug 2016 13:36:43 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:36:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 03/20] MIPS: SEAD3: Probe UARTs using DT
Date:   Tue, 9 Aug 2016 13:35:28 +0100
Message-ID: <20160809123546.10190-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54439
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

Probe the UARTs on SEAD3 boards using device tree rather than platform
code, in order to reduce the amount of the latter. This requires that
CONFIG_SERIAL_OF_PLATFORM be enabled, so enable it in sead3_defconfig.
The SEAD3 DT shim code is extended to read bootloader environment
variables to determine the appropriate UART & mode for kernel console
output & set the stdout-path property of the chosen node accordingly.

In contrast to the old platform code, which appears to have only ever
set "console=ttyS0,38400n8r" with the code in console_config never
having an effect, this will honor the "yamontty" environment variable to
select between the 2 UARTs on the board and then check the "modetty0" or
"modetty1" variable as appropriate to determine the UART configuration.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/sead3.dts             |  37 ++++++++++
 arch/mips/configs/sead3_defconfig            |   2 +
 arch/mips/include/asm/mips-boards/sead3int.h |   4 --
 arch/mips/mti-sead3/sead3-dtshim.c           | 104 ++++++++++++++++++++++++++-
 arch/mips/mti-sead3/sead3-init.c             |  46 ------------
 arch/mips/mti-sead3/sead3-platform.c         |  30 --------
 6 files changed, 142 insertions(+), 81 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index 051b3a9..3f681c5 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -12,6 +12,15 @@
 	compatible = "mti,sead-3";
 	interrupt-parent = <&gic>;
 
+	chosen {
+		stdout-path = "uart1:115200";
+	};
+
+	aliases {
+		uart0 = &uart0;
+		uart1 = &uart1;
+	};
+
 	cpus {
 		cpu@0 {
 			compatible = "mti,mips14KEc", "mti,mips14Kc";
@@ -50,4 +59,32 @@
 			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
 		};
 	};
+
+	/* UART connected to FTDI & miniUSB socket */
+	uart0: uart@1f000900 {
+		compatible = "ns16550a";
+		reg = <0x1f000900 0x20>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+
+		clock-frequency = <14745600>;
+
+		interrupts = <3>; /* GIC 3 or CPU 4 */
+
+		no-loopback-test;
+	};
+
+	/* UART connected to RS232 socket */
+	uart1: uart@1f000800 {
+		compatible = "ns16550a";
+		reg = <0x1f000800 0x20>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+
+		clock-frequency = <14745600>;
+
+		interrupts = <2>; /* GIC 2 or CPU 4 */
+
+		no-loopback-test;
+	};
 };
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
index dae9354..deb48fb 100644
--- a/arch/mips/configs/sead3_defconfig
+++ b/arch/mips/configs/sead3_defconfig
@@ -39,6 +39,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=y
+CONFIG_OF=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_SCSI=y
@@ -70,6 +71,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index bd85da3..3a5e079 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -14,14 +14,10 @@
 
 /* CPU interrupt offsets */
 #define CPU_INT_EHCI		2
-#define CPU_INT_UART0		4
-#define CPU_INT_UART1		4
 #define CPU_INT_NET		6
 
 /* GIC interrupt offsets */
 #define GIC_INT_NET		GIC_SHARED_TO_HWIRQ(0)
-#define GIC_INT_UART1		GIC_SHARED_TO_HWIRQ(2)
-#define GIC_INT_UART0		GIC_SHARED_TO_HWIRQ(3)
 #define GIC_INT_EHCI		GIC_SHARED_TO_HWIRQ(5)
 
 #endif /* !(_MIPS_SEAD3INT_H) */
diff --git a/arch/mips/mti-sead3/sead3-dtshim.c b/arch/mips/mti-sead3/sead3-dtshim.c
index 1592d07..8314943 100644
--- a/arch/mips/mti-sead3/sead3-dtshim.c
+++ b/arch/mips/mti-sead3/sead3-dtshim.c
@@ -22,7 +22,8 @@ static unsigned char fdt_buf[16 << 10] __initdata;
 
 static int remove_gic(void *fdt)
 {
-	int gic_off, cpu_off, err;
+	const unsigned int cpu_uart_int = 4;
+	int gic_off, cpu_off, uart_off, err;
 	uint32_t cfg, cpu_phandle;
 
 	/* leave the GIC node intact if a GIC is present */
@@ -61,6 +62,103 @@ static int remove_gic(void *fdt)
 		return err;
 	}
 
+	uart_off = fdt_node_offset_by_compatible(fdt, -1, "ns16550a");
+	while (uart_off >= 0) {
+		err = fdt_setprop_u32(fdt, uart_off, "interrupts",
+				      cpu_uart_int);
+		if (err) {
+			pr_err("unable to set UART interrupts property: %d\n",
+			       err);
+			return err;
+		}
+
+		uart_off = fdt_node_offset_by_compatible(fdt, uart_off,
+							 "ns16550a");
+	}
+	if (uart_off != -FDT_ERR_NOTFOUND) {
+		pr_err("error searching for UART DT node: %d\n", uart_off);
+		return uart_off;
+	}
+
+	return 0;
+}
+
+static int serial_config(void *fdt)
+{
+	const char *yamontty, *mode_var;
+	char mode_var_name[9], path[18], parity;
+	unsigned int uart, baud, stop_bits;
+	bool hw_flow;
+	int chosen_off, err;
+
+	yamontty = fw_getenv("yamontty");
+	if (!yamontty || !strcmp(yamontty, "tty0")) {
+		uart = 0;
+	} else if (!strcmp(yamontty, "tty1")) {
+		uart = 1;
+	} else {
+		pr_warn("yamontty environment variable '%s' invalid\n",
+			yamontty);
+		uart = 0;
+	}
+
+	baud = stop_bits = 0;
+	parity = 0;
+	hw_flow = false;
+
+	snprintf(mode_var_name, sizeof(mode_var_name), "modetty%u", uart);
+	mode_var = fw_getenv(mode_var_name);
+	if (mode_var) {
+		while (mode_var[0] >= '0' && mode_var[0] <= '9') {
+			baud *= 10;
+			baud += mode_var[0] - '0';
+			mode_var++;
+		}
+		if (mode_var[0] == ',')
+			mode_var++;
+		if (mode_var[0])
+			parity = mode_var[0];
+		if (mode_var[0] == ',')
+			mode_var++;
+		if (mode_var[0])
+			stop_bits = mode_var[0] - '0';
+		if (mode_var[0] == ',')
+			mode_var++;
+		if (!strcmp(mode_var, "hw"))
+			hw_flow = true;
+	}
+
+	if (!baud)
+		baud = 38400;
+
+	if (parity != 'e' && parity != 'n' && parity != 'o')
+		parity = 'n';
+
+	if (stop_bits != 7 && stop_bits != 8)
+		stop_bits = 8;
+
+	WARN_ON(snprintf(path, sizeof(path), "uart%u:%u%c%u%s",
+			 uart, baud, parity, stop_bits,
+			 hw_flow ? "r" : "") >= sizeof(path));
+
+	/* find or add chosen node */
+	chosen_off = fdt_path_offset(fdt, "/chosen");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_path_offset(fdt, "/chosen@0");
+	if (chosen_off == -FDT_ERR_NOTFOUND)
+		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
+	if (chosen_off < 0) {
+		pr_err("Unable to find or add DT chosen node: %d\n",
+		       chosen_off);
+		return chosen_off;
+	}
+
+	err = fdt_setprop_string(fdt, chosen_off, "stdout-path", path);
+	if (err) {
+		pr_err("Unable to set stdout-path property: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 
@@ -83,6 +181,10 @@ void __init *sead3_dt_shim(void *fdt)
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
+	err = serial_config(fdt_buf);
+	if (err)
+		panic("Unable to patch FDT: %d", err);
+
 	err = fdt_pack(fdt_buf);
 	if (err)
 		panic("Unable to pack FDT: %d\n", err);
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index 3572ea3..e81f5b7 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -17,47 +17,6 @@
 extern char except_vec_nmi;
 extern char except_vec_ejtag_debug;
 
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-static void __init console_config(void)
-{
-	char console_string[40];
-	int baud = 0;
-	char parity = '\0', bits = '\0', flow = '\0';
-	char *s;
-
-	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
-		s = fw_getenv("modetty0");
-		if (s) {
-			while (*s >= '0' && *s <= '9')
-				baud = baud*10 + *s++ - '0';
-			if (*s == ',')
-				s++;
-			if (*s)
-				parity = *s++;
-			if (*s == ',')
-				s++;
-			if (*s)
-				bits = *s++;
-			if (*s == ',')
-				s++;
-			if (*s == 'h')
-				flow = 'r';
-		}
-		if (baud == 0)
-			baud = 38400;
-		if (parity != 'n' && parity != 'o' && parity != 'e')
-			parity = 'n';
-		if (bits != '7' && bits != '8')
-			bits = '8';
-		if (flow == '\0')
-			flow = 'r';
-		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
-			parity, bits, flow);
-		strcat(fw_getcmdline(), console_string);
-	}
-}
-#endif
-
 static void __init mips_nmi_setup(void)
 {
 	void *base;
@@ -140,11 +99,6 @@ void __init prom_init(void)
 	else if ((strstr(fw_getcmdline(), "console=ttyS1")) != NULL)
 		fw_init_early_console(1);
 #endif
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	if ((strstr(fw_getcmdline(), "console=")) == NULL)
-		strcat(fw_getcmdline(), " console=ttyS0,38400n8r");
-	console_config();
-#endif
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
index 12cf905..e772a05 100644
--- a/arch/mips/mti-sead3/sead3-platform.c
+++ b/arch/mips/mti-sead3/sead3-platform.c
@@ -14,35 +14,10 @@
 #include <linux/mtd/physmap.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/serial_8250.h>
 #include <linux/smsc911x.h>
 
 #include <asm/mips-boards/sead3int.h>
 
-#define UART(base)							\
-{									\
-	.mapbase	= base,						\
-	.irq		= -1,						\
-	.uartclk	= 14745600,					\
-	.iotype		= UPIO_MEM32,					\
-	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP, \
-	.regshift	= 2,						\
-}
-
-static struct plat_serial8250_port uart8250_data[] = {
-	UART(0x1f000900),   /* ttyS0 = USB   */
-	UART(0x1f000800),   /* ttyS1 = RS232 */
-	{ },
-};
-
-static struct platform_device uart8250_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM2,
-	.dev			= {
-		.platform_data	= uart8250_data,
-	},
-};
-
 static struct smsc911x_platform_config sead3_smsc911x_data = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
@@ -195,7 +170,6 @@ static struct platform_device ehci_device = {
 };
 
 static struct platform_device *sead3_platform_devices[] __initdata = {
-	&uart8250_device,
 	&sead3_flash,
 	&pled_device,
 	&fled_device,
@@ -228,15 +202,11 @@ static int __init sead3_platforms_device_init(void)
 	}
 
 	if (gic_present) {
-		uart8250_data[0].irq = irq_create_mapping(irqd, GIC_INT_UART0);
-		uart8250_data[1].irq = irq_create_mapping(irqd, GIC_INT_UART1);
 		ehci_resources[1].start =
 			irq_create_mapping(irqd, GIC_INT_EHCI);
 		sead3_net_resources[1].start =
 			irq_create_mapping(irqd, GIC_INT_NET);
 	} else {
-		uart8250_data[0].irq = irq_create_mapping(irqd, CPU_INT_UART0);
-		uart8250_data[1].irq = irq_create_mapping(irqd, CPU_INT_UART1);
 		ehci_resources[1].start =
 			irq_create_mapping(irqd, CPU_INT_EHCI);
 		sead3_net_resources[1].start =
-- 
2.9.2
