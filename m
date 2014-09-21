Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:47:29 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52151 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008708AbaIUAqzLi0da (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:46:55 +0200
Received: by mail-pd0-f172.google.com with SMTP id y10so2157331pdj.17
        for <multiple recipients>; Sat, 20 Sep 2014 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WJzAetj58ACdJZOjl6ihBUkNzpYTH3nuSRhY4SbvS7s=;
        b=rOfMC1HV118c/UXhTOdLUbyPExSAVjkrbhzZi/FsoY79peZXIl+gimmkelvaZ0up6N
         Ptk5jF2WKnTXVKpSOJqPW77gSNkElx/SoJP7mvn98dwD8dbF13wLrVDBQDb8NPBp5tJA
         LWDBoX7dofNwCzUn5vOrFprfRlfpPAsGYfyCzNBjuWe7mXRY5fQVTUhFLIXFVdFXsm5J
         sgAx+dNHFhcEkuPYaoes5uelbJIS4V/Be74/gTv1rW+EwD6KTfwnXywHgqnnZu7P+jpZ
         lXrjmnF04CEdlU4L4oxsLNlFQ1Ej7sMNjHd9nfcBnxxoKuG/m1ACfSx4HmayD2PgtxBt
         ZGOg==
X-Received: by 10.70.30.132 with SMTP id s4mr15107771pdh.96.1411260408941;
        Sat, 20 Sep 2014 17:46:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id rw8sm5524512pbc.11.2014.09.20.17.46.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:46:48 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 02/11] next: mips: Fix ip27_defconfig
