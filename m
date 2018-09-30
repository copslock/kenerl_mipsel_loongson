Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2018 16:16:55 +0200 (CEST)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:43582
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeI3OPqh6JIu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2018 16:15:46 +0200
Received: by mail-wr1-x443.google.com with SMTP id n1-v6so834886wrt.10;
        Sun, 30 Sep 2018 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KzbXWHiVBEKxE00/R0XHr24qeypDAG/oGIJijJl/Cc=;
        b=VRy7VtwiVFq5F9e8y+cqLmgSU7xRWL8utMJ91K0hyuxq9BuzwmTKJb4Ivrm3g2FSau
         W7xb4QnRBVwVyEjo1ZidcO2xbPTl0WMHT0TgQxvemf2HIbND9r4lYXSh5BkM41/dl7gY
         YCO0aoRLR1RtmrQeQfLWZDsnJbKEy+fntgwxLxc02tQUhN6xx2gHtHx/QTTwg+mWrCY4
         SqPddC6TUSKDtKLM5guKprHBLu6B7nyX7t3zrbu1syLZsqeC7EEPDr7/3zlZ2isGs2VR
         Z8P4GZltpRtPerA1LDsHSiFhmYK5W4mFxw5ZpJAG9WyqIqo8VppKcR/2HYBj+bvByZZn
         sS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KzbXWHiVBEKxE00/R0XHr24qeypDAG/oGIJijJl/Cc=;
        b=LkA5rzg6Ecr3Amgrv5E8oa56lm8/LqXJyJe2jPbqQjSUvjlCPbVwafOIGz0ykBk7fg
         APCvkdL2RdSeghKXMTqRJJDhSuV8fCUy5uvaqqOZV12smrmFB13GfikwBwXsAu5cVgi5
         KZ1T4fhRKAOeq9pz2RYB+J0goTVN8VhQvKHh6/cz4pCVK4c9L9hg4ltj0uwAvLsXm9Xk
         8zsNZzgSmWXikKGCZl3dGBUxU/g0rqjysb0yJcgNNu5mkUewqKaTydNZbtl7aNUU/KQh
         QKpcr5+j/pkA6RHDsO3j7LdgYPryBlFbxB5vjeuD9bLOtx0XaGe28DLHf0D7v9S+5u8H
         euFw==
X-Gm-Message-State: ABuFfogRykJKqENpo2Ow9jsbgPhIUIVkBLvX12FLbx/Z7qz3f8F6Tfn0
        oh3dgMFJmkmythnS1D4UQEWZxRhshec=
X-Google-Smtp-Source: ACcGV61emR7/7uURrgPEq5hFKKMnsO6ASDn4dIBrfMrebKzyoScQgo+fwfTdMBsjeW7zhfvRIvKq5w==
X-Received: by 2002:adf:bbc3:: with SMTP id z3-v6mr4321630wrg.183.1538316940694;
        Sun, 30 Sep 2018 07:15:40 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:40 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 5/5] MIPS: Add Realtek RTL8186 SoC support
Date:   Sun, 30 Sep 2018 17:15:10 +0300
Message-Id: <20180930141510.2690-6-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930141510.2690-1-yasha.che3@gmail.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

The Realtek RTL8186 SoC is a MIPS based SoC
used in some home routers [1][2].

The hardware includes Lexra LX5280 CPU with a TLB,
two Ethernet controllers, a WLAN controller and more.

With this patch, it is possible to successfully boot
the kernel and load userspace on the Edimax BR-6204Wg
router.
Network drivers support will come in future patches.

This patch includes:
- New MIPS rtl8186 platform
    - Core platform setup code (mostly DT based)
    - New Kconfig option
    - defconfig file
    - MIPS zboot UART support
- RTL8186 interrupt controller driver
- RTL8186 timer driver
- Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
  router

