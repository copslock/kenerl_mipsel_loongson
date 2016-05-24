Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 15:09:05 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028491AbcEXNJBmjqcV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 15:09:01 +0200
Received: from p5492f80a.dip0.t-ipconnect.de
        ([84.146.248.10] helo=nereus.tec.linutronix.de. ident=mdkuser)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1b5C4z-00089P-17; Tue, 24 May 2016 15:09:01 +0200
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Add missing FROZEN hotplug notifier transitions
Date:   Tue, 24 May 2016 15:08:47 +0200
Message-Id: <1464095327-55194-1-git-send-email-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.8.1
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <anna-maria@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53638
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

The corresponding FROZEN hotplug notifier transitions used on
suspend/resume are ignored. Therefore the switch case action argument
is masked with the frozen hotplug notifier transition mask.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/mips/cavium-octeon/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -384,7 +384,7 @@ static int octeon_cpu_callback(struct no
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
-	switch (action) {
+	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_UP_PREPARE:
 		octeon_update_boot_vector(cpu);
 		break;