Date:   Sat, 20 Sep 2014 17:46:17 -0700
Message-Id: <1411260386-6800-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42711
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
 arch/mips/configs/ip27_defconfig | 112 +++++++++++++--------------------------
 1 file changed, 37 insertions(+), 75 deletions(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index cc07560..cb8cf5ba 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -2,32 +2,28 @@ CONFIG_SGI_IP27=y
 CONFIG_NUMA=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_SMP=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 CONFIG_RELAY=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
-# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI=y
-CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
-CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
@@ -42,7 +38,6 @@ CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
@@ -96,7 +91,6 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
@@ -104,7 +98,6 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_OSD=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
-# CONFIG_MISC_DEVICES is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -117,7 +110,6 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
 CONFIG_BE2ISCSI=m
@@ -162,6 +154,37 @@ CONFIG_DM_UEVENT=y
 CONFIG_IFB=m
 CONFIG_MACVLAN=m
 CONFIG_VETH=m
+CONFIG_ATL2=m
+CONFIG_ATL1E=m
+CONFIG_ATL1C=m
+CONFIG_B44=m
+CONFIG_BNX2X=m
+CONFIG_ENIC=m
+CONFIG_DNET=m
+CONFIG_BE2NET=m
+CONFIG_VXGE=m
+CONFIG_E1000E=m
+CONFIG_IGB=m
+CONFIG_IGBVF=m
+CONFIG_IXGBE=m
+CONFIG_IP1000=m
+CONFIG_JME=m
+CONFIG_MLX4_EN=m
+# CONFIG_MLX4_DEBUG is not set
+CONFIG_KS8851_MLL=m
+CONFIG_AX88796=m
+CONFIG_AX88796_93CX6=y
+CONFIG_ETHOC=m
+CONFIG_QLA3XXX=m
+CONFIG_QLGE=m
+CONFIG_NETXEN_NIC=m
+CONFIG_SFC=m
+CONFIG_SGI_IOC3_ETH=y
+CONFIG_SMC91X=m
+CONFIG_SMSC911X=m
+CONFIG_NIU=m
+CONFIG_TEHUTI=m
+CONFIG_VIA_VELOCITY=m
 CONFIG_PHYLIB=y
 CONFIG_MARVELL_PHY=m
 CONFIG_DAVICOM_PHY=m
@@ -175,39 +198,6 @@ CONFIG_REALTEK_PHY=m
 CONFIG_NATIONAL_PHY=m
 CONFIG_STE10XP=m
 CONFIG_LSI_ET1011C_PHY=m
-CONFIG_MDIO_BITBANG=m
-CONFIG_NET_ETHERNET=y
-CONFIG_AX88796=m
-CONFIG_AX88796_93CX6=y
-CONFIG_SGI_IOC3_ETH=y
-CONFIG_SMC91X=m
-CONFIG_ETHOC=m
-CONFIG_SMSC911X=m
-CONFIG_DNET=m
-CONFIG_B44=m
-CONFIG_KS8851_MLL=m
-CONFIG_ATL2=m
-CONFIG_E1000E=m
-CONFIG_IP1000=m
-CONFIG_IGB=m
-CONFIG_IGBVF=m
-CONFIG_VIA_VELOCITY=m
-CONFIG_QLA3XXX=m
-CONFIG_ATL1E=m
-CONFIG_ATL1C=m
-CONFIG_JME=m
-CONFIG_ENIC=m
-CONFIG_IXGBE=m
-CONFIG_VXGE=m
-CONFIG_NETXEN_NIC=m
-CONFIG_NIU=m
-CONFIG_MLX4_EN=m
-# CONFIG_MLX4_DEBUG is not set
-CONFIG_TEHUTI=m
-CONFIG_BNX2X=m
-CONFIG_QLGE=m
-CONFIG_SFC=m
-CONFIG_BE2NET=m
 CONFIG_LIBERTAS_THINFIRM=m
 CONFIG_ATMEL=m
 CONFIG_PCI_ATMEL=m
@@ -215,9 +205,6 @@ CONFIG_PRISM54=m
 CONFIG_RTL8180=m
 CONFIG_ADM8211=m
 CONFIG_MWL8K=m
-CONFIG_ATH_COMMON=m
-CONFIG_ATH5K=m
-CONFIG_ATH9K=m
 CONFIG_B43=m
 CONFIG_B43LEGACY=m
 # CONFIG_B43LEGACY_DEBUG is not set
@@ -229,22 +216,10 @@ CONFIG_HOSTAP_PCI=m
 CONFIG_IPW2100=m
 CONFIG_IPW2100_MONITOR=y
 CONFIG_IPW2100_DEBUG=y
-CONFIG_IPW2200=m
-CONFIG_IPW2200_MONITOR=y
-CONFIG_IPW2200_PROMISCUOUS=y
-CONFIG_IPW2200_QOS=y
-CONFIG_IPW2200_DEBUG=y
 CONFIG_IWLWIFI=m
-CONFIG_IWLAGN=m
-CONFIG_IWL4965=y
-CONFIG_IWL5000=y
+CONFIG_IWL4965=m
 CONFIG_IWL3945=m
 CONFIG_LIBERTAS=m
-CONFIG_HERMES=m
-# CONFIG_HERMES_CACHE_FW_ON_INIT is not set
-CONFIG_PLX_HERMES=m
-CONFIG_TMD_HERMES=m
-CONFIG_NORTEL_HERMES=m
 CONFIG_P54_COMMON=m
 CONFIG_P54_PCI=m
 CONFIG_RT2X00=m
@@ -252,21 +227,19 @@ CONFIG_RT2400PCI=m
 CONFIG_RT2500PCI=m
 CONFIG_RT61PCI=m
 CONFIG_RT2800PCI=m
-CONFIG_WL12XX=m
-CONFIG_WL1251=m
 # CONFIG_INPUT is not set
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_LIBPS2=m
 CONFIG_SERIO_RAW=m
 CONFIG_SERIO_ALTERA_PS2=m
 # CONFIG_VT is not set
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_NOZOMI=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_ALI1535=m
@@ -289,7 +262,6 @@ CONFIG_I2C_SIMTEC=m
 CONFIG_I2C_PARPORT_LIGHT=m
 CONFIG_I2C_TAOS_EVM=m
 CONFIG_I2C_STUB=m
-CONFIG_PPS=m
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=m
 CONFIG_MFD_PCF50633=m
@@ -326,7 +298,6 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
 CONFIG_FSCACHE=m
@@ -339,18 +310,10 @@ CONFIG_SQUASHFS=m
 CONFIG_OMFS_FS=m
 CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_RPCSEC_GSS_KRB5=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_DLM=m
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITYFS=y
-CONFIG_CRYPTO_FIPS=y
-CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_GCM=m
 CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_LRW=m
@@ -382,5 +345,4 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_ZLIB=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRYPTO_DEV_HIFN_795X=m
 CONFIG_CRC_T10DIF=m
-- 
1.9.1
