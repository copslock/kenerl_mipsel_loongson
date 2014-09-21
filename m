Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:47:10 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54536 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009377AbaIUAqwl3s7n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:46:52 +0200
Received: by mail-pd0-f174.google.com with SMTP id g10so1705960pdj.19
        for <multiple recipients>; Sat, 20 Sep 2014 17:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kc2yixOYS9PmaODcA58mJ/sNwL3nNyWka+/w6Fjp0BA=;
        b=nLVMFR+xSNAckl/sdHQ/ZYtbydKgoSueHYkx4yqboD2dnkHyMcMYXkilR3ywK0y2qF
         HnMo0UsYNJ7JGagbvT5OZx95nxR1yJdAHB+sAfwkZwMxAhHoNpufV+PL+4fD6rTXBTNH
         7AtiD2Ad6EWkAUqD+8MdXAX+rrRhADlyjPIGJ0ffbbUWiEW2kIVL0Ir6GBf2MchkPzLZ
         obHAgOOlMj+mgaPFYr/aHJtcgGBjSztLEtQ7eXeqzcgwYKP0CyfSafG1xSQl3kBw2/8b
         ZiY8j01LMQuO8CDLThT8MLKOlm465R8sgAnPB9Dm4vNnXjzEDFRU/EEjK7df86jA/nWI
         wQEA==
X-Received: by 10.70.49.231 with SMTP id x7mr10519468pdn.75.1411260406477;
        Sat, 20 Sep 2014 17:46:46 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id v1sm5507776pdp.76.2014.09.20.17.46.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:46:46 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 01/11] next: mips: Fix gpr_defconfig
Date:   Sat, 20 Sep 2014 17:46:16 -0700
Message-Id: <1411260386-6800-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42710
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
 arch/mips/configs/gpr_defconfig | 104 +++++++++++++---------------------------
 1 file changed, 34 insertions(+), 70 deletions(-)

diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 8f219da..8cc7cab 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -1,24 +1,23 @@
 CONFIG_MIPS_ALCHEMY=y
 CONFIG_MIPS_GPR=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_PCI=y
 CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -36,7 +35,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_DSCP=m
@@ -58,16 +56,12 @@ CONFIG_NETFILTER_XT_MATCH_REALM=m
 CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
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
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -95,7 +89,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_IP_DCCP=m
 CONFIG_IP_SCTP=m
 CONFIG_TIPC=m
@@ -113,13 +106,8 @@ CONFIG_ATALK=m
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
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
@@ -165,7 +153,6 @@ CONFIG_YAM=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -180,15 +167,29 @@ CONFIG_TIFM_CORE=m
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SPI_ATTRS=m
 CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_ISCSI_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
-# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
+CONFIG_NET_FC=y
+CONFIG_NETCONSOLE=m
+CONFIG_ATM_TCP=m
+CONFIG_ATM_LANAI=m
+CONFIG_ATM_ENI=m
+CONFIG_ATM_FIRESTREAM=m
+CONFIG_ATM_ZATM=m
+CONFIG_ATM_NICSTAR=m
+CONFIG_ATM_IDT77252=m
+CONFIG_ATM_AMBASSADOR=m
+CONFIG_ATM_HORIZON=m
+CONFIG_ATM_IA=m
+CONFIG_ATM_FORE200E=m
+CONFIG_ATM_HE=m
+CONFIG_ATM_HE_USE_SUNI=y
+CONFIG_MIPS_AU1X00_ENET=y
 CONFIG_MARVELL_PHY=m
 CONFIG_DAVICOM_PHY=m
 CONFIG_QSEMI_PHY=m
@@ -196,15 +197,20 @@ CONFIG_LXT_PHY=m
 CONFIG_CICADA_PHY=m
 CONFIG_VITESSE_PHY=m
 CONFIG_SMSC_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-CONFIG_ATH_COMMON=y
-CONFIG_ATH_DEBUG=y
-CONFIG_ATH5K=y
-CONFIG_ATH5K_DEBUG=y
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOATM=m
+CONFIG_PPPOE=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLIP_SMART=y
+CONFIG_SLIP_MODE_SLIP6=y
 CONFIG_WAN=y
 CONFIG_LANMEDIA=m
 CONFIG_HDLC=m
@@ -221,40 +227,8 @@ CONFIG_DSCC4=m
 CONFIG_DSCC4_PCISYNC=y
 CONFIG_DSCC4_PCI_RST=y
 CONFIG_DLCI=m
-CONFIG_WAN_ROUTER_DRIVERS=m
-CONFIG_CYCLADES_SYNC=m
-CONFIG_CYCLOMX_X25=y
 CONFIG_LAPBETHER=m
 CONFIG_X25_ASY=m
-CONFIG_ATM_TCP=m
-CONFIG_ATM_LANAI=m
-CONFIG_ATM_ENI=m
-CONFIG_ATM_FIRESTREAM=m
-CONFIG_ATM_ZATM=m
-CONFIG_ATM_NICSTAR=m
-CONFIG_ATM_IDT77252=m
-CONFIG_ATM_AMBASSADOR=m
-CONFIG_ATM_HORIZON=m
-CONFIG_ATM_IA=m
-CONFIG_ATM_FORE200E=m
-CONFIG_ATM_HE=m
-CONFIG_ATM_HE_USE_SUNI=y
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
-CONFIG_PPPOATM=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
-CONFIG_NET_FC=y
-CONFIG_NETCONSOLE=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -267,7 +241,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
-CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_SENSORS_LM83=y
 CONFIG_WATCHDOG=y
@@ -285,22 +258,15 @@ CONFIG_USB_HIDDEV=y
 CONFIG_USB_KBD=m
 CONFIG_USB_MOUSE=m
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=m
-CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_SERIAL=y
-CONFIG_USB_EZUSB=y
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_SIERRAWIRELESS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 CONFIG_ISO9660_FS=m
@@ -315,16 +281,14 @@ CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_RUBIN=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
 CONFIG_CRYPTO_NULL=m
-- 
1.9.1
