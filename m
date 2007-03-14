Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 16:00:01 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:51929 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022448AbXCNP7y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2007 15:59:54 +0000
Received: from localhost (p2145-ipad30funabasi.chiba.ocn.ne.jp [221.184.77.145])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C7B45F55; Thu, 15 Mar 2007 00:58:28 +0900 (JST)
Date:	Thu, 15 Mar 2007 00:58:28 +0900 (JST)
Message-Id: <20070315.005828.37531652.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] jmr3927 cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Kill dead codes
* Rearrange irq chip handlers
* Minimize defconfig

compile-tested.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                     |    1 
 arch/mips/configs/jmr3927_defconfig   |  254 +++++++-------------------
 arch/mips/jmr3927/common/prom.c       |   12 -
 arch/mips/jmr3927/common/puts.c       |  122 ------------
 arch/mips/jmr3927/rbhma3100/Makefile  |    1 
 arch/mips/jmr3927/rbhma3100/init.c    |   16 -
 arch/mips/jmr3927/rbhma3100/irq.c     |  312 +++-----------------------------
 arch/mips/jmr3927/rbhma3100/kgdb_io.c |   54 -----
 arch/mips/jmr3927/rbhma3100/setup.c   |  157 ++--------------
 arch/mips/pci/fixup-jmr3927.c         |   11 -
 arch/mips/pci/ops-tx3927.c            |  232 -----------------------
 include/asm-mips/jmr3927/irq.h        |   57 -----
 include/asm-mips/jmr3927/jmr3927.h    |  130 -------------
 include/asm-mips/jmr3927/tx3927.h     |    8 
 include/asm-mips/jmr3927/txx927.h     |    5 
 15 files changed, 145 insertions(+), 1227 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ce4c24e..258894f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -777,6 +777,7 @@ config TOSHIBA_JMR3927
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select TOSHIBA_BOARDS
+	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config TOSHIBA_RBTX4927
 	bool "Toshiba TBTX49[23]7 board"
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 21a0947..068e48e 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:34 2007
+# Linux kernel version: 2.6.21-rc3
+# Thu Mar 15 00:40:40 2007
 #
 CONFIG_MIPS=y
 
@@ -70,7 +70,7 @@ CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_TIME=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_CPU_BIG_ENDIAN=y
@@ -138,12 +138,12 @@ CONFIG_ZONE_DMA_FLAG=1
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
-# CONFIG_HZ_250 is not set
+CONFIG_HZ_250=y
 # CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
+# CONFIG_HZ_1000 is not set
 # CONFIG_HZ_1024 is not set
 CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
+CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
@@ -175,14 +175,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-CONFIG_HOTPLUG=y
+# CONFIG_HOTPLUG is not set
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
@@ -217,11 +218,11 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_AS is not set
 # CONFIG_DEFAULT_DEADLINE is not set
-# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_IOSCHED="cfq"
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -233,12 +234,10 @@ CONFIG_MMU=y
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
 
 #
 # PCI Hotplug Support
 #
-# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
@@ -250,10 +249,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_PM is not set
 
 #
 # Networking
@@ -267,12 +263,7 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=y
-# CONFIG_XFRM_SUB_POLICY is not set
-CONFIG_XFRM_MIGRATE=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
+# CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -290,19 +281,18 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=y
-CONFIG_INET_XFRM_MODE_TUNNEL=y
-CONFIG_INET_XFRM_MODE_BEET=y
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
-CONFIG_NETWORK_SECMARK=y
+# CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -343,13 +333,7 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=y
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=y
-CONFIG_IEEE80211_CRYPT_CCMP=y
-CONFIG_IEEE80211_SOFTMAC=y
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -360,14 +344,12 @@ CONFIG_WIRELESS_EXT=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
 #
-CONFIG_CONNECTOR=y
-CONFIG_PROC_EVENTS=y
+# CONFIG_CONNECTOR is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -396,16 +378,13 @@ CONFIG_PROC_EVENTS=y
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=y
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
-CONFIG_SGI_IOC4=y
+# CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
 
 #
@@ -416,7 +395,7 @@ CONFIG_SGI_IOC4=y
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=y
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 # CONFIG_SCSI_NETLINK is not set
 
@@ -462,26 +441,13 @@ CONFIG_NETDEVICES=y
 #
 # PHY device support
 #
-CONFIG_PHYLIB=y
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-# CONFIG_BROADCOM_PHY is not set
-# CONFIG_FIXED_PHY is not set
+# CONFIG_PHYLIB is not set
 
 #
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
@@ -493,7 +459,27 @@ CONFIG_NET_ETHERNET=y
 #
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+CONFIG_TC35815=y
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_SC92031 is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -509,20 +495,21 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=y
+# CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
 # CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=y
+# CONFIG_CHELSIO_T3 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=y
+# CONFIG_NETXEN_NIC is not set
 
 #
 # Token Ring devices
@@ -566,10 +553,7 @@ CONFIG_INPUT=y
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
@@ -587,21 +571,13 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=y
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
-CONFIG_VT=y
-CONFIG_VT_CONSOLE=y
-CONFIG_HW_CONSOLE=y
-CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_VT is not set
 CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_COMPUTONE is not set
 # CONFIG_ROCKETPORT is not set
@@ -609,7 +585,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_DIGIEPCA is not set
 # CONFIG_MOXA_INTELLIO is not set
 # CONFIG_MOXA_SMARTIO is not set
-CONFIG_MOXA_SMARTIO_NEW=y
+# CONFIG_MOXA_SMARTIO_NEW is not set
 # CONFIG_ISI is not set
 # CONFIG_SYNCLINKMP is not set
 # CONFIG_SYNCLINK_GT is not set
@@ -629,11 +605,12 @@ CONFIG_MOXA_SMARTIO_NEW=y
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_TXX9=y
 CONFIG_HAS_TXX9_SERIAL=y
 CONFIG_SERIAL_TXX9_NR_UARTS=6
-# CONFIG_SERIAL_TXX9_CONSOLE is not set
-# CONFIG_SERIAL_TXX9_STDSERIAL is not set
+CONFIG_SERIAL_TXX9_CONSOLE=y
+CONFIG_SERIAL_TXX9_STDSERIAL=y
 # CONFIG_SERIAL_JSM is not set
 # CONFIG_UNIX98_PTYS is not set
 CONFIG_LEGACY_PTYS=y
@@ -685,6 +662,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -697,51 +679,8 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
-CONFIG_FB=y
-# CONFIG_FB_CFB_FILLRECT is not set
-# CONFIG_FB_CFB_COPYAREA is not set
-# CONFIG_FB_CFB_IMAGEBLIT is not set
-# CONFIG_FB_SVGALIB is not set
-# CONFIG_FB_MACMODES is not set
-# CONFIG_FB_BACKLIGHT is not set
-# CONFIG_FB_MODE_HELPERS is not set
-# CONFIG_FB_TILEBLITTING is not set
-# CONFIG_FB_CIRRUS is not set
-# CONFIG_FB_PM2 is not set
-# CONFIG_FB_CYBER2000 is not set
-# CONFIG_FB_ASILIANT is not set
-# CONFIG_FB_IMSTT is not set
-# CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_NVIDIA is not set
-# CONFIG_FB_RIVA is not set
-# CONFIG_FB_MATROX is not set
-# CONFIG_FB_RADEON is not set
-# CONFIG_FB_ATY128 is not set
-# CONFIG_FB_ATY is not set
-# CONFIG_FB_S3 is not set
-# CONFIG_FB_SAVAGE is not set
-# CONFIG_FB_SIS is not set
-# CONFIG_FB_NEOMAGIC is not set
-# CONFIG_FB_KYRO is not set
-# CONFIG_FB_3DFX is not set
-# CONFIG_FB_VOODOO1 is not set
-# CONFIG_FB_SMIVGX is not set
-# CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_VIRTUAL is not set
-
-#
-# Console display driver support
-#
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
-
-#
-# Logo configuration
-#
-# CONFIG_LOGO is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_FB is not set
 
 #
 # Sound
@@ -864,7 +803,7 @@ CONFIG_INOTIFY_USER=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
-CONFIG_FUSE_FS=y
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -889,14 +828,13 @@ CONFIG_SYSFS=y
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
 #
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
@@ -944,10 +882,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Distributed Lock Manager
 #
-CONFIG_DLM=y
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
+# CONFIG_DLM is not set
 
 #
 # Profiling support
