Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:50:08 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64780 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009391AbaIUArTyyCUG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:47:19 +0200
Received: by mail-pd0-f180.google.com with SMTP id r10so2164535pdi.11
        for <multiple recipients>; Sat, 20 Sep 2014 17:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5X04BEwG4FvwgNmxzzeLb16t+QHxyKcUCt52F8bjKE=;
        b=pE5T29xzseFSxttDsdq1gWcRbBh+Y0p9LAAIYWlls28OzDNdQAKDHH+79V2ebw5d0z
         qi/Yd9DOt1coQY+iDzuEkTq4YTKXk/YSaPFMfbSJHKs2ZmhZUTIrM5yukVz9vv6ksEPp
         r8Ee54dBrVWVuwmoI2fuOSTElkjwjogb7dgxZ/LR0m7B0L1F8JUyPL1KHRV3VjsEStzR
         +FLgWEdmH1xwJdpCBkqoPHQoZ7PhnuaexEfaqqV3OfJRz4BaETHkgclkOOAdj71eLU5C
         o93QnhNIaNpQf/naUBQH9giwgWYGHBXmnu8WpBjHjFUc6C+0tqJLxxmM5uQByP0PuXB+
         zIBA==
X-Received: by 10.70.118.9 with SMTP id ki9mr15258207pdb.104.1411260433821;
        Sat, 20 Sep 2014 17:47:13 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id ve13sm5570794pac.6.2014.09.20.17.47.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:47:13 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 11/11] next: mips: Fix rm200_defconfig
Date:   Sat, 20 Sep 2014 17:46:26 -0700
Message-Id: <1411260386-6800-12-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42720
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
 arch/mips/configs/rm200_defconfig | 55 +++++++--------------------------------
 1 file changed, 10 insertions(+), 45 deletions(-)

diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 29d79ae..12d94db 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -3,7 +3,6 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_ARC_CONSOLE=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -11,15 +10,15 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
 CONFIG_NET_KEY=m
@@ -27,8 +26,6 @@ CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -36,7 +33,6 @@ CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_INET6_AH=m
@@ -49,7 +45,6 @@ CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -94,21 +89,12 @@ CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
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
-CONFIG_NF_NAT_SNMP_BASIC=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -118,7 +104,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -129,7 +114,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -154,7 +138,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE=m
 CONFIG_DECNET=m
 CONFIG_NET_SCHED=y
@@ -214,7 +197,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_SX8=m
-CONFIG_BLK_DEV_UB=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
@@ -228,7 +210,6 @@ CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_FC_ATTRS=y
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_AIC94XX=m
 # CONFIG_AIC94XX_DEBUG is not set
@@ -253,11 +234,16 @@ CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
+CONFIG_DUMMY=m
 CONFIG_EQUALIZER=m
 CONFIG_TUN=m
-CONFIG_PHYLIB=m
+CONFIG_PCNET32=y
+CONFIG_CHELSIO_T3=m
+CONFIG_NE2000=m
+CONFIG_QLA3XXX=m
+CONFIG_NETXEN_NIC=m
+CONFIG_VIA_VELOCITY=m
 CONFIG_MARVELL_PHY=m
 CONFIG_DAVICOM_PHY=m
 CONFIG_QSEMI_PHY=m
@@ -265,22 +251,13 @@ CONFIG_LXT_PHY=m
 CONFIG_CICADA_PHY=m
 CONFIG_VITESSE_PHY=m
 CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_ISA=y
-CONFIG_NE2000=m
-CONFIG_NET_PCI=y
-CONFIG_PCNET32=y
-CONFIG_VIA_VELOCITY=m
-CONFIG_QLA3XXX=m
-CONFIG_CHELSIO_T3=m
-CONFIG_NETXEN_NIC=m
+CONFIG_PLIP=m
 CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_PLIP=m
 CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_PARKBD=m
 CONFIG_SERIO_RAW=m
@@ -344,7 +321,6 @@ CONFIG_USB_SERIAL_KLSI=m
 CONFIG_USB_SERIAL_KOBIL_SCT=m
 CONFIG_USB_SERIAL_MCT_U232=m
 CONFIG_USB_SERIAL_PL2303=m
-CONFIG_USB_SERIAL_HP4X=m
 CONFIG_USB_SERIAL_SAFE=m
 CONFIG_USB_SERIAL_SAFE_PADDED=y
 CONFIG_USB_SERIAL_CYBERJACK=m
@@ -366,7 +342,6 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
@@ -394,12 +369,8 @@ CONFIG_ROMFS_FS=m
 CONFIG_SYSV_FS=m
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
-CONFIG_NFS_V3=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_RPCSEC_GSS_KRB5=m
-CONFIG_RPCSEC_GSS_SPKM3=m
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
 CONFIG_NCP_FS=m
 CONFIG_NCPFS_PACKET_SIGNING=y
@@ -412,7 +383,6 @@ CONFIG_NCPFS_NLS=y
 CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -451,22 +421,17 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DLM=m
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST6=m
-- 
1.9.1
