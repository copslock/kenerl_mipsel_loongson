Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:22:07 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:56148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013542AbbLINVdeVDrA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Dec 2015 14:21:33 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A010AD59;
        Wed,  9 Dec 2015 13:21:33 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 2/4] printk/nmi: Use IRQ work only when ready
Date:   Wed,  9 Dec 2015 14:21:03 +0100
Message-Id: <1449667265-17525-3-git-send-email-pmladek@suse.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1449667265-17525-1-git-send-email-pmladek@suse.com>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

NMIs could happen at any time. This patch makes sure that the safe
printk() in NMI will schedule IRQ work only when the related
structs are initialized.

All pending messages are flushed when the IRQ work is being
initialized.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 7b5ff81b291f..29a498586465 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -38,6 +38,7 @@
  * were handled or when IRQs are blocked.
  */
 DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
+static int printk_nmi_irq_ready;
 
 #define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
 
@@ -83,8 +84,11 @@ again:
 		goto again;
 
 	/* Get flushed in a more safe context. */
-	if (add)
+	if (add && printk_nmi_irq_ready) {
+		/* Make sure that IRQ work is really initialized. */
+		smp_rmb();
 		irq_work_queue(&s->work);
+	}
 
 	return add;
 }
@@ -190,6 +194,13 @@ void __init printk_nmi_init(void)
 
 		init_irq_work(&s->work, __printk_nmi_flush);
 	}
+
+	/* Make sure that IRQ works are initialized before enabling. */
+	smp_wmb();
+	printk_nmi_irq_ready = 1;
+
+	/* Flush pending messages that did not have scheduled IRQ works. */
+	printk_nmi_flush();
 }
 
 void printk_nmi_enter(void)
-- 
1.8.5.6
