Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:14:00 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34704 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008611AbaLLWIvyXlJ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:51 +0100
Received: by mail-pa0-f54.google.com with SMTP id fb1so8005979pad.41
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=db2lmA0iALjZdjn4UxcQFLhySVWuPEHUXyIWFvLeKf8=;
        b=IK7cQCXgmfqwUrX8GlMrsVUdilxU4ijGxvJJ+zuKSwC8AKb28bnnWvdaV7a2xuD3e4
         00VS6K9G/ChtfW+ATwEYkNPhHafAiwDf4KtwP1aySnBxDdMOeX+9q/HH2K9YuPZxDC78
         ZtVStSXfIs9k8LH381J/OgplEOnPtwgKbrI/hQKaujlsV/pO8GoDlrL92bI5tsd4b+rJ
         Ac9hbQPDF6DZ5u50bNGrp1prkatGStyxsYyT5VAOzdp5/uytRqW77M09jNV6ch/t+F0A
         TJX1YHd2rdn+6V7QAiMHbQ4lwP4H+699ACR0td2r4tQntZ4em2TVAYLm4Jv+UunzdXxi
         G8uA==
X-Received: by 10.66.151.202 with SMTP id us10mr30631990pab.78.1418422126121;
        Fri, 12 Dec 2014 14:08:46 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:45 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 20/23] MIPS: BMIPS: Enable additional peripheral and CPU support in defconfig
Date:   Fri, 12 Dec 2014 14:07:11 -0800
Message-Id: <1418422034-17099-21-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44658
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
---
 arch/mips/Kconfig                     | 18 +++++--
 arch/mips/configs/bmips_be_defconfig  |  9 +++-
 arch/mips/configs/bmips_stb_defconfig | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/configs/bmips_stb_defconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d28c29e..d277863 100644
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
+	select SYS_HAS_CPU_BMIPS3300
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
