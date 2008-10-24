Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 23:47:34 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:31659 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S22319682AbYJXWrE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 23:47:04 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id B1EE5C8103;
	Sat, 25 Oct 2008 01:46:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id ue-95y+e9juX; Sat, 25 Oct 2008 01:46:57 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 88AC5C80D3;
	Sat, 25 Oct 2008 01:46:57 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 47D32108020; Sat, 25 Oct 2008 01:46:56 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [MIPS] IP22: Small cleanups
Date:	Sat, 25 Oct 2008 01:46:56 +0300
Message-Id: <1224888417-26494-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The following functions

disable_local1_irq()
disable_local2_irq()
disable_local3_irq()

are needlessly defined global, so make them static. While at
it, fix a couple of coding style errors in the same file.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/sgi-ip22/ip22-int.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index f6d9bf4..5b9b4f3 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/time.h>
 
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
@@ -23,7 +24,6 @@
 #include <asm/sgi/ioc.h>
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
-#include <asm/time.h>
 
 /* #define DEBUG_SGINT */
 
@@ -68,7 +68,7 @@ static void enable_local1_irq(unsigned int irq)
 		sgint->imask1 |= (1 << (irq - SGINT_LOCAL1));
 }
 
-void disable_local1_irq(unsigned int irq)
+static void disable_local1_irq(unsigned int irq)
 {
 	sgint->imask1 &= ~(1 << (irq - SGINT_LOCAL1));
 }
@@ -87,7 +87,7 @@ static void enable_local2_irq(unsigned int irq)
 	sgint->cmeimask0 |= (1 << (irq - SGINT_LOCAL2));
 }
 
-void disable_local2_irq(unsigned int irq)
+static void disable_local2_irq(unsigned int irq)
 {
 	sgint->cmeimask0 &= ~(1 << (irq - SGINT_LOCAL2));
 	if (!sgint->cmeimask0)
@@ -108,7 +108,7 @@ static void enable_local3_irq(unsigned int irq)
 	sgint->cmeimask1 |= (1 << (irq - SGINT_LOCAL3));
 }
 
-void disable_local3_irq(unsigned int irq)
+static void disable_local3_irq(unsigned int irq)
 {
 	sgint->cmeimask1 &= ~(1 << (irq - SGINT_LOCAL3));
 	if (!sgint->cmeimask1)
@@ -344,6 +344,6 @@ void __init arch_init_irq(void)
 
 #ifdef CONFIG_EISA
 	if (ip22_is_fullhouse())	/* Only Indigo-2 has EISA stuff */
-	        ip22_eisa_init();
+		ip22_eisa_init();
 #endif
 }
-- 
1.5.4.3
