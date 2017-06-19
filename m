Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 20:34:15 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51800 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991532AbdFSSeHHu6SP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 20:34:07 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v5JIY2tJ015122;
        Mon, 19 Jun 2017 20:34:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Corey Minyard <cminyard@mvista.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Jiri Slaby <jslaby@suse.cz>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 256/268] MIPS: Fix crash registers on non-crashing CPUs
Date:   Mon, 19 Jun 2017 20:32:35 +0200
Message-Id: <1497897167-14556-257-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1497897167-14556-1-git-send-email-w@1wt.eu>
References: <1497897167-14556-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: Corey Minyard <cminyard@mvista.com>

commit c80e1b62ffca52e2d1d865ee58bc79c4c0c55005 upstream.

As part of handling a crash on an SMP system, an IPI is send to
all other CPUs to save their current registers and stop.  It was
using task_pt_regs(current) to get the registers, but that will
only be accurate if the CPU was interrupted running in userland.
Instead allow the architecture to pass in the registers (all
pass NULL now, but allow for the future) and then use get_irq_regs()
which should be accurate as we are in an interrupt.  Fall back to
task_pt_regs(current) if nothing else is available.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13050/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/crash.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 93aa302..c683129 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -15,12 +15,22 @@ static int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
 #ifdef CONFIG_SMP
-static void crash_shutdown_secondary(void *ignore)
+static void crash_shutdown_secondary(void *passed_regs)
 {
-	struct pt_regs *regs;
+	struct pt_regs *regs = passed_regs;
 	int cpu = smp_processor_id();
 
-	regs = task_pt_regs(current);
+	/*
+	 * If we are passed registers, use those.  Otherwise get the
+	 * regs from the last interrupt, which should be correct, as
+	 * we are in an interrupt.  But if the regs are not there,
+	 * pull them from the top of the stack.  They are probably
+	 * wrong, but we need something to keep from crashing again.
+	 */
+	if (!regs)
+		regs = get_irq_regs();
+	if (!regs)
+		regs = task_pt_regs(current);
 
 	if (!cpu_online(cpu))
 		return;
-- 
2.8.0.rc2.1.gbe9624a
