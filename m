Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:50:28 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34033 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024613AbcCAAsiK2Kx8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:38 +0100
Received: by mail-pa0-f67.google.com with SMTP id yy13so9429873pab.1;
        Mon, 29 Feb 2016 16:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6DPZvnRCZJsrd3lEowyPzxuY2fvIj2S/U5BA6/Dy3AE=;
        b=JO88DfUMfDImRdkS+6GlOwIX5dd+p8m70VXggRrsQSHMRah1qNJKo9WxJWEsFXZ63k
         +k05OgOLI46g+C4bKvmjS8si2HlRbps89sTeN62hRICF2dHlGdxI5GmxIKmLT6RYnvE1
         oQP4eDbFf9/o+5DwjHqEdvNHRx6RF9aIJ0SrMJ8kPEHZ8gX7l55EDgSp2mO3L97C4xat
         7XY+4lpAlYA/Yv2363ie5C2GDZwP0hmJZPqYjdttp0rDtD2bFL8J9/u1DDQf9cSI1CXX
         UZsmQD7xa6OVYtC5UqZyvj60CPjtyZEtousZ56LOgeYBendB3Hkqw6u6JTtv9Jgeurnu
         6m3w==
X-Gm-Message-State: AD7BkJJjj42dyoKaAXO44PqHw9rjLGsq7yCAaEM01tl+rkwSERuksYkSLUaDV30IN2mdXw==
X-Received: by 10.67.12.175 with SMTP id er15mr26141742pad.70.1456793312498;
        Mon, 29 Feb 2016 16:48:32 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:32 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 8/8] MIPS: Loongson: Add a Loongson-1A default config file
Date:   Tue,  1 Mar 2016 08:48:16 +0800
Message-Id: <1456793296-17120-9-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/configs/ls1a_defconfig | 132 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 arch/mips/configs/ls1a_defconfig

diff --git a/arch/mips/configs/ls1a_defconfig b/arch/mips/configs/ls1a_defconfig
new file mode 100644
index 0000000..a3069f8
--- /dev/null
+++ b/arch/mips/configs/ls1a_defconfig
@@ -0,0 +1,132 @@
+CONFIG_MACH_LOONGSON32=y
+CONFIG_ZONE_DMA=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_HIGHMEM=y
+CONFIG_HZ_1000=y
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_EXPERT=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
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
+CONFIG_BRIDGE=y
+# CONFIG_BRIDGE_IGMP_SNOOPING is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_NFTL=y
+CONFIG_NFTL_RW=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_SATA_PMP is not set
+CONFIG_SATA_AHCI_PLATFORM=y
+# CONFIG_ATA_SFF is not set
+CONFIG_NETDEVICES=y
+CONFIG_NETCONSOLE=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_REALTEK_PHY=y
+# CONFIG_USB_NET_DRIVERS is not set
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
+CONFIG_I2C=y
+CONFIG_SPI=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_USB=y
+CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=m
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=m
+CONFIG_USB_GADGET=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PCF8563=y
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
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_XZ_DEC=y
-- 
1.9.1