@@ -972,65 +907,22 @@ CONFIG_CMDLINE=""
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=y
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_XCBC=y
-CONFIG_CRYPTO_NULL=y
-CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_WP512=y
-CONFIG_CRYPTO_TGR192=y
-CONFIG_CRYPTO_GF128MUL=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=y
-CONFIG_CRYPTO_LRW=y
-CONFIG_CRYPTO_DES=y
-CONFIG_CRYPTO_FCRYPT=y
-CONFIG_CRYPTO_BLOWFISH=y
-CONFIG_CRYPTO_TWOFISH=y
-CONFIG_CRYPTO_TWOFISH_COMMON=y
-CONFIG_CRYPTO_SERPENT=y
-CONFIG_CRYPTO_AES=y
-CONFIG_CRYPTO_CAST5=y
-CONFIG_CRYPTO_CAST6=y
-CONFIG_CRYPTO_TEA=y
-CONFIG_CRYPTO_ARC4=y
-CONFIG_CRYPTO_KHAZAD=y
-CONFIG_CRYPTO_ANUBIS=y
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_CRYPTO_CRC32C=y
-CONFIG_CRYPTO_CAMELLIA=y
-
-#
-# Hardware crypto devices
-#
+# CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=y
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=y
-CONFIG_ZLIB_INFLATE=y
-CONFIG_ZLIB_DEFLATE=y
+# CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
diff --git a/arch/mips/jmr3927/common/prom.c b/arch/mips/jmr3927/common/prom.c
index aa481b7..5398813 100644
--- a/arch/mips/jmr3927/common/prom.c
+++ b/arch/mips/jmr3927/common/prom.c
@@ -41,16 +41,6 @@
 
 #include <asm/bootinfo.h>
 
