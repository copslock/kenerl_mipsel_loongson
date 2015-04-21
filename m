Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:50:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55440 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025938AbbDUOttLb7IZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:49:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E468B5238F961;
        Tue, 21 Apr 2015 15:49:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:49:45 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:49:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 08/37] MIPS: JZ4740: use generic plat_irq_dispatch
Date:   Tue, 21 Apr 2015 15:46:35 +0100
Message-ID: <1429627624-30525-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Make use of the generic plat_irq_dispatch function introduced by commit
85f7cdacbb81 "MIPS: Provide a generic plat_irq_dispatch", in order to
reduce unnecessary code duplication.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Changes in v3:
  - Rebase.

Changes in v2:
  - None.
---
 arch/mips/jz4740/irq.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 3ec90875..a2452bb 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -27,7 +27,6 @@
 #include <linux/seq_file.h>
 
 #include <asm/io.h>
-#include <asm/mipsregs.h>
 
 #include <asm/mach-jz4740/base.h>
 #include <asm/mach-jz4740/irq.h>
@@ -111,17 +110,6 @@ void __init arch_init_irq(void)
 	setup_irq(2, &jz4740_cascade_action);
 }
 
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-	if (pending & STATUSF_IP2)
-		do_IRQ(2);
-	else if (pending & STATUSF_IP3)
-		do_IRQ(3);
-	else
-		spurious_interrupt();
-}
-
 #ifdef CONFIG_DEBUG_FS
 
 static inline void intc_seq_reg(struct seq_file *s, const char *name,
-- 
2.3.5
