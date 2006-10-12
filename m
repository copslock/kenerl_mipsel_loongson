Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 22:17:45 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:57104 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20038556AbWJLVRn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 22:17:43 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Thu, 12 Oct 2006 14:17:28 -0700
X-Server-Uuid: 79DB55DB-3CB4-423E-BEDB-D0F268247E63
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 6CF622B0; Thu, 12 Oct 2006 14:17:28 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 49EA12AF for
 <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:17:28 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHK52092; Thu, 12 Oct 2006 14:17:27 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 CD84B20501 for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:17:27
 -0700 (PDT)
Received: from localhost.localdomain ([10.240.253.52]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 12 Oct 2006 14:17:27 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k9CLGvSC012866
 for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:17:03 -0700
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k9CLGeok012862 for linux-mips@linux-mips.org;
 Thu, 12 Oct 2006 14:16:40 -0700
Date:	Thu, 12 Oct 2006 14:16:40 -0700
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Update default silicon revision for swarm defconfig
Message-ID: <20061012211640.GA12830@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Oct 2006 21:17:27.0738 (UTC)
 FILETIME=[D1D6E9A0:01C6EE43]
X-WSS-ID: 69306F622I03932283-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips


When building the swarm defconfig, the current default is for an old silicon
revision that is not shipping anymore, and which requires special workarounds
not present in current compilers.

This change updates the default silicon revision to Bn - which is what most
everyone has nowadays.

Signed-off-by: Mark Mason <mason@broadcom.com>

---
 arch/mips/configs/sb1250-swarm_defconfig |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index 625c1c6..ab8f092 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:19 2006
+# Linux kernel version: 2.6.18-rc4
+# Thu Oct 12 13:57:21 2006
 #
 CONFIG_MIPS=y
 
@@ -66,9 +66,9 @@ # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
 CONFIG_SIBYTE_SB1250=y
 CONFIG_SIBYTE_SB1xxx_SOC=y
-CONFIG_CPU_SB1_PASS_1=y
+# CONFIG_CPU_SB1_PASS_1 is not set
 # CONFIG_CPU_SB1_PASS_2_1250 is not set
-# CONFIG_CPU_SB1_PASS_2_2 is not set
+CONFIG_CPU_SB1_PASS_2_2=y
 # CONFIG_CPU_SB1_PASS_4 is not set
 # CONFIG_CPU_SB1_PASS_2_112x is not set
 # CONFIG_CPU_SB1_PASS_3 is not set
@@ -138,7 +138,7 @@ CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_VPE_LOADER is not set
-CONFIG_SB1_PASS_1_WORKAROUNDS=y
+CONFIG_SB1_PASS_2_WORKAROUNDS=y
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -190,6 +190,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
@@ -409,6 +410,7 @@ # CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=9220
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_BUFFERS=8
@@ -697,6 +699,7 @@ # Graphics support
 #
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -849,7 +852,6 @@ # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -874,6 +876,7 @@ # CONFIG_PROFILING is not set
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-- 
1.1.6.g4e27f
