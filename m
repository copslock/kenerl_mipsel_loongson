Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2003 09:14:57 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.177]:50651
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225363AbTLQJOy>; Wed, 17 Dec 2003 09:14:54 +0000
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1AWXlc-0001yK-00
	for linux-mips@linux-mips.org; Wed, 17 Dec 2003 10:14:52 +0100
Received: from [80.129.135.60] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1AWXlb-0007Ps-00
	for linux-mips@linux-mips.org; Wed, 17 Dec 2003 10:14:52 +0100
Received: from [62.254.210.162] (helo=ftp.linux-mips.org)
	by mxng16.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1AOyUu-00049K-00
	for bruno.randolf@4g-systems.biz; Wed, 26 Nov 2003 13:10:20 +0100
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:51590 "EHLO
	ftp.linux-mips.org") by linux-mips.org with ESMTP
	id <S8225340AbTKZMKS>; Wed, 26 Nov 2003 12:10:18 +0000
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 12:09:58 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:57319
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225301AbTKZMJp>; Wed, 26 Nov 2003 12:09:45 +0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1AOyUK-0005V8-00
	for linux-mips@linux-mips.org; Wed, 26 Nov 2003 13:09:44 +0100
Received: from [80.129.142.67] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1AOyUJ-0002O0-00
	for linux-mips@linux-mips.org; Wed, 26 Nov 2003 13:09:43 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
Organization: 4G Mobile Systeme
To: linux-mips@linux-mips.org
Subject: au1000/mtx-1 patch
Date: Wed, 17 Dec 2003 10:14:51 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d41044fba7cf33548d8f98fdbdd6d515
X-archive-position: 3677
X-ecartis-version: Ecartis v1.0.0
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L6B4/Fwy/KAcfcB"
Message-Id: <200312171014.51677.bruno.randolf@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d41044fba7cf33548d8f98fdbdd6d515
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips


--Boundary-00=_L6B4/Fwy/KAcfcB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello!

i send this a second time since my last request from a month ago was ignore=
d.=20
it would be really good if this quite trivial but important (whithout it ou=
r=20
board wont work correctly) patch would make it into the final 2.4 kernel.

could someone please apply the attached patch to the linux_2_4 branch. it
fixes the board initialization for the mtx-1 board, makes the naming more
consistent and changes my e-mail address.

thanks a lot!

bruno
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4B6Lfg2jtUL97G4RAq0KAJ9ZipT+Jkjmg2lXJRnCFMpMqXtHJQCfSMyN
c1Z2iNvtGsnRFVBtyRhQ4FU=3D
=3DPZ1U
=2D----END PGP SIGNATURE-----

--Boundary-00=_L6B4/Fwy/KAcfcB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.4.23-rc5-mtx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4.23-rc5-mtx.diff"

diff -Nurb mips-2.4.23-rc5/arch/mips/au1000/mtx-1/Makefile mips-2.4.23-rc5-mtx/arch/mips/au1000/mtx-1/Makefile
--- mips-2.4.23-rc5/arch/mips/au1000/mtx-1/Makefile	2003-11-26 10:51:39.000000000 +0100
+++ mips-2.4.23-rc5-mtx/arch/mips/au1000/mtx-1/Makefile	2003-11-26 11:37:13.000000000 +0100
@@ -2,7 +2,7 @@
 #  Copyright 2003 MontaVista Software Inc.
 #  Author: MontaVista Software, Inc.
 #     	ppopov@mvista.com or source@mvista.com
-#       Bruno Randolf <bruno.randolf@4g-systems.de>
+#       Bruno Randolf <bruno.randolf@4g-systems.biz>
 #
 # Makefile for 4G Systems MTX-1 board.
 #
