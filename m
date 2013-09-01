Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Sep 2013 18:51:30 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34012 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819547Ab3IAQv1usxq0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Sep 2013 18:51:27 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: lantiq: add defconfig for xway SoC
Date:   Sun,  1 Sep 2013 18:51:08 +0200
Message-Id: <1378054268-4722-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This add a default config for the Lantiq XWAY SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/configs/xway_defconfig |  159 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 arch/mips/configs/xway_defconfig

diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
new file mode 100644
index 0000000..8987846
--- /dev/null
+++ b/arch/mips/configs/xway_defconfig
@@ -0,0 +1,159 @@
+CONFIG_LANTIQ=y
+CONFIG_XRX200_PHY_FW=y
+CONFIG_CPU_MIPS32_R2=y
+# CONFIG_COMPACTION is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_COREDUMP is not set
+# CONFIG_SUSPEND is not set
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
+CONFIG_ARPD=y
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_BRIDGE_NETFILTER is not set
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NETFILTER_XT_TARGET_CT=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NF_CONNTRACK_IPV4=m
+# CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_RAW=m
+CONFIG_BRIDGE=y
+# CONFIG_BRIDGE_IGMP_SNOOPING is not set
+CONFIG_VLAN_8021Q=y
+CONFIG_NET_SCHED=y
+CONFIG_HAMRADIO=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_LANTIQ=y
+CONFIG_EEPROM_93CX6=m
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_NETDEVICES=y
+CONFIG_LANTIQ_ETOP=y
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_PHYLIB=y
+CONFIG_PPP=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
+CONFIG_ISDN=y
+CONFIG_INPUT=m
+CONFIG_INPUT_POLLDEV=m
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SPI=y
+CONFIG_GPIO_MM_LANTIQ=y
+CONFIG_GPIO_STP_XWAY=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_HID is not set
+# CONFIG_USB_HID is not set
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_STORAGE_DEBUG=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_STAGING=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+# CONFIG_JFFS2_FS_POSIX_ACL is not set
+# CONFIG_JFFS2_FS_SECURITY is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+# CONFIG_JFFS2_ZLIB is not set
+CONFIG_SQUASHFS=y
+# CONFIG_SQUASHFS_ZLIB is not set
+CONFIG_SQUASHFS_XZ=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_ARC4=m
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRC_ITU_T=m
+CONFIG_CRC32_SARWATE=y
+CONFIG_AVERAGE=y
-- 
1.7.10.4
