Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:49:52 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64349 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009390AbaIUArQVSkMI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:47:16 +0200
Received: by mail-pd0-f176.google.com with SMTP id z10so899762pdj.21
        for <multiple recipients>; Sat, 20 Sep 2014 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkmzdGpUJCj683ZWhx5hNXGCtdM5yjtL3CacsnLh36w=;
        b=R2snnvPF7BFpSI82K0iX2ooGzPosnCI/UFMItGNpusWx2vVPro63Iq8RoR9ZU5u/f+
         Ebo4fJgO6mWjw43i1oOCSjDbhMG++ppDo5MTl4X+idmzo8xOfxBUryKbWaro/UMHh8gz
         zw1lpj45UGD+4r7/E8W6HCRVLfa3OhWrtyGDVTTqPf2R1RFreNvCM2HcNBkYn12wXbdt
         eauzxUCeFtrVEwSKWXK2SHNwYcHfjTVbgVpQ69lhJWC+UGxxpmU1APwbFVzHUXyt4KMW
         Y6oqpcbs2LSDUcmieL/avkwXk/yTKdOo3U+JVKXPKUef/fSp9xUw9BYHpd96BntyLRhx
         2AJA==
X-Received: by 10.66.139.106 with SMTP id qx10mr14142672pab.126.1411260430110;
        Sat, 20 Sep 2014 17:47:10 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id ts7sm5480448pbc.90.2014.09.20.17.47.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:47:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 10/11] next: mips: Fix nlm_xlr_defconfig
Date:   Sat, 20 Sep 2014 17:46:25 -0700
Message-Id: <1411260386-6800-11-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commit 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead
of selecting NET') changes 'select NET' to 'depends NET'. As a result, many
configurations which do not explicitly select CONFIG_NET are no longer valid
and need to be updated.

The command sequence to create the new configuration is as follows.

- Run "make ARCH=mips <configuration>" on upstream kernel
- Copy resulting .config to next-20140919
- Run "make ARCH=mips olddefconfig" in next-20140919
- Run "make ARCH=mips savedefconfig"
- Copy resulting defconfig file to arch/mips/configs/<configuration>
- Build the image with the resulting configuration

Fixes: 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead of selecting NET')
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/configs/nlm_xlr_defconfig | 90 ++++++++++++-------------------------
 1 file changed, 28 insertions(+), 62 deletions(-)

diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index c6f8465..0a64df1 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -3,29 +3,25 @@ CONFIG_HIGHMEM=y
 CONFIG_KSM=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_SMP=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_KEXEC=y
-CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
-CONFIG_AUDIT=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
-CONFIG_INITRAMFS_COMPRESSION_GZIP=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_ELF_CORE is not set
@@ -37,12 +33,31 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_BLK_DEV_INTEGRITY=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ACORN_PARTITION=y
+CONFIG_ACORN_PARTITION_ICS=y
+CONFIG_ACORN_PARTITION_RISCIX=y
+CONFIG_OSF_PARTITION=y
+CONFIG_AMIGA_PARTITION=y
+CONFIG_ATARI_PARTITION=y
+CONFIG_MAC_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_UNIXWARE_DISKLABEL=y
+CONFIG_LDM_PARTITION=y
+CONFIG_SGI_PARTITION=y
+CONFIG_ULTRIX_PARTITION=y
+CONFIG_SUN_PARTITION=y
+CONFIG_KARMA_PARTITION=y
+CONFIG_SYSV68_PARTITION=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM_RUNTIME=y
 CONFIG_PM_DEBUG=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
@@ -74,7 +89,6 @@ CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -85,7 +99,6 @@ CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_NETLABEL=y
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
@@ -101,7 +114,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -161,21 +173,13 @@ CONFIG_IP_VS_DH=m
 CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
-CONFIG_IP_VS_FTP=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
-CONFIG_IP_NF_TARGET_ULOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -186,8 +190,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
-CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -197,7 +199,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -224,7 +225,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_DCCP=m
 CONFIG_RDS=m
@@ -245,13 +245,8 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_ECONET=m
-CONFIG_ECONET_AUNUDP=y
-CONFIG_ECONET_NATIVE=y
-CONFIG_WAN_ROUTER=m
 CONFIG_PHONET=m
 CONFIG_IEEE802154=m
 CONFIG_NET_SCHED=y
@@ -308,7 +303,6 @@ CONFIG_BLK_DEV_OSD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_CDROM_PKTCDVD=y
-CONFIG_MISC_DEVICES=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -317,11 +311,11 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_SCH=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_SPI_ATTRS=m
+CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
 CONFIG_SCSI_SRP_ATTRS=m
 CONFIG_ISCSI_TCP=m
@@ -352,7 +346,6 @@ CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
 # CONFIG_DEVKMEM is not set
-CONFIG_STALDRV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=48
@@ -365,14 +358,12 @@ CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_RAW_DRIVER=m
 CONFIG_I2C=y
 CONFIG_I2C_XLR=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1374=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1374=y
 CONFIG_UIO=y
-CONFIG_UIO_PDRV=m
 CONFIG_UIO_PDRV_GENIRQ=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
@@ -385,7 +376,6 @@ CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_GFS2_FS=m
-CONFIG_GFS2_FS_LOCKING_DLM=y
 CONFIG_OCFS2_FS=m
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
@@ -432,9 +422,8 @@ CONFIG_SYSV_FS=m
 CONFIG_UFS_FS=m
 CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFS_FSCACHE=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
@@ -455,25 +444,6 @@ CONFIG_NCPFS_NLS=y
 CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ACORN_PARTITION=y
-CONFIG_ACORN_PARTITION_ICS=y
-CONFIG_ACORN_PARTITION_RISCIX=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_ATARI_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_LDM_PARTITION=y
-CONFIG_SGI_PARTITION=y
-CONFIG_ULTRIX_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
-CONFIG_SYSV68_PARTITION=y
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=m
@@ -514,20 +484,18 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_KGDB=y
 CONFIG_SECURITY=y
-CONFIG_SECURITY_NETWORK=y
 CONFIG_LSM_MMAP_MIN_ADDR=0
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
@@ -535,7 +503,6 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_SMACK=y
 CONFIG_SECURITY_TOMOYO=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_CCM=m
@@ -552,7 +519,6 @@ CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
-- 
1.9.1
