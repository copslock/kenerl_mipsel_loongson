Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jul 2013 07:40:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:58689 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816841Ab3GYFkeud9ca (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jul 2013 07:40:34 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1V2EHp-0006wS-WF; Thu, 25 Jul 2013 00:40:26 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: Move declaration of 'fixup_irqs' to common header.
Date:   Thu, 25 Jul 2013 00:40:17 -0500
Message-Id: <1374730817-9040-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

To prepare for CPU hotplug of CM-based platforms.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/cavium-octeon/smp.c |    2 --
 arch/mips/include/asm/irq.h   |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 138cc80..a63dbc0 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -255,8 +255,6 @@ static void octeon_cpus_done(void)
 /* State of each CPU. */
 DEFINE_PER_CPU(int, cpu_state);
 
-extern void fixup_irqs(void);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 7bc2cdb..8994ca8 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -126,6 +126,7 @@ extern void do_IRQ_no_affinity(unsigned int irq);
 
 extern void arch_init_irq(void);
 extern void spurious_interrupt(void);
+extern void fixup_irqs(void);
 
 extern int allocate_irqno(void);
 extern void alloc_legacy_irqno(void);
-- 
1.7.2.5