-extern int prom_argc;
-extern char **prom_argv, **prom_envp;
-
-typedef struct
-{
-    char *name;
-/*    char *val; */
-}t_env_var;
-
-
 char * __init prom_getcmdline(void)
 {
 	return &(arcs_cmdline[0]);
@@ -60,6 +50,8 @@ void  __init prom_init_cmdline(void)
 {
 	char *cp;
 	int actr;
+	int prom_argc = fw_arg0;
+	char **prom_argv = (char **) fw_arg1;
 
 	actr = 1; /* Always ignore argv[0] */
 
diff --git a/arch/mips/jmr3927/common/puts.c b/arch/mips/jmr3927/common/puts.c
index 1c1cad9..c611ab4 100644
--- a/arch/mips/jmr3927/common/puts.c
+++ b/arch/mips/jmr3927/common/puts.c
@@ -32,137 +32,29 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/types.h>
-#include <asm/jmr3927/txx927.h>
 #include <asm/jmr3927/tx3927.h>
-#include <asm/jmr3927/jmr3927.h>
 
 #define TIMEOUT       0xffffff
-#define SLOW_DOWN
-
-static const char digits[16] = "0123456789abcdef";
-
-#ifdef SLOW_DOWN
-#define slow_down() { int k; for (k=0; k<10000; k++); }
-#else
-#define slow_down()
-#endif
 
 void
-putch(const unsigned char c)
+prom_putchar(char c)
 {
         int i = 0;
 
         do {
-            slow_down();
             i++;
-            if (i>TIMEOUT) {
+            if (i>TIMEOUT)
                 break;
-            }
         } while (!(tx3927_sioptr(1)->cisr & TXx927_SICISR_TXALS));
 	tx3927_sioptr(1)->tfifo = c;
 	return;
 }
 
-unsigned char getch(void)
-{
-        int i = 0;
-	int dicr;
-	char c;
-
-	/* diable RX int. */
-	dicr = tx3927_sioptr(1)->dicr;
-	tx3927_sioptr(1)->dicr = 0;
-
-        do {
-            slow_down();
-            i++;
-            if (i>TIMEOUT) {
-                break;
-            }
-        } while (tx3927_sioptr(1)->disr & TXx927_SIDISR_UVALID)
-		;
-	c = tx3927_sioptr(1)->rfifo;
-
-	/* clear RX int. status */
-	tx3927_sioptr(1)->disr &= ~TXx927_SIDISR_RDIS;
-	/* enable RX int. */
-	tx3927_sioptr(1)->dicr = dicr;
-
-	return c;
-}
-void
-do_jmr3927_led_set(char n)
-{
-    /* and with current leds */
-    jmr3927_led_and_set(n);
-}
-
 void
-puts(unsigned char *cp)
+puts(const char *cp)
 {
-    int i = 0;
-
-    while (*cp) {
-        do {
-            slow_down();
-            i++;
-            if (i>TIMEOUT) {
-                break;
-            }
-        } while (!(tx3927_sioptr(1)->cisr & TXx927_SICISR_TXALS));
-	tx3927_sioptr(1)->tfifo = *cp++;
-    }
-    putch('\r');
-    putch('\n');
-}
-
-void
-fputs(unsigned char *cp)
-{
-    int i = 0;
-
-    while (*cp) {
-        do {
-             slow_down();
-            i++;
-            if (i>TIMEOUT) {
-                break;
-            }
-        } while (!(tx3927_sioptr(1)->cisr & TXx927_SICISR_TXALS));
-	tx3927_sioptr(1)->tfifo = *cp++;
-    }
-}
-
-
-void
-put64(uint64_t ul)
-{
-    int cnt;
-    unsigned ch;
-
-    cnt = 16;            /* 16 nibbles in a 64 bit long */
-    putch('0');
-    putch('x');
-    do {
-        cnt--;
-        ch = (unsigned char)(ul >> cnt * 4) & 0x0F;
-                putch(digits[ch]);
-    } while (cnt > 0);
-}
-
-void
-put32(unsigned u)
-{
-    int cnt;
-    unsigned ch;
-
-    cnt = 8;            /* 8 nibbles in a 32 bit long */
-    putch('0');
-    putch('x');
-    do {
-        cnt--;
-        ch = (unsigned char)(u >> cnt * 4) & 0x0F;
-                putch(digits[ch]);
-    } while (cnt > 0);
+    while (*cp)
+	prom_putchar(*cp++);
+    prom_putchar('\r');
+    prom_putchar('\n');
 }
diff --git a/arch/mips/jmr3927/rbhma3100/Makefile b/arch/mips/jmr3927/rbhma3100/Makefile
index 18fe9a8..8d00ba4 100644
--- a/arch/mips/jmr3927/rbhma3100/Makefile
+++ b/arch/mips/jmr3927/rbhma3100/Makefile
@@ -3,5 +3,4 @@
 #
 
 obj-y	 			+= init.o irq.o setup.o
-obj-$(CONFIG_RUNTIME_DEBUG) 	+= debug.o
 obj-$(CONFIG_KGDB)		+= kgdb_io.o
diff --git a/arch/mips/jmr3927/rbhma3100/init.c b/arch/mips/jmr3927/rbhma3100/init.c
index a55cb45..9169fab 100644
--- a/arch/mips/jmr3927/rbhma3100/init.c
+++ b/arch/mips/jmr3927/rbhma3100/init.c
@@ -28,20 +28,10 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
-#include <asm/mipsregs.h>
 #include <asm/jmr3927/jmr3927.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
 extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-unsigned long mips_nofpu = 0;
 
 const char *get_system_type(void)
 {
@@ -52,7 +42,7 @@ const char *get_system_type(void)
 	;
 }
 
-extern void puts(unsigned char *cp);
+extern void puts(const char *cp);
 
 void __init prom_init(void)
 {
@@ -61,10 +51,6 @@ void __init prom_init(void)
 	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
 		puts("Warning: TX3927 TLB off\n");
 #endif
-	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
-
 	mips_machgroup = MACH_GROUP_TOSHIBA;
 
 #ifdef CONFIG_TOSHIBA_JMR3927
diff --git a/arch/mips/jmr3927/rbhma3100/irq.c b/arch/mips/jmr3927/rbhma3100/irq.c
index 7d2c203..1187b44 100644
--- a/arch/mips/jmr3927/rbhma3100/irq.c
+++ b/arch/mips/jmr3927/rbhma3100/irq.c
@@ -30,53 +30,21 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-
-#include <linux/errno.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-#include <linux/bitops.h>
 
-#include <asm/irq_regs.h>
 #include <asm/io.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
-#include <asm/ptrace.h>
 #include <asm/processor.h>
-#include <asm/jmr3927/irq.h>
-#include <asm/debug.h>
 #include <asm/jmr3927/jmr3927.h>
 
 #if JMR3927_IRQ_END > NR_IRQS
 #error JMR3927_IRQ_END > NR_IRQS
 #endif
 
-struct tb_irq_space* tb_irq_spaces;
-
-static int jmr3927_irq_base = -1;
-
-#ifdef CONFIG_PCI
-static int jmr3927_gen_iack(void)
-{
-	/* generate ACK cycle */
-#ifdef __BIG_ENDIAN
-	return (tx3927_pcicptr->iiadp >> 24) & 0xff;
-#else
-	return tx3927_pcicptr->iiadp & 0xff;
-#endif
-}
-#endif
-
 #define irc_dlevel	0
 #define irc_elevel	1
 
@@ -87,89 +55,24 @@ static unsigned char irc_level[TX3927_NU
 	6, 6, 6			/* TMR */
 };
 
-static void jmr3927_irq_disable(unsigned int irq_nr);
-static void jmr3927_irq_enable(unsigned int irq_nr);
-
-static void jmr3927_irq_ack(unsigned int irq)
-{
-	if (irq == JMR3927_IRQ_IRC_TMR0)
-		jmr3927_tmrptr->tisr = 0;       /* ack interrupt */
-
-	jmr3927_irq_disable(irq);
-}
-
-static void jmr3927_irq_end(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		jmr3927_irq_enable(irq);
-}
-
-static void jmr3927_irq_disable(unsigned int irq_nr)
-{
-	struct tb_irq_space* sp;
-
-	for (sp = tb_irq_spaces; sp; sp = sp->next) {
-		if (sp->start_irqno <= irq_nr &&
-		    irq_nr < sp->start_irqno + sp->nr_irqs) {
-			if (sp->mask_func)
-				sp->mask_func(irq_nr - sp->start_irqno,
-					      sp->space_id);
-			break;
-		}
-	}
-}
-
-static void jmr3927_irq_enable(unsigned int irq_nr)
-{
-	struct tb_irq_space* sp;
-
-	for (sp = tb_irq_spaces; sp; sp = sp->next) {
-		if (sp->start_irqno <= irq_nr &&
-		    irq_nr < sp->start_irqno + sp->nr_irqs) {
-			if (sp->unmask_func)
-				sp->unmask_func(irq_nr - sp->start_irqno,
-						sp->space_id);
-			break;
-		}
-	}
-}
-
 /*
  * CP0_STATUS is a thread's resource (saved/restored on context switch).
- * So disable_irq/enable_irq MUST handle IOC/ISAC/IRC registers.
+ * So disable_irq/enable_irq MUST handle IOC/IRC registers.
  */
-static void mask_irq_isac(int irq_nr, int space_id)
-{
-	/* 0: mask */
-	unsigned char imask =
-		jmr3927_isac_reg_in(JMR3927_ISAC_INTM_ADDR);
-	unsigned int bit  = 1 << irq_nr;
-	jmr3927_isac_reg_out(imask & ~bit, JMR3927_ISAC_INTM_ADDR);
-	/* flush write buffer */
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
-}
-static void unmask_irq_isac(int irq_nr, int space_id)
-{
-	/* 0: mask */
-	unsigned char imask = jmr3927_isac_reg_in(JMR3927_ISAC_INTM_ADDR);
-	unsigned int bit  = 1 << irq_nr;
-	jmr3927_isac_reg_out(imask | bit, JMR3927_ISAC_INTM_ADDR);
-	/* flush write buffer */
-	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
-}
-
-static void mask_irq_ioc(int irq_nr, int space_id)
+static void mask_irq_ioc(unsigned int irq)
 {
 	/* 0: mask */
+	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
 	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
 	unsigned int bit = 1 << irq_nr;
 	jmr3927_ioc_reg_out(imask & ~bit, JMR3927_IOC_INTM_ADDR);
 	/* flush write buffer */
 	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
 }
-static void unmask_irq_ioc(int irq_nr, int space_id)
+static void unmask_irq_ioc(unsigned int irq)
 {
 	/* 0: mask */
+	unsigned int irq_nr = irq - JMR3927_IRQ_IOC;
 	unsigned char imask = jmr3927_ioc_reg_in(JMR3927_IOC_INTM_ADDR);
 	unsigned int bit = 1 << irq_nr;
 	jmr3927_ioc_reg_out(imask | bit, JMR3927_IOC_INTM_ADDR);
@@ -177,8 +80,9 @@ static void unmask_irq_ioc(int irq_nr, i
 	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
 }
 
-static void mask_irq_irc(int irq_nr, int space_id)
+static void mask_irq_irc(unsigned int irq)
 {
+	unsigned int irq_nr = irq - JMR3927_IRQ_IRC;
 	volatile unsigned long *ilrp = &tx3927_ircptr->ilr[irq_nr / 2];
 	if (irq_nr & 1)
 		*ilrp = (*ilrp & 0x00ff) | (irc_dlevel << 8);
@@ -191,8 +95,9 @@ static void mask_irq_irc(int irq_nr, int
 	(void)tx3927_ircptr->ssr;
 }
 
-static void unmask_irq_irc(int irq_nr, int space_id)
+static void unmask_irq_irc(unsigned int irq)
 {
+	unsigned int irq_nr = irq - JMR3927_IRQ_IRC;
 	volatile unsigned long *ilrp = &tx3927_ircptr->ilr[irq_nr / 2];
 	if (irq_nr & 1)
 		*ilrp = (*ilrp & 0x00ff) | (irc_level[irq_nr] << 8);
@@ -203,98 +108,14 @@ static void unmask_irq_irc(int irq_nr, i
 	tx3927_ircptr->imr = irc_elevel;
 }
 
-struct tb_irq_space jmr3927_isac_irqspace = {
-	.next = NULL,
-	.start_irqno = JMR3927_IRQ_ISAC,
-	nr_irqs : JMR3927_NR_IRQ_ISAC,
-	.mask_func = mask_irq_isac,
-	.unmask_func = unmask_irq_isac,
-	.name = "ISAC",
-	.space_id = 0,
-	can_share : 0
-};
-struct tb_irq_space jmr3927_ioc_irqspace = {
-	.next = NULL,
-	.start_irqno = JMR3927_IRQ_IOC,
-	nr_irqs : JMR3927_NR_IRQ_IOC,
-	.mask_func = mask_irq_ioc,
-	.unmask_func = unmask_irq_ioc,
-	.name = "IOC",
-	.space_id = 0,
-	can_share : 1
-};
-
-struct tb_irq_space jmr3927_irc_irqspace = {
-	.next		= NULL,
-	.start_irqno	= JMR3927_IRQ_IRC,
-	.nr_irqs	= JMR3927_NR_IRQ_IRC,
-	.mask_func	= mask_irq_irc,
-	.unmask_func	= unmask_irq_irc,
-	.name		= "on-chip",
-	.space_id	= 0,
-	.can_share	= 0
-};
-
-
-#ifdef CONFIG_TX_BRANCH_LIKELY_BUG_WORKAROUND
-static int tx_branch_likely_bug_count = 0;
-static int have_tx_branch_likely_bug = 0;
-
-static void tx_branch_likely_bug_fixup(void)
-{
-	struct pt_regs *regs = get_irq_regs();
-
-	/* TX39/49-BUG: Under this condition, the insn in delay slot
-           of the branch likely insn is executed (not nullified) even
-           the branch condition is false. */
-	if (!have_tx_branch_likely_bug)
-		return;
-	if ((regs->cp0_epc & 0xfff) == 0xffc &&
-	    KSEGX(regs->cp0_epc) != KSEG0 &&
-	    KSEGX(regs->cp0_epc) != KSEG1) {
-		unsigned int insn = *(unsigned int*)(regs->cp0_epc - 4);
-		/* beql,bnel,blezl,bgtzl */
-		/* bltzl,bgezl,blezall,bgezall */
-		/* bczfl, bcztl */
-		if ((insn & 0xf0000000) == 0x50000000 ||
-		    (insn & 0xfc0e0000) == 0x04020000 ||
-		    (insn & 0xf3fe0000) == 0x41020000) {
-			regs->cp0_epc -= 4;
-			tx_branch_likely_bug_count++;
-			printk(KERN_INFO
-			       "fix branch-likery bug in %s (insn %08x)\n",
-			       current->comm, insn);
-		}
-	}
-}
-#endif
-
-static void jmr3927_spurious(void)
-{
-	struct pt_regs * regs = get_irq_regs();
-
-#ifdef CONFIG_TX_BRANCH_LIKELY_BUG_WORKAROUND
-	tx_branch_likely_bug_fixup();
-#endif
-	printk(KERN_WARNING "spurious interrupt (cause 0x%lx, pc 0x%lx, ra 0x%lx).\n",
-	       regs->cp0_cause, regs->cp0_epc, regs->regs[31]);
-}
-
 asmlinkage void plat_irq_dispatch(void)
 {
-	struct pt_regs * regs = get_irq_regs();
+	unsigned long cp0_cause = read_c0_cause();
 	int irq;
 
-#ifdef CONFIG_TX_BRANCH_LIKELY_BUG_WORKAROUND
-	tx_branch_likely_bug_fixup();
-#endif
-	if ((regs->cp0_cause & CAUSEF_IP7) == 0) {
-#if 0
-		jmr3927_spurious();
-#endif
+	if ((cp0_cause & CAUSEF_IP7) == 0)
 		return;
-	}
-	irq = (regs->cp0_cause >> CAUSEB_IP2) & 0x0f;
+	irq = (cp0_cause >> CAUSEB_IP2) & 0x0f;
 
 	do_IRQ(irq + JMR3927_IRQ_IRC);
 }
@@ -317,35 +138,6 @@ static struct irqaction ioc_action = {
 	jmr3927_ioc_interrupt, 0, CPU_MASK_NONE, "IOC", NULL, NULL,
 };
 
-static irqreturn_t jmr3927_isac_interrupt(int irq, void *dev_id)
-{
-	unsigned char istat = jmr3927_isac_reg_in(JMR3927_ISAC_INTS2_ADDR);
-	int i;
-
-	for (i = 0; i < JMR3927_NR_IRQ_ISAC; i++) {
-		if (istat & (1 << i)) {
-			irq = JMR3927_IRQ_ISAC + i;
-			do_IRQ(irq);
-		}
-	}
-	return IRQ_HANDLED;
-}
-
-static struct irqaction isac_action = {
-	jmr3927_isac_interrupt, 0, CPU_MASK_NONE, "ISAC", NULL, NULL,
-};
-
-
-static irqreturn_t jmr3927_isaerr_interrupt(int irq, void *dev_id)
-{
-	printk(KERN_WARNING "ISA error interrupt (irq 0x%x).\n", irq);
-
-	return IRQ_HANDLED;
-}
-static struct irqaction isaerr_action = {
-	jmr3927_isaerr_interrupt, 0, CPU_MASK_NONE, "ISA error", NULL, NULL,
-};
-
 static irqreturn_t jmr3927_pcierr_interrupt(int irq, void *dev_id)
 {
 	printk(KERN_WARNING "PCI error interrupt (irq 0x%x).\n", irq);
@@ -358,54 +150,19 @@ static struct irqaction pcierr_action =
 	jmr3927_pcierr_interrupt, 0, CPU_MASK_NONE, "PCI error", NULL, NULL,
 };
 
-int jmr3927_ether1_irq = 0;
-
-void jmr3927_irq_init(u32 irq_base);
+static void __init jmr3927_irq_init(void);
 
 void __init arch_init_irq(void)
 {
-	/* look for io board's presence */
-	int have_isac = jmr3927_have_isac();
-
 	/* Now, interrupt control disabled, */
 	/* all IRC interrupts are masked, */
 	/* all IRC interrupt mode are Low Active. */
 
-	if (have_isac) {
-
-		/* ETHER1 (NE2000 compatible 10M-Ether) parameter setup */
-		/* temporary enable interrupt control */
-		tx3927_ircptr->cer = 1;
-		/* ETHER1 Int. Is High-Active. */
-		if (tx3927_ircptr->ssr & (1 << 0))
-			jmr3927_ether1_irq = JMR3927_IRQ_IRC_INT0;
-#if 0	/* INT3 may be asserted by ether0 (even after reboot...) */
-		else if (tx3927_ircptr->ssr & (1 << 3))
-			jmr3927_ether1_irq = JMR3927_IRQ_IRC_INT3;
-#endif
-		/* disable interrupt control */
-		tx3927_ircptr->cer = 0;
-
-		/* Ether1: High Active */
-		if (jmr3927_ether1_irq) {
-			int ether1_irc = jmr3927_ether1_irq - JMR3927_IRQ_IRC;
-			tx3927_ircptr->cr[ether1_irc / 8] |=
-				TX3927_IRCR_HIGH << ((ether1_irc % 8) * 2);
-		}
-	}
-
 	/* mask all IOC interrupts */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTM_ADDR);
 	/* setup IOC interrupt mode (SOFT:High Active, Others:Low Active) */
 	jmr3927_ioc_reg_out(JMR3927_IOC_INTF_SOFT, JMR3927_IOC_INTP_ADDR);
 
-	if (have_isac) {
-		/* mask all ISAC interrupts */
-		jmr3927_isac_reg_out(0, JMR3927_ISAC_INTM_ADDR);
-		/* setup ISAC interrupt mode (ISAIRQ3,ISAIRQ5:Low Active ???) */
-		jmr3927_isac_reg_out(JMR3927_ISAC_INTF_IRQ3|JMR3927_ISAC_INTF_IRQ5, JMR3927_ISAC_INTP_ADDR);
-	}
-
 	/* clear PCI Soft interrupts */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_INTS1_ADDR);
 	/* clear PCI Reset interrupts */
@@ -415,21 +172,11 @@ void __init arch_init_irq(void)
 	tx3927_ircptr->cer = TX3927_IRCER_ICE;
 	tx3927_ircptr->imr = irc_elevel;
 
-	jmr3927_irq_init(NR_ISA_IRQS);
-
-	/* setup irq space */
-	add_tb_irq_space(&jmr3927_isac_irqspace);
-	add_tb_irq_space(&jmr3927_ioc_irqspace);
-	add_tb_irq_space(&jmr3927_irc_irqspace);
+	jmr3927_irq_init();
 
 	/* setup IOC interrupt 1 (PCI, MODEM) */
 	setup_irq(JMR3927_IRQ_IOCINT, &ioc_action);
 
-	if (have_isac) {
-		setup_irq(JMR3927_IRQ_ISACINT, &isac_action);
-		setup_irq(JMR3927_IRQ_ISAC_ISAER, &isaerr_action);
-	}
-
 #ifdef CONFIG_PCI
 	setup_irq(JMR3927_IRQ_IRC_PCI, &pcierr_action);
 #endif
@@ -438,21 +185,28 @@ void __init arch_init_irq(void)
 	set_c0_status(ST0_IM);	/* IE bit is still 0. */
 }
 
-static struct irq_chip jmr3927_irq_controller = {
-	.name = "jmr3927_irq",
-	.ack = jmr3927_irq_ack,
-	.mask = jmr3927_irq_disable,
-	.mask_ack = jmr3927_irq_ack,
-	.unmask = jmr3927_irq_enable,
-	.end = jmr3927_irq_end,
+static struct irq_chip jmr3927_irq_ioc = {
+	.name = "jmr3927_ioc",
+	.ack = mask_irq_ioc,
+	.mask = mask_irq_ioc,
+	.mask_ack = mask_irq_ioc,
+	.unmask = unmask_irq_ioc,
 };
 
-void jmr3927_irq_init(u32 irq_base)
+static struct irq_chip jmr3927_irq_irc = {
+	.name = "jmr3927_irc",
+	.ack = mask_irq_irc,
+	.mask = mask_irq_irc,
+	.mask_ack = mask_irq_irc,
+	.unmask = unmask_irq_irc,
+};
+
+static void __init jmr3927_irq_init(void)
 {
 	u32 i;
 
-	for (i= irq_base; i< irq_base + JMR3927_NR_IRQ_IRC + JMR3927_NR_IRQ_IOC; i++)
-		set_irq_chip(i, &jmr3927_irq_controller);
-
-	jmr3927_irq_base = irq_base;
+	for (i = JMR3927_IRQ_IRC; i < JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC; i++)
+		set_irq_chip_and_handler(i, &jmr3927_irq_irc, handle_level_irq);
+	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
+		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
 }
diff --git a/arch/mips/jmr3927/rbhma3100/kgdb_io.c b/arch/mips/jmr3927/rbhma3100/kgdb_io.c
index 269a42d..2604f2c 100644
--- a/arch/mips/jmr3927/rbhma3100/kgdb_io.c
+++ b/arch/mips/jmr3927/rbhma3100/kgdb_io.c
@@ -31,23 +31,12 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/types.h>
-#include <asm/jmr3927/txx927.h>
-#include <asm/jmr3927/tx3927.h>
 #include <asm/jmr3927/jmr3927.h>
 
 #define TIMEOUT       0xffffff
-#define SLOW_DOWN
-
-static const char digits[16] = "0123456789abcdef";
-
-#ifdef SLOW_DOWN
-#define slow_down() { int k; for (k=0; k<10000; k++); }
-#else
-#define slow_down()
-#endif
 
 static int remoteDebugInitialized = 0;
+static void debugInit(int baud)
 
 int putDebugChar(unsigned char c)
 {
@@ -103,20 +92,8 @@ unsigned char getDebugChar(void)
 	return c;
 }
 
-void debugInit(int baud)
+static void debugInit(int baud)
 {
-	/*
-	volatile unsigned long lcr;
-	volatile unsigned long dicr;
-	volatile unsigned long disr;
-	volatile unsigned long cisr;
-	volatile unsigned long fcr;
-	volatile unsigned long flcr;
-	volatile unsigned long bgr;
-	volatile unsigned long tfifo;
-	volatile unsigned long rfifo;
-	*/
-
 	tx3927_sioptr(0)->lcr = 0x020;
 	tx3927_sioptr(0)->dicr = 0;
 	tx3927_sioptr(0)->disr = 0x4100;
@@ -125,31 +102,4 @@ void debugInit(int baud)
 	tx3927_sioptr(0)->flcr = 0x02;
 	tx3927_sioptr(0)->bgr = ((JMR3927_BASE_BAUD + baud / 2) / baud) |
 		TXx927_SIBGR_BCLK_T0;
-#if 0
-	/*
-	 * Reset the UART.
-	 */
-	tx3927_sioptr(0)->fcr = TXx927_SIFCR_SWRST;
-	while (tx3927_sioptr(0)->fcr & TXx927_SIFCR_SWRST)
-		;
-
-	/*
-	 * and set the speed of the serial port
-	 * (currently hardwired to 9600 8N1
-	 */
-
-	tx3927_sioptr(0)->lcr = TXx927_SILCR_UMODE_8BIT |
-		TXx927_SILCR_USBL_1BIT |
-		TXx927_SILCR_SCS_IMCLK_BG;
-	tx3927_sioptr(0)->bgr =
-		((JMR3927_BASE_BAUD + baud / 2) / baud) |
-		TXx927_SIBGR_BCLK_T0;
-
-	/* HW RTS/CTS control */
-	if (ser->flags & ASYNC_HAVE_CTS_LINE)
-		tx3927_sioptr(0)->flcr = TXx927_SIFLCR_RCS | TXx927_SIFLCR_TES |
-			TXx927_SIFLCR_RTSTL_MAX /* 15 */;
-	/* Enable RX/TX */
-	tx3927_sioptr(0)->flcr &= ~(TXx927_SIFLCR_RSDE | TXx927_SIFLCR_TSDE);
-#endif
 }
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index fc523bd..d1ef289 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -54,87 +54,18 @@
 
 #include <asm/addrspace.h>
 #include <asm/time.h>
-#include <asm/bcache.h>
-#include <asm/irq.h>
 #include <asm/reboot.h>
-#include <asm/gdb-stub.h>
 #include <asm/jmr3927/jmr3927.h>
 #include <asm/mipsregs.h>
-#include <asm/traps.h>
 
-extern void puts(unsigned char *cp);
+extern void puts(const char *cp);
 
 /* Tick Timer divider */
 #define JMR3927_TIMER_CCD	0	/* 1/2 */
 #define JMR3927_TIMER_CLK	(JMR3927_IMCLK / (2 << JMR3927_TIMER_CCD))
 
-unsigned char led_state = 0xf;
-
-struct {
-    struct resource ram0;
-    struct resource ram1;
-    struct resource pcimem;
-    struct resource iob;
-    struct resource ioc;
-    struct resource pciio;
-    struct resource jmy1394;
-    struct resource rom1;
-    struct resource rom0;
-    struct resource sio0;
-    struct resource sio1;
-} jmr3927_resources = {
-	{
-		.start	= 0,
-		.end	= 0x01FFFFFF,
-		.name	= "RAM0",
-		.flags = IORESOURCE_MEM
-	}, {
-		.start	= 0x02000000,
-		.end	= 0x03FFFFFF,
-		.name	= "RAM1",
-		.flags = IORESOURCE_MEM
-	}, {
-		.start	= 0x08000000,
-		.end	= 0x07FFFFFF,
-		.name	= "PCIMEM",
-		.flags = IORESOURCE_MEM
-	}, {
-		.start	= 0x10000000,
-		.end	= 0x13FFFFFF,
-		.name	= "IOB"
-	}, {
-		.start	= 0x14000000,
-		.end	= 0x14FFFFFF,
-		.name	= "IOC"
-	}, {
-		.start	= 0x15000000,
-		.end	= 0x15FFFFFF,
-		.name	= "PCIIO"
-	}, {
-		.start	= 0x1D000000,
-		.end	= 0x1D3FFFFF,
-		.name	= "JMY1394"
-	}, {
-		.start	= 0x1E000000,
-		.end	= 0x1E3FFFFF,
-		.name	= "ROM1"
-	}, {
-		.start	= 0x1FC00000,
-		.end	= 0x1FFFFFFF,
-		.name	= "ROM0"
-	}, {
-		.start	= 0xFFFEF300,
-		.end	= 0xFFFEF3FF,
-		.name	= "SIO0"
-	}, {
-		.start	= 0xFFFEF400,
-		.end	= 0xFFFEF4FF,
-		.name	= "SIO1"
-	},
-};
-
 /* don't enable - see errata */
-int jmr3927_ccfg_toeon = 0;
+static int jmr3927_ccfg_toeon;
 
 static inline void do_reset(void)
 {
@@ -173,9 +104,15 @@ static cycle_t jmr3927_hpt_read(void)
 	return jiffies * (JMR3927_TIMER_CLK / HZ) + jmr3927_tmrptr->trr;
 }
 
+static void jmr3927_timer_ack(void)
+{
+	jmr3927_tmrptr->tisr = 0;       /* ack interrupt */
+}
+
 static void __init jmr3927_time_init(void)
 {
 	clocksource_mips.read = jmr3927_hpt_read;
+	mips_timer_ack = jmr3927_timer_ack;
 	mips_hpt_frequency = JMR3927_TIMER_CLK;
 }
 
@@ -190,9 +127,6 @@ void __init plat_timer_setup(struct irqa
 	setup_irq(JMR3927_IRQ_TICK, irq);
 }
 
-#define USECS_PER_JIFFY (1000000/HZ)
-
-//#undef DO_WRITE_THROUGH
 #define DO_WRITE_THROUGH
 #define DO_ENABLE_CACHE
 
@@ -224,12 +158,6 @@ void __init plat_mem_setup(void)
 	/* Reboot on panic */
 	panic_timeout = 180;
 
-	{
-		unsigned int conf;
-		conf = read_c0_conf();
-	}
-
-#if 1
 	/* cache setup */
 	{
 		unsigned int conf;
@@ -256,16 +184,14 @@ void __init plat_mem_setup(void)
 		write_c0_conf(conf);
 		write_c0_cache(0);
 	}
-#endif
 
 	/* initialize board */
 	jmr3927_board_init();
 
 	argptr = prom_getcmdline();
 
-	if ((argptr = strstr(argptr, "toeon")) != NULL) {
-			jmr3927_ccfg_toeon = 1;
-	}
+	if ((argptr = strstr(argptr, "toeon")) != NULL)
+		jmr3927_ccfg_toeon = 1;
 	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "ip=")) == NULL) {
 		argptr = prom_getcmdline();
@@ -281,7 +207,7 @@ void __init plat_mem_setup(void)
 			memset(&req, 0, sizeof(req));
 			req.line = i;
 			req.iotype = UPIO_MEM;
-			req.membase = (char *)TX3927_SIO_REG(i);
+			req.membase = (unsigned char __iomem *)TX3927_SIO_REG(i);
 			req.mapbase = TX3927_SIO_REG(i);
 			req.irq = i == 0 ?
 				JMR3927_IRQ_IRC_SIO0 : JMR3927_IRQ_IRC_SIO1;
@@ -303,65 +229,33 @@ void __init plat_mem_setup(void)
 
 static void tx3927_setup(void);
 
-#ifdef CONFIG_PCI
-unsigned long mips_pci_io_base;
-unsigned long mips_pci_io_size;
-unsigned long mips_pci_mem_base;
-unsigned long mips_pci_mem_size;
-/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
-unsigned long mips_pci_io_pciaddr = 0;
-#endif
-
 static void __init jmr3927_board_init(void)
 {
-	char *argptr;
-
-#ifdef CONFIG_PCI
-	mips_pci_io_base = JMR3927_PCIIO;
-	mips_pci_io_size = JMR3927_PCIIO_SIZE;
-	mips_pci_mem_base = JMR3927_PCIMEM;
-	mips_pci_mem_size = JMR3927_PCIMEM_SIZE;
-#endif
-
 	tx3927_setup();
 
-	if (jmr3927_have_isac()) {
-
-#ifdef CONFIG_FB_E1355
-		argptr = prom_getcmdline();
-		if ((argptr = strstr(argptr, "video=")) == NULL) {
-			argptr = prom_getcmdline();
-			strcat(argptr, " video=e1355fb:crt16h");
-		}
-#endif
-
-#ifdef CONFIG_BLK_DEV_IDE
-		/* overrides PCI-IDE */
-#endif
-	}
-
 	/* SIO0 DTR on */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
 
 	jmr3927_led_set(0);
 
-
-	if (jmr3927_have_isac())
-		jmr3927_io_led_set(0);
 	printk("JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
 	       jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
 	       jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
 	       jmr3927_dipsw1(), jmr3927_dipsw2(),
 	       jmr3927_dipsw3(), jmr3927_dipsw4());
-	if (jmr3927_have_isac())
-		printk("JMI-3927IO2 --- ISAC(Rev %d) DIPSW:%01x\n",
-		       jmr3927_isac_reg_in(JMR3927_ISAC_REV_ADDR) & JMR3927_REV_MASK,
-		       jmr3927_io_dipsw());
 }
 
-void __init tx3927_setup(void)
+static void __init tx3927_setup(void)
 {
 	int i;
+#ifdef CONFIG_PCI
+	unsigned long mips_pci_io_base = JMR3927_PCIIO;
+	unsigned long mips_pci_io_size = JMR3927_PCIIO_SIZE;
+	unsigned long mips_pci_mem_base = JMR3927_PCIMEM;
+	unsigned long mips_pci_mem_size = JMR3927_PCIMEM_SIZE;
+	/* for legacy I/O, PCI I/O PCI Bus address must be 0 */
+	unsigned long mips_pci_io_pciaddr = 0;
+#endif
 
 	/* SDRAMC are configured by PROM */
 
@@ -475,10 +369,8 @@ void __init tx3927_setup(void)
 		tx3927_pcicptr->mbas = ~(mips_pci_mem_size - 1);
 		tx3927_pcicptr->mba = 0;
 		tx3927_pcicptr->tlbmma = 0;
-#ifndef JMR3927_INIT_INDIRECT_PCI
 		/* Enable Direct mapping Address Space Decoder */
 		tx3927_pcicptr->lbc |= TX3927_PCIC_LBC_ILMDE | TX3927_PCIC_LBC_ILIDE;
-#endif
 
 		/* Clear All Local Bus Status */
 		tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
@@ -491,22 +383,15 @@ void __init tx3927_setup(void)
 
 		/* PCIC Int => IRC IRQ10 */
 		tx3927_pcicptr->il = TX3927_IR_PCI;
-#if 1
 		/* Target Control (per errata) */
 		tx3927_pcicptr->tc = TX3927_PCIC_TC_OF8E | TX3927_PCIC_TC_IF8E;
-#endif
 
 		/* Enable Bus Arbiter */
-#if 0
-		tx3927_pcicptr->req_trace = 0x73737373;
-#endif
 		tx3927_pcicptr->pbapmc = TX3927_PCIC_PBAPMC_PBAEN;
 
 		tx3927_pcicptr->pcicmd = PCI_COMMAND_MASTER |
 			PCI_COMMAND_MEMORY |
-#if 1
 			PCI_COMMAND_IO |
-#endif
 			PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
 	}
 #endif /* CONFIG_PCI */
@@ -555,8 +440,6 @@ static int __init jmr3927_rtc_init(void)
 		.flags	= IORESOURCE_MEM,
 	};
 	struct platform_device *dev;
-	if (!jmr3927_have_nvram())
-		return -ENODEV;
 	dev = platform_device_register_simple("ds1742", -1, &res, 1);
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index 6e72d21..73d1850 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -29,7 +29,6 @@
  */
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
 
 #include <asm/jmr3927/jmr3927.h>
@@ -81,14 +80,8 @@ int __init pcibios_map_irq(struct pci_de
 
 	/* Check OnBoard Ethernet (IDSEL=A24, DevNu=13) */
 	if (dev->bus->parent == NULL &&
-	    slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(24)) {
-		extern int jmr3927_ether1_irq;
-		/* check this irq line was reserved for ether1 */
-		if (jmr3927_ether1_irq != JMR3927_IRQ_ETHER0)
-			irq = JMR3927_IRQ_ETHER0;
-		else
-			irq = 0;	/* disable */
-	}
+	    slot == TX3927_PCIC_IDSEL_AD_TO_SLOT(24))
+		irq = JMR3927_IRQ_ETHER0;
 	return irq;
 }
 
diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index 42530a0..aa698bd 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -40,7 +40,6 @@
 
 #include <asm/addrspace.h>
 #include <asm/jmr3927/jmr3927.h>
-#include <asm/debug.h>
 
 static inline int mkaddr(unsigned char bus, unsigned char dev_fn,
 	unsigned char where)
@@ -130,234 +129,3 @@ struct pci_ops jmr3927_pci_ops = {
 	jmr3927_pci_read_config,
 	jmr3927_pci_write_config,
 };
-
-
-#ifndef JMR3927_INIT_INDIRECT_PCI
-
-inline unsigned long tc_readl(volatile __u32 * addr)
-{
-	return readl(addr);
-}
-
-inline void tc_writel(unsigned long data, volatile __u32 * addr)
-{
-	writel(data, addr);
-}
-#else
-
-unsigned long tc_readl(volatile __u32 * addr)
-{
-	unsigned long val;
-
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) CPHYSADDR(addr);
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_MEMREAD << PCI_IPCIBE_ICMD_SHIFT) |
-	    PCI_IPCIBE_IBE_LONG;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	val =
-	    le32_to_cpu(*(volatile u32 *) (unsigned long) & tx3927_pcicptr->
-			ipcidata);
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-	return val;
-}
-
-void tc_writel(unsigned long data, volatile __u32 * addr)
-{
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcidata =
-	    cpu_to_le32(data);
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) CPHYSADDR(addr);
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_MEMWRITE << PCI_IPCIBE_ICMD_SHIFT) |
-	    PCI_IPCIBE_IBE_LONG;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-}
-
-unsigned char tx_ioinb(unsigned char *addr)
-{
-	unsigned long val;
-	__u32 ioaddr;
-	int offset;
-	int byte;
-
-	ioaddr = (unsigned long) addr;
-	offset = ioaddr & 0x3;
-	byte = 0xf & ~(8 >> offset);
-
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) ioaddr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_IOREAD << PCI_IPCIBE_ICMD_SHIFT) | byte;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	val =
-	    le32_to_cpu(*(volatile u32 *) (unsigned long) & tx3927_pcicptr->
-			ipcidata);
-	val = val & 0xff;
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-	return val;
-}
-
-void tx_iooutb(unsigned long data, unsigned char *addr)
-{
-	__u32 ioaddr;
-	int offset;
-	int byte;
-
-	data = data | (data << 8) | (data << 16) | (data << 24);
-	ioaddr = (unsigned long) addr;
-	offset = ioaddr & 0x3;
-	byte = 0xf & ~(8 >> offset);
-
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcidata = data;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) ioaddr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_IOWRITE << PCI_IPCIBE_ICMD_SHIFT) | byte;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-}
-
-unsigned short tx_ioinw(unsigned short *addr)
-{
-	unsigned long val;
-	__u32 ioaddr;
-	int offset;
-	int byte;
-
-	ioaddr = (unsigned long) addr;
-	offset = ioaddr & 0x2;
-	byte = 3 << offset;
-
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) ioaddr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_IOREAD << PCI_IPCIBE_ICMD_SHIFT) | byte;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	val =
-	    le32_to_cpu(*(volatile u32 *) (unsigned long) & tx3927_pcicptr->
-			ipcidata);
-	val = val & 0xffff;
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-	return val;
-
-}
-
-void tx_iooutw(unsigned long data, unsigned short *addr)
-{
-	__u32 ioaddr;
-	int offset;
-	int byte;
-
-	data = data | (data << 16);
-	ioaddr = (unsigned long) addr;
-	offset = ioaddr & 0x2;
-	byte = 3 << offset;
-
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcidata = data;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) ioaddr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_IOWRITE << PCI_IPCIBE_ICMD_SHIFT) | byte;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-}
-
-unsigned long tx_ioinl(unsigned int *addr)
-{
-	unsigned long val;
-	__u32 ioaddr;
-
-	ioaddr = (unsigned long) addr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) ioaddr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_IOREAD << PCI_IPCIBE_ICMD_SHIFT) |
-	    PCI_IPCIBE_IBE_LONG;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	val =
-	    le32_to_cpu(*(volatile u32 *) (unsigned long) & tx3927_pcicptr->
-			ipcidata);
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-	return val;
-}
-
-void tx_iooutl(unsigned long data, unsigned int *addr)
-{
-	__u32 ioaddr;
-
-	ioaddr = (unsigned long) addr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcidata =
-	    cpu_to_le32(data);
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipciaddr =
-	    (unsigned long) ioaddr;
-	*(volatile u32 *) (unsigned long) & tx3927_pcicptr->ipcibe =
-	    (PCI_IPCIBE_ICMD_IOWRITE << PCI_IPCIBE_ICMD_SHIFT) |
-	    PCI_IPCIBE_IBE_LONG;
-	while (!(tx3927_pcicptr->istat & PCI_ISTAT_IDICC));
-	/* clear by setting */
-	tx3927_pcicptr->istat |= PCI_ISTAT_IDICC;
-}
-
-void tx_insbyte(unsigned char *addr, void *buffer, unsigned int count)
-{
-	unsigned char *ptr = (unsigned char *) buffer;
-
-	while (count--) {
-		*ptr++ = tx_ioinb(addr);
-	}
-}
-
-void tx_insword(unsigned short *addr, void *buffer, unsigned int count)
-{
-	unsigned short *ptr = (unsigned short *) buffer;
-
-	while (count--) {
-		*ptr++ = tx_ioinw(addr);
-	}
-}
-
-void tx_inslong(unsigned int *addr, void *buffer, unsigned int count)
-{
-	unsigned long *ptr = (unsigned long *) buffer;
-
-	while (count--) {
-		*ptr++ = tx_ioinl(addr);
-	}
-}
-
-void tx_outsbyte(unsigned char *addr, void *buffer, unsigned int count)
-{
-	unsigned char *ptr = (unsigned char *) buffer;
-
-	while (count--) {
-		tx_iooutb(*ptr++, addr);
-	}
-}
-
-void tx_outsword(unsigned short *addr, void *buffer, unsigned int count)
-{
-	unsigned short *ptr = (unsigned short *) buffer;
-
-	while (count--) {
-		tx_iooutw(*ptr++, addr);
-	}
-}
-
-void tx_outslong(unsigned int *addr, void *buffer, unsigned int count)
-{
-	unsigned long *ptr = (unsigned long *) buffer;
-
-	while (count--) {
-		tx_iooutl(*ptr++, addr);
-	}
-}
-#endif
diff --git a/include/asm-mips/jmr3927/irq.h b/include/asm-mips/jmr3927/irq.h
deleted file mode 100644
index e3e7ed3..0000000
--- a/include/asm-mips/jmr3927/irq.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- *  linux/include/asm-mips/tx3927/irq.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 Toshiba Corporation
- */
-#ifndef __ASM_TX3927_IRQ_H
-#define __ASM_TX3927_IRQ_H
-
-#ifndef __ASSEMBLY__
-
-#include <asm/irq.h>
-
-struct tb_irq_space {
-	struct tb_irq_space* next;
-	int start_irqno;
-	int nr_irqs;
-	void (*mask_func)(int irq_nr, int space_id);
-	void (*unmask_func)(int irq_no, int space_id);
-	const char *name;
-	int space_id;
-	int can_share;
-};
-extern struct tb_irq_space* tb_irq_spaces;
-
-static __inline__ void add_tb_irq_space(struct tb_irq_space* sp)
-{
-	sp->next = tb_irq_spaces;
-	tb_irq_spaces = sp;
-}
-
-
-struct pt_regs;
-extern void
-toshibaboards_spurious(struct pt_regs *regs, int irq);
-extern void
-toshibaboards_irqdispatch(struct pt_regs *regs, int irq);
-
-extern struct irqaction *
-toshibaboards_get_irq_action(int irq);
-extern int
-toshibaboards_setup_irq(int irq, struct irqaction * new);
-
-
-extern int (*toshibaboards_gen_iack)(void);
-
-#endif /* !__ASSEMBLY__ */
-
-#define NR_ISA_IRQS 16
-#define TB_IRQ_IS_ISA(irq)	\
-	(0 <= (irq) && (irq) < NR_ISA_IRQS)
-#define TB_IRQ_TO_ISA_IRQ(irq)	(irq)
-
-#endif /* __ASM_TX3927_IRQ_H */
diff --git a/include/asm-mips/jmr3927/jmr3927.h b/include/asm-mips/jmr3927/jmr3927.h
index c50e68f..958e297 100644
--- a/include/asm-mips/jmr3927/jmr3927.h
+++ b/include/asm-mips/jmr3927/jmr3927.h
@@ -1,5 +1,5 @@
 /*
- * Defines for the TJSYS JMR-TX3927/JMI-3927IO2/JMY-1394IF.
+ * Defines for the TJSYS JMR-TX3927
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -12,10 +12,7 @@
 
 #include <asm/jmr3927/tx3927.h>
 #include <asm/addrspace.h>
-#include <asm/jmr3927/irq.h>
-#ifndef __ASSEMBLY__
 #include <asm/system.h>
-#endif
 
 /* CS */
 #define JMR3927_ROMCE0	0x1fc00000	/* 4M */
