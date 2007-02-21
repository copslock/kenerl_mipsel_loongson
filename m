Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 03:13:56 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:12045 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20039019AbXBUDNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2007 03:13:51 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.0)); Tue, 20 Feb 2007 19:13:11 -0800
X-Server-Uuid: 9206F490-5C8F-4575-BE70-2AAA8A3D4853
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 51C222AF; Tue, 20 Feb 2007 19:13:11 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 3EB812AE for
 <linux-mips@linux-mips.org>; Tue, 20 Feb 2007 19:13:11 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EYO24134; Tue, 20 Feb 2007 19:13:10 -0800 (PST)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 C680720502 for <linux-mips@linux-mips.org>; Tue, 20 Feb 2007 19:13:10
 -0800 (PST)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 20 Feb 2007 19:13:10 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] update sb1250 defconfig
Date:	Tue, 20 Feb 2007 19:13:07 -0800
Message-ID: <710F16C36810444CA2F5821E5EAB7F231C84ED@NT-SJCA-0752.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] update sb1250 defconfig
Thread-Index: AcdVZjT1QcMAkxpaSrijAMD3ZFsbgw==
From:	"Manoj Ekbote" <manoj.ekbote@broadcom.com>
To:	linux-mips@linux-mips.org
X-OriginalArrivalTime: 21 Feb 2007 03:13:10.0733 (UTC)
 FILETIME=[375EBFD0:01C75566]
X-WSS-ID: 69C5674D3Y825784606-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoj.ekbote@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoj.ekbote@broadcom.com
Precedence: bulk
X-list: linux-mips

This patch updates sb1250-swarm-defconfig file to default to Sibyte Bn
silicon as the PASS_1 processors are very old.

Signed-off-by: Manoj Ekbote <manoje@broadcom.com>

----

diff --git a/arch/mips/configs/sb1250-swarm_defconfig
b/arch/mips/configs/sb1250-swarm_defconfig
index 533df6f..45b68de 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
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
@@ -142,7 +142,7 @@ CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
-CONFIG_SB1_PASS_1_WORKAROUNDS=y
+CONFIG_SB1_PASS_2_WORKAROUNDS=y
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
