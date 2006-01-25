Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 23:23:17 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:29970 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133463AbWAYXW6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 23:22:58 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 25 Jan 2006 15:27:07 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 6925367420; Wed, 25 Jan 2006 15:27:07 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id E4B1967421 for
 <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 15:27:06 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CTY43777; Wed, 25 Jan 2006 15:27:05 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 52E4720501 for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 15:27:05
 -0800 (PST)
Received: from localhost.localdomain ([10.240.253.39]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 25 Jan 2006 15:27:05 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0PNQc4c006146
 for <linux-mips@linux-mips.org>; Wed, 25 Jan 2006 15:26:44 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0PNQbY7006145 for linux-mips@linux-mips.org;
 Wed, 25 Jan 2006 15:26:37 -0800
Date:	Wed, 25 Jan 2006 15:26:37 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] swarm board defconfig fixes
Message-ID: <20060125232637.GA6107@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 25 Jan 2006 23:27:05.0162 (UTC)
 FILETIME=[DA24A2A0:01C62206]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006012509; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230342E34334438303745342E303031322D412D;
 ENG=IBF; TS=20060125232709; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006012509_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FC6D6C141W4452851-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

For the swarm defconfig, set the default silicon stepping to Bx, and
enable 64-bit ELF builds.

Signed-off-by: Mark Mason <mason@broadcom.com>
---

This fixes out-of-the box compilation and configuration errors for the swarm
defconfig.

diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 
-# Wed Jan 11 17:48:35 2006
+# Linux kernel version: 2.6.15
+# Wed Jan 25 13:01:27 2006
 #
 CONFIG_MIPS=y
 
@@ -65,9 +65,9 @@ CONFIG_SIBYTE_SWARM=y
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
@@ -131,7 +131,7 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_SIBYTE_DMA_PAGEOPS is not set
 CONFIG_CPU_HAS_PREFETCH=y
 # CONFIG_MIPS_MT is not set
-CONFIG_SB1_PASS_1_WORKAROUNDS=y
+CONFIG_SB1_PASS_2_WORKAROUNDS=y
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -249,7 +249,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_BUILD_ELF64=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_MIPS32_O32=y