@@ -35,28 +32,10 @@
 #define JMR3927_SDRAM_SIZE	0x02000000	/* 32M */
 #define JMR3927_PORT_BASE	KSEG1
 
-/* select indirect initiator access per errata */
-#define JMR3927_INIT_INDIRECT_PCI
-#define PCI_ISTAT_IDICC           0x1000
-#define PCI_IPCIBE_IBE_LONG       0
-#define PCI_IPCIBE_ICMD_IOREAD    2
-#define PCI_IPCIBE_ICMD_IOWRITE   3
-#define PCI_IPCIBE_ICMD_MEMREAD   6
-#define PCI_IPCIBE_ICMD_MEMWRITE  7
-#define PCI_IPCIBE_ICMD_SHIFT     4
-
 /* Address map (virtual address) */
 #define JMR3927_ROM0_BASE	(KSEG1 + JMR3927_ROMCE0)
 #define JMR3927_ROM1_BASE	(KSEG1 + JMR3927_ROMCE1)
 #define JMR3927_IOC_BASE	(KSEG1 + JMR3927_ROMCE2)
-#define JMR3927_IOB_BASE	(KSEG1 + JMR3927_ROMCE3)
-#define JMR3927_ISAMEM_BASE	(JMR3927_IOB_BASE)
-#define JMR3927_ISAIO_BASE	(JMR3927_IOB_BASE + 0x01000000)
-#define JMR3927_ISAC_BASE	(JMR3927_IOB_BASE + 0x02000000)
-#define JMR3927_LCDVGA_REG_BASE	(JMR3927_IOB_BASE + 0x03000000)
-#define JMR3927_LCDVGA_MEM_BASE	(JMR3927_IOB_BASE + 0x03800000)
-#define JMR3927_JMY1394_BASE	(KSEG1 + JMR3927_ROMCE5)
-#define JMR3927_PREMIER3_BASE	(JMR3927_JMY1394_BASE + 0x00100000)
 #define JMR3927_PCIMEM_BASE	(KSEG1 + JMR3927_PCIMEM)
 #define JMR3927_PCIIO_BASE	(KSEG1 + JMR3927_PCIIO)
 
