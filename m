Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 15:22:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:9689 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022329AbXFVOVy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2007 15:21:54 +0100
Received: from localhost (p1126-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.126])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EAFBB8633; Fri, 22 Jun 2007 23:21:48 +0900 (JST)
Date:	Fri, 22 Jun 2007 23:22:29 +0900 (JST)
Message-Id: <20070622.232229.72712905.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com, mlachwani@mvista.com
Subject: [PATCH 4/4] rbtx4938: Update and minimize defconfig
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch depends on:
[PATCH 2/4] rbtx4938: Convert SPI codes to use generic SPI drivers

 arch/mips/configs/rbhma4500_defconfig |  896 ++++-----------------------------
 1 files changed, 102 insertions(+), 794 deletions(-)

diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 6b9beba..4aee174 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:39 2007
+# Linux kernel version: 2.6.22-rc5
+# Fri Jun 22 21:39:45 2007
 #
 CONFIG_MIPS=y
 
@@ -9,19 +9,8 @@ CONFIG_MIPS=y
 # Machine selection
 #
 CONFIG_ZONE_DMA=y
-# CONFIG_MIPS_MTX1 is not set
-# CONFIG_MIPS_BOSPORUS is not set
-# CONFIG_MIPS_PB1000 is not set
-# CONFIG_MIPS_PB1100 is not set
-# CONFIG_MIPS_PB1500 is not set
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_LEMOTE_FULONG is not set
+# CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
@@ -32,15 +21,13 @@ CONFIG_ZONE_DMA=y
 # CONFIG_MIPS_SEAD is not set
 # CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
 # CONFIG_MOMENCO_OCELOT is not set
 # CONFIG_MOMENCO_OCELOT_3 is not set
-# CONFIG_MOMENCO_OCELOT_G is not set
-# CONFIG_MIPS_XXS1500 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_DDB5477 is not set
 # CONFIG_MACH_VR41XX is not set
+# CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_QEMU is not set
 # CONFIG_MARKEINS is not set
@@ -80,6 +67,7 @@ CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_I8259=y
+# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
@@ -92,6 +80,7 @@ CONFIG_HAVE_STD_PC_SERIAL_PORT=y
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -148,12 +137,12 @@ CONFIG_ZONE_DMA_FLAG=1
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
@@ -185,28 +174,35 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
 CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