[1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
[2] https://wikidevi.com/wiki/Realtek_RTL8186

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/Kbuild.platforms                    |   1 +
 arch/mips/Kconfig                             |  17 ++
 arch/mips/boot/compressed/uart-16550.c        |   5 +
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/realtek/Makefile           |   4 +
 arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 +++++++
 .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
 arch/mips/configs/rtl8186_defconfig           | 112 +++++++++
 arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
 arch/mips/rtl8186/Makefile                    |   2 +
 arch/mips/rtl8186/Platform                    |   7 +
 arch/mips/rtl8186/irq.c                       |   8 +
 arch/mips/rtl8186/prom.c                      |  15 ++
 arch/mips/rtl8186/setup.c                     |  80 +++++++
 arch/mips/rtl8186/time.c                      |  10 +
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rtl8186.c           | 220 ++++++++++++++++++
 drivers/irqchip/Kconfig                       |   5 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rtl8186.c                 | 107 +++++++++
 21 files changed, 773 insertions(+)
 create mode 100644 arch/mips/boot/dts/realtek/Makefile
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186.dtsi
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
 create mode 100644 arch/mips/configs/rtl8186_defconfig
 create mode 100644 arch/mips/include/asm/mach-rtl8186/rtl8186.h
 create mode 100644 arch/mips/rtl8186/Makefile
 create mode 100644 arch/mips/rtl8186/Platform
 create mode 100644 arch/mips/rtl8186/irq.c
 create mode 100644 arch/mips/rtl8186/prom.c
 create mode 100644 arch/mips/rtl8186/setup.c
 create mode 100644 arch/mips/rtl8186/time.c
 create mode 100644 drivers/clocksource/timer-rtl8186.c
 create mode 100644 drivers/irqchip/irq-rtl8186.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index ac7ad54f984f..2793741f05e5 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -27,6 +27,7 @@ platforms += pmcs-msp71xx
 platforms += pnx833x
 platforms += ralink
 platforms += rb532
+platforms += rtl8186
 platforms += sgi-ip22
 platforms += sgi-ip27
 platforms += sgi-ip32
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bbeabd6b0a80..2f2ef09a1961 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -344,6 +344,23 @@ config MACH_DECSTATION
 
 	  otherwise choose R3000.
 
+config MACH_RTL8186
+	bool "Realtek RTL8186 SoC"
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_HAS_CPU_LX5280
+	select DMA_NONCOHERENT
+	select SYS_SUPPORTS_ZBOOT_UART16550
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select USE_OF
+	select COMMON_CLK
+	select RTL8186_IRQ
+	select RTL8186_TIMER
+	select BUILTIN_DTB
+	help
+	  Realtek RTL8186 SoC support.
+
 config MACH_JAZZ
 	bool "Jazz family of machines"
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index aee8d7b8f091..99314df48718 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -35,6 +35,11 @@
 #define IOTYPE unsigned int
 #endif
 
+#ifdef CONFIG_MACH_RTL8186
+#define UART0_BASE 0xbd0100c3
+#define PORT(offset) (UART0_BASE + (4 * offset))
+#endif
+
 #ifndef IOTYPE
 #define IOTYPE char
 #endif
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 1e79cab8e269..50dc192bbde5 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -11,6 +11,7 @@ subdir-y	+= ni
 subdir-y	+= pic32
 subdir-y	+= qca
 subdir-y	+= ralink
+subdir-y	+= realtek
 subdir-y	+= xilfpga
 
 obj-$(CONFIG_BUILTIN_DTB)	:= $(addsuffix /, $(subdir-y))
diff --git a/arch/mips/boot/dts/realtek/Makefile b/arch/mips/boot/dts/realtek/Makefile
new file mode 100644
index 000000000000..654c3a8da574
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_MACH_RTL8186)	+= rtl8186_edimax_br_6204wg.dtb
+
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/realtek/rtl8186.dtsi b/arch/mips/boot/dts/realtek/rtl8186.dtsi
new file mode 100644
index 000000000000..d172999a42a6
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/rtl8186.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "realtek,rtl8186-soc";
+
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "lexra,lx5280";
+			reg = <0>;
+			clocks = <&cpu_clk>;
+			d-cache-size = <8192>;
+			i-cache-size = <8192>;
+			d-cache-line-size = <16>;
+			i-cache-line-size = <16>;
+			tlb-entries = <16>;
+		};
+	};
+
+	cpu_clk: cpu_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>; /* Stub. Varies with boards */
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <22000000>; /* 22MHz */
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1d010000 0x1000>;
+
+		intc: interrupt-controller@1d010000 {
+			compatible = "realtek,rtl8186-intc";
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			reg = <0x0 0x8>;
+		};
+
+		timer {
+			compatible = "realtek,rtl8186-timer";
+			interrupts = <0>;
+			clocks = <&sysclk>;
+
+			reg = <0x50 0x30>;
+		};
+
+		uart0: serial@1d0100c3 {
+			compatible = "ns16550a";
+			reg = <0xc3 0x20>;
+			reg-io-width = <1>;
+			reg-shift = <2>;
+			interrupts = <3>;
+			clocks = <&cpu_clk>;
+			fifo-size = <16>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@1d0100e3 {
+			compatible = "ns16550a";
+			reg = <0xe3 0x20>;
+			reg-io-width = <1>;
+			reg-shift = <2>;
+			interrupts = <3>;
+			clocks = <&cpu_clk>;
+			fifo-size = <16>;
+
+			status = "disabled";
+		};
+	};
+};
+
diff --git a/arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts b/arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
new file mode 100644
index 000000000000..c28edb83de4e
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/include/ "rtl8186.dtsi"
+
+/ {
+	compatible = "edimax,br-6204wg", "realtek,rtl8186-soc";
+	model = "Edimax BR-6204Wg";
+
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x01000000>; /* 16MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,38400n8";
+	};
+
+	flash0: flash@1e000000 {
+		compatible = "cfi-flash";
+		reg = <0x1e000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		bank-width = <2>;
+
+		partition@0 {
+			label = "bootloader+defaults";
+			reg = <0x0 0x8000>;
+			read-only;
+		};
+		partition@8000 {
+			label = "settings";
+			reg = <0x8000 0x8000>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&cpu_clk {
+	clock-frequency = <180000000>; /* 180MHz */
+};
diff --git a/arch/mips/configs/rtl8186_defconfig b/arch/mips/configs/rtl8186_defconfig
new file mode 100644
index 000000000000..03be44de770d
--- /dev/null
+++ b/arch/mips/configs/rtl8186_defconfig
@@ -0,0 +1,112 @@
+CONFIG_MACH_RTL8186=y
+CONFIG_HZ_100=y
+CONFIG_MIPS_ELF_APPENDED_DTB=y
+CONFIG_KERNEL_XZ=y
+# CONFIG_SWAP is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_SGETMASK_SYSCALL is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+# CONFIG_STACKPROTECTOR_STRONG is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NET_FOU=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_BRIDGE_NETFILTER is not set
+# CONFIG_NETFILTER_INGRESS is not set
+CONFIG_NF_CONNTRACK=y
+# CONFIG_NF_CONNTRACK_PROCFS is not set
+# CONFIG_NF_CT_PROTO_DCCP is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_SYNPROXY=y
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_BRIDGE=y
+# CONFIG_BRIDGE_IGMP_SNOOPING is not set
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_FQ_CODEL=y
+CONFIG_NET_SCH_DEFAULT=y
+CONFIG_DEFAULT_FQ_CODEL=y
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_CORE is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVMEM is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_FILE_DIRECT=y
+# CONFIG_SQUASHFS_ZLIB is not set
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+CONFIG_DEBUG_INFO_SPLIT=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_PANIC_TIMEOUT=10
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_ZBOOT=y
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
diff --git a/arch/mips/include/asm/mach-rtl8186/rtl8186.h b/arch/mips/include/asm/mach-rtl8186/rtl8186.h
new file mode 100644
index 000000000000..d699b25c7854
--- /dev/null
+++ b/arch/mips/include/asm/mach-rtl8186/rtl8186.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RTL8186_H
+#define __ASM_RTL8186_H
+
+#include <linux/compiler.h>
+
+#define RTL8186_REG_BASE ((void __iomem *)0xbd010000)
+#define RTL8186_REGISTER(offset) (RTL8186_REG_BASE + offset)
+
+/* Watchdog registers */
+#define RTL8186_CDBR        RTL8186_REGISTER(0x58)
+#define RTL8186_WDTCNR      RTL8186_REGISTER(0x5C)
+
+/* UART addresses */
+#define RTL8186_UART0_BASE  RTL8186_REGISTER(0xC3)
+#define RTL8186_UART1_BASE  RTL8186_REGISTER(0xE3)
+
+/* GPIO registers */
+#define RTL8186_GPABDATA    RTL8186_REGISTER(0x120)
+#define RTL8186_GPABDIR     RTL8186_REGISTER(0x124)
+#define RTL8186_GPABIMR     RTL8186_REGISTER(0x128)
+#define RTL8186_GPABISR     RTL8186_REGISTER(0x12C)
+#define RTL8186_GPCDDATA    RTL8186_REGISTER(0x130)
+#define RTL8186_GPCDDIR     RTL8186_REGISTER(0x134)
+#define RTL8186_GPCDIMR     RTL8186_REGISTER(0x138)
+#define RTL8186_GPCDISR     RTL8186_REGISTER(0x13C)
+#define RTL8186_GPEFDATA    RTL8186_REGISTER(0x140)
+#define RTL8186_GPEFDIR     RTL8186_REGISTER(0x144)
+#define RTL8186_GPEFIMR     RTL8186_REGISTER(0x148)
+#define RTL8186_GPEFISR     RTL8186_REGISTER(0x14C)
+#define RTL8186_GPGDATA     RTL8186_REGISTER(0x150)
+#define RTL8186_GPGDIR      RTL8186_REGISTER(0x154)
+#define RTL8186_GPGIMR      RTL8186_REGISTER(0x158)
+#define RTL8186_GPGISR      RTL8186_REGISTER(0x15C)
+
+
+#endif /* __ASM_RTL8186_H */
diff --git a/arch/mips/rtl8186/Makefile b/arch/mips/rtl8186/Makefile
new file mode 100644
index 000000000000..010f38349aa6
--- /dev/null
+++ b/arch/mips/rtl8186/Makefile
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+obj-y := prom.o setup.o irq.o time.o
diff --git a/arch/mips/rtl8186/Platform b/arch/mips/rtl8186/Platform
new file mode 100644
index 000000000000..5c23cfbffc62
--- /dev/null
+++ b/arch/mips/rtl8186/Platform
@@ -0,0 +1,7 @@
+#
+# RTL8186
+#
+platform-$(CONFIG_MACH_RTL8186) += rtl8186/
+cflags-$(CONFIG_MACH_RTL8186)   += -I$(srctree)/arch/mips/include/asm/mach-rtl8186
+load-$(CONFIG_MACH_RTL8186)     += 0xffffffff80010000
+zload-$(CONFIG_MACH_RTL8186)    += 0xffffffff80800000
diff --git a/arch/mips/rtl8186/irq.c b/arch/mips/rtl8186/irq.c
new file mode 100644
index 000000000000..f158bfe25bca
--- /dev/null
+++ b/arch/mips/rtl8186/irq.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/irqchip.h>
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
diff --git a/arch/mips/rtl8186/prom.c b/arch/mips/rtl8186/prom.c
new file mode 100644
index 000000000000..0ec7979a23f9
--- /dev/null
+++ b/arch/mips/rtl8186/prom.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/mach-rtl8186/rtl8186.h>
+
+void __init prom_init(void)
+{
+	setup_8250_early_printk_port((unsigned long)RTL8186_UART0_BASE, 2,
+				     10000);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/rtl8186/setup.c b/arch/mips/rtl8186/setup.c
new file mode 100644
index 000000000000..ac3a0e982493
--- /dev/null
+++ b/arch/mips/rtl8186/setup.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+
+#include <asm/reboot.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/bootinfo.h>
+
+#include <asm/mach-rtl8186/rtl8186.h>
+
+const char *get_system_type(void)
+{
+	return "Realtek RTL8186";
+}
+
+void rtl8186_machine_restart(char *command)
+{
+	/* Disable all interrupts */
+	local_irq_disable();
+
+	/* Use watchdog to reset the system */
+	writel(0x10, RTL8186_CDBR);
+	writel(0x00, RTL8186_WDTCNR);
+
+	for (;;)
+		;
+}
+
+#define GPIO_A2 BIT(2)
+#define GPIO_A3 BIT(3)
+#define GPIO_A7 BIT(7)
+#define GPIO_A8 BIT(8)
+
+/* Temporary hack until rtl8186-gpio driver is implemented */
+void __init rtl8186_edimax_br6204wg_setup_leds(void)
+{
+	unsigned int gpabdir, gpabdata;
+
+	gpabdir = readl(RTL8186_GPABDIR);
+	gpabdata = readl(RTL8186_GPABDATA);
+
+	writel(gpabdir | (GPIO_A2 | GPIO_A3), RTL8186_GPABDIR);
+
+	gpabdata &= ~GPIO_A2; /* Turn on A2 - green PWR */
+	gpabdata |= GPIO_A3;  /* Turn off A3 - orange WLAN */
+	writel(gpabdata, RTL8186_GPABDATA);
+}
+
+void __init *plat_get_fdt(void)
+{
+	if (fw_passed_dtb)
+		return (void *)fw_passed_dtb;
+
+	return NULL;
+}
+
+void __init plat_mem_setup(void)
+{
+	void *dtb;
+
+	_machine_restart = rtl8186_machine_restart;
+
+	dtb = plat_get_fdt();
+	if (!dtb)
+		panic("no dtb found");
+
+	__dt_setup_arch(dtb);
+}
+
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+
+	if (of_machine_is_compatible("edimax,br-6204wg"))
+		rtl8186_edimax_br6204wg_setup_leds();
+}
diff --git a/arch/mips/rtl8186/time.c b/arch/mips/rtl8186/time.c
new file mode 100644
index 000000000000..78062b588bb3
--- /dev/null
+++ b/arch/mips/rtl8186/time.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/of_clk.h>
+
+void __init plat_time_init(void)
+{
+	of_clk_init(NULL);
+	timer_probe();
+}
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd88ec15..da87f73d0631 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -609,4 +609,13 @@ config ATCPIT100_TIMER
 	help
 	  This option enables support for the Andestech ATCPIT100 timers.
 
