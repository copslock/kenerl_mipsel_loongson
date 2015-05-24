Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:20:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20685 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006775AbbEXPULo-CP6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:20:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 987D978FFFD30;
        Sun, 24 May 2015 16:20:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:20:08 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:20:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v5 14/37] MIPS: JZ4740: drop intc debugfs code
Date:   Sun, 24 May 2015 16:11:24 +0100
Message-ID: <1432480307-23789-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47612
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

The debugfs code becomes a nuisance when attempting to avoid globals,
since the interrupt controller probe function run too early for it to be
safe to create the debugfs files. Drop it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- New patch.

Changes in v2: None

 arch/mips/jz4740/irq.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index ddcf78a..615eaa8 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -23,9 +23,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
 #include <asm/io.h>
 
 #include <asm/mach-jz4740/base.h>
@@ -123,42 +120,3 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 	return 0;
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
-
-#ifdef CONFIG_DEBUG_FS
-
-static inline void intc_seq_reg(struct seq_file *s, const char *name,
-	unsigned int reg)
-{
-	seq_printf(s, "%s:\t\t%08x\n", name, readl(jz_intc_base + reg));
-}
-
-static int intc_regs_show(struct seq_file *s, void *unused)
-{
-	intc_seq_reg(s, "Status", JZ_REG_INTC_STATUS);
-	intc_seq_reg(s, "Mask", JZ_REG_INTC_MASK);
-	intc_seq_reg(s, "Pending", JZ_REG_INTC_PENDING);
-
-	return 0;
-}
-
-static int intc_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, intc_regs_show, NULL);
-}
-
-static const struct file_operations intc_regs_operations = {
-	.open		= intc_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init intc_debugfs_init(void)
-{
-	(void) debugfs_create_file("jz_regs_intc", S_IFREG | S_IRUGO,
-				NULL, NULL, &intc_regs_operations);
-	return 0;
-}
-subsys_initcall(intc_debugfs_init);
-
-#endif
-- 
2.4.1
