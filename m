Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2014 03:50:30 +0100 (CET)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:55905 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870558AbaAHCrGe7aDa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jan 2014 03:47:06 +0100
Received: by mail-pb0-f45.google.com with SMTP id rp16so957688pbb.18
        for <multiple recipients>; Tue, 07 Jan 2014 18:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cugjZnrEX8QrJU7K+RcP5QPevpC8LjiqsEPKr5lO9gI=;
        b=LCEkgb75x23PmKoH1Wrs4nojefO3f5gDp0ME+9dfeCI31fDiQuntmMBIXBUGR/7xBv
         YP+mJGSgoewTNJMJ0Bw48ai7xuOZ5ijLYSUppHayMjCZRAE6ruHJFcqHVU5aJS4SyGT7
         24/5uDROzkZg82vlDXvzxSYVA3Xy1z7KIFKSTrJRDbWe+N1jLvmK927RG1SlXD7qQ+EK
         6/rhOJVBJxwGUz2I+zS23gXf+j3m3QyjC+NAI3tDJu7VwCuEgcPJk6qmicIZd5J3U42P
         WBhF4MXKWuppOJB/sF8VdRaibSG3U/PjwsJSq/F0LJi3MdOsUqm0FHHkehpYNE92GibV
         bzAQ==
X-Received: by 10.66.65.134 with SMTP id x6mr9270014pas.12.1389149220191;
        Tue, 07 Jan 2014 18:47:00 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id fm1sm44515266pab.22.2014.01.07.18.46.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jan 2014 18:46:59 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V16 12/12] MIPS: Loongson: Add a Loongson-3 default config file
