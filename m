Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 01:14:59 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:3333 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20037482AbWJKAO5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2006 01:14:57 +0100
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Tue, 10 Oct 2006 17:14:43 -0700
X-Server-Uuid: 8BFFF8BB-6D19-4612-8F54-AA4CE9D0539E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 9C2FA2AF; Tue, 10 Oct 2006 17:14:43 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 763722AE for
 <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:14:43 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHF36936; Tue, 10 Oct 2006 17:14:41 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 4EC5C20503 for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:14:41
 -0700 (PDT)
Received: from localhost.localdomain ([10.240.253.63]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 10 Oct 2006 17:14:40 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k9B0EuhS022802
 for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:15:02 -0700
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k9B0EoaP022801 for linux-mips@linux-mips.org;
 Tue, 10 Oct 2006 17:14:50 -0700
Date:	Tue, 10 Oct 2006 17:14:50 -0700
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Update bcm91480b (bigsur) defconfig
Message-ID: <20061011001450.GB22605@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 11 Oct 2006 00:14:41.0097 (UTC)
 FILETIME=[3EFD3B90:01C6ECCA]
X-WSS-ID: 6932E8F909W3300579-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips


Update the BCM91480B (bigsur) defconfig.  Turn off kernel message timestamps,
include common IDE support by default, tmpfs, n32 and other minor bits needed
to have a really useful default kernel configuration.

Signed-off-by: Mark Mason <mason@broadcom.com>

---
 arch/mips/configs/bigsur_defconfig |   52 +++++++++++++++++++++++++++--------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 887fd95..3c99f18 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:02:58 2006
+# Linux kernel version: 2.6.18-rc4
+# Tue Oct 10 10:39:34 2006
 #
 CONFIG_MIPS=y
 
@@ -186,6 +186,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
@@ -254,12 +255,10 @@ CONFIG_MMU=y
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
 
 #
 # PCI Hotplug Support
 #
-# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
@@ -270,7 +269,7 @@ # CONFIG_BUILD_ELF64 is not set
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_MIPS32_O32=y
-# CONFIG_MIPS32_N32 is not set
+CONFIG_MIPS32_N32=y
 CONFIG_BINFMT_ELF32=y
 
 #
@@ -367,7 +366,6 @@ # Generic Driver Options
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
@@ -403,7 +401,7 @@ # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -428,10 +426,39 @@ #
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
-# CONFIG_BLK_DEV_IDEPCI is not set
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+CONFIG_BLK_DEV_CMD64X=y
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
 # CONFIG_BLK_DEV_IDE_SWARM is not set
 # CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
 
@@ -728,6 +755,7 @@ # Graphics support
 #
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -840,7 +868,7 @@ #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -880,7 +908,6 @@ # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -905,7 +932,8 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
-CONFIG_PRINTK_TIME=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+# CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
-- 
1.1.6.g4e27f
