Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2016 15:30:01 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34667 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028728AbcFVN373nZeO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jun 2016 15:29:59 +0200
Received: by mail-lf0-f67.google.com with SMTP id l184so13851585lfl.1;
        Wed, 22 Jun 2016 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DZxFYjQEijlLoV0DtZdH/o+rLiuss3SlztLSjJ5ii0w=;
        b=qE+Ce3l4H3eDTRQYoBdA2JycOF1xn53K7MkL3RBabjmR2jpoCSpuMqSVXZLhDe1OPh
         AfPRRleH2CcDKWi3lnpOmDz4GWWrrwDvkx6g/mBasAOMxlelBMAYjOP0sVpmu7gr8mAx
         J8s8Yj3DY79CuO9UcjhCcLPNeero3WCH5aJvzKIXl+sV8tgEo+JD41cjiSCcv6gNFRhQ
         gN9fHaHk63wUn2YkqnAK4nLU87RatvhJn+TwSYCA5imTKYk5iUzWhkpQdNvNpN58bAJd
         +fjO+5fBXXGFQ9ast/n58uZDLSuqwArxBYTMWI1WBbLH7AfvdjK7+kNj5fp/6u1fTcCn
         MZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DZxFYjQEijlLoV0DtZdH/o+rLiuss3SlztLSjJ5ii0w=;
        b=k96uu3/vgHgp/wEgXZfy98jHt5nMLktZDDiSaCzS106LCKpgZ44DMu22Pbc5m6o+co
         WJnPcDz4Kw+448jYYzupLdbN7Y+lAph6wSYs48Gu2zqQL0setIfNEIgtDUyTd46TyMNk
         A0ML9mmtFje4RO44IIuIfyYhEVTLBm+xbGdcThviNlqL1LQr9bkr5h8el2Gj7C5KIbUv
         7Dyecmmo/JNhrMFfLhTzPdLFPlyeIuFbebohlaFiw6cn4xgoRufW6yQK0qX0LVxxVV3s
         VMyMxEsxjXXm4grC2YIPjOVXIhia+2m3zTW1C6xq3EUr4jO2SA5tCvZOA0Hdd+zEJits
         UjGA==
X-Gm-Message-State: ALyK8tJZLYPR1lNGJd+F1Z7M4bKsGY7dR9GKV2Mn65hJqn1GvneGvLudocvrPBstFMjNKA==
X-Received: by 10.25.143.149 with SMTP id r143mr9578867lfd.165.1466602193545;
        Wed, 22 Jun 2016 06:29:53 -0700 (PDT)
Received: from localhost.localdomain ([213.129.100.75])
        by smtp.gmail.com with ESMTPSA id n1sm34841lbw.46.2016.06.22.06.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jun 2016 06:29:51 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: add default configuration for ath25
Date:   Wed, 22 Jun 2016 16:29:44 +0300
Message-Id: <1466602184-16265-1-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.7.3
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Looks like I forget it during initial submission.

 arch/mips/configs/ath25_defconfig | 119 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 arch/mips/configs/ath25_defconfig

diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
new file mode 100644
index 0000000..2c82995
--- /dev/null
+++ b/arch/mips/configs/ath25_defconfig
@@ -0,0 +1,119 @@
+CONFIG_ATH25=y
+# CONFIG_COMPACTION is not set
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+# CONFIG_FHANDLE is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_IPV6 is not set
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
+CONFIG_MAC80211_DEBUGFS=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-2
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
+# CONFIG_MTD_CFI_I2 is not set
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_NETDEVICES=y
+# CONFIG_ETHERNET is not set
+# CONFIG_WLAN_VENDOR_ADMTEK is not set
+CONFIG_ATH5K=m
+# CONFIG_WLAN_VENDOR_ATMEL is not set
+# CONFIG_WLAN_VENDOR_BROADCOM is not set
+# CONFIG_WLAN_VENDOR_CISCO is not set
+# CONFIG_WLAN_VENDOR_INTEL is not set
+# CONFIG_WLAN_VENDOR_INTERSIL is not set
+# CONFIG_WLAN_VENDOR_MARVELL is not set
+# CONFIG_WLAN_VENDOR_MEDIATEK is not set
+# CONFIG_WLAN_VENDOR_RALINK is not set
+# CONFIG_WLAN_VENDOR_REALTEK is not set
+# CONFIG_WLAN_VENDOR_RSI is not set
+# CONFIG_WLAN_VENDOR_ST is not set
+# CONFIG_WLAN_VENDOR_TI is not set
+# CONFIG_WLAN_VENDOR_ZYDAS is not set
+CONFIG_INPUT=m
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_PCI is not set
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_VGA_ARB is not set
+CONFIG_USB=m
+CONFIG_USB_EHCI_HCD=m
+CONFIG_LEDS_CLASS=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+# CONFIG_JFFS2_FS_POSIX_ACL is not set
+# CONFIG_JFFS2_FS_SECURITY is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+# CONFIG_JFFS2_ZLIB is not set
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_FILE_DIRECT=y
+CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
+# CONFIG_SQUASHFS_ZLIB is not set
+CONFIG_SQUASHFS_XZ=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
-- 
2.7.3