+CONFIG_ANON_INODES=y
 # CONFIG_EPOLL is not set
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -243,17 +239,12 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
-# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
@@ -265,10 +256,7 @@ CONFIG_TRAD_SIGNALS=y
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
@@ -278,14 +266,9 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-# CONFIG_XFRM_USER is not set
-# CONFIG_XFRM_SUB_POLICY is not set
-CONFIG_XFRM_MIGRATE=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -293,7 +276,7 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_DHCP is not set
-CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
@@ -304,130 +287,23 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
-CONFIG_INET_TUNNEL=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
-CONFIG_IPV6=m
-# CONFIG_IPV6_PRIVACY is not set
-CONFIG_IPV6_ROUTER_PREF=y
-CONFIG_IPV6_ROUTE_INFO=y
-# CONFIG_INET6_AH is not set
-# CONFIG_INET6_ESP is not set
-# CONFIG_INET6_IPCOMP is not set
-CONFIG_IPV6_MIP6=y
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
-CONFIG_INET6_XFRM_MODE_TUNNEL=m
-CONFIG_INET6_XFRM_MODE_BEET=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
-CONFIG_IPV6_SIT=m
-# CONFIG_IPV6_TUNNEL is not set
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_IPV6_SUBTREES=y
-CONFIG_NETWORK_SECMARK=y
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
-
-#
-# Core Netfilter Configuration
-#
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_NETFILTER_NETLINK_QUEUE=m
-CONFIG_NETFILTER_NETLINK_LOG=m
-CONFIG_NF_CONNTRACK_ENABLED=m
-CONFIG_NF_CONNTRACK_SUPPORT=y
-# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
-CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_ACCT=y
-CONFIG_NF_CONNTRACK_MARK=y
-CONFIG_NF_CONNTRACK_SECMARK=y
-CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_GRE=m
-CONFIG_NF_CT_PROTO_SCTP=m
-CONFIG_NF_CONNTRACK_AMANDA=m
-CONFIG_NF_CONNTRACK_FTP=m
-CONFIG_NF_CONNTRACK_H323=m
-CONFIG_NF_CONNTRACK_IRC=m
-# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
-CONFIG_NF_CONNTRACK_PPTP=m
-CONFIG_NF_CONNTRACK_SANE=m
-CONFIG_NF_CONNTRACK_SIP=m
-CONFIG_NF_CONNTRACK_TFTP=m
-CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
-CONFIG_NETFILTER_XT_TARGET_NFLOG=m
-CONFIG_NETFILTER_XT_TARGET_SECMARK=m
-CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
-CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
-CONFIG_NETFILTER_XT_MATCH_DSCP=m
-CONFIG_NETFILTER_XT_MATCH_ESP=m
-CONFIG_NETFILTER_XT_MATCH_HELPER=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_LIMIT=m
-CONFIG_NETFILTER_XT_MATCH_MAC=m
-CONFIG_NETFILTER_XT_MATCH_MARK=m
-# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
-CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
-CONFIG_NETFILTER_XT_MATCH_QUOTA=m
-CONFIG_NETFILTER_XT_MATCH_REALM=m
-CONFIG_NETFILTER_XT_MATCH_SCTP=m
-CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
-CONFIG_NETFILTER_XT_MATCH_STRING=m
-CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
-
-#
-# IP: Netfilter Configuration
-#
-CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_NF_CONNTRACK_PROC_COMPAT=y
-# CONFIG_IP_NF_QUEUE is not set
-# CONFIG_IP_NF_IPTABLES is not set
-# CONFIG_IP_NF_ARPTABLES is not set
-
-#
-# IPv6: Netfilter Configuration (EXPERIMENTAL)
-#
-CONFIG_NF_CONNTRACK_IPV6=m
-# CONFIG_IP6_NF_QUEUE is not set
-# CONFIG_IP6_NF_IPTABLES is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -445,7 +321,6 @@ CONFIG_NF_CONNTRACK_IPV6=m
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
-CONFIG_NET_CLS_ROUTE=y
 
 #
 # Network testing
@@ -454,15 +329,16 @@ CONFIG_NET_CLS_ROUTE=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_CRYPT_TKIP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
-CONFIG_FIB_RULES=y
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -473,94 +349,13 @@ CONFIG_FIB_RULES=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
 #
-CONFIG_CONNECTOR=m
-
-#
-# Memory Technology Devices (MTD)
-#
-CONFIG_MTD=y
-# CONFIG_MTD_DEBUG is not set
-# CONFIG_MTD_CONCAT is not set
-CONFIG_MTD_PARTITIONS=y
-# CONFIG_MTD_REDBOOT_PARTS is not set
-# CONFIG_MTD_CMDLINE_PARTS is not set
-
-#
-# User Modules And Translation Layers
-#
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLKDEVS=y
-CONFIG_MTD_BLOCK=y
-# CONFIG_FTL is not set
-# CONFIG_NFTL is not set
-# CONFIG_INFTL is not set
-# CONFIG_RFD_FTL is not set
-# CONFIG_SSFDC is not set
-
-#
-# RAM/ROM/Flash chip drivers
-#
-CONFIG_MTD_CFI=y
-# CONFIG_MTD_JEDECPROBE is not set
-CONFIG_MTD_GEN_PROBE=y
-# CONFIG_MTD_CFI_ADV_OPTIONS is not set
-CONFIG_MTD_MAP_BANK_WIDTH_1=y
-CONFIG_MTD_MAP_BANK_WIDTH_2=y
-CONFIG_MTD_MAP_BANK_WIDTH_4=y
-# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
-CONFIG_MTD_CFI_I1=y
-CONFIG_MTD_CFI_I2=y
-# CONFIG_MTD_CFI_I4 is not set
-# CONFIG_MTD_CFI_I8 is not set
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-# CONFIG_MTD_CFI_STAA is not set
-CONFIG_MTD_CFI_UTIL=y
-# CONFIG_MTD_RAM is not set
-# CONFIG_MTD_ROM is not set
-# CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
-
-#
-# Mapping drivers for chip access
-#
-# CONFIG_MTD_COMPLEX_MAPPINGS is not set
-# CONFIG_MTD_PHYSMAP is not set
-# CONFIG_MTD_PLATRAM is not set
-
-#
-# Self-contained MTD device drivers
-#
-# CONFIG_MTD_PMC551 is not set
-# CONFIG_MTD_SLRAM is not set
-# CONFIG_MTD_PHRAM is not set
-# CONFIG_MTD_MTDRAM is not set
-# CONFIG_MTD_BLOCK2MTD is not set
-
-#
-# Disk-On-Chip Device Drivers
-#
-# CONFIG_MTD_DOC2000 is not set
-# CONFIG_MTD_DOC2001 is not set
-# CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
-# CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
-# CONFIG_MTD_ONENAND is not set
+# CONFIG_CONNECTOR is not set
+# CONFIG_MTD is not set
 
 #
 # Parallel port support
