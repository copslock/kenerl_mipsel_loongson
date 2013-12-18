Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 22:38:18 +0100 (CET)
Received: from seketeli.net ([91.121.166.71]:50296 "EHLO ms.seketeli.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867285Ab3LRVhUHjx66 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 22:37:20 +0100
Received: from localhost (176-26-190-109.dsl.ovh.fr [109.190.26.176])
        by ms.seketeli.net (Postfix) with ESMTP id 42E78EA075;
        Wed, 18 Dec 2013 23:12:17 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 066FEA40A1E; Wed, 18 Dec 2013 22:37:00 +0100 (CET)
From:   Apelete Seketeli <apelete@seketeli.net>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] mips: qi_lb60: add defconfig for Ben NanoNote
Date:   Wed, 18 Dec 2013 22:36:59 +0100
Message-Id: <1387402619-22921-2-git-send-email-apelete@seketeli.net>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1387402619-22921-1-git-send-email-apelete@seketeli.net>
References: <1387402619-22921-1-git-send-email-apelete@seketeli.net>
Return-Path: <apelete@seketeli.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apelete@seketeli.net
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

Add defconfig for the Ben NanoNote handheld computer which is built
around QI_LB60 board and Ingenic JZ4740 MIPS SoC.

Signed-off-by: Apelete Seketeli <apelete@seketeli.net>
---
 arch/mips/configs/qi_lb60_defconfig |  188 +++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 arch/mips/configs/qi_lb60_defconfig

diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
new file mode 100644
index 0000000..2b96547
--- /dev/null
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -0,0 +1,188 @@
+CONFIG_MACH_JZ4740=y
+# CONFIG_COMPACTION is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_HZ_100=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_CUBIC is not set
+CONFIG_TCP_CONG_WESTWOOD=y
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_JZ4740=y
+CONFIG_MTD_UBI=y
+CONFIG_NETDEVICES=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_MATRIX=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=2
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_DMA is not set
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_BATTERY_JZ4740=y
+CONFIG_CHARGER_GPIO=y
+# CONFIG_HWMON is not set
+CONFIG_MFD_JZ4740_ADC=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_FB=y
+CONFIG_FB_JZ4740=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_LOGO_LINUX_CLUT224 is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_MIPS is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_JZ4740_SOC=y
+CONFIG_SND_JZ4740_SOC_QI_LB60=y
+CONFIG_USB=y
+CONFIG_USB_OTG_BLACKLIST_HUB=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_MUSB_JZ4740=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DEBUG=y
+CONFIG_USB_ETH=y
+# CONFIG_USB_ETH_RNDIS is not set
+CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_MMC_JZ4740=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_JZ4740=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_JZ4740=y
+CONFIG_PWM=y
+CONFIG_PWM_JZ4740=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+# CONFIG_JFFS2_ZLIB is not set
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
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
+CONFIG_READABLE_ASM=y
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_STACKOVERFLOW=y
+CONFIG_PANIC_ON_OOPS=y
+# CONFIG_FTRACE is not set
+CONFIG_KGDB=y
+CONFIG_RUNTIME_DEBUG=y
+CONFIG_CRYPTO_ZLIB=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_FONTS=y
+CONFIG_FONT_SUN8x16=y
-- 
1.7.10.4
