Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:49:34 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59300 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009387AbaIUArNf06rN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:47:13 +0200
Received: by mail-pd0-f171.google.com with SMTP id y13so2161939pdi.16
        for <multiple recipients>; Sat, 20 Sep 2014 17:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYvDkqMpAF2pzm+bQAWfsJ0AbAIc093LdqfIhNyFsGs=;
        b=WRjgouZBCLindMCvK+Hd9pdbaQ1diWaM5GPD9DFRHG6/e9xHpgRS2FeuX39GHWThS+
         NtjblYXADDLVyK4IgLOML+1qHrLniakCjTb3TyZW7Vz5fa2io+NV4nx5a3XLlo1o8LcK
         b+H/gkNP5GO3hrVnHwZRh+iCXOqw33ltppo57/+f3Y+4a0ZTSN4OEkIa1q8Phi16eCzP
         Wg5uWgs0bT2jR3qnjobS9iiwtlxUgMLRU7LIQRc00HZ+5WOIvZj8iQl6pk00ZuKPPuQA
         n2tRwV6WCCJQaU1szJi4AKIEpM7BR4MBkDS/NG+rbJsZXTy8nTKHXCHNt0S/CXSO/iio
         /rpg==
X-Received: by 10.67.23.103 with SMTP id hz7mr11492345pad.118.1411260427508;
        Sat, 20 Sep 2014 17:47:07 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id p1sm5542830pdr.15.2014.09.20.17.47.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:47:07 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 09/11] next: mips: Fix nlm_xlp_defconfig
Date:   Sat, 20 Sep 2014 17:46:24 -0700
Message-Id: <1411260386-6800-10-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42718
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
 arch/mips/configs/nlm_xlp_defconfig | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index 2f660e9..a269b0c 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -6,19 +6,18 @@ CONFIG_KSM=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_SMP=y
 # CONFIG_SECCOMP is not set
-CONFIG_EXPERIMENTAL=y
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
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
@@ -50,7 +49,6 @@ CONFIG_SGI_PARTITION=y
 CONFIG_ULTRIX_PARTITION=y
 CONFIG_SUN_PARTITION=y
 CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_SYSV68_PARTITION=y
 CONFIG_PCI=y
 CONFIG_PCI_DEBUG=y
@@ -63,6 +61,7 @@ CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_PM_RUNTIME=y
 CONFIG_PM_DEBUG=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
@@ -94,7 +93,6 @@ CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -105,7 +103,6 @@ CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_NETLABEL=y
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
@@ -121,7 +118,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -181,20 +177,13 @@ CONFIG_IP_VS_DH=m
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
-CONFIG_IP_NF_TARGET_ULOG=m
-CONFIG_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -205,7 +194,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
 CONFIG_IP6_NF_MATCH_FRAG=m
@@ -241,7 +229,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_DCCP=m
 CONFIG_RDS=m
@@ -262,10 +249,8 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_WAN_ROUTER=m
 CONFIG_PHONET=m
 CONFIG_IEEE802154=m
 CONFIG_NET_SCHED=y
@@ -317,7 +302,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -340,11 +324,11 @@ CONFIG_CHR_DEV_OSST=m
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
@@ -414,7 +398,6 @@ CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
 # CONFIG_DEVKMEM is not set
-CONFIG_STALDRV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=48
@@ -436,7 +419,6 @@ CONFIG_THERMAL=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_UIO=y
-CONFIG_UIO_PDRV=m
 CONFIG_UIO_PDRV_GENIRQ=m
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
@@ -493,7 +475,7 @@ CONFIG_UFS_FS=m
 CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFS_FSCACHE=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
@@ -554,15 +536,15 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FRAME_WARN=1024
 CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_KGDB=y
@@ -574,7 +556,6 @@ CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_SECURITY_SMACK=y
 CONFIG_SECURITY_TOMOYO=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_CCM=m
@@ -591,7 +572,6 @@ CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_RMD256=m
 CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
-- 
1.9.1
