Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 15:18:32 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:3063 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225345AbULAPS2>;
	Wed, 1 Dec 2004 15:18:28 +0000
Received: MO(mo01)id iB1FIP7U006108; Thu, 2 Dec 2004 00:18:25 +0900 (JST)
Received: MDO(mdo00) id iB1FIOSW016811; Thu, 2 Dec 2004 00:18:25 +0900 (JST)
Received: 4UMRO00 id iB1FINLj012038; Thu, 2 Dec 2004 00:18:24 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Thu, 2 Dec 2004 00:18:22 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] update TANBAC TB0229 configuration
Message-Id: <20041202001822.5d5b4522.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated TANBAC TB0229 configuration.
Please apply this patch to 2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/configs/tb0229_defconfig a/arch/mips/configs/tb0229_defconfig
--- a-orig/arch/mips/configs/tb0229_defconfig	Mon Nov 22 15:12:30 2004
+++ a/arch/mips/configs/tb0229_defconfig	Thu Dec  2 00:05:59 2004
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.10-rc2
-# Sun Nov 21 14:12:07 2004
+# Wed Dec  1 14:32:07 2004
 #
 CONFIG_MIPS=y
 # CONFIG_MIPS64 is not set
@@ -65,7 +65,7 @@
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
-CONFIG_VRC4173=y
+# CONFIG_VRC4173 is not set
 # CONFIG_TOSHIBA_JMR3927 is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
@@ -315,7 +315,7 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_NET_VENDOR_3COM is not set
@@ -325,7 +325,27 @@
 #
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
+CONFIG_NET_PCI=y
+CONFIG_PCNET32=y
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
+# CONFIG_EEPRO100_PIO is not set
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
+# CONFIG_LAN_SAA9730 is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -338,6 +358,7 @@
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 
 #
@@ -684,7 +705,7 @@
 #
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
+CONFIG_CMDLINE="mem=64M console=ttyS0,38400 ip=bootp root=/dev/nfs"
 
 #
 # Security options
@@ -702,7 +723,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
