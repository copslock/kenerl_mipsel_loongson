Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Nov 2010 23:13:04 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16368 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491937Ab0KEWNA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Nov 2010 23:13:00 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cd481900001>; Fri, 05 Nov 2010 15:13:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 5 Nov 2010 15:13:35 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 5 Nov 2010 15:13:35 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oA5MCqha017544;
        Fri, 5 Nov 2010 15:12:53 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oA5MCowN017543;
        Fri, 5 Nov 2010 15:12:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] MIPS: Rework GENERIC_HARDIRQS Kconfig.
Date:   Fri,  5 Nov 2010 15:12:48 -0700
Message-Id: <1288995168-17511-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 05 Nov 2010 22:13:35.0404 (UTC) FILETIME=[B08EB6C0:01CB7D36]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Recent changes to CONFIG_GENERIC_HARDIRQS have caused us to start
getting:

warning: (SMP && SYS_SUPPORTS_SMP) selects IRQ_PER_CPU which has unmet direct dependencies (HAVE_GENERIC_HARDIRQS)

Rearranging our Kconfig quiets the message.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 67a2fa2..7fc6bd1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -19,6 +19,8 @@ config MIPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_IRQ_PROBE
 
 menu "Machine selection"
 
@@ -1922,20 +1924,6 @@ config CPU_R4400_WORKAROUNDS
 	bool
 
 #
-# Use the generic interrupt handling code in kernel/irq/:
-#
-config GENERIC_HARDIRQS
-	bool
-	default y
-
-config GENERIC_IRQ_PROBE
-	bool
-	default y
-
-config IRQ_PER_CPU
-	bool
-
-#
 # - Highmem only makes sense for the 32-bit kernel.
 # - The current highmem code will only work properly on physically indexed
 #   caches such as R3000, SB1, R7000 or those that look like they're virtually
-- 
1.7.2.3
