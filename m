Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 06:32:13 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33940 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030577AbcESEcL5uLOm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 06:32:11 +0200
Received: by mail-pf0-f193.google.com with SMTP id 145so6907187pfz.1;
        Wed, 18 May 2016 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PzsFVQdHSAPqVaJPLz3mKZi6Lb4RMfiYGXPEDX5X7dg=;
        b=nopbQQ/SpXK66katZSXdMVFDVWtqXpp6eHCQrZ2kdQ9trbYSG8XqGeokK2YhTkg7G2
         VQVmQIg2qBi/07odKJhOoui8M2rDV3GP2tKF9Dv+4W4FFJtGZrljlVDNA9B14xUpw+1G
         AXzqT6sc5yrRtu/7XZN0KNTOyPYsmmrKNZgQGgDaj79880OKkrHurckFctkUtEChPKfB
         0oQlWDvC8SGV9RDkN+KwNV16dyNaqvYWN4EB5kgp3k0tC59bILNJ3IBZ6d1OdLmedwqY
         FwuGci6ROA/0Sb2+/VDx8Tx7fN/FoTOmfKQPwU/TRb5sBilsPZllUcz+2I2fR+jot5Sr
         WN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PzsFVQdHSAPqVaJPLz3mKZi6Lb4RMfiYGXPEDX5X7dg=;
        b=CyVeGvQeL0vC2PvED+WyBtNECZoBlfBX8WSRj0rtjVMbX3Ob1D30xQvw1eQ2ko9GPA
         8+Ju+b6p1paiLe40HBJqq7CMpuFkJTQ6qJwj/RsqnWxDl5/jQ1uLP4NNyFWLA7hD3hUL
         ashpvsRYAS5nZp8EUveP5L31MXRUU+I1XVc2B9yAmizt31WL1qBtuZv8lENlX7qTm7se
         qN8N+nMcRM/tfluoTm48u3x6N0jpGMLV+dmP7FHWd2t2jS7zKzmlp92OZgSehQ4nzdp4
         ucSk7SAshaMwcDyKpTR61+JkALwleeJYn2aS6MZO8+NkYdxNrPyECzbNjq/TOFVC0DIF
         Bkfg==
X-Gm-Message-State: AOPr4FU9IPUmD85HPLNKyBs/kyvOPJdgJOrjVZ+kSsa1J3EV1cVGmg+Qd6/rtRb6SGPfhw==
X-Received: by 10.98.34.141 with SMTP id p13mr16402459pfj.156.1463632326330;
        Wed, 18 May 2016 21:32:06 -0700 (PDT)
Received: from ly-pc (li734-185.members.linode.com. [106.185.31.185])
        by smtp.gmail.com with ESMTPSA id 64sm15767716pfk.69.2016.05.18.21.32.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 21:32:05 -0700 (PDT)
Date:   Thu, 19 May 2016 12:31:57 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org
Cc:     keguang.zhang@gmail.com, chenhc@lemote.com, gnaygnil@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 4/4] MIPS: Loongson1C: Add defconfig
Message-ID: <20160519043150.GA5415@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Add defconfig file for Loongson1C

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/configs/loongson1c_defconfig | 126 +++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 arch/mips/configs/loongson1c_defconfig

diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
new file mode 100644
index 0000000..2304d41
--- /dev/null
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -0,0 +1,126 @@
+CONFIG_MACH_LOONGSON32=y
+CONFIG_LOONGSON1_LS1C=y
+CONFIG_PREEMPT=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_NAMESPACES=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_LOONGSON1=y
+CONFIG_MTD_UBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_SCSI=m
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=m
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
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
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_LOONGSON1=y
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_HID_GENERIC=m
+CONFIG_USB_HID=m
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=m
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
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
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
+CONFIG_UBIFS_ATIME_SUPPORT=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_ISO8859_1=m
+CONFIG_DYNAMIC_DEBUG=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
+# CONFIG_EARLY_PRINTK is not set
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
-- 
1.9.1
