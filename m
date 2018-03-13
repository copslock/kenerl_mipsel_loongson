Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2018 16:39:34 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbeCMPi6hazQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2018 16:38:58 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 285CFF73;
        Tue, 13 Mar 2018 15:38:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 078/140] MIPS: BMIPS: Do not mask IPIs during suspend
Date:   Tue, 13 Mar 2018 16:24:41 +0100
Message-Id: <20180313152503.380862971@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62960
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17385/
[jhogan@kernel.org: checkpatch: wrap long lines and fix commit refs]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp-bmips.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -168,11 +168,11 @@ static void bmips_prepare_cpus(unsigned
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
 