@@ -72,25 +51,14 @@
 #define JMR3927_IOC_INTP_ADDR	(JMR3927_IOC_BASE + 0x000b0000)
 #define JMR3927_IOC_RESET_ADDR	(JMR3927_IOC_BASE + 0x000f0000)
 
-#define JMR3927_ISAC_REV_ADDR	(JMR3927_ISAC_BASE + 0x00000000)
-#define JMR3927_ISAC_EINTS_ADDR	(JMR3927_ISAC_BASE + 0x00200000)
-#define JMR3927_ISAC_EINTM_ADDR	(JMR3927_ISAC_BASE + 0x00300000)
-#define JMR3927_ISAC_NMI_ADDR	(JMR3927_ISAC_BASE + 0x00400000)
-#define JMR3927_ISAC_LED_ADDR	(JMR3927_ISAC_BASE + 0x00500000)
-#define JMR3927_ISAC_INTP_ADDR	(JMR3927_ISAC_BASE + 0x00800000)
-#define JMR3927_ISAC_INTS1_ADDR	(JMR3927_ISAC_BASE + 0x00900000)
-#define JMR3927_ISAC_INTS2_ADDR	(JMR3927_ISAC_BASE + 0x00a00000)
-#define JMR3927_ISAC_INTM_ADDR	(JMR3927_ISAC_BASE + 0x00b00000)
-
 /* Flash ROM */
 #define JMR3927_FLASH_BASE	(JMR3927_ROM0_BASE)
 #define JMR3927_FLASH_SIZE	0x00400000
 