@@ -582,93 +377,30 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
-CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
-# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
-CONFIG_SGI_IOC4=m
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
-CONFIG_IDE=y
-CONFIG_IDE_MAX_HWIFS=4
-CONFIG_BLK_DEV_IDE=y
-
-#
-# Please see Documentation/ide.txt for help/info on IDE drives
-#
-# CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-# CONFIG_IDEDISK_MULTI_MODE is not set
-CONFIG_BLK_DEV_IDECD=y
-# CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_IDE_TASK_IOCTL is not set
-
-#
-# IDE chipset support/bugfixes
-#
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_IDEPCI=y
-CONFIG_IDEPCI_SHARE_IRQ=y
-# CONFIG_BLK_DEV_OFFBOARD is not set
-# CONFIG_BLK_DEV_GENERIC is not set
-# CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_PCI_AUTO is not set
-# CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_BLK_DEV_ALI15X3 is not set
-# CONFIG_BLK_DEV_AMD74XX is not set
-# CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_BLK_DEV_TRIFLEX is not set
-# CONFIG_BLK_DEV_CY82C693 is not set
-# CONFIG_BLK_DEV_CS5520 is not set
-# CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT34X is not set
-# CONFIG_BLK_DEV_HPT366 is not set
-# CONFIG_BLK_DEV_JMICRON is not set
-# CONFIG_BLK_DEV_SC1200 is not set
-# CONFIG_BLK_DEV_PIIX is not set
-CONFIG_BLK_DEV_IT8213=m
-# CONFIG_BLK_DEV_IT821X is not set
-# CONFIG_BLK_DEV_NS87415 is not set
-# CONFIG_BLK_DEV_PDC202XX_OLD is not set
-# CONFIG_BLK_DEV_PDC202XX_NEW is not set
-# CONFIG_BLK_DEV_SVWKS is not set
-# CONFIG_BLK_DEV_SIIMAGE is not set
-# CONFIG_BLK_DEV_SLC90E66 is not set
-# CONFIG_BLK_DEV_TRM290 is not set
-# CONFIG_BLK_DEV_VIA82CXXX is not set
-CONFIG_BLK_DEV_TC86C001=m
-# CONFIG_IDE_ARM is not set
-CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_BLINK is not set
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 # CONFIG_SCSI_NETLINK is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 # CONFIG_ATA is not set
 
 #
@@ -684,6 +416,7 @@ CONFIG_RAID_ATTRS=m
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 
 #
@@ -698,36 +431,15 @@ CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
-CONFIG_TUN=m
-
-#
-# ARCnet devices
-#
+# CONFIG_TUN is not set
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
-CONFIG_PHYLIB=m
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-CONFIG_VITESSE_PHY=m
-CONFIG_SMSC_PHY=m
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
@@ -746,6 +458,7 @@ CONFIG_NET_PCI=y
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
+CONFIG_TC35815=y
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
@@ -760,91 +473,20 @@ CONFIG_NET_PCI=y
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
 # CONFIG_SC92031 is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=m
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-CONFIG_NET_RADIO=y
-# CONFIG_NET_WIRELESS_RTNETLINK is not set
-
-#
-# Obsolete Wireless cards support (pre-802.11)
-#
-# CONFIG_STRIP is not set
-
-#
-# Wireless 802.11b ISA/PCI cards support
-#
-# CONFIG_IPW2100 is not set
-CONFIG_IPW2200=m
-# CONFIG_IPW2200_MONITOR is not set
-# CONFIG_IPW2200_QOS is not set
-# CONFIG_IPW2200_DEBUG is not set
-# CONFIG_HERMES is not set
-# CONFIG_ATMEL is not set
-
-#
-# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
-#
-# CONFIG_PRISM54 is not set
-# CONFIG_USB_ZD1201 is not set
-# CONFIG_HOSTAP is not set
-# CONFIG_BCM43XX is not set
-# CONFIG_ZD1211RW is not set
-CONFIG_NET_WIRELESS=y
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-# CONFIG_PPP_BSDCOMP is not set
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=m
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -863,57 +505,18 @@ CONFIG_SLHC=m
 #
 # Input device support
 #
