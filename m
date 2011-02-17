Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 23:04:51 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9497 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491115Ab1BQWEr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 23:04:47 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d9bab0001>; Thu, 17 Feb 2011 14:05:31 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 14:04:39 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 14:04:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1HM4aXv025954;
        Thu, 17 Feb 2011 14:04:36 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1HM4aor025952;
        Thu, 17 Feb 2011 14:04:36 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Cleanup Kconfig IRQ_CPU* symbols.
Date:   Thu, 17 Feb 2011 14:04:33 -0800
Message-Id: <1297980273-25920-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 17 Feb 2011 22:04:39.0269 (UTC) FILETIME=[ABF50150:01CBCEEE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Octeon doesn't use IRQ_CPU, so don't select it.

IRQ_CPU_OCTEON is a completely unused symbol, remove it completely.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e89b416..89eff23 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -992,9 +992,6 @@ config IRQ_GT641XX
 config IRQ_GIC
 	bool
 
-config IRQ_CPU_OCTEON
-	bool
-
 config MIPS_BOARDS_GEN
 	bool
 
@@ -1354,8 +1351,6 @@ config CPU_SB1
 config CPU_CAVIUM_OCTEON
 	bool "Cavium Octeon processor"
 	depends on SYS_HAS_CPU_CAVIUM_OCTEON
-	select IRQ_CPU
-	select IRQ_CPU_OCTEON
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_SMP
-- 
1.7.2.3