-/* bits for IOC_REV/IOC_BREV/ISAC_REV (high byte) */
+/* bits for IOC_REV/IOC_BREV (high byte) */
 #define JMR3927_IDT_MASK	0xfc
 #define JMR3927_REV_MASK	0x03
 #define JMR3927_IOC_IDT		0xe0
-#define JMR3927_ISAC_IDT	0x20
 
 /* bits for IOC_INTS1/IOC_INTS2/IOC_INTM/IOC_INTP (high byte) */
 #define JMR3927_IOC_INTB_PCIA	0
@@ -114,40 +82,6 @@
 #define JMR3927_IOC_RESET_CPU	1
 #define JMR3927_IOC_RESET_PCI	2
 
-/* bits for ISAC_EINTS/ISAC_EINTM (high byte) */
-#define JMR3927_ISAC_EINTB_IOCHK	2
-#define JMR3927_ISAC_EINTB_BWTH	4
-#define JMR3927_ISAC_EINTF_IOCHK	(1 << JMR3927_ISAC_EINTB_IOCHK)
-#define JMR3927_ISAC_EINTF_BWTH	(1 << JMR3927_ISAC_EINTB_BWTH)
-
-/* bits for ISAC_LED (high byte) */
-#define JMR3927_ISAC_LED_ISALED	0x01
-#define JMR3927_ISAC_LED_USRLED	0x02
-
-/* bits for ISAC_INTS/ISAC_INTM/ISAC_INTP (high byte) */
-#define JMR3927_ISAC_INTB_IRQ5	0
-#define JMR3927_ISAC_INTB_IRQKB	1
-#define JMR3927_ISAC_INTB_IRQMOUSE	2
-#define JMR3927_ISAC_INTB_IRQ4	3
-#define JMR3927_ISAC_INTB_IRQ12	4
-#define JMR3927_ISAC_INTB_IRQ3	5
-#define JMR3927_ISAC_INTB_IRQ10	6
-#define JMR3927_ISAC_INTB_ISAER	7
-#define JMR3927_ISAC_INTF_IRQ5	(1 << JMR3927_ISAC_INTB_IRQ5)
-#define JMR3927_ISAC_INTF_IRQKB	(1 << JMR3927_ISAC_INTB_IRQKB)
-#define JMR3927_ISAC_INTF_IRQMOUSE	(1 << JMR3927_ISAC_INTB_IRQMOUSE)
-#define JMR3927_ISAC_INTF_IRQ4	(1 << JMR3927_ISAC_INTB_IRQ4)
-#define JMR3927_ISAC_INTF_IRQ12	(1 << JMR3927_ISAC_INTB_IRQ12)
-#define JMR3927_ISAC_INTF_IRQ3	(1 << JMR3927_ISAC_INTB_IRQ3)
-#define JMR3927_ISAC_INTF_IRQ10	(1 << JMR3927_ISAC_INTB_IRQ10)
-#define JMR3927_ISAC_INTF_ISAER	(1 << JMR3927_ISAC_INTB_ISAER)
-
-#ifndef __ASSEMBLY__
-
-#if 0
-#define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned short *)(a)) = (d) << 8)
-#define jmr3927_ioc_reg_in(a)		(((*(volatile unsigned short *)(a)) >> 8) & 0xff)
-#else
 #if defined(__BIG_ENDIAN)
 #define jmr3927_ioc_reg_out(d, a)	((*(volatile unsigned char *)(a)) = (d))
 #define jmr3927_ioc_reg_in(a)		(*(volatile unsigned char *)(a))
