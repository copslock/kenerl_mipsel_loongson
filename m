Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2012 01:41:12 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58627 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823087Ab2JQXlJr-FzG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Oct 2012 01:41:09 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so8018215pbc.36
        for <multiple recipients>; Wed, 17 Oct 2012 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=W2VTqewK+4dAFya5+Px5nRpZ0pKFYtSS8CeFxyeHV58=;
        b=kzhRt2LYDE+XEJxWBsfEDmAQe75uO84H1TvQAgXsY99VLWUiyxuummMf8LJbBoTDjJ
         fqb8mSaXfRmnERL0mhU7bDU0EOepDxCO846cE1UeyqjSfWPaXstlhVH1EWwKkXG+HdMU
         E15pmjjKQXaSK9VRpqijSXf6mN4HuT+UjXaCDbF7/1P7ILk9GBfCPDluetk+Pfn3YePo
         bsR+1N6mkyRHk776Ig4/u9r+G+pdrn4NzAXjv7rEkMVZWEADAFwspx3Mhg+H3z0j9r8q
         +DGKOJv51hn03qjQE1ShLoESREO4QiUL2B1bv/b8RujmsCdmutgzSgLQvNSVKe7q8yji
         N9lw==
Received: by 10.66.76.98 with SMTP id j2mr54332551paw.65.1350517262502;
        Wed, 17 Oct 2012 16:41:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id uh7sm13196420pbc.35.2012.10.17.16.41.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 16:41:01 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q9HNe0e4001605;
        Wed, 17 Oct 2012 16:40:00 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q9HNdxkD001604;
        Wed, 17 Oct 2012 16:39:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Update cavium_octeon_defconfig
Date:   Wed, 17 Oct 2012 16:39:58 -0700
Message-Id: <1350517198-1568-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 34716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Turn on support for most hardware present on OCTEON development boards
as well as some filesystems and SATA controllers so we can boot off of
a disk or CF

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/configs/cavium_octeon_defconfig | 98 +++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 17 deletions(-)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 75165df..014ba4b 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -1,7 +1,11 @@
 CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD=y
+CONFIG_CAVIUM_CN63XXP1=y
 CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=2
 CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_SMP=y
+CONFIG_NR_CPUS=32
+CONFIG_HZ_100=y
 CONFIG_PREEMPT=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
@@ -11,16 +15,15 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
@@ -42,22 +45,68 @@ CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
+CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_OF_PARTS is not set
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_SLRAM=y
+CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
-# CONFIG_MISC_DEVICES is not set
+CONFIG_EEPROM_AT24=y
+CONFIG_EEPROM_AT25=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_PATA_OCTEON_CF=y
+CONFIG_SATA_SIL=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_NETDEV_10000 is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+# CONFIG_NET_VENDOR_HP is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+# CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_NET_PACKET_ENGINE is not set
+# CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_TOSHIBA is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_MARVELL_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_BCM87XX_PHY=y
+# CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
@@ -66,24 +115,39 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_OCTEON=y
+CONFIG_SPI=y
+CONFIG_SPI_OCTEON=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_STAGING=y
+CONFIG_OCTEON_ETHERNET=y
+# CONFIG_NET_VENDOR_SILICOM is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
-# CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_NLS=y
+CONFIG_HUGETLBFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-# CONFIG_EARLY_PRINTK is not set
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_CRYPTO_CBC=y
-- 
1.7.11.7
