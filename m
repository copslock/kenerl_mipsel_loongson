Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:31:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012620AbbEXPbYbN7PV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:31:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8B1C2D7870528;
        Sun, 24 May 2015 16:31:17 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:31:20 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:31:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 37/37] MIPS: ingenic: initial MIPS Creator CI20 support
Date:   Sun, 24 May 2015 16:11:47 +0100
Message-ID: <1432480307-23789-38-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47635
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

Add an initial device tree for the Ingenic JZ4780 based MIPS Creator
CI20 board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

Changes in v5:
- Dropped initramfs from ci20_defconfig.
- Drop nowait from builtin command line in ci20_defconfig.
- Enable UARTs 0, 1, 3 & 4 (all of which are accessible on the board)
  and specify their numbering using aliases to preserve their ttyS0,
  ttyS1, ttyS3 & ttyS4 naming.

Changes in v4: None
Changes in v3:
- Rebase, relocating behind CONFIG_MACH_INGENIC.

Changes in v2: None

 arch/mips/boot/dts/ingenic/Makefile |   1 +
 arch/mips/boot/dts/ingenic/ci20.dts |  44 ++++++++++
 arch/mips/configs/ci20_defconfig    | 162 ++++++++++++++++++++++++++++++++++++
 arch/mips/jz4740/Kconfig            |   4 +
 4 files changed, 211 insertions(+)
 create mode 100644 arch/mips/boot/dts/ingenic/ci20.dts
 create mode 100644 arch/mips/configs/ci20_defconfig

diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index 0c84f0b..f2b864f 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
+dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
new file mode 100644
index 0000000..9fcb9e7
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+#include "jz4780.dtsi"
+
+/ {
+	compatible = "img,ci20", "ingenic,jz4780";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x10000000
+		       0x30000000 0x30000000>;
+	};
+};
+
+&ext {
+	clock-frequency = <48000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
new file mode 100644
index 0000000..4e36b6e
--- /dev/null
+++ b/arch/mips/configs/ci20_defconfig
@@ -0,0 +1,162 @@
+CONFIG_MACH_INGENIC=y
+CONFIG_JZ4780_CI20=y
+CONFIG_HIGHMEM=y
+# CONFIG_COMPACTION is not set
+CONFIG_CMA=y
+CONFIG_HZ_100=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_KMEM=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=32
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+CONFIG_DM9000=y
+CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_LEGACY_PTY_COUNT=2
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=5
+CONFIG_SERIAL_8250_RUNTIME_UARTS=5
+CONFIG_SERIAL_8250_INGENIC=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_JZ4780=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DEBUG=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_MEMORY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_PROC_KCORE=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=y
+CONFIG_CONFIGFS_FS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NLS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_737=y
+CONFIG_NLS_CODEPAGE_775=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
+CONFIG_NLS_CODEPAGE_855=y
+CONFIG_NLS_CODEPAGE_857=y
+CONFIG_NLS_CODEPAGE_860=y
+CONFIG_NLS_CODEPAGE_861=y
+CONFIG_NLS_CODEPAGE_862=y
+CONFIG_NLS_CODEPAGE_863=y
+CONFIG_NLS_CODEPAGE_864=y
+CONFIG_NLS_CODEPAGE_865=y
+CONFIG_NLS_CODEPAGE_866=y
+CONFIG_NLS_CODEPAGE_869=y
+CONFIG_NLS_CODEPAGE_936=y
+CONFIG_NLS_CODEPAGE_950=y
+CONFIG_NLS_CODEPAGE_932=y
+CONFIG_NLS_CODEPAGE_949=y
+CONFIG_NLS_CODEPAGE_874=y
+CONFIG_NLS_ISO8859_8=y
+CONFIG_NLS_CODEPAGE_1250=y
+CONFIG_NLS_CODEPAGE_1251=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+CONFIG_NLS_ISO8859_3=y
+CONFIG_NLS_ISO8859_4=y
+CONFIG_NLS_ISO8859_5=y
+CONFIG_NLS_ISO8859_6=y
+CONFIG_NLS_ISO8859_7=y
+CONFIG_NLS_ISO8859_9=y
+CONFIG_NLS_ISO8859_13=y
+CONFIG_NLS_ISO8859_14=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_KOI8_R=y
+CONFIG_NLS_KOI8_U=y
+CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PANIC_TIMEOUT=10
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_STACKTRACE=y
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 21adcea..36f8201 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -7,6 +7,10 @@ config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
 	select MACH_JZ4740
 
+config JZ4780_CI20
+	bool "MIPS Creator CI20"
+	select MACH_JZ4780
+
 endchoice
 
 config MACH_JZ4740
-- 
2.4.1
