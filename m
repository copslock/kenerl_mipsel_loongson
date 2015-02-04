Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:32:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37040 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012524AbbBDPWzbS7kt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A73341E6E186;
        Wed,  4 Feb 2015 15:22:46 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:49 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:48 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 33/34] MIPS: initial MIPS Creator CI20 board support
Date:   Wed, 4 Feb 2015 15:22:02 +0000
Message-ID: <1423063323-19419-34-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

Add a device tree for the Ingenic jz4780 based MIPS Creator CI20 board.
Note that this is unselectable via Kconfig until the jz4780 SoC is made
selectable in a later commit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/boot/dts/Makefile      |   1 +
 arch/mips/boot/dts/ci20.dts      |  21 +++++++
 arch/mips/configs/ci20_defconfig | 127 +++++++++++++++++++++++++++++++++++++++
 arch/mips/jz4740/Kconfig         |  10 +++
 4 files changed, 159 insertions(+)
 create mode 100644 arch/mips/boot/dts/ci20.dts
 create mode 100644 arch/mips/configs/ci20_defconfig

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index a1127f3..28e6a21 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_DTB_RT305X_EVAL)		+= rt3052_eval.dtb
 dtb-$(CONFIG_DTB_RT3883_EVAL)		+= rt3883_eval.dtb
 dtb-$(CONFIG_DTB_MT7620A_EVAL)		+= mt7620a_eval.dtb
 dtb-$(CONFIG_JZ4740_QI_LB60)		+= qi_lb60.dtb
+dtb-$(CONFIG_JZ4780_CI20)		+= ci20.dtb
 dtb-$(CONFIG_MIPS_SEAD3)		+= sead3.dtb
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ci20.dts b/arch/mips/boot/dts/ci20.dts
new file mode 100644
index 0000000..4f882ef
--- /dev/null
+++ b/arch/mips/boot/dts/ci20.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+#include "jz4780.dtsi"
+
+/ {
+	compatible = "img,ci20", "ingenic,jz4780";
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
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
new file mode 100644
index 0000000..6562d28
--- /dev/null
+++ b/arch/mips/configs/ci20_defconfig
@@ -0,0 +1,127 @@
+CONFIG_MACH_JZ4780=y
+# CONFIG_COMPACTION is not set
+CONFIG_HZ_100=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_RESOURCE_COUNTERS=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_KMEM=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+# CONFIG_RD_GZIP is not set
+CONFIG_RD_XZ=y
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
+CONFIG_SERIAL_8250_JZ47XX=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
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
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_PANIC_ON_OOPS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_STACKTRACE=y
+# CONFIG_FTRACE is not set
+# CONFIG_EARLY_PRINTK is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS4,115200 clk_ignore_unused"
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 4689030..72ac174 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -7,3 +7,13 @@ config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
 
 endchoice
+
+choice
+	prompt "Machine type"
+	depends on MACH_JZ4780
+	default JZ4780_CI20
+
+config JZ4780_CI20
+	bool "MIPS Creator CI20"
+
+endchoice
-- 
1.9.1
