Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2012 08:09:26 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42524 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902235Ab2GYGHE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2012 08:07:04 +0200
Received: by pbbrq13 with SMTP id rq13so940719pbb.36
        for <multiple recipients>; Tue, 24 Jul 2012 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E/+6Npb6c1lMdENGLTk3c2o9fCzoE8HiXHGWv6gfPsY=;
        b=wYy7hZFtVwSUPbDpkukOl2bR77uBYuhUTlFTI0FkrYi1UM2Kr8lwZBcGpBNH4IRMfg
         8dVjZUbNbH/f29Xng6TXqosfSdBGuKQK8TLscP5CF5Cr3iXrWnXH3JyHTI/P9FCH8ut5
         o6oiGNupGsrS0yLSHYqO7QrRCvYWk7weZdG2iLxWo6GpPaIjur3e2rKbsXEGNsm/yiWt
         cQ5Nnnb5KbsltKBVhYXtox7/SDcngShSiQHqydyifVrLl8zld5n7b7AE9Gax8cVHulHp
         bYZbz37Vfrh4Uz3fMebRG7z2vywCh4aecoxOC+DtCtykZQ4xc0z64URzv2Iw64MbYvUe
         fqoA==
Received: by 10.68.193.196 with SMTP id hq4mr9346572pbc.76.1343196418040;
        Tue, 24 Jul 2012 23:06:58 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id pj10sm13694271pbb.46.2012.07.24.23.06.54
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:06:57 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     wuzhangjin@gmail.com, zhzhl555@gmail.com,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V7 4/4] (Updated) MIPS: Add defconfig for Loongson1B
Date:   Wed, 25 Jul 2012 14:06:41 +0800
Message-Id: <1343196401-6435-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1343196401-6435-1-git-send-email-keguang.zhang@gmail.com>
References: <1343196401-6435-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 33985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

This patch adds defconfig for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V7(updated):
	Add CONFIG_USB_ANNOUNCE_NEW_DEVICES in default
	configuration.
---
 arch/mips/configs/ls1b_defconfig |  109 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/configs/ls1b_defconfig

diff --git a/arch/mips/configs/ls1b_defconfig b/arch/mips/configs/ls1b_defconfig
new file mode 100644
index 0000000..80cff8b
--- /dev/null
+++ b/arch/mips/configs/ls1b_defconfig
@@ -0,0 +1,109 @@
+CONFIG_MACH_LOONGSON1=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_EXPERT=y
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
+CONFIG_SCSI=m
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=m
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
+CONFIG_STMMAC_DA=y
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+CONFIG_INPUT_EVDEV=y
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
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_USB_HID=m
+CONFIG_HID_GENERIC=m
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_STORAGE=m
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_PL2303=m
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
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
+# CONFIG_EARLY_PRINTK is not set
-- 
1.7.1
