Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 21:16:33 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:53135 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1902756Ab2HNTQ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 21:16:29 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 377D123C00D3;
        Tue, 14 Aug 2012 21:16:27 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: add default configuration for ath79
Date:   Tue, 14 Aug 2012 21:16:04 +0200
Message-Id: <1344971764-22742-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/configs/ath79_defconfig |  111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 arch/mips/configs/ath79_defconfig

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
new file mode 100644
index 0000000..ea87d43
--- /dev/null
+++ b/arch/mips/configs/ath79_defconfig
@@ -0,0 +1,111 @@
+CONFIG_ATH79=y
+CONFIG_ATH79_MACH_AP121=y
+CONFIG_ATH79_MACH_AP81=y
+CONFIG_ATH79_MACH_DB120=y
+CONFIG_ATH79_MACH_PB44=y
+CONFIG_ATH79_MACH_UBNT_XM=y
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+CONFIG_RD_LZMA=y
+# CONFIG_KALLSYMS is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_PCI=y
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
+CONFIG_MAC80211_DEBUGFS=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-2
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_M25P80=y
+# CONFIG_M25PXX_USE_FAST_READ is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_PACKET_ENGINE is not set
+CONFIG_ATH_COMMON=m
+CONFIG_ATH9K=m
+CONFIG_ATH9K_AHB=y
+CONFIG_INPUT=m
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO_POLLED=m
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_PCI is not set
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_AR933X=y
+CONFIG_SERIAL_AR933X_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_I2C_GPIO=y
+CONFIG_SPI=y
+CONFIG_SPI_ATH79=y
+CONFIG_SPI_GPIO=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCF857X=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_ATH79_WDT=y
+# CONFIG_VGA_ARB is not set
+# CONFIG_HID is not set
+# CONFIG_USB_HID is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRC_ITU_T=m
-- 
1.7.10