-CONFIG_INPUT=y
-# CONFIG_INPUT_FF_MEMLESS is not set
-
-#
-# Userland interfaces
-#
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input Device Drivers
-#
-CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_KEYBOARD_SUNKBD is not set
-# CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
-# CONFIG_KEYBOARD_NEWTON is not set
-# CONFIG_KEYBOARD_STOWAWAY is not set
-CONFIG_INPUT_MOUSE=y
-CONFIG_MOUSE_PS2=y
-# CONFIG_MOUSE_SERIAL is not set
-# CONFIG_MOUSE_VSXXXAA is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+# CONFIG_INPUT is not set
 
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_SERIO_RAW is not set
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
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -925,11 +528,12 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
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
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -939,15 +543,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_DRM is not set
@@ -957,10 +556,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -985,92 +581,36 @@ CONFIG_SPI_AT25=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
+# CONFIG_HWMON is not set
 
 #
-# Hardware Monitoring support
+# Multifunction device drivers
 #
-CONFIG_HWMON=y
-# CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_PC87427 is not set
-# CONFIG_SENSORS_VT1211 is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_MFD_SM501 is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
-CONFIG_FB=y
-CONFIG_FB_CFB_FILLRECT=y
-CONFIG_FB_CFB_COPYAREA=y
-CONFIG_FB_CFB_IMAGEBLIT=y
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
-CONFIG_FB_ATY=y
-CONFIG_FB_ATY_CT=y
-# CONFIG_FB_ATY_GENERIC_LCD is not set
-# CONFIG_FB_ATY_GX is not set
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
-CONFIG_VGA_CONSOLE=y
-# CONFIG_VGACON_SOFT_SCROLLBACK is not set
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
-
-#
-# Logo configuration
-#
-# CONFIG_LOGO is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Sound
+# Display device support
 #
-# CONFIG_SOUND is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_FB is not set
 
 #
-# HID Devices
+# Sound
 #
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
+# CONFIG_SOUND is not set
 
 #
 # USB support
@@ -1078,120 +618,16 @@ CONFIG_HID=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-CONFIG_USB=y
-# CONFIG_USB_DEBUG is not set
-
-#
-# Miscellaneous USB options
-#
-# CONFIG_USB_DEVICEFS is not set
-# CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_SUSPEND is not set
-# CONFIG_USB_OTG is not set
-
-#
-# USB Host Controller Drivers
-#
-# CONFIG_USB_EHCI_HCD is not set
-# CONFIG_USB_ISP116X_HCD is not set
-# CONFIG_USB_OHCI_HCD is not set
-# CONFIG_USB_UHCI_HCD is not set
-# CONFIG_USB_SL811_HCD is not set
-
-#
-# USB Device Class drivers
-#
-# CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
+# CONFIG_USB is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
-#
-# CONFIG_USB_LIBUSUAL is not set
-
-#
-# USB Input Devices
-#
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-CONFIG_USB_HIDDEV=y
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-CONFIG_USB_YEALINK=m
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
-# USB Imaging devices
-#
-# CONFIG_USB_MDC800 is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
-# CONFIG_USB_USBNET is not set
-CONFIG_USB_MON=y
-
-#
-# USB port drivers
-#
-
-#
-# USB Serial Converter support
-#
-# CONFIG_USB_SERIAL is not set
-
-#
-# USB Miscellaneous drivers
-#
-# CONFIG_USB_EMI62 is not set
-# CONFIG_USB_EMI26 is not set
-# CONFIG_USB_ADUTUX is not set
-# CONFIG_USB_AUERSWALD is not set
-# CONFIG_USB_RIO500 is not set
-# CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set
-# CONFIG_USB_LED is not set
-# CONFIG_USB_CYPRESS_CY7C63 is not set
-# CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
-# CONFIG_USB_IDMOUSE is not set
-# CONFIG_USB_FTDI_ELAN is not set
-# CONFIG_USB_APPLEDISPLAY is not set
-# CONFIG_USB_LD is not set
-# CONFIG_USB_TRANCEVIBRATOR is not set
-
-#
-# USB DSL modem support
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -1271,38 +707,15 @@ CONFIG_RTC_DRV_RS5C348=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
 # File systems
 #
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
-# CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=m
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
 # CONFIG_EXT4DEV_FS is not set