+config RTL8186_TIMER
+	bool "RTL8186 timer driver"
+	depends on MACH_RTL8186
+	depends on COMMON_CLK
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables support for the RTL8186 timer driver.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37e52f9..734e8566e1b6 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
+obj-$(CONFIG_RTL8186_TIMER)		+= timer-rtl8186.o
diff --git a/drivers/clocksource/timer-rtl8186.c b/drivers/clocksource/timer-rtl8186.c
new file mode 100644
index 000000000000..47ef4b09ad27
--- /dev/null
+++ b/drivers/clocksource/timer-rtl8186.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek RTL8186 SoC timer driver.
+ *
+ * Timer0 (24bit): Unused
+ * Timer1 (24bit): Unused
+ * Timer2 (32bit): Used as clocksource
+ * Timer3 (32bit): Used as clock event device
+ *
+ * Copyright (C) 2018 Yasha Cherikovsky
+ */
+
+#include <linux/init.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/sched_clock.h>
+#include <linux/of_clk.h>
+#include <linux/io.h>
+
+#include <asm/time.h>
+#include <asm/idle.h>
+
+#include "timer-of.h"
+
+/* Timer registers */
+#define TCCNR			0x0
+#define TCIR			0x4
+#define TC_DATA(t)		(0x10 + 4 * (t))
+#define TC_CNT(t)		(0x20 + 4 * (t))
+
+/* TCCNR register bits */
+#define TCCNR_TC_EN_BIT(t)		BIT((t) * 2)
+#define TCCNR_TC_MODE_BIT(t)		BIT((t) * 2 + 1)
+#define TCCNR_TC_SRC_BIT(t)		BIT((t) + 8)
+
+/* TCIR register bits */
+#define TCIR_TC_IE_BIT(t)		BIT(t)
+#define TCIR_TC_IP_BIT(t)		BIT((t) + 4)
+
+
+/* Forward declaration */
+static struct timer_of to;
+
+static void __iomem *base;
+
+
+#define RTL8186_TIMER_MODE_COUNTER	0
+#define RTL8186_TIMER_MODE_TIMER	1
+
+static void rtl8186_set_enable_bit(int timer, int enabled)
+{
+	u16 tccnr;
+
+	tccnr = readl(base + TCCNR);
+	tccnr &= ~(TCCNR_TC_EN_BIT(timer));
+
+	if (enabled)
+		tccnr |= TCCNR_TC_EN_BIT(timer);
+
+	writel(tccnr, base + TCCNR);
+}
+
+static void rtl8186_set_mode_bit(int timer, int mode)
+{
+	u16 tccnr;
+
+	tccnr = readl(base + TCCNR);
+	tccnr &= ~(TCCNR_TC_MODE_BIT(timer));
+
+	if (mode)
+		tccnr |= TCCNR_TC_MODE_BIT(timer);
+
+	writel(tccnr, base + TCCNR);
+}
+
+
+static irqreturn_t rtl8186_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = dev_id;
+	int status;
+
+	status = readl(base + TCIR);
+	writel(status, base + TCIR); /* Clear all interrupts */
+
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static int rtl8186_clockevent_set_next(unsigned long evt,
+				       struct clock_event_device *cd)
+{
+	rtl8186_set_enable_bit(3, 0);
+	writel(evt, base + TC_DATA(3));
+	writel(evt, base + TC_CNT(3));
+	rtl8186_set_enable_bit(3, 1);
+	return 0;
+}
+
+static int rtl8186_set_state_periodic(struct clock_event_device *cd)
+{
+	unsigned long period = timer_of_period(to_timer_of(cd));
+
+	rtl8186_set_enable_bit(3, 0);
+	rtl8186_set_mode_bit(3, RTL8186_TIMER_MODE_TIMER);
+
+	/* This timer should reach zero each jiffy */
+	writel(period, base + TC_DATA(3));
+	writel(period, base + TC_CNT(3));
+
+	rtl8186_set_enable_bit(3, 1);
+	return 0;
+}
+
+static int rtl8186_set_state_oneshot(struct clock_event_device *cd)
+{
+	rtl8186_set_enable_bit(3, 0);
+	rtl8186_set_mode_bit(3, RTL8186_TIMER_MODE_COUNTER);
+	return 0;
+}
+
+static int rtl8186_set_state_shutdown(struct clock_event_device *cd)
+{
+	rtl8186_set_enable_bit(3, 0);
+	return 0;
+}
+
+static void rtl8186_timer_init_hw(void)
+{
+	/* Disable all timers */
+	writel(0, base + TCCNR);
+
+	/* Clear and disable all timer interrupts */
+	writel(0xf0, base + TCIR);
+
+	/* Reset all timers timeouts */
+	writel(0, base + TC_DATA(0));
+	writel(0, base + TC_DATA(1));
+	writel(0, base + TC_DATA(2));
+	writel(0, base + TC_DATA(3));
+
+	/* Reset all counters */
+	writel(0, base + TC_CNT(0));
+	writel(0, base + TC_CNT(1));
+	writel(0, base + TC_CNT(2));
+	writel(0, base + TC_CNT(3));
+}
+
+static u64 notrace rtl8186_timer_sched_read(void)
+{
+	return ~readl(base + TC_CNT(2));
+}
+
+static int rtl8186_start_clksrc(void)
+{
+	/* We use Timer2 as a clocksource (monotonic counter). */
+	writel(0xFFFFFFFF, base + TC_DATA(2));
+	writel(0xFFFFFFFF, base + TC_CNT(2));
+
+	rtl8186_set_mode_bit(2, RTL8186_TIMER_MODE_TIMER);
+	rtl8186_set_enable_bit(2, 1);
+
+	sched_clock_register(rtl8186_timer_sched_read, 32, timer_of_rate(&to));
+
+	return clocksource_mmio_init(base + TC_CNT(2), "rtl8186-clksrc",
+				     timer_of_rate(&to), 500, 32,
+				     clocksource_mmio_readl_down);
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK | TIMER_OF_IRQ,
+
+	.clkevt = {
+			.name = "rtl8186_tick",
+			.rating = 200,
+			.features = CLOCK_EVT_FEAT_ONESHOT |
+				    CLOCK_EVT_FEAT_PERIODIC,
+			.set_next_event = rtl8186_clockevent_set_next,
+			.cpumask = cpu_possible_mask,
+			.set_state_periodic = rtl8186_set_state_periodic,
+			.set_state_oneshot = rtl8186_set_state_oneshot,
+			.set_state_shutdown = rtl8186_set_state_shutdown,
+	},
+
+	.of_irq = {
+			.handler = rtl8186_timer_interrupt,
+			.flags = IRQF_TIMER,
+	},
+};
+
+static int __init rtl8186_timer_init(struct device_node *node)
+{
+	int ret;
+
+	ret = timer_of_init(node, &to);
+	if (ret)
+		return ret;
+
+	base = timer_of_base(&to);
+
+	rtl8186_timer_init_hw();
+
+	ret = rtl8186_start_clksrc();
+	if (ret) {
+		pr_err("Failed to register clocksource\n");
+		return ret;
+	}
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 100,
+					0xffffffff);
+
+	/* Enable interrupts for Timer3. Disable interrupts for others */
+	writel(TCIR_TC_IE_BIT(3), base + TCIR);
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(rtl8186_timer, "realtek,rtl8186-timer", rtl8186_timer_init);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..83099905a871 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,4 +371,9 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
 
