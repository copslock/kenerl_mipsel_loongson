Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 17:04:08 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49100 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994644AbeFGPEBc79vf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 17:04:01 +0200
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbT-0005Zk-LJ; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Bh-LT; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Justin Chen" <justinpopo6@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, "James Hogan" <jhogan@kernel.org>
Date:   Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.568346237@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 325/410] MIPS: BMIPS: Do not mask IPIs during suspend
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justinpopo6@gmail.com>

commit 06a3f0c9f2725f5d7c63c4203839373c9bd00c28 upstream.

Commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on CPU IRQs") fixes an
issue where disable_irq did not actually disable the irq. The bug caused
our IPIs to not be disabled, which actually is the correct behavior.

With the addition of commit a3e6c1eff548 ("MIPS: IRQ: Fix disable_irq on
CPU IRQs"), the IPIs were getting disabled going into suspend, thus
schedule_ipi() was not being called. This caused deadlocks where
schedulable task were not being scheduled and other cpus were waiting
for them to do something.

Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called on the
IPIs during suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17385/
[jhogan@kernel.org: checkpatch: wrap long lines and fix commit refs]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/smp-bmips.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -159,11 +159,11 @@ static void bmips_prepare_cpus(unsigned
 		return;
 	}
 
-	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi0", NULL))
+	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt");
-	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
-			"smp_ipi1", NULL))
+	if (request_irq(IPI1_IRQ, bmips_ipi_interrupt,
+			IRQF_PERCPU | IRQF_NO_SUSPEND, "smp_ipi1", NULL))
 		panic("Can't request IPI1 interrupt");
 }
 
