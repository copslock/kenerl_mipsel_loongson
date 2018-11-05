Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 04:18:52 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990437AbeKEDSro7QfN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 04:18:47 +0100
Date:   Mon, 5 Nov 2018 03:18:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/3] MIPS: DEC: Update R3k DECstation defconfig for Y2018
In-Reply-To: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1811050242580.20378@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Regenerate the R3k DECstation defconfig, in particular including more 
relevant drivers.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/configs/decstation_defconfig |  163 +++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 28 deletions(-)

linux-mips-dec-defconfig-4.20-rc1.diff
Index: linux-20181104-3maxp-defconfig/arch/mips/configs/decstation_defconfig
===================================================================
--- linux-20181104-3maxp-defconfig.orig/arch/mips/configs/decstation_defconfig
+++ linux-20181104-3maxp-defconfig/arch/mips/configs/decstation_defconfig
@@ -1,17 +1,26 @@
-CONFIG_MACH_DECSTATION=y
-CONFIG_CPU_R3000=y
 CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_LOG_BUF_SHIFT=15
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_HOTPLUG is not set
+# CONFIG_SGETMASK_SYSCALL is not set
+# CONFIG_SYSFS_SYSCALL is not set
+CONFIG_BPF_SYSCALL=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_MACH_DECSTATION=y
+CONFIG_CPU_R3000=y
+CONFIG_TC=y
+# CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_TC=y
-CONFIG_PM=y
+# CONFIG_LBDAF is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_OSF_PARTITION=y
+# CONFIG_EFI_PARTITION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -39,37 +48,92 @@ CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
+CONFIG_IP_SCTP=m
 CONFIG_VLAN_8021Q=m
-CONFIG_CONNECTOR=m
+CONFIG_DECNET=m
+CONFIG_DECNET_ROUTER=y
+# CONFIG_WIRELESS is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_MTD=m
+CONFIG_MTD_BLOCK=m
+CONFIG_MTD_BLOCK_RO=m
+CONFIG_MTD_MS02NV=m
 CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_RAM=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
-CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_SPI_ATTRS=m
-CONFIG_SCSI_SAS_ATTRS=m
 CONFIG_ISCSI_TCP=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
+# CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_DECLANCE=y
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_AURORA is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
+# CONFIG_NET_VENDOR_CAVIUM is not set
+# CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_HUAWEI is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_NI is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_SOCIONEXT is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SYNOPSYS is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
 CONFIG_FDDI=y
-CONFIG_DEFXX=m
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-# CONFIG_SERIAL_DZ is not set
+CONFIG_DEFZA=y
+CONFIG_DEFXX=y
+# CONFIG_WLAN is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_LKKBD=y
+# CONFIG_MOUSE_PS2 is not set
+CONFIG_MOUSE_VSXXXAA=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
+CONFIG_FB_TGA=y
+CONFIG_FB_PMAG_AA=y
 CONFIG_FB_PMAG_BA=y
 CONFIG_FB_PMAGB_B=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE_COLUMNS=160
+CONFIG_DUMMY_CONSOLE_ROWS=64
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_CMOS=y
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+# CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -77,30 +141,60 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-CONFIG_FUSE_FS=m
+# CONFIG_MANDATORY_FILE_LOCKING is not set
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_CHILDREN=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_UFS_FS=y
 CONFIG_UFS_FS_WRITE=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_OSF_PARTITION=y
-CONFIG_DLM=m
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_ECB=m
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V3_ACL=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+CONFIG_NLS_ISO8859_8=m
+CONFIG_NLS_ASCII=m
+CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_ISO8859_2=m
+CONFIG_NLS_ISO8859_3=m
+CONFIG_NLS_ISO8859_4=m
+CONFIG_NLS_ISO8859_5=m
+CONFIG_NLS_ISO8859_6=m
+CONFIG_NLS_ISO8859_7=m
+CONFIG_NLS_ISO8859_9=m
+CONFIG_NLS_ISO8859_13=m
+CONFIG_NLS_ISO8859_14=m
+CONFIG_NLS_ISO8859_15=m
+CONFIG_NLS_UTF8=m
+CONFIG_CRYPTO_RSA=m
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_GCM=m
+CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_OFB=m
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_XTS=m
+CONFIG_CRYPTO_KEYWRAP=m
+CONFIG_CRYPTO_CMAC=m
 CONFIG_CRYPTO_XCBC=m
+CONFIG_CRYPTO_VMAC=m
+CONFIG_CRYPTO_CRC32=m
+CONFIG_CRYPTO_CRCT10DIF=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
+CONFIG_CRYPTO_RMD128=m
+CONFIG_CRYPTO_RMD160=m
+CONFIG_CRYPTO_RMD256=m
+CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
@@ -112,6 +206,19 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_SALSA20=m
+CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_LZO=m
+CONFIG_CRYPTO_842=m
+CONFIG_CRYPTO_LZ4=m
+CONFIG_CRYPTO_LZ4HC=m
+CONFIG_CRYPTO_ANSI_CPRNG=m
+CONFIG_CRYPTO_DRBG_HASH=y
+CONFIG_CRYPTO_DRBG_CTR=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_FRAME_WARN=2048
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_FTRACE is not set
