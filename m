Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2015 07:37:19 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60490 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006766AbbBVGgm7dYq9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Feb 2015 07:36:42 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YPQ60-0000CY-Pw; Sun, 22 Feb 2015 00:32:52 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH V5 3/3] MIPS: XPA: Add new configuration file.
Date:   Sun, 22 Feb 2015 00:36:28 -0600
Message-Id: <1424586988-21544-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1424586988-21544-1-git-send-email-Steven.Hill@imgtec.com>
References: <1424586988-21544-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Add in new config files for enabling a XPA platform.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/configs/maltaup_xpa_defconfig |  440 +++++++++++++++++++++++++++++++
 1 file changed, 440 insertions(+)
 create mode 100644 arch/mips/configs/maltaup_xpa_defconfig

diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
new file mode 100644
index 0000000..2330c0f
--- /dev/null
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -0,0 +1,440 @@
+CONFIG_MIPS_MALTA=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_CPU_MIPS32_R5_FEATURES=y
+CONFIG_CPU_MIPS32_R5_XPA=y
+CONFIG_PAGE_SIZE_16KB=y
+CONFIG_HZ_100=y
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=15
+CONFIG_NAMESPACES=y
+CONFIG_RELAY=y
+CONFIG_EXPERT=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PCI=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=m
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=m
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
+CONFIG_INET_IPCOMP=m
+CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_INET_XFRM_MODE_TUNNEL=m
+CONFIG_TCP_MD5SIG=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_IPV6_TUNNEL=m
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_DCCP=m
+CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_PPTP=m
+CONFIG_NF_CONNTRACK_SANE=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_TARGET_TRACE=m
+CONFIG_NETFILTER_XT_TARGET_SECMARK=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_DCCP=m
+CONFIG_NETFILTER_XT_MATCH_ESP=m
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_HELPER=m
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MARK=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_OWNER=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
+CONFIG_NETFILTER_XT_MATCH_RATEEST=m
+CONFIG_NETFILTER_XT_MATCH_REALM=m
+CONFIG_NETFILTER_XT_MATCH_RECENT=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
+CONFIG_NETFILTER_XT_MATCH_U32=m
+CONFIG_IP_VS=m
+CONFIG_IP_VS_IPV6=y
+CONFIG_IP_VS_PROTO_TCP=y
+CONFIG_IP_VS_PROTO_UDP=y
+CONFIG_IP_VS_PROTO_ESP=y
+CONFIG_IP_VS_PROTO_AH=y
+CONFIG_IP_VS_RR=m
+CONFIG_IP_VS_WRR=m
+CONFIG_IP_VS_LC=m
+CONFIG_IP_VS_WLC=m
+CONFIG_IP_VS_LBLC=m
+CONFIG_IP_VS_LBLCR=m
+CONFIG_IP_VS_DH=m
+CONFIG_IP_VS_SH=m
+CONFIG_IP_VS_SED=m
+CONFIG_IP_VS_NQ=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_AH=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_CLUSTERIP=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+CONFIG_NF_CONNTRACK_IPV6=m
+CONFIG_IP6_NF_MATCH_AH=m
+CONFIG_IP6_NF_MATCH_EUI64=m
+CONFIG_IP6_NF_MATCH_FRAG=m
+CONFIG_IP6_NF_MATCH_OPTS=m
+CONFIG_IP6_NF_MATCH_HL=m
+CONFIG_IP6_NF_MATCH_IPV6HEADER=m
+CONFIG_IP6_NF_MATCH_MH=m
+CONFIG_IP6_NF_MATCH_RT=m
+CONFIG_IP6_NF_TARGET_HL=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_IP6_NF_RAW=m
+CONFIG_BRIDGE_NF_EBTABLES=m
+CONFIG_BRIDGE_EBT_BROUTE=m
+CONFIG_BRIDGE_EBT_T_FILTER=m
+CONFIG_BRIDGE_EBT_T_NAT=m
+CONFIG_BRIDGE_EBT_802_3=m
+CONFIG_BRIDGE_EBT_AMONG=m
+CONFIG_BRIDGE_EBT_ARP=m
+CONFIG_BRIDGE_EBT_IP=m
+CONFIG_BRIDGE_EBT_IP6=m
+CONFIG_BRIDGE_EBT_LIMIT=m
+CONFIG_BRIDGE_EBT_MARK=m
+CONFIG_BRIDGE_EBT_PKTTYPE=m
+CONFIG_BRIDGE_EBT_STP=m
+CONFIG_BRIDGE_EBT_VLAN=m
+CONFIG_BRIDGE_EBT_ARPREPLY=m
+CONFIG_BRIDGE_EBT_DNAT=m
+CONFIG_BRIDGE_EBT_MARK_T=m
+CONFIG_BRIDGE_EBT_REDIRECT=m
+CONFIG_BRIDGE_EBT_SNAT=m
+CONFIG_BRIDGE_EBT_LOG=m
+CONFIG_BRIDGE_EBT_NFLOG=m
+CONFIG_IP_SCTP=m
+CONFIG_BRIDGE=m
+CONFIG_VLAN_8021Q=m
+CONFIG_VLAN_8021Q_GVRP=y
+CONFIG_ATALK=m
+CONFIG_DEV_APPLETALK=m
+CONFIG_IPDDP=m
+CONFIG_IPDDP_ENCAP=y
+CONFIG_PHONET=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_HFSC=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+CONFIG_NET_CLS_RSVP=m
+CONFIG_NET_CLS_RSVP6=m
+CONFIG_NET_CLS_FLOW=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_POLICE=y
+CONFIG_NET_ACT_GACT=m
+CONFIG_GACT_PROB=y
+CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_IPT=m
+CONFIG_NET_ACT_NAT=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_ACT_SIMP=m
+CONFIG_NET_ACT_SKBEDIT=m
+CONFIG_NET_CLS_IND=y
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
+CONFIG_MAC80211_MESH=y
+CONFIG_RFKILL=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_CONNECTOR=m
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_OOPS=m
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_UBI=m
+CONFIG_MTD_UBI_GLUEBI=m
+CONFIG_BLK_DEV_FD=m
+CONFIG_BLK_DEV_UMEM=m
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_CRYPTOLOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_CDROM_PKTCDVD=m
+CONFIG_ATA_OVER_ETH=m
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDECD=y
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_GENERIC=y
+CONFIG_BLK_DEV_PIIX=y
+CONFIG_BLK_DEV_IT8213=m
+CONFIG_BLK_DEV_TC86C001=m
+CONFIG_RAID_ATTRS=m
+CONFIG_SCSI=m
+CONFIG_BLK_DEV_SD=m
+CONFIG_CHR_DEV_ST=m
+CONFIG_CHR_DEV_OSST=m
+CONFIG_BLK_DEV_SR=m
+CONFIG_BLK_DEV_SR_VENDOR=y
+CONFIG_CHR_DEV_SG=m
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_SCSI_FC_ATTRS=m
+CONFIG_ISCSI_TCP=m
+CONFIG_BLK_DEV_3W_XXXX_RAID=m
+CONFIG_SCSI_3W_9XXX=m
+CONFIG_SCSI_ACARD=m
+CONFIG_SCSI_AACRAID=m
+CONFIG_SCSI_AIC7XXX=m
+CONFIG_AIC7XXX_RESET_DELAY_MS=15000
+# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=m
+CONFIG_MD_LINEAR=m
+CONFIG_MD_RAID0=m
+CONFIG_MD_RAID1=m
+CONFIG_MD_RAID10=m
+CONFIG_MD_RAID456=m
+CONFIG_MD_MULTIPATH=m
+CONFIG_MD_FAULTY=m
+CONFIG_BLK_DEV_DM=m
+CONFIG_DM_CRYPT=m
+CONFIG_DM_SNAPSHOT=m
+CONFIG_DM_MIRROR=m
+CONFIG_DM_ZERO=m
+CONFIG_DM_MULTIPATH=m
+CONFIG_NETDEVICES=y
+CONFIG_BONDING=m
+CONFIG_DUMMY=m
+CONFIG_EQUALIZER=m
+CONFIG_IFB=m
+CONFIG_MACVLAN=m
+CONFIG_TUN=m
+CONFIG_VETH=m
+# CONFIG_NET_VENDOR_3COM is not set
+CONFIG_PCNET32=y
+CONFIG_CHELSIO_T3=m
+CONFIG_AX88796=m
+CONFIG_NETXEN_NIC=m
+CONFIG_TC35815=m
+CONFIG_MARVELL_PHY=m
+CONFIG_DAVICOM_PHY=m
+CONFIG_QSEMI_PHY=m
+CONFIG_LXT_PHY=m
+CONFIG_CICADA_PHY=m
+CONFIG_VITESSE_PHY=m
+CONFIG_SMSC_PHY=m
+CONFIG_BROADCOM_PHY=m
+CONFIG_ICPLUS_PHY=m
+CONFIG_REALTEK_PHY=m
+CONFIG_ATMEL=m
+CONFIG_PCI_ATMEL=m
+CONFIG_PRISM54=m
+CONFIG_HOSTAP=m
+CONFIG_HOSTAP_FIRMWARE=y
+CONFIG_HOSTAP_FIRMWARE_NVRAM=y
+CONFIG_HOSTAP_PLX=m
+CONFIG_HOSTAP_PCI=m
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
+CONFIG_LIBERTAS=m
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_FB_CIRRUS=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_HID=m
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_UIO=m
+CONFIG_UIO_CIF=m
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_REISERFS_FS=m
+CONFIG_REISERFS_PROC_INFO=y
+CONFIG_REISERFS_FS_XATTR=y
+CONFIG_REISERFS_FS_POSIX_ACL=y
+CONFIG_REISERFS_FS_SECURITY=y
+CONFIG_JFS_FS=m
+CONFIG_JFS_POSIX_ACL=y
+CONFIG_JFS_SECURITY=y
+CONFIG_XFS_FS=m
+CONFIG_XFS_QUOTA=y
+CONFIG_XFS_POSIX_ACL=y
+CONFIG_QUOTA=y
+CONFIG_QFMT_V2=y
+CONFIG_FUSE_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_AFFS_FS=m
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+CONFIG_BEFS_FS=m
+CONFIG_BFS_FS=m
+CONFIG_EFS_FS=m
+CONFIG_JFFS2_FS=m
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_RUBIN=y
+CONFIG_CRAMFS=m
+CONFIG_VXFS_FS=m
+CONFIG_MINIX_FS=m
+CONFIG_ROMFS_FS=m
+CONFIG_SYSV_FS=m
+CONFIG_UFS_FS=m
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_CODEPAGE_737=m
+CONFIG_NLS_CODEPAGE_775=m
+CONFIG_NLS_CODEPAGE_850=m
+CONFIG_NLS_CODEPAGE_852=m
+CONFIG_NLS_CODEPAGE_855=m
+CONFIG_NLS_CODEPAGE_857=m
+CONFIG_NLS_CODEPAGE_860=m
+CONFIG_NLS_CODEPAGE_861=m
+CONFIG_NLS_CODEPAGE_862=m
+CONFIG_NLS_CODEPAGE_863=m
+CONFIG_NLS_CODEPAGE_864=m
+CONFIG_NLS_CODEPAGE_865=m
+CONFIG_NLS_CODEPAGE_866=m
+CONFIG_NLS_CODEPAGE_869=m
+CONFIG_NLS_CODEPAGE_936=m
+CONFIG_NLS_CODEPAGE_950=m
+CONFIG_NLS_CODEPAGE_932=m
+CONFIG_NLS_CODEPAGE_949=m
+CONFIG_NLS_CODEPAGE_874=m
+CONFIG_NLS_ISO8859_8=m
+CONFIG_NLS_CODEPAGE_1250=m
+CONFIG_NLS_CODEPAGE_1251=m
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
+CONFIG_NLS_KOI8_R=m
+CONFIG_NLS_KOI8_U=m
+CONFIG_CRYPTO_NULL=m
+CONFIG_CRYPTO_CRYPTD=m
+CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_XCBC=m
+CONFIG_CRYPTO_MD4=m
+CONFIG_CRYPTO_SHA256=m
+CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_WP512=m
+CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_BLOWFISH=m
+CONFIG_CRYPTO_CAMELLIA=m
+CONFIG_CRYPTO_CAST5=m
+CONFIG_CRYPTO_CAST6=m
+CONFIG_CRYPTO_FCRYPT=m
+CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_SERPENT=m
+CONFIG_CRYPTO_TEA=m
+CONFIG_CRYPTO_TWOFISH=m
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRC16=m
-- 
1.7.10.4
