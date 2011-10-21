Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2011 12:30:30 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:62944 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491199Ab1JUK3u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2011 12:29:50 +0200
Received: by ggnk3 with SMTP id k3so4279684ggn.36
        for <multiple recipients>; Fri, 21 Oct 2011 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dC7gHk53Q7qGT25rNxzUsIZvmPTAu3H4XPnpykdjtxM=;
        b=wJ9Z2Odey1fXUnOpViBxzIXNkJ9jqjm2J8F8V0W4cApXlu6aF8RTzys25IRGWNPatf
         cUhDAeJd/r0lM3cCAgcNMEhUK3FaSvZixIf3K5AxXL+ExOH76dcPUPtJpYt6SfyXZTQ5
         j/eo/L1zsHxZbCan9Nd8n/OtgdDEBd1HnuyJ8=
Received: by 10.43.43.130 with SMTP id uc2mr11930762icb.35.1319192967298;
        Fri, 21 Oct 2011 03:29:27 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id l28sm31920244ibc.3.2011.10.21.03.29.16
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 03:29:26 -0700 (PDT)
From:   keguang.zhang@gmail.com
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, wuzhangjin@gmail.com, r0bertz@gentoo.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V2 4/4] MIPS: Add defconfig for Loongson1B
Date:   Fri, 21 Oct 2011 18:28:08 +0800
Message-Id: <1319192888-21465-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com>
References: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 31261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15643

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds defconfig for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/configs/ls1b_defconfig |   89 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/configs/ls1b_defconfig

diff --git a/arch/mips/configs/ls1b_defconfig b/arch/mips/configs/ls1b_defconfig
new file mode 100644
index 0000000..9294ea0
--- /dev/null
+++ b/arch/mips/configs/ls1b_defconfig
@@ -0,0 +1,89 @@
+CONFIG_MACH_LOONGSON1=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_TINY_RCU=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_NETDEVICES=y
+CONFIG_STMMAC_ETH=y
+CONFIG_STMMAC_DA=y
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_LEGACY_PTY_COUNT=8
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_RAMOOPS=y
+# CONFIG_HWMON is not set
+# CONFIG_MFD_SUPPORT is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_FTRACE is not set
+# CONFIG_EARLY_PRINTK is not set
-- 
1.7.1
