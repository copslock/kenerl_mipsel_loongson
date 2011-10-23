Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 15:46:27 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3030 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491030Ab1JWNoL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2011 15:44:11 +0200
X-TM-IMSS-Message-ID: <b9686e590004e560@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id b9686e590004e560 ; Sun, 23 Oct 2011 06:44:03 -0700
Date:   Sun, 23 Oct 2011 19:09:49 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 05/12] MIPS: Netlogic: Update default config
Message-ID: <20111023133944.GA24257@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Oct 2011 13:37:47.0456 (UTC) FILETIME=[F38C9C00:01CC9188]
X-archive-position: 31275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16582

- Enable PCI and MSI by default
- Update cross compile tool-chain and rootfs

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/configs/nlm_xlr_defconfig |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index e4b399f..7c68666 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -8,7 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_KEXEC=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="mips64-unknown-linux-gnu-"
+CONFIG_CROSS_COMPILE="mips-linux-gnu-"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -22,15 +22,13 @@ CONFIG_AUDIT=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="usr/dev_file_list usr/rootfs"
+CONFIG_INITRAMFS_SOURCE="usr/dev_file_list usr/rootfs.xlr"
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_INITRAMFS_COMPRESSION_GZIP=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_ELF_CORE is not set
-# CONFIG_PCSPKR_PLATFORM is not set
 # CONFIG_PERF_EVENTS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
@@ -39,6 +37,9 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_BLK_DEV_INTEGRITY=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM_RUNTIME=y
 CONFIG_PM_DEBUG=y
@@ -297,12 +298,10 @@ CONFIG_NET_ACT_SIMP=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_DCB=y
 CONFIG_NET_PKTGEN=m
-# CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 CONFIG_CONNECTOR=y
-CONFIG_MTD=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
@@ -339,6 +338,9 @@ CONFIG_SCSI_DH_EMC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_SCSI_OSD_INITIATOR=m
 CONFIG_SCSI_OSD_ULD=m
+CONFIG_NETDEVICES=y
+CONFIG_E1000E=y
+CONFIG_SKY2=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
@@ -443,7 +445,6 @@ CONFIG_CIFS_UPCALL=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_CIFS_DFS_UPCALL=y
-CONFIG_CIFS_EXPERIMENTAL=y
 CONFIG_NCP_FS=m
 CONFIG_NCPFS_PACKET_SIGNING=y
 CONFIG_NCPFS_IOCTL_LOCKING=y
@@ -516,7 +517,6 @@ CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_UNUSED_SYMBOLS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
-- 
1.7.4.1