@@ -157,31 +91,9 @@
 #else
 #error "No Endian"
 #endif
-#endif
-#define jmr3927_isac_reg_out(d, a)	((*(volatile unsigned char *)(a)) = (d))
-#define jmr3927_isac_reg_in(a)		(*(volatile unsigned char *)(a))
-
-static inline int jmr3927_have_isac(void)
-{
-	unsigned char idt;
-	unsigned long flags;
-	unsigned long romcr3;
-
-	local_irq_save(flags);
-	romcr3 = tx3927_romcptr->cr[3];
-	tx3927_romcptr->cr[3] &= 0xffffefff;	/* do not wait infinitely */
-	idt = jmr3927_isac_reg_in(JMR3927_ISAC_REV_ADDR) & JMR3927_IDT_MASK;
-	tx3927_romcptr->cr[3] = romcr3;
-	local_irq_restore(flags);
-
-	return idt == JMR3927_ISAC_IDT;
-}
-#define jmr3927_have_nvram() \
-	((jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_IDT_MASK) == JMR3927_IOC_IDT)
 
 /* LED macro */
 #define jmr3927_led_set(n/*0-16*/)	jmr3927_ioc_reg_out(~(n), JMR3927_IOC_LED_ADDR)
-#define jmr3927_io_led_set(n/*0-3*/)	jmr3927_isac_reg_out((n), JMR3927_ISAC_LED_ADDR)
 
 #define jmr3927_led_and_set(n/*0-16*/)	jmr3927_ioc_reg_out((~(n)) & jmr3927_ioc_reg_in(JMR3927_IOC_LED_ADDR), JMR3927_IOC_LED_ADDR)
 
