Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 13:00:08 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:19475 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20021467AbXFUMAG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2007 13:00:06 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1I1LKX-0001U6-00
	for <linux-mips@linux-mips.org>; Thu, 21 Jun 2007 13:00:05 +0100
Received: from hendon.mips.com ([192.168.192.184] helo=localhost.localdomain)
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1I1LKQ-0001Pd-01; Thu, 21 Jun 2007 12:59:58 +0100
From:	chris@mips.com
To:	linux-mips@linux-mips.org
Cc:	Chris Dearman <chris@mips.com>
Subject: [PATCH] Fix timer/performance interrupt detection
Date:	Thu, 21 Jun 2007 12:59:57 +0100
Message-Id: <1182427198884-git-send-email-chris@mips.com>
X-Mailer: git-send-email 1.4.3.GIT
In-Reply-To: <11824271984112-git-send-email-chris@mips.com>
References: <11824271984112-git-send-email-chris@mips.com>
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: chris@mips.com
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---
 arch/mips/kernel/traps.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b123364..3ea7863 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1372,12 +1372,12 @@ void __init per_cpu_trap_init(void)
 	 */
 	if (cpu_has_mips_r2) {
 		cp0_compare_irq = (read_c0_intctl () >> 29) & 7;
-		cp0_perfcount_irq = -1;
-	} else {
-		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
 		cp0_perfcount_irq = (read_c0_intctl () >> 26) & 7;
-		if (cp0_perfcount_irq != cp0_compare_irq)
+		if (cp0_perfcount_irq == cp0_compare_irq)
 			cp0_perfcount_irq = -1;
+	} else {
+		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
+		cp0_perfcount_irq = -1;
 	}
 
 #ifdef CONFIG_MIPS_MT_SMTC
-- 
1.4.4.3
