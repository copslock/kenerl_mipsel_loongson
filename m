Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 14:18:26 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57311 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006999AbcDDMSVQoVvi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 14:18:21 +0200
Received: from p5492f5e7.dip0.t-ipconnect.de
        ([84.146.245.231] helo=nereus.tec.linutronix.de. ident=mdkuser)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1an3SW-00087s-CA; Mon, 04 Apr 2016 14:18:20 +0200
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Remove no longer needed work_on_cpu() call
Date:   Mon,  4 Apr 2016 14:18:03 +0200
Message-Id: <1459772283-40657-1-git-send-email-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.7.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <anna-maria@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anna-maria@linutronix.de
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

Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this
work_on_cpu() calls are no longer required.

Replace work_on_cpu() with a direct call of mips_cdmm_bus_up() or
mips_cdmm_bus_down(). Description of those functions are adapted.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 drivers/bus/mips_cdmm.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/bus/mips_cdmm.c
+++ b/drivers/bus/mips_cdmm.c
@@ -599,8 +599,8 @@ BUILD_PERDEV_HELPER(cpu_up)         /* i
  * mips_cdmm_bus_down() - Tear down the CDMM bus.
  * @data:	Pointer to unsigned int CPU number.
  *
- * This work_on_cpu callback function is executed on a given CPU to call the
- * CDMM driver cpu_down callback for all devices on that CPU.
+ * This function is executed on the hotplugged CPU and calls the CDMM
+ * driver cpu_down callback for all devices on that CPU.
  */
 static long mips_cdmm_bus_down(void *data)
 {
@@ -630,7 +630,9 @@ static long mips_cdmm_bus_down(void *dat
  * CDMM devices on that CPU, or to call the CDMM driver cpu_up callback for all
  * devices already discovered on that CPU.
  *
- * It is used during initialisation and when CPUs are brought online.
+ * It is used as work_on_cpu callback function during
+ * initialisation. When CPUs are brought online the function is
+ * invoked directly on the hotplugged CPU.
  */
 static long mips_cdmm_bus_up(void *data)
 {
@@ -677,10 +679,10 @@ static int mips_cdmm_cpu_notify(struct n
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
 	case CPU_DOWN_FAILED:
-		work_on_cpu(cpu, mips_cdmm_bus_up, &cpu);
+		mips_cdmm_bus_up(&cpu);
 		break;
 	case CPU_DOWN_PREPARE:
-		work_on_cpu(cpu, mips_cdmm_bus_down, &cpu);
+		mips_cdmm_bus_down(&cpu);
 		break;
 	default:
 		return NOTIFY_DONE;
