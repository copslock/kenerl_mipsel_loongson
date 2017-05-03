Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2017 14:23:51 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:46777 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993977AbdECMXklXTaG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 May 2017 14:23:40 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 066C3AD48;
        Wed,  3 May 2017 12:23:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: Fix crash registers on non-crashing CPUs
Date:   Wed,  3 May 2017 14:23:19 +0200
Message-Id: <20170503122327.12095-41-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503122327.12095-1-jslaby@suse.cz>
References: <20170503122327.12095-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
---
 arch/mips/kernel/crash.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 93aa302948d7..c68312947ed9 100644
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
2.12.2
