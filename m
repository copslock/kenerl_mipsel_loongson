Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:52:05 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63547 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825714Ab2JWRsKh0JTM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:10 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520872lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ov3w8UH/CSJPcUiTpZQZFT+83rmXPGxdeaxqVZCYXHo=;
        b=izQNVs8x/E+h+Sm6/bKGsIuY1wjyiKwoxe+/mpg9xsAcheJ5sgIZSCTiag7aDthq11
         CN+B0c6xJQO74q4aTEmzc1zZtE/XDNF0RbR6FWPHE5uw+Nw6ZeTA8Ar9zQ3lkml6X0vG
         0ys7wudhDE/94BmRMD2wJDSAM5PTpr44HVNUfsnj5iVxXvDNRxypcc2piTgQ3OqTTZmM
         nWbYknc9+t7uqEVRk3oMhsZEHkxbHJBHKlzGpT1D23VQ2dPnG1BKoUplbY7FLDQ/XbWI
         SA2lhuhpaVsHAdJ1kPSMBy32auc1+JdlQvQJu7aD0R2LkP28O6+XlwQs6J5S4PM9wGEo
         oviw==
Received: by 10.112.103.135 with SMTP id fw7mr5303148lbb.16.1351014490088;
        Tue, 23 Oct 2012 10:48:10 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:09 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 13/13] MIPS: rzx50: Add defconfig file
Date:   Tue, 23 Oct 2012 21:44:01 +0400
Message-Id: <1351014241-3207-14-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/configs/ritmix-rzx50_defonfig |   63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 arch/mips/configs/ritmix-rzx50_defonfig

diff --git a/arch/mips/configs/ritmix-rzx50_defonfig b/arch/mips/configs/ritmix-rzx50_defonfig
new file mode 100644
index 0000000..fc392f5
--- /dev/null
+++ b/arch/mips/configs/ritmix-rzx50_defonfig
@@ -0,0 +1,63 @@
+CONFIG_MACH_JZ4750D=y
+CONFIG_HZ_100=y
+CONFIG_KEXEC=y
+# CONFIG_SECCOMP is not set
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="/home/antony/git/gcwnow-buildroot.git/output/images/rootfs.cpio"
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
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
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_NETDEVICES=y
+# CONFIG_ETHERNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_LEGACY_PTY_COUNT=2
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_FTRACE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="mem=64M root=/dev/loop0 ro rdinit=/bin/sh console=ttyS1,57600 panic=3"
+CONFIG_CMDLINE_OVERRIDE=y
-- 
1.7.10.4
