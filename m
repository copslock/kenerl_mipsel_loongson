Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2011 12:41:42 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:39852 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903655Ab1LPLkP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2011 12:40:15 +0100
Received: by mail-iy0-f177.google.com with SMTP id k27so3443602iad.36
        for <multiple recipients>; Fri, 16 Dec 2011 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SCZjSw/HO31rkAl/VE41iAheXjO5Ur5fER4+fLv00dQ=;
        b=gwB+xiNayxaXNl8MWkLijwBAWaWAZocD8HtD1wT04dyfId2+frvcE5UI8vruDCPt7Y
         nzqmYZIQTV6Hm0tMc3p/vlmZjIvZLJ/47/cJIMMfpgeoJskntl3yGgaRqauI6o8aTqYX
         9WREqvmtmJ66jlNHXBQhwI2dNHPfiW4UHYUQ0=
Received: by 10.50.51.234 with SMTP id n10mr8308241igo.10.1324035614570;
        Fri, 16 Dec 2011 03:40:14 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id wo4sm14335289igc.5.2011.12.16.03.40.07
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 03:40:14 -0800 (PST)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     zhzhl555@gmail.com, peppe.cavallaro@st.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V5 4/4] MIPS: Add defconfig for Loongson1B
Date:   Fri, 16 Dec 2011 19:39:04 +0800
Message-Id: <1324035544-2373-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1324035544-2373-1-git-send-email-keguang.zhang@gmail.com>
References: <1324035544-2373-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 32110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13180

This patch adds defconfig for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/configs/ls1b_defconfig |   90 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/configs/ls1b_defconfig

diff --git a/arch/mips/configs/ls1b_defconfig b/arch/mips/configs/ls1b_defconfig
new file mode 100644
index 0000000..42954bc
--- /dev/null
+++ b/arch/mips/configs/ls1b_defconfig
@@ -0,0 +1,90 @@
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
+# CONFIG_HWMON is not set
+# CONFIG_MFD_SUPPORT is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_LOONGSON1=y
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
