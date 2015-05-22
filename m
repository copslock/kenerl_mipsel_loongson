Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:54:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34439 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013269AbbEVPybOjkUI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:54:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AAD34C80EE651;
        Fri, 22 May 2015 16:54:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:54:25 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:54:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Michal Marek <mmarek@suse.cz>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 09/15] MIPS: malta: probe UARTs using DT
Date:   Fri, 22 May 2015 16:51:08 +0100
Message-ID: <1432309875-9712-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47558
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

Add the DT nodes required to probe the UARTs present in the Malta
development board, and remove the platform data that was previously
accomplishing the same thing. Enable CONFIG_SERIAL_OF_PLATFORM in the
various Malta defconfigs in order to continue supporting serial output
when using them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/malta.dts            | 51 +++++++++++++++++++++++++++++
 arch/mips/configs/malta_defconfig           |  1 +
 arch/mips/configs/malta_kvm_defconfig       |  1 +
 arch/mips/configs/malta_kvm_guest_defconfig |  1 +
 arch/mips/configs/malta_qemu_32r6_defconfig |  1 +
 arch/mips/configs/maltaaprp_defconfig       |  1 +
 arch/mips/configs/maltasmvp_defconfig       |  1 +
 arch/mips/configs/maltasmvp_eva_defconfig   |  1 +
 arch/mips/configs/maltaup_defconfig         |  1 +
 arch/mips/configs/maltaup_xpa_defconfig     |  1 +
 arch/mips/mti-malta/malta-platform.c        | 37 ---------------------
 11 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index 4bcdeb4..905a347 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -43,6 +43,57 @@
 		};
 	};
 
+	isa {
+		compatible = "isa";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <1 0 0 0x1000>;
+
+		uart0: uart@3f8 {
+			compatible = "ns16550";
+			reg = <1 0x3f8 0x8>;
+
+			clock-frequency = <1843200>;
+
+			interrupt-parent = <&i8259>;
+			interrupts = <4>;
+
+			no-loopback-test;
+		};
+
+		uart1: uart@2f8 {
+			compatible = "ns16550";
+			reg = <1 0x2f8 0x8>;
+
+			clock-frequency = <1843200>;
+
+			interrupt-parent = <&i8259>;
+			interrupts = <3>;
+
+			no-loopback-test;
+		};
+	};
+
+	fpga {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1f000000 0x100000>;
+
+		uart2: uart@900 {
+			compatible = "ns16550";
+
+			reg = <0x900 0x40>;
+			reg-io-width = <4>;
+			reg-shift = <3>;
+
+			clock-frequency = <3686400>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+	};
+
 	board {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 61a4460..4f0528c 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -320,6 +320,7 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index d41742d..815595d 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -329,6 +329,7 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index a7806e8..2a0d7b0 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -329,6 +329,7 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 4bce1f8..9415088 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -132,6 +132,7 @@ CONFIG_PCNET32=y
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index fb042ce..955897a 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -132,6 +132,7 @@ CONFIG_PCNET32=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index f8a3231..b3ae18e 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -136,6 +136,7 @@ CONFIG_PCNET32=y
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index c83338a..9ae3235 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -137,6 +137,7 @@ CONFIG_PCNET32=y
 CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 6234464..73a54ca 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -131,6 +131,7 @@ CONFIG_PCNET32=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index c388bff..7d7714c 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -324,6 +324,7 @@ CONFIG_LIBERTAS=m
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CIRRUS=y
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index e1dd1c1..184c00d5 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -32,42 +32,6 @@
 #include <asm/mips-boards/maltaint.h>
 #include <mtd/mtd-abi.h>
 
-#define SMC_PORT(base, int)						\
-{									\
-	.iobase		= base,						\
-	.irq		= int,						\
-	.uartclk	= 1843200,					\
-	.iotype		= UPIO_PORT,					\
-	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,		\
-	.regshift	= 0,						\
-}
-
-#define CBUS_UART_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP)
-
-static struct plat_serial8250_port uart8250_data[] = {
-	SMC_PORT(0x3F8, 4),
-	SMC_PORT(0x2F8, 3),
-#ifndef CONFIG_MIPS_CMP
-	{
-		.mapbase	= 0x1f000900,	/* The CBUS UART */
-		.irq		= MIPS_CPU_IRQ_BASE + MIPSCPU_INT_MB2,
-		.uartclk	= 3686400,	/* Twice the usual clk! */
-		.iotype		= UPIO_MEM32,
-		.flags		= CBUS_UART_FLAGS,
-		.regshift	= 3,
-	},
-#endif
-	{ },
-};
-
-static struct platform_device malta_uart8250_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= uart8250_data,
-	},
-};
-
 struct resource malta_rtc_resources[] = {
 	{
 		.start	= RTC_PORT(0),
@@ -128,7 +92,6 @@ static struct platform_device malta_flash_device = {
 };
 
 static struct platform_device *malta_devices[] __initdata = {
-	&malta_uart8250_device,
 	&malta_rtc_device,
 	&malta_flash_device,
 };
-- 
2.4.1
