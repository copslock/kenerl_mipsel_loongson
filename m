Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2012 21:03:19 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:48332 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1901341Ab2AVUDN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2012 21:03:13 +0100
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.ottawa.windriver.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0MK30ZP017584;
        Sun, 22 Jan 2012 12:03:00 -0800 (PST)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH] mips: fix netlogic defconfigs for coverage builds
Date:   Sun, 22 Jan 2012 15:02:46 -0500
Message-Id: <1327262566-2676-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.7.2
X-archive-position: 32311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The toolchain prefix will most likely be site specific and is
not guaranteed to always be "mips-linux-gnu-", so simply don't
specify one.  A quick "git grep" shows this to be consistent
amongst other cross compiled targets.

Similarly, the site specific initramfs source location should not
be used, since that won't exist for most people, and it prevents
them from doing coverage builds on the defconfigs, such as those
done in linux-next and run routinely by many others.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Jayachandran C <jayachandranc@netlogicmicro.com>

diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index 4479fd6..28c6b27 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -8,7 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 # CONFIG_SECCOMP is not set
 CONFIG_USE_OF=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="mips-linux-gnu-"
+CONFIG_CROSS_COMPILE=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -22,7 +22,7 @@ CONFIG_AUDIT=y
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="usr/dev_file_list usr/rootfs.xlp"
+CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_INITRAMFS_COMPRESSION_LZMA=y
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 7c68666..d0b857d 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -8,7 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_KEXEC=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="mips-linux-gnu-"
+CONFIG_CROSS_COMPILE=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -22,7 +22,7 @@ CONFIG_AUDIT=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="usr/dev_file_list usr/rootfs.xlr"
+CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_INITRAMFS_COMPRESSION_GZIP=y
-- 
1.7.7.2