@@ -190,10 +102,6 @@ static inline int jmr3927_have_isac(void
 #define jmr3927_dipsw2()	((tx3927_pioptr->din & (1 << 10)) == 0)
 #define jmr3927_dipsw3()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 2) == 0)
 #define jmr3927_dipsw4()	((jmr3927_ioc_reg_in(JMR3927_IOC_DIPSW_ADDR) & 1) == 0)
-#define jmr3927_io_dipsw()	(jmr3927_isac_reg_in(JMR3927_ISAC_LED_ADDR) >> 4)
-
-
-#endif /* !__ASSEMBLY__ */
 
 /*
  * IRQ mappings
@@ -206,16 +114,10 @@ static inline int jmr3927_have_isac(void
  */
 #define JMR3927_NR_IRQ_IRC	16	/* On-Chip IRC */
 #define JMR3927_NR_IRQ_IOC	8	/* PCI/MODEM/INT[6:7] */
-#define JMR3927_NR_IRQ_ISAC	8	/* ISA */
 
-
-#define JMR3927_IRQ_IRC	NR_ISA_IRQS
+#define JMR3927_IRQ_IRC	16
 #define JMR3927_IRQ_IOC	(JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC)
-#define JMR3927_IRQ_ISAC	(JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC)
-#define JMR3927_IRQ_END	(JMR3927_IRQ_ISAC + JMR3927_NR_IRQ_ISAC)
-#define JMR3927_IRQ_IS_IRC(irq)	(JMR3927_IRQ_IRC <= (irq) && (irq) < JMR3927_IRQ_IOC)
-#define JMR3927_IRQ_IS_IOC(irq)		(JMR3927_IRQ_IOC <= (irq) && (irq) < JMR3927_IRQ_ISAC)
-#define JMR3927_IRQ_IS_ISAC(irq)	(JMR3927_IRQ_ISAC <= (irq) && (irq) < JMR3927_IRQ_END)
+#define JMR3927_IRQ_END	(JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC)
 
 #define JMR3927_IRQ_IRC_INT0	(JMR3927_IRQ_IRC + TX3927_IR_INT0)
 #define JMR3927_IRQ_IRC_INT1	(JMR3927_IRQ_IRC + TX3927_IR_INT1)
@@ -240,37 +142,13 @@ static inline int jmr3927_have_isac(void
 #define JMR3927_IRQ_IOC_INT6	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT6)
 #define JMR3927_IRQ_IOC_INT7	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_INT7)
 #define JMR3927_IRQ_IOC_SOFT	(JMR3927_IRQ_IOC + JMR3927_IOC_INTB_SOFT)
-#define JMR3927_IRQ_ISAC_IRQ5	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQ5)
-#define JMR3927_IRQ_ISAC_IRQKB	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQKB)
-#define JMR3927_IRQ_ISAC_IRQMOUSE	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQMOUSE)
-#define JMR3927_IRQ_ISAC_IRQ4	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQ4)
-#define JMR3927_IRQ_ISAC_IRQ12	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQ12)
-#define JMR3927_IRQ_ISAC_IRQ3	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQ3)
-#define JMR3927_IRQ_ISAC_IRQ10	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_IRQ10)
-#define JMR3927_IRQ_ISAC_ISAER	(JMR3927_IRQ_ISAC + JMR3927_ISAC_INTB_ISAER)
 
-#if 0	/* auto detect */
-/* RTL8019AS 10M Ether (JMI-3927IO2:JPW2:1-2 Short) */
-#define JMR3927_IRQ_ETHER1	JMR3927_IRQ_IRC_INT0
-#endif
 /* IOC (PCI, MODEM) */
 #define JMR3927_IRQ_IOCINT	JMR3927_IRQ_IRC_INT1
-/* ISAC (ISA, PCMCIA, KEYBOARD, MOUSE) */
-#define JMR3927_IRQ_ISACINT	JMR3927_IRQ_IRC_INT2
 /* TC35815 100M Ether (JMR-TX3912:JPW4:2-3 Short) */
 #define JMR3927_IRQ_ETHER0	JMR3927_IRQ_IRC_INT3
 /* Clock Tick (10ms) */
 #define JMR3927_IRQ_TICK	JMR3927_IRQ_IRC_TMR0
-#define JMR3927_IRQ_IDE		JMR3927_IRQ_ISAC_IRQ12
-
-/* IEEE1394 (Note that this may conflicts with RTL8019AS 10M Ether...) */
-#define JMR3927_IRQ_PREMIER3	JMR3927_IRQ_IRC_INT0
-
-/* I/O Ports */
-/* RTL8019AS 10M Ether */
-#define JMR3927_ETHER1_PORT	(JMR3927_ISAIO_BASE - JMR3927_PORT_BASE + 0x280)
-#define JMR3927_KBD_PORT	(JMR3927_ISAIO_BASE - JMR3927_PORT_BASE + 0x00800060)
-#define JMR3927_IDE_PORT	(JMR3927_ISAIO_BASE - JMR3927_PORT_BASE + 0x001001f0)
 
 /* Clocks */
 #define JMR3927_CORECLK	132710400	/* 132.7MHz */
diff --git a/include/asm-mips/jmr3927/tx3927.h b/include/asm-mips/jmr3927/tx3927.h
index b3d67c7..0b9073b 100644
--- a/include/asm-mips/jmr3927/tx3927.h
+++ b/include/asm-mips/jmr3927/tx3927.h
@@ -22,8 +22,6 @@
 #define TX3927_SIO_REG(ch)	(0xfffef300 + (ch) * 0x100)
 #define TX3927_PIO_REG		0xfffef500
 
-#ifndef __ASSEMBLY__
-
 struct tx3927_sdramc_reg {
 	volatile unsigned long cr[8];
 	volatile unsigned long tr[3];
@@ -164,8 +162,6 @@ struct tx3927_ccfg_reg {
 	volatile unsigned long pdcr;
 };
 
-#endif /* !__ASSEMBLY__ */
-
 /*
  * SDRAMC
  */
@@ -348,8 +344,6 @@ struct tx3927_ccfg_reg {
 #define TX3927_PCFG_SELDMA_ALL	0x0000000f
 #define TX3927_PCFG_SELDMA(ch)	(0x00000001<<(ch))
 
-#ifndef __ASSEMBLY__
-
 #define tx3927_sdramcptr	((struct tx3927_sdramc_reg *)TX3927_SDRAMC_REG)
 #define tx3927_romcptr		((struct tx3927_romc_reg *)TX3927_ROMC_REG)
 #define tx3927_dmaptr		((struct tx3927_dma_reg *)TX3927_DMA_REG)
@@ -360,6 +354,4 @@ struct tx3927_ccfg_reg {
 #define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
 #define tx3927_pioptr		((struct txx927_pio_reg *)TX3927_PIO_REG)
 
-#endif /* !__ASSEMBLY__ */
-
 #endif /* __ASM_TX3927_H */
diff --git a/include/asm-mips/jmr3927/txx927.h b/include/asm-mips/jmr3927/txx927.h
index 9d5792e..58a8ff6 100644
--- a/include/asm-mips/jmr3927/txx927.h
+++ b/include/asm-mips/jmr3927/txx927.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_TXX927_H
 #define __ASM_TXX927_H
 
-#ifndef __ASSEMBLY__
-
 struct txx927_tmr_reg {
 	volatile unsigned long tcr;
 	volatile unsigned long tisr;
@@ -52,9 +50,6 @@ struct txx927_pio_reg {
 	volatile unsigned long maskext;
 };
 
-#endif /* !__ASSEMBLY__ */
-
-
 /*
  * TMR
  */