-CONFIG_JBD=m
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
-CONFIG_REISERFS_FS=m
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
-# CONFIG_REISERFS_FS_XATTR is not set
+# CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-CONFIG_XFS_FS=m
-# CONFIG_XFS_QUOTA is not set
-# CONFIG_XFS_SECURITY is not set
-# CONFIG_XFS_POSIX_ACL is not set
-# CONFIG_XFS_RT is not set
+# CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -1312,26 +725,21 @@ CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
-CONFIG_AUTOFS4_FS=m
-CONFIG_FUSE_FS=m
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=y
-# CONFIG_JOLIET is not set
-# CONFIG_ZISOFS is not set
+# CONFIG_ISO9660_FS is not set
 # CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-CONFIG_VFAT_FS=y
-CONFIG_FAT_DEFAULT_CODEPAGE=437
-CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1345,7 +753,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -1357,16 +765,7 @@ CONFIG_CONFIGFS_FS=m
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_DEBUG=0
-CONFIG_JFFS2_FS_WRITEBUFFER=y
-# CONFIG_JFFS2_SUMMARY is not set
-# CONFIG_JFFS2_FS_XATTR is not set
-# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
-CONFIG_JFFS2_ZLIB=y
-CONFIG_JFFS2_RTIME=y
-# CONFIG_JFFS2_RUBIN is not set
-CONFIG_CRAMFS=y
+# CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
@@ -1381,19 +780,16 @@ CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
+# CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-CONFIG_EXPORTFS=m
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -1409,54 +805,12 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Native Language Support
 #
-CONFIG_NLS=y
-CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
-# CONFIG_NLS_CODEPAGE_737 is not set
-# CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
-# CONFIG_NLS_CODEPAGE_855 is not set
-# CONFIG_NLS_CODEPAGE_857 is not set
-# CONFIG_NLS_CODEPAGE_860 is not set
-# CONFIG_NLS_CODEPAGE_861 is not set
-# CONFIG_NLS_CODEPAGE_862 is not set
-# CONFIG_NLS_CODEPAGE_863 is not set
-# CONFIG_NLS_CODEPAGE_864 is not set
-# CONFIG_NLS_CODEPAGE_865 is not set
-# CONFIG_NLS_CODEPAGE_866 is not set
-# CONFIG_NLS_CODEPAGE_869 is not set
-# CONFIG_NLS_CODEPAGE_936 is not set
-# CONFIG_NLS_CODEPAGE_950 is not set
-# CONFIG_NLS_CODEPAGE_932 is not set
-# CONFIG_NLS_CODEPAGE_949 is not set
-# CONFIG_NLS_CODEPAGE_874 is not set
-# CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
-# CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
-# CONFIG_NLS_ISO8859_2 is not set
-# CONFIG_NLS_ISO8859_3 is not set
-# CONFIG_NLS_ISO8859_4 is not set
-# CONFIG_NLS_ISO8859_5 is not set
-# CONFIG_NLS_ISO8859_6 is not set
-# CONFIG_NLS_ISO8859_7 is not set
-# CONFIG_NLS_ISO8859_9 is not set
-# CONFIG_NLS_ISO8859_13 is not set
-# CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
-# CONFIG_NLS_KOI8_R is not set
-# CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
+# CONFIG_NLS is not set
 
 #
 # Distributed Lock Manager
 #
-CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
+# CONFIG_DLM is not set
 
 #
 # Profiling support
@@ -1474,7 +828,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE=""
 CONFIG_SYS_SUPPORTS_KGDB=y
@@ -1488,62 +841,17 @@ CONFIG_SYS_SUPPORTS_KGDB=y
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_TWOFISH_COMMON=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-CONFIG_CRYPTO_CAMELLIA=m
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+# CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=y
-CONFIG_ZLIB_DEFLATE=y
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
+# CONFIG_LIBCRC32C is not set
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