Date:   Wed,  8 Jan 2014 10:44:28 +0800
Message-Id: <1389149068-24376-13-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/configs/loongson3_defconfig |  342 +++++++++++++++++++++++++++++++++
 1 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/configs/loongson3_defconfig

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
new file mode 100644
index 0000000..65dfe57
--- /dev/null
+++ b/arch/mips/configs/loongson3_defconfig
@@ -0,0 +1,342 @@
+CONFIG_MACH_LOONGSON=y
+CONFIG_SWIOTLB=y
+CONFIG_LEMOTE_MACH3A=y
+CONFIG_CPU_LOONGSON3=y
+CONFIG_64BIT=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_KSM=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HZ_256=y
+CONFIG_PREEMPT=y
+CONFIG_KEXEC=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_KERNEL_LZMA=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CPUSETS=y
+CONFIG_RESOURCE_COUNTERS=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_SWAP=y
+CONFIG_BLK_CGROUP=y
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_BLK_DEV_INTEGRITY=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_IOSCHED_DEADLINE=m
+CONFIG_CFQ_GROUP_IOSCHED=y
+CONFIG_PCI=y
+CONFIG_HT_PCI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_HOTPLUG_PCI_PCIE=y
+# CONFIG_PCIEAER is not set
+CONFIG_PCIEASPM_PERFORMANCE=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_HOTPLUG_PCI_SHPC=m
+CONFIG_BINFMT_MISC=m
+CONFIG_MIPS32_COMPAT=y
+CONFIG_MIPS32_O32=y
+CONFIG_MIPS32_N32=y
+CONFIG_PM_RUNTIME=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_LOG=m
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_DCCP=m
+CONFIG_NETFILTER_XT_MATCH_ESP=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MARK=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
+CONFIG_NETFILTER_XT_MATCH_REALM=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_IP_VS=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_AH=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+CONFIG_IP_SCTP=m
+CONFIG_L2TP=m
+CONFIG_BRIDGE=m
+CONFIG_CFG80211=m
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=m
+CONFIG_RFKILL=m
+CONFIG_RFKILL_INPUT=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=m
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_RAID_ATTRS=m
+CONFIG_SCSI_TGT=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_CHR_DEV_SCH=m
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SPI_ATTRS=m
+CONFIG_SCSI_FC_ATTRS=m
+CONFIG_SCSI_ISCSI_ATTRS=m
+CONFIG_MEGARAID_NEWGEN=y
+CONFIG_MEGARAID_MM=y
+CONFIG_MEGARAID_MAILBOX=y
+CONFIG_MEGARAID_LEGACY=y
+CONFIG_MEGARAID_SAS=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_PATA_ATIIXP=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=m
+CONFIG_DM_CRYPT=m
+CONFIG_DM_SNAPSHOT=m
+CONFIG_DM_MIRROR=m
+CONFIG_DM_ZERO=m
+CONFIG_NETDEVICES=y
+CONFIG_TUN=m
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+# CONFIG_NET_VENDOR_HP is not set
+CONFIG_E1000=y
+CONFIG_E1000E=y
+CONFIG_IGB=y
+CONFIG_IXGB=y
+CONFIG_IXGBE=y
+# CONFIG_NET_VENDOR_I825XX is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+# CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_NET_PACKET_ENGINE is not set
+# CONFIG_NET_VENDOR_QLOGIC is not set
+CONFIG_8139CP=m
+CONFIG_8139TOO=m
+CONFIG_R8169=y
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_TOSHIBA is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOE=m
+CONFIG_PPPOL2TP=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_ATH_CARDS=m
+CONFIG_ATH9K=m
+CONFIG_HOSTAP=m
+CONFIG_INPUT_POLLDEV=m
+CONFIG_INPUT_SPARSEKMAP=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_XTKBD=m
+CONFIG_MOUSE_PS2_SENTELIC=y
+CONFIG_MOUSE_SERIAL=m
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=m
+CONFIG_SERIO_SERPORT=m
+CONFIG_SERIO_RAW=m
+CONFIG_LEGACY_PTY_COUNT=16
+CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=16
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_HW_RANDOM=y
+CONFIG_RAW_DRIVER=m
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_PIIX4=y
+CONFIG_SENSORS_LM75=m
+CONFIG_SENSORS_LM93=m
+CONFIG_SENSORS_W83627HF=m
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
+CONFIG_DRM=y
+CONFIG_DRM_RADEON=y
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_FB_RADEON=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_PLATFORM=m
+CONFIG_BACKLIGHT_GENERIC=m
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
+CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=m
+CONFIG_SND_SEQUENCER=m
+CONFIG_SND_SEQ_DUMMY=m
+# CONFIG_SND_ISA is not set
+CONFIG_SND_HDA_INTEL=m
+CONFIG_SND_HDA_PATCH_LOADER=y
+# CONFIG_SND_USB is not set
+CONFIG_HID_A4TECH=m
+CONFIG_HID_SUNPLUS=m
+CONFIG_USB=y
+CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=m
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_UHCI_HCD=m
+CONFIG_USB_STORAGE=m
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_OPTION=m
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_DMADEVICES=y
+CONFIG_PM_DEVFREQ=y
+CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
+CONFIG_DEVFREQ_GOV_PERFORMANCE=y
+CONFIG_DEVFREQ_GOV_POWERSAVE=y
+CONFIG_DEVFREQ_GOV_USERSPACE=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_QUOTA=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=936
+CONFIG_FAT_DEFAULT_IOCHARSET="gb2312"
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CRAMFS=m
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_NFS_FS=m
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=m
+CONFIG_NFSD=m
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
+CONFIG_CIFS=m
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_936=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_FRAME_WARN=1024
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_RCU_CPU_STALL_VERBOSE is not set
+# CONFIG_FTRACE is not set
+CONFIG_SECURITY=y
+CONFIG_SECURITYFS=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_PATH=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_SELINUX_BOOTPARAM=y
+CONFIG_SECURITY_SELINUX_DISABLE=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_CRYPTO_AUTHENC=m
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_WP512=m
+CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_BLOWFISH=m
+CONFIG_CRYPTO_CAST5=m
+CONFIG_CRYPTO_CAST6=m
+CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_SERPENT=m
+CONFIG_CRYPTO_TEA=m
+CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_DEFLATE=m
-- 
1.7.7.3
