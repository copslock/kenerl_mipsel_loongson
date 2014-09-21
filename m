Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:47:47 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63217 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009383AbaIUAq5cCnfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:46:57 +0200
Received: by mail-pd0-f175.google.com with SMTP id v10so1075837pde.34
        for <multiple recipients>; Sat, 20 Sep 2014 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9rXsrKjYcBE70mPbnChT/uEMFiaHsFkhxasMB+buAY=;
        b=QV4HRNaCjTxfsjT3/nbnzbuATgyeQKjhDcZIBQoFbQRzhi+4YSVRGevQibvJGYIHI3
         T8jrM6NlgE7VIwo4+SFa0yyPn0LEoiS7Qo2lpKAqm1BgWVVAo/0uMOouf1RwUlIIVmTE
         7DBLMS3IDqPNe4tQlG4aZCqWh/bOokrDXPDX/zSBGiZ3higFBJQggkVKE5q+ZErta/EX
         vL56agK/rMs8oY3eXT5HIfsqpNUsT09m8/fuqXn9FCFmsDWtSSQhcMoxvlEnpIPtlur4
         J17GtdNdTSfU3R5/N2DHaWiA+AR9DYg4j830pw5vDZjm7U9p1+XZIz6EH9LvFSGvLOfI
         LJ7A==
X-Received: by 10.68.94.34 with SMTP id cz2mr12535199pbb.7.1411260411455;
        Sat, 20 Sep 2014 17:46:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id ri1sm5516248pdb.61.2014.09.20.17.46.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:46:50 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 03/11] next: mips: Fix jazz_defconfig
Date:   Sat, 20 Sep 2014 17:46:18 -0700
Message-Id: <1411260386-6800-4-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42712
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
 arch/mips/configs/jazz_defconfig | 43 +++++-----------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 2575302..c24896f 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -1,7 +1,6 @@
 CONFIG_MACH_JAZZ=y
 CONFIG_OLIVETTI_M700=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -9,15 +8,14 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
 CONFIG_NET_KEY=m
@@ -25,15 +23,12 @@ CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_NET_IPIP=m
-CONFIG_NET_IPGRE=m
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_INET6_AH=m
@@ -42,7 +37,6 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
@@ -85,21 +79,12 @@ CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
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
@@ -109,7 +94,6 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_IP6_NF_QUEUE=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -120,7 +104,6 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_MH=m
 CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_TARGET_LOG=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
@@ -145,7 +128,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE=m
 CONFIG_DECNET=m
 CONFIG_NET_SCHED=y
@@ -235,10 +217,12 @@ CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
 CONFIG_BONDING=m
+CONFIG_DUMMY=m
 CONFIG_EQUALIZER=m
 CONFIG_TUN=m
+CONFIG_MIPS_JAZZ_SONIC=y
+CONFIG_NE2000=m
 CONFIG_PHYLIB=m
 CONFIG_MARVELL_PHY=m
 CONFIG_DAVICOM_PHY=m
@@ -247,12 +231,6 @@ CONFIG_LXT_PHY=m
 CONFIG_CICADA_PHY=m
 CONFIG_VITESSE_PHY=m
 CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_JAZZ_SONIC=y
-CONFIG_NET_ISA=y
-CONFIG_NE2000=m
-CONFIG_NET_PCI=y
 CONFIG_PLIP=m
 CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_PARKBD=m
@@ -276,7 +254,6 @@ CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_ISO9660_FS=m
@@ -303,12 +280,8 @@ CONFIG_ROMFS_FS=m
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
@@ -321,7 +294,6 @@ CONFIG_NCPFS_NLS=y
 CONFIG_NCPFS_EXTRAS=y
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
@@ -360,22 +332,17 @@ CONFIG_NLS_ISO8859_15=m
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