diff -Nurb mips-2.4.23-rc5/arch/mips/au1000/mtx-1/board_setup.c mips-2.4.23-rc5-mtx/arch/mips/au1000/mtx-1/board_setup.c
--- mips-2.4.23-rc5/arch/mips/au1000/mtx-1/board_setup.c	2003-11-26 10:51:39.000000000 +0100
+++ mips-2.4.23-rc5-mtx/arch/mips/au1000/mtx-1/board_setup.c	2003-11-26 11:38:11.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	MTX-1 board setup.
+ *	4G Systems MTX-1 board setup.
  *
  * Copyright 2003 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
- *         Bruno Randolf <bruno.randolf@4g-systems.de>
+ *         Bruno Randolf <bruno.randolf@4g-systems.biz>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -50,12 +50,9 @@
 
 void __init board_setup(void)
 {
-	u32 pin_func;
-
 	rtc_ops = &no_rtc_ops;
 
 #if defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1X00_USB_DEVICE)
-
 #ifdef CONFIG_AU1X00_USB_DEVICE
 	// 2nd USB port is USB device
 	au_writel(au_readl(SYS_PINFUNC) & (u32)(~0x8000), SYS_PINFUNC);
@@ -63,10 +60,8 @@
 	// enable USB power switch
 	au_writel( au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR );
 	au_writel( 0x100000, GPIO2_OUTPUT );
-
 #endif // defined (CONFIG_USB_OHCI) || defined (CONFIG_AU1000_USB_DEVICE)
 
-
 #ifdef CONFIG_PCI
 #if defined(__MIPSEB__)
 	au_writel(0xf | (2<<6) | (1<<4), Au1500_PCI_CFG);
@@ -80,8 +75,11 @@
 	// set U3/GPIO23 to GPIO23 (SYS_PF_U3)
 	au_writel( SYS_PF_NI2 | SYS_PF_U3, SYS_PINFUNC );
 
-	// initialize GPIO: none used ATM
+	// initialize GPIO
 	au_writel( 0xFFFFFFFF, SYS_TRIOUTCLR );
+	au_writel( 0x00000001, SYS_OUTPUTCLR ); // set M66EN (PCI 66MHz) to OFF
+	au_writel( 0x00000008, SYS_OUTPUTSET ); // set PCI CLKRUN# to OFF
+	au_writel( 0x00000020, SYS_OUTPUTCLR ); // set eth PHY TX_ER to OFF
 
 	// enable LED and set it to green
 	au_writel( au_readl(GPIO2_DIR) | 0x1800, GPIO2_DIR );
diff -Nurb mips-2.4.23-rc5/arch/mips/au1000/mtx-1/init.c mips-2.4.23-rc5-mtx/arch/mips/au1000/mtx-1/init.c
--- mips-2.4.23-rc5/arch/mips/au1000/mtx-1/init.c	2003-11-26 10:51:39.000000000 +0100
+++ mips-2.4.23-rc5-mtx/arch/mips/au1000/mtx-1/init.c	2003-11-26 11:38:36.000000000 +0100
@@ -1,12 +1,12 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	MTX-1 board setup
+ *	4G Systems MTX-1 board setup
  *
  * Copyright 2003 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
- *         Bruno Randolf <bruno.randolf@4g-systems.de>
+ *         Bruno Randolf <bruno.randolf@4g-systems.biz>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
diff -Nurb mips-2.4.23-rc5/arch/mips/defconfig-mtx-1 mips-2.4.23-rc5-mtx/arch/mips/defconfig-mtx-1
--- mips-2.4.23-rc5/arch/mips/defconfig-mtx-1	2003-11-26 10:51:39.000000000 +0100
+++ mips-2.4.23-rc5-mtx/arch/mips/defconfig-mtx-1	2003-11-26 12:38:46.000000000 +0100
@@ -1,5 +1,5 @@
 #
-# Automatically generated make config: don't edit
+# Automatically generated by make menuconfig: don't edit
 #
 CONFIG_MIPS=y
 CONFIG_MIPS32=y
@@ -138,7 +138,7 @@
 # CONFIG_MIPS32_N32 is not set
 # CONFIG_BINFMT_ELF32 is not set
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_PM is not set
+CONFIG_PM=y
 
 #
 # Memory Technology Devices (MTD)
@@ -149,10 +149,6 @@
 # CONFIG_MTD_CONCAT is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
-
-#
-# User Modules And Translation Layers
-#
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
@@ -200,10 +196,6 @@
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
-
-#
-# Disk-On-Chip Device Drivers
-#
 # CONFIG_MTD_DOC1000 is not set
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
@@ -239,7 +231,8 @@
 # CONFIG_BLK_DEV_UMEM is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_BLK_STATS is not set
 
@@ -259,33 +252,85 @@
 # Networking options
 #
 CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
+CONFIG_PACKET_MMAP=y
+CONFIG_NETLINK_DEV=m
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
-# CONFIG_FILTER is not set
+CONFIG_FILTER=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_FWMARK=y
+CONFIG_IP_ROUTE_NAT=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_TOS=y
+CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
+CONFIG_NET_IPIP=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
 # CONFIG_ARPD is not set
 # CONFIG_INET_ECN is not set
-# CONFIG_SYN_COOKIES is not set
+CONFIG_SYN_COOKIES=y
 
 #
 #   IP: Netfilter Configuration
 #
-# CONFIG_IP_NF_CONNTRACK is not set
-# CONFIG_IP_NF_QUEUE is not set
-# CONFIG_IP_NF_IPTABLES is not set
-# CONFIG_IP_NF_ARPTABLES is not set
+CONFIG_IP_NF_CONNTRACK=m
+CONFIG_IP_NF_FTP=m
+# CONFIG_IP_NF_AMANDA is not set
+# CONFIG_IP_NF_TFTP is not set
+CONFIG_IP_NF_IRC=m
+CONFIG_IP_NF_QUEUE=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_LIMIT=m
+CONFIG_IP_NF_MATCH_MAC=m
+CONFIG_IP_NF_MATCH_PKTTYPE=m
+CONFIG_IP_NF_MATCH_MARK=m
+CONFIG_IP_NF_MATCH_MULTIPORT=m
+CONFIG_IP_NF_MATCH_TOS=m
+# CONFIG_IP_NF_MATCH_RECENT is not set
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_DSCP=m
+CONFIG_IP_NF_MATCH_AH_ESP=m
+CONFIG_IP_NF_MATCH_LENGTH=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_MATCH_TCPMSS=m
+CONFIG_IP_NF_MATCH_HELPER=m
+CONFIG_IP_NF_MATCH_STATE=m
+CONFIG_IP_NF_MATCH_CONNTRACK=m
+# CONFIG_IP_NF_MATCH_UNCLEAN is not set
+# CONFIG_IP_NF_MATCH_OWNER is not set
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+# CONFIG_IP_NF_TARGET_MIRROR is not set
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+# CONFIG_IP_NF_NAT_LOCAL is not set
+# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
+CONFIG_IP_NF_NAT_IRC=m
+CONFIG_IP_NF_NAT_FTP=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_TOS=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_DSCP=m
+CONFIG_IP_NF_TARGET_MARK=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_TARGET_TCPMSS=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+# CONFIG_IP_NF_ARP_MANGLE is not set
 # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
 # CONFIG_IP_NF_COMPAT_IPFWADM is not set
 
@@ -302,11 +347,7 @@
 CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
-# CONFIG_VLAN_8021Q is not set
-
-#
-#  
-#
+CONFIG_VLAN_8021Q=m
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 
@@ -315,7 +356,7 @@
 #
 # CONFIG_DEV_APPLETALK is not set
 # CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
+CONFIG_BRIDGE=m
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_LLC is not set
@@ -328,12 +369,34 @@
 #
 # QoS and/or fair queueing
 #
-# CONFIG_NET_SCHED is not set
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+# CONFIG_NET_SCH_CSZ is not set
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_QOS=y
+CONFIG_NET_ESTIMATOR=y
+CONFIG_NET_CLS=y
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_ROUTE=y
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+CONFIG_NET_CLS_RSVP=m
+# CONFIG_NET_CLS_RSVP6 is not set
+CONFIG_NET_CLS_POLICE=y
 
 #
 # Network testing
 #
-# CONFIG_NET_PKTGEN is not set
+CONFIG_NET_PKTGEN=m
 
 #
 # Telephony Support
@@ -352,7 +415,71 @@
 #
 # SCSI support
 #
-# CONFIG_SCSI is not set
+CONFIG_SCSI=m
+CONFIG_BLK_DEV_SD=m
+CONFIG_SD_EXTRA_DEVS=40
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=m
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_SR_EXTRA_DEVS=2
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_SCSI_DEBUG_QUEUES is not set
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_7000FASST is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AHA152X is not set
+# CONFIG_SCSI_AHA1542 is not set
+# CONFIG_SCSI_AHA1740 is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_IN2000 is not set
+# CONFIG_SCSI_AM53C974 is not set
+# CONFIG_SCSI_MEGARAID is not set
+# CONFIG_SCSI_MEGARAID2 is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_CPQFCTS is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_DTC3280 is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_DMA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_GENERIC_NCR5380 is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_NCR53C406A is not set
+# CONFIG_SCSI_NCR53C7xx is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_NCR53C8XX is not set
+# CONFIG_SCSI_SYM53C8XX is not set
+# CONFIG_SCSI_PAS16 is not set
+# CONFIG_SCSI_PCI2000 is not set
+# CONFIG_SCSI_PCI2220I is not set
+# CONFIG_SCSI_PSI240I is not set
+# CONFIG_SCSI_QLOGIC_FAS is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_SIM710 is not set
+# CONFIG_SCSI_SYM53C416 is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_T128 is not set
+# CONFIG_SCSI_U14_34F is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
 
 #
 # I2O device support
@@ -373,10 +500,10 @@
 # ARCnet devices
 #
 # CONFIG_ARCNET is not set
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
+CONFIG_DUMMY=m
+CONFIG_BONDING=m
 # CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
+CONFIG_TUN=m
 # CONFIG_ETHERTAP is not set
 
 #
@@ -415,13 +542,32 @@
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PLIP is not set
-# CONFIG_PPP is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
 
 #
 # Wireless LAN (non-hamradio)
 #
-# CONFIG_NET_RADIO is not set
+CONFIG_NET_RADIO=y
+# CONFIG_STRIP is not set
+# CONFIG_WAVELAN is not set
+# CONFIG_ARLAN is not set
+# CONFIG_AIRONET4500 is not set
+# CONFIG_AIRONET4500_NONCS is not set
+# CONFIG_AIRONET4500_PROC is not set
+# CONFIG_AIRO is not set
+# CONFIG_HERMES is not set
+# CONFIG_PLX_HERMES is not set
+# CONFIG_TMD_HERMES is not set
+# CONFIG_PCI_HERMES is not set
+CONFIG_NET_WIRELESS=y
 
 #
 # Token Ring devices
@@ -511,14 +657,6 @@
 # Joysticks
 #
 # CONFIG_INPUT_GAMEPORT is not set
-
-#
-# Input core support is needed for gameports
-#
-
-#
-# Input core support is needed for joysticks
-#
 # CONFIG_QIC02_TAPE is not set
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_IPMI_PANIC_EVENT is not set
@@ -550,7 +688,7 @@
 # Direct Rendering Manager (XFree86 DRI support)
 #
 # CONFIG_DRM is not set
-# CONFIG_AU1X00_GPIO is not set
+CONFIG_AU1X00_GPIO=m
 # CONFIG_TS_AU1X00_ADS7846 is not set
 
 #
@@ -560,7 +698,7 @@
 # CONFIG_QFMT_V2 is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
-# CONFIG_REISERFS_FS is not set
+CONFIG_REISERFS_FS=m
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_ADFS_FS is not set
@@ -571,28 +709,29 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
-CONFIG_EXT3_FS=y
-CONFIG_JBD=y
+CONFIG_EXT3_FS=m
+CONFIG_JBD=m
 # CONFIG_JBD_DEBUG is not set
-# CONFIG_FAT_FS is not set
-# CONFIG_MSDOS_FS is not set
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
 # CONFIG_UMSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=m
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS_FS is not set
-# CONFIG_JFFS2_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
 # CONFIG_CRAMFS is not set
 CONFIG_TMPFS=y
 CONFIG_RAMFS=y
-# CONFIG_ISO9660_FS is not set
-# CONFIG_JOLIET is not set
-# CONFIG_ZISOFS is not set
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
 # CONFIG_JFS_FS is not set
 # CONFIG_JFS_DEBUG is not set
 # CONFIG_JFS_STATISTICS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
-# CONFIG_NTFS_FS is not set
+CONFIG_NTFS_FS=m
 # CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
@@ -603,9 +742,9 @@
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_QNX4FS_RW is not set
 # CONFIG_ROMFS_FS is not set
-CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS=m
 # CONFIG_SYSV_FS is not set
-# CONFIG_UDF_FS is not set
+CONFIG_UDF_FS=m
 # CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
@@ -625,7 +764,8 @@
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_SMB_FS is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
 # CONFIG_NCPFS_IOCTL_LOCKING is not set
@@ -635,30 +775,252 @@
 # CONFIG_NCPFS_SMALLDOS is not set
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
-# CONFIG_ZISOFS_FS is not set
+CONFIG_ZISOFS_FS=m
 
 #
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-# CONFIG_SMB_NLS is not set
-# CONFIG_NLS is not set
+CONFIG_SMB_NLS=y
+CONFIG_NLS=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS_DEFAULT="iso8859-15"
+CONFIG_NLS_CODEPAGE_437=m
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=m
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+CONFIG_NLS_ISO8859_15=m
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=m
 
 #
 # Multimedia devices
 #
-# CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_DEV=m
+
+#
+# Video For Linux
+#
+# CONFIG_VIDEO_PROC_FS is not set
+# CONFIG_I2C_PARPORT is not set
+# CONFIG_VIDEO_BT848 is not set
+# CONFIG_VIDEO_PMS is not set
+# CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_SAA5249 is not set
+# CONFIG_TUNER_3036 is not set
+# CONFIG_VIDEO_STRADIS is not set
+# CONFIG_VIDEO_ZORAN is not set
+# CONFIG_VIDEO_ZORAN_BUZ is not set
+# CONFIG_VIDEO_ZORAN_DC10 is not set
+# CONFIG_VIDEO_ZORAN_LML33 is not set
+# CONFIG_VIDEO_ZR36120 is not set
+# CONFIG_VIDEO_MEYE is not set
+
+#
+# Radio Adapters
+#
+# CONFIG_RADIO_GEMTEK_PCI is not set
+# CONFIG_RADIO_MAXIRADIO is not set
+# CONFIG_RADIO_MAESTRO is not set
+# CONFIG_RADIO_MIROPCM20 is not set
 
 #
 # Sound
 #
-# CONFIG_SOUND is not set
+CONFIG_SOUND=m
+# CONFIG_SOUND_ALI5455 is not set
+# CONFIG_SOUND_BT878 is not set
+# CONFIG_SOUND_CMPCI is not set
+# CONFIG_SOUND_EMU10K1 is not set
+# CONFIG_MIDI_EMU10K1 is not set
+# CONFIG_SOUND_FUSION is not set
+# CONFIG_SOUND_CS4281 is not set
+# CONFIG_SOUND_ES1370 is not set
+# CONFIG_SOUND_ES1371 is not set
+# CONFIG_SOUND_ESSSOLO1 is not set
+# CONFIG_SOUND_MAESTRO is not set
+# CONFIG_SOUND_MAESTRO3 is not set
+# CONFIG_SOUND_FORTE is not set
+# CONFIG_SOUND_ICH is not set
+# CONFIG_SOUND_RME96XX is not set
+# CONFIG_SOUND_SONICVIBES is not set
+# CONFIG_SOUND_AU1X00 is not set
+# CONFIG_SOUND_TRIDENT is not set
+# CONFIG_SOUND_MSNDCLAS is not set
+# CONFIG_SOUND_MSNDPIN is not set
+# CONFIG_SOUND_VIA82CXXX is not set
+# CONFIG_MIDI_VIA82CXXX is not set
+CONFIG_SOUND_OSS=m
+# CONFIG_SOUND_TRACEINIT is not set
+# CONFIG_SOUND_DMAP is not set
+# CONFIG_SOUND_AD1816 is not set
+# CONFIG_SOUND_AD1889 is not set
+# CONFIG_SOUND_SGALAXY is not set
+# CONFIG_SOUND_ADLIB is not set
+# CONFIG_SOUND_ACI_MIXER is not set
+# CONFIG_SOUND_CS4232 is not set
+# CONFIG_SOUND_SSCAPE is not set
+# CONFIG_SOUND_GUS is not set
+# CONFIG_SOUND_VMIDI is not set
+# CONFIG_SOUND_TRIX is not set
+# CONFIG_SOUND_MSS is not set
+# CONFIG_SOUND_MPU401 is not set
+# CONFIG_SOUND_NM256 is not set
+# CONFIG_SOUND_MAD16 is not set
+# CONFIG_SOUND_PAS is not set
+# CONFIG_PAS_JOYSTICK is not set
+# CONFIG_SOUND_PSS is not set
+# CONFIG_SOUND_SB is not set
+# CONFIG_SOUND_AWE32_SYNTH is not set
+# CONFIG_SOUND_KAHLUA is not set
+# CONFIG_SOUND_WAVEFRONT is not set
+# CONFIG_SOUND_MAUI is not set
+# CONFIG_SOUND_YM3812 is not set
+# CONFIG_SOUND_OPL3SA1 is not set
+# CONFIG_SOUND_OPL3SA2 is not set
+# CONFIG_SOUND_YMFPCI is not set
+# CONFIG_SOUND_YMFPCI_LEGACY is not set
+# CONFIG_SOUND_UART6850 is not set
+# CONFIG_SOUND_AEDSP16 is not set
+# CONFIG_SOUND_TVMIXER is not set
+# CONFIG_SOUND_AD1980 is not set
+# CONFIG_SOUND_WM97XX is not set
 
 #
 # USB support
 #
-# CONFIG_USB is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_UHCI is not set
+# CONFIG_USB_UHCI_ALT is not set
+CONFIG_USB_OHCI=y
+CONFIG_USB_AUDIO=m
+CONFIG_USB_EMI26=m
+CONFIG_USB_MIDI=m
+CONFIG_USB_STORAGE=m
+CONFIG_USB_STORAGE_DEBUG=y
+CONFIG_USB_STORAGE_DATAFAB=y
+CONFIG_USB_STORAGE_FREECOM=y
+# CONFIG_USB_STORAGE_ISD200 is not set
+CONFIG_USB_STORAGE_DPCM=y
+CONFIG_USB_STORAGE_HP8200e=y
+CONFIG_USB_STORAGE_SDDR09=y
+CONFIG_USB_STORAGE_SDDR55=y
+CONFIG_USB_STORAGE_JUMPSHOT=y
+CONFIG_USB_ACM=m
+CONFIG_USB_PRINTER=m
+# CONFIG_USB_HID is not set
+# CONFIG_USB_HIDINPUT is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+CONFIG_USB_DC2XX=m
+CONFIG_USB_MDC800=m
+CONFIG_USB_SCANNER=m
+CONFIG_USB_MICROTEK=m
+CONFIG_USB_HPUSBSCSI=m
+CONFIG_USB_IBMCAM=m
+CONFIG_USB_KONICAWC=m
+CONFIG_USB_OV511=m
+CONFIG_USB_PWC=m
+CONFIG_USB_SE401=m
+CONFIG_USB_STV680=m
+# CONFIG_USB_W9968CF is not set
+CONFIG_USB_VICAM=m
+CONFIG_USB_DSBR=m
+CONFIG_USB_DABUSB=m
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+CONFIG_USB_KAWETH=m
+CONFIG_USB_CATC=m
+# CONFIG_USB_AX8817X is not set
+CONFIG_USB_CDCETHER=m
+CONFIG_USB_USBNET=m
+# CONFIG_USB_USS720 is not set
+
+#
+# USB Serial Converter support
+#
+CONFIG_USB_SERIAL=m
+# CONFIG_USB_SERIAL_DEBUG is not set
+CONFIG_USB_SERIAL_GENERIC=y
+CONFIG_USB_SERIAL_BELKIN=m
+CONFIG_USB_SERIAL_WHITEHEAT=m
+CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
+CONFIG_USB_SERIAL_EMPEG=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_VISOR=m
+CONFIG_USB_SERIAL_IPAQ=m
+CONFIG_USB_SERIAL_IR=m
+CONFIG_USB_SERIAL_EDGEPORT=m
+CONFIG_USB_SERIAL_EDGEPORT_TI=m
+CONFIG_USB_SERIAL_KEYSPAN_PDA=m
+CONFIG_USB_SERIAL_KEYSPAN=m
+CONFIG_USB_SERIAL_KEYSPAN_USA28=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19=y
+CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
+CONFIG_USB_SERIAL_KEYSPAN_MPR=y
+CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
+CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
+CONFIG_USB_SERIAL_MCT_U232=m
+CONFIG_USB_SERIAL_KLSI=m
+CONFIG_USB_SERIAL_KOBIL_SCT=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_USB_SERIAL_CYBERJACK=m
+CONFIG_USB_SERIAL_XIRCOM=m
+CONFIG_USB_SERIAL_OMNINET=m
+CONFIG_USB_RIO500=m
+CONFIG_USB_AUERSWALD=m
+CONFIG_USB_TIGL=m
+CONFIG_USB_BRLVGER=m
+CONFIG_USB_LCD=m
 
 #
 # Support for USB gadgets
@@ -668,7 +1030,30 @@
 #
 # Bluetooth support
 #
-# CONFIG_BLUEZ is not set
+CONFIG_BLUEZ=m
+CONFIG_BLUEZ_L2CAP=m
+CONFIG_BLUEZ_SCO=m
+CONFIG_BLUEZ_RFCOMM=m
+CONFIG_BLUEZ_RFCOMM_TTY=y
+CONFIG_BLUEZ_BNEP=m
+CONFIG_BLUEZ_BNEP_MC_FILTER=y
+CONFIG_BLUEZ_BNEP_PROTO_FILTER=y
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BLUEZ_HCIUSB=m
+CONFIG_BLUEZ_USB_SCO=y
+CONFIG_BLUEZ_HCIUART=m
+CONFIG_BLUEZ_HCIUART_H4=y
+CONFIG_BLUEZ_HCIUART_BCSP=y
+CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=y
+# CONFIG_BLUEZ_HCIBFUSB is not set
+# CONFIG_BLUEZ_HCIDTL1 is not set
+# CONFIG_BLUEZ_HCIBT3C is not set
+# CONFIG_BLUEZ_HCIBLUECARD is not set
+# CONFIG_BLUEZ_HCIBTUART is not set
+CONFIG_BLUEZ_HCIVHCI=m
 
 #
 # Kernel hacking
@@ -691,5 +1076,5 @@
 # Library routines
 #
 # CONFIG_CRC32 is not set
-# CONFIG_ZLIB_INFLATE is not set
-# CONFIG_ZLIB_DEFLATE is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y


--Boundary-00=_L6B4/Fwy/KAcfcB--
