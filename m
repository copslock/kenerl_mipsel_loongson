Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2017 11:06:17 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:40003 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993868AbdEDJFgTyu3m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 May 2017 11:05:36 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E49DAEEC;
        Thu,  4 May 2017 09:05:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 78/86] MIPS: Fix crash registers on non-crashing CPUs
Date:   Thu,  4 May 2017 11:04:43 +0200
Message-Id: <b8099bcecc4b10a4c252ee57a0ebf7afe73ec07f.1493888632.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <13a6a971c9165237531c2870da03084a6becc905.1493888632.git.jslaby@suse.cz>
References: <13a6a971c9165237531c2870da03084a6becc905.1493888632.git.jslaby@suse.cz>
In-Reply-To: <cover.1493888632.git.jslaby@suse.cz>
References: <cover.1493888632.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57849
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

3.12-stable review patch.  If anyone has any objections, please let me know.

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
