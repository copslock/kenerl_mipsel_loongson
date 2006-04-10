Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2006 09:50:37 +0100 (BST)
Received: from h081217049130.dyn.cm.kabsi.at ([81.217.49.130]:14519 "EHLO
	phobos.hvrlab.org") by ftp.linux-mips.org with ESMTP
	id S8133510AbWDJIuZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Apr 2006 09:50:25 +0100
Received: from phobos.hvrlab.org (localhost.localdomain [127.0.0.1])
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-3) with ESMTP id k3A91xF0029833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Apr 2006 11:01:59 +0200
Received: (from hvr@localhost)
	by phobos.hvrlab.org (8.13.4/8.13.4/Submit) id k3A91sXm029832;
	Mon, 10 Apr 2006 11:01:54 +0200
Message-Id: <200604100901.k3A91sXm029832@phobos.hvrlab.org>
To:	linux-mips@linux-mips.org
Cc:	ppopov@embeddedalley.com
From:	Herbert Valerio Riedel <hvr@hvrlab.org>
Date:	Mon Apr 10 10:38:45 2006 +0200
Subject: [PATCH] AU1xxxx mips_timer_interrupt() fixes
X-Virus-Scanned: ClamAV 0.84/1388/Mon Apr 10 07:50:38 2006 on phobos.hvrlab.org
X-Virus-Status:	Clean
Return-Path: <hvr@hvrlab.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@hvrlab.org
Precedence: bulk
X-list: linux-mips

common/au1000/irq.c was missing a mips_timer_interrupt() prototype, whereas
in common/au1000/time.c the actual mips_timer_interrupt() implementation
was missing an irq_exit() invocation, causing a preempt_count() leak

Signed-off-by: Herbert Valerio Riedel <hvr@hvrlab.org>


---

 arch/mips/au1000/common/irq.c  |    1 +
 arch/mips/au1000/common/time.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

d0a263ef156cf498d97cf6b2f37ba4d8d4a92559
diff --git a/arch/mips/au1000/common/irq.c b/arch/mips/au1000/common/irq.c
index da61de7..afe05ec 100644
--- a/arch/mips/au1000/common/irq.c
+++ b/arch/mips/au1000/common/irq.c
@@ -68,6 +68,7 @@
 
 extern void set_debug_traps(void);
 extern irq_cpustat_t irq_stat [NR_CPUS];
+extern void mips_timer_interrupt(struct pt_regs *regs);
 
 static void setup_local_irq(unsigned int irq, int type, int int_req);
 static unsigned int startup_irq(unsigned int irq);
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index f85f152..f74d66a 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -116,6 +116,7 @@ void mips_timer_interrupt(struct pt_regs
 
 null:
 	ack_r4ktimer(0);
+	irq_exit();
 }
 
 #ifdef CONFIG_PM
-- 
1.2.4
