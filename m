Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2017 23:28:34 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993957AbdEAV20HXucG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 May 2017 23:28:26 +0200
Received: from localhost (unknown [107.14.56.132])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96564B6B;
        Mon,  1 May 2017 21:28:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 4.4 09/43] MIPS: Fix crash registers on non-crashing CPUs
Date:   Mon,  1 May 2017 14:27:09 -0700
Message-Id: <20170501212559.916770336@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170501212559.546911128@linuxfoundation.org>
References: <20170501212559.546911128@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/crash.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -14,12 +14,22 @@ static int crashing_cpu = -1;
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