+config RTL8186_IRQ
+	bool
+	depends on MACH_RTL8186
+	select IRQ_DOMAIN
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15f268f646bf..2e0bb859a8f4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
+obj-$(CONFIG_RTL8186_IRQ)		+= irq-rtl8186.o
diff --git a/drivers/irqchip/irq-rtl8186.c b/drivers/irqchip/irq-rtl8186.c
new file mode 100644
index 000000000000..3eb6b947d5a0
--- /dev/null
+++ b/drivers/irqchip/irq-rtl8186.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek RTL8186 SoC interrupt controller driver.
+ *
+ * Copyright (C) 2018 Yasha Cherikovsky
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define RTL8186_NR_IRQS 11
+
+#define GIMR 0x00
+#define GISR 0x04
+
+static struct {
+	void __iomem *base;
+	struct irq_domain *domain;
+} intc;
+
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	u32 hwirq, virq;
+	u32 gimr = readl(intc.base + GIMR);
+	u32 gisr = readl(intc.base + GISR);
+	u32 pending = gimr & gisr & ((1 << RTL8186_NR_IRQS) - 1);
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	while (pending) {
+		hwirq = fls(pending) - 1;
+		virq = irq_linear_revmap(intc.domain, hwirq);
+		do_IRQ(virq);
+		pending &= ~BIT(hwirq);
+	}
+}
+
+static void rtl8186_irq_mask(struct irq_data *data)
+{
+	unsigned long irq = data->hwirq;
+
+	writel(readl(intc.base + GIMR) & (~(BIT(irq))), intc.base + GIMR);
+}
+
+static void rtl8186_irq_unmask(struct irq_data *data)
+{
+	unsigned long irq = data->hwirq;
+
+	writel((readl(intc.base + GIMR) | (BIT(irq))), intc.base + GIMR);
+}
+
+static struct irq_chip rtl8186_irq_chip = {
+	.name = "RTL8186",
+	.irq_mask = rtl8186_irq_mask,
+	.irq_unmask = rtl8186_irq_unmask,
+};
+
+static int rtl8186_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				       irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &rtl8186_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops rtl8186_irq_ops = {
+	.map = rtl8186_intc_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init rtl8186_intc_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	intc.base = of_io_request_and_map(node, 0, of_node_full_name(node));
+
+	if (IS_ERR(intc.base))
+		panic("%pOF: unable to map resource", node);
+
+	intc.domain = irq_domain_add_linear(node, RTL8186_NR_IRQS,
+					    &rtl8186_irq_ops, NULL);
+
+	if (!intc.domain)
+		panic("%pOF: unable to create IRQ domain\n", node);
+
+	/* Start with all interrupts disabled */
+	writel(0, intc.base + GIMR);
+
+	/*
+	 * Enable all hardware interrupts in CP0 status register.
+	 * Software interrupts are disabled.
+	 */
+	set_c0_status(ST0_IM);
+	clear_c0_status(STATUSF_IP0 | STATUSF_IP1);
+	clear_c0_cause(CAUSEF_IP);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(rtl8186_intc, "realtek,rtl8186-intc", rtl8186_intc_of_init);
-- 
2.19.0
