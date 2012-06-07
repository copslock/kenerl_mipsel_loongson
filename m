Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 21:53:08 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:64094 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903735Ab2FGTwp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 21:52:45 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so1427993dad.36
        for <multiple recipients>; Thu, 07 Jun 2012 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lL2e6XKhkEo8jr3KjHEyBZ9uKsZwMlMiTv8UCpWgpjw=;
        b=qkKmRJOB+OfEKNIbgXDWup6Dw1m37DgaWzr4PINkdVBKNPn0c8rgQ3PbrK2uh6ALt5
         l6SoPClIJXaabc7y9sw6snnOPOuHIRz5dImTq9nJAlcdc1E+HgR6IQ/ye605huJFR0e1
         IMeKQXv37+IfOnhDiYaCWMaCFlF183UMkZ5qozgRHaS9M3CrCtUcjjytTNOYyRvZDVol
         dbP/0soPoSdDjsZmWP3NaY5R9uR75J3xyVkreYJue5eTp5T7pK8hsFRei2+9I/X5oXrP
         nhaLSU6NKfp//0desJkX0laxjAhWIuuypz8vRzeOtI28H+yFwBOwbc5HwlJ4olb4a/t8
         uWjg==
Received: by 10.68.227.195 with SMTP id sc3mr11246490pbc.104.1339098764724;
        Thu, 07 Jun 2012 12:52:44 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ph1sm5096869pbb.45.2012.06.07.12.52.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 12:52:44 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q57Jqg0m009987;
        Thu, 7 Jun 2012 12:52:42 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q57JqgLJ009986;
        Thu, 7 Jun 2012 12:52:42 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 3/3] MIPS:Update cavium-octeon_defconfig
Date:   Thu,  7 Jun 2012 12:52:41 -0700
Message-Id: <1339098761-9955-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33601
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

Enable PCI,MSI and Ethernet drivers.  Arbitrarily set page size to 16K

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/configs/cavium-octeon_defconfig |  167 +++++++++++++++++++++++------
 1 files changed, 133 insertions(+), 34 deletions(-)

diff --git a/arch/mips/configs/cavium-octeon_defconfig b/arch/mips/configs/cavium-octeon_defconfig
index 75165df..357e78e 100644
--- a/arch/mips/configs/cavium-octeon_defconfig
+++ b/arch/mips/configs/cavium-octeon_defconfig
@@ -1,38 +1,48 @@
 CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD=y
+CONFIG_CAVIUM_CN63XXP1=y
 CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=2
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_FORCE_MAX_ZONEORDER=14
 CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_SMP=y
-CONFIG_PREEMPT=y
+CONFIG_NR_CPUS=32
+CONFIG_HZ_1000=y
 CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_FHANDLE=y
+CONFIG_IRQ_DOMAIN_DEBUG=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_LOG_BUF_SHIFT=16
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
+CONFIG_XFRM_USER=m
+CONFIG_NET_KEY=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
@@ -41,53 +51,142 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
 # CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
+# CONFIG_IPV6_SIT is not set
+CONFIG_BRIDGE=m
+# CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_SLRAM=y
+CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
-# CONFIG_MISC_DEVICES is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=500000
+CONFIG_EEPROM_AT24=m
+CONFIG_EEPROM_AT25=m
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+# CONFIG_SATA_PMP is not set
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_SIL24=y
+CONFIG_PATA_OCTEON_CF=y
+# CONFIG_ATA_BMDMA is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_INPUT is not set
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
+# CONFIG_NET_VENDOR_MICROCHIP is not set
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
+CONFIG_MARVELL_PHY=y
+CONFIG_BROADCOM_PHY=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
+CONFIG_SERIAL_8250_NR_UARTS=6
+CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA9541=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_OCTEON=y
+CONFIG_SPI=y
+CONFIG_SENSORS_TMP421=y
+CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
-# CONFIG_USB_SUPPORT is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OCTEON_EHCI=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_LIBUSUAL=y
+CONFIG_MMC=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_STAGING=y
+CONFIG_OCTEON_ETHERNET=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
-# CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_NLS=y
+CONFIG_HUGETLBFS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
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
+# CONFIG_FTRACE is not set
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.2.3
