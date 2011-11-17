Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 10:41:40 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:42636 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904026Ab1KQJkm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 10:40:42 +0100
Received: by mail-yw0-f49.google.com with SMTP id 31so955238ywp.36
        for <multiple recipients>; Thu, 17 Nov 2011 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cqRzHIKYaqihpkAPwB/zJcDTTNgImoX3J97yOnVSx8Q=;
        b=mcmFihUReSI22HGjuL1j7kTwa4uKGcyzeTePvpcD9394HkDTw4YkuNo+pg9aXenESt
         QsoQyVX7nEeTydRcNmumi1q36O8LgyzLeq0LmfOst8Hyv4F8Bu2wUaZ9FDvhstOYEHMR
         yux5k8pNGPaQZbXMjE/+2OP7AZ5m4VOMWt5Gs=
Received: by 10.236.191.198 with SMTP id g46mr7600528yhn.118.1321522841682;
        Thu, 17 Nov 2011 01:40:41 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id j25sm5198496yhm.12.2011.11.17.01.40.28
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:40:41 -0800 (PST)
From:   keguang.zhang@gmail.com
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, zhzhl555@gmail.com, peppe.cavallaro@st.com,
        wuzhangjin@gmail.com, r0bertz@gentoo.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V3 5/5] MIPS: Add defconfig for Loongson1B
Date:   Thu, 17 Nov 2011 17:39:08 +0800
Message-Id: <1321522748-21391-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1321522748-21391-1-git-send-email-keguang.zhang@gmail.com>
References: <1321522748-21391-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 31718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14295

From: Kelvin Cheung <keguang.zhang@gmail.com>

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
