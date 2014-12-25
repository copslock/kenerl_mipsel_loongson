Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:03:38 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37976 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009170AbaLYR5kNabWp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:40 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so12010798pab.19;
        Thu, 25 Dec 2014 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XeOgnXoJ+SkczN5tpP42QlQwfsPhKf6trlt4e1N6NHc=;
        b=iYTI3payEsC2H1i+LLgi6YVO0nG+tzhmhDYg+rulSujS7tMofygEEnSCeGT8Z/6KEC
         VCRvsLv4q1w5pqaSS7OhY/MPd9xDYpcR/1V+rS1vWY6UlKRWoGWWPKuBaPyZa0vN0+Lq
         950WQ2i2FzUBm4N6QXjqEdTnk97pJvJ5aP6E/2seR5mMtQbymZKX5fzDONaW3EseVHm3
         Zern6QZI1bBwj47QQ93QqFyIdnWt9ug0qs29G2sV9l/ys1+YUgErUo6Qb0BKV9WBWYGl
         WwD8rpUkFS7lFGsiEPYKoNNw91bw7jXvECd2vyWWUztN2JbXFJZtusuPUbr0D5CubucQ
         MZVA==
X-Received: by 10.70.137.238 with SMTP id ql14mr63533307pdb.94.1419530254422;
        Thu, 25 Dec 2014 09:57:34 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.32
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:33 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 22/25] MIPS: BMIPS: Enable additional peripheral and CPU support in defconfig
Date:   Thu, 25 Dec 2014 09:49:17 -0800
Message-Id: <1419529760-9520-23-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Also, add an LE defconfig for set-top box (BCM7xxx).  This will allow the
BMIPS kernel to run on several non-BCM3384 platforms.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/Kconfig                     | 18 +++++--
 arch/mips/configs/bmips_be_defconfig  |  9 +++-
 arch/mips/configs/bmips_stb_defconfig | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/configs/bmips_stb_defconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d28c29e..6f53dda 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -139,17 +139,25 @@ config BMIPS_GENERIC
 	select CSRC_R4K
 	select SYNC_R4K
 	select COMMON_CLK
-	select DMA_NONCOHERENT
+	select BCM7038_L1_IRQ
+	select BCM7120_L2_IRQ
+	select BRCMSTB_L2_IRQ
 	select IRQ_CPU
+	select RAW_IRQ_ACCESSORS
+	select DMA_NONCOHERENT
 	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_CPU_BMIPS32_3300
+	select SYS_HAS_CPU_BMIPS4350
+	select SYS_HAS_CPU_BMIPS4380
 	select SYS_HAS_CPU_BMIPS5000
 	select SWAP_IO_SPACE
-	select USB_EHCI_BIG_ENDIAN_DESC
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	select USB_OHCI_BIG_ENDIAN_DESC
-	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index 36af5af..f5585c8 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -33,6 +33,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_BRCMSTB_GISB_ARB=y
 CONFIG_MTD=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -43,15 +44,19 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_BCMGENET=y
 CONFIG_USB_USBNET=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_EARLYCON_FORCE=y
 CONFIG_SERIAL_BCM63XX=y
 CONFIG_SERIAL_BCM63XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_BRCMSTB=y
+CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
@@ -75,4 +80,6 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon"
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
new file mode 100644
index 0000000..400a47e
--- /dev/null
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -0,0 +1,88 @@
+CONFIG_BMIPS_GENERIC=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_HIGHMEM=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_O32_FP64_SUPPORT=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_NO_HZ=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+CONFIG_EXPERT=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_CFG80211=y
+CONFIG_NL80211_TESTMODE=y
+CONFIG_MAC80211=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_BRCMSTB_GISB_ARB=y
+CONFIG_MTD=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_BLK_DEV is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+CONFIG_BCMGENET=y
+CONFIG_USB_USBNET=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_BRCMSTB=y
+CONFIG_POWER_RESET_SYSCON=y
+# CONFIG_HWMON is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_FUSE_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_CIFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon"
+# CONFIG_CRYPTO_HW is not set
-- 
2.1.1
