Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 12:28:55 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:45927 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491181Ab1HLK2v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 12:28:51 +0200
Received: by fxd20 with SMTP id 20so2884541fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 03:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SBjWQp4jkHQZjCKVsuF8XU6Fqbjr2SUAUdTvsaZv2js=;
        b=Djl3ZAI5XoJTWyO1Ko+S+tAo+USsqzkM8eRsvJisxCdcrOkH6uFf1J+p84D3XiFScP
         PwB6y9KAwOi6hoPkrgADgeoqDxE6yneJAG3aSmahdeTCJBTKlz1osLXJoYJgCMpVMU8O
         ujUUi+JaMhUxIT1WxfCnGOhZsQFfUEbE32f8w=
Received: by 10.223.7.65 with SMTP id c1mr1022869fac.131.1313144926441;
        Fri, 12 Aug 2011 03:28:46 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id g16sm1574007faa.27.2011.08.12.03.28.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 03:28:45 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: db1200: disable cascade IRQ in handler
Date:   Fri, 12 Aug 2011 12:28:35 +0200
Message-Id: <1313144915-16321-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9292

Disable the cascade IRQ in the cascade handler.  This is required to
get the DB1300 working, and also gets rid of all spurious interrupts
previously observed on the DB1200; so Config[OD] can be disabled
again for better performance.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/bcsr.c         |    4 ++++
 arch/mips/alchemy/devboards/db1200/setup.c |    7 -------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index 596ad00..463d2c4 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -89,8 +89,12 @@ static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
 {
 	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
 
+	disable_irq_nosync(irq);
+
 	for ( ; bisr; bisr &= bisr - 1)
 		generic_handle_irq(bcsr_csc_base + __ffs(bisr));
+
+	enable_irq(irq);
 }
 
 /* NOTE: both the enable and mask bits must be cleared, otherwise the
diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
index 1dac4f2..4a89800 100644
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -23,13 +23,6 @@ void __init board_setup(void)
 	unsigned long freq0, clksrc, div, pfc;
 	unsigned short whoami;
 
-	/* Set Config[OD] (disable overlapping bus transaction):
-	 * This gets rid of a _lot_ of spurious interrupts (especially
-	 * wrt. IDE); but incurs ~10% performance hit in some
-	 * cpu-bound applications.
-	 */
-	set_c0_config(1 << 19);
-
 	bcsr_init(DB1200_BCSR_PHYS_ADDR,
 		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
 
-- 
1.7.6
