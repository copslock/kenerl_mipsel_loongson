Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 00:16:15 +0200 (CEST)
Received: from mail-qg0-f74.google.com ([209.85.192.74]:33270 "EHLO
        mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007480AbaH2WOxlMhlZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 00:14:53 +0200
Received: by mail-qg0-f74.google.com with SMTP id a108so419596qge.3
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O6sUuel9j0b7drn1mCH0JpoL1Swhm/hgHm/jm10KbF4=;
        b=fPNAwsCd3nynwOh5PUFXzr/uLez2ch5Oi5caUPAdrkS/qhK2QCg0ywL3DJbExBae3f
         H+S22e1YcjEUCA58NvZBG/nbhqtaag1xnkn0eYLkxlrlB14/+wFihvFErBXs9InN1q6A
         RBKZ8PNyLWhUzXTSWTC5FpaX3m07bkhxlgxThaBbu47EVCI+8JljiIfUw1ziyIf+eri3
         VO4KQQQUAAdxqUPPUBX9xFkc7qm/pCgIxEaqQ1SFrR6jwvtQsfKgQNRpFhOVYWcZXMfk
         OvbhQywSxzQzET31WB8jktuMQ/q9bpIRl8a9EUAYZ3nwQVLczUWVXVkys073IDzhaNoY
         mfrw==
X-Gm-Message-State: ALoCoQmhpGllRrAXhIFP08/tuEpZN5wG++4onMl/7+N0/EEfY27pp3QTwQquNUR2ZjuUzxl0YEwv
X-Received: by 10.236.100.134 with SMTP id z6mr7314254yhf.8.1409350487861;
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id d7si1007yho.2.2014.08.29.15.14.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Aug 2014 15:14:47 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6BDD15A43BE;
        Fri, 29 Aug 2014 15:14:42 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 20BE3221060; Fri, 29 Aug 2014 15:14:42 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] MIPS: Provide a generic plat_irq_dispatch
Date:   Fri, 29 Aug 2014 15:14:28 -0700
Message-Id: <1409350479-19108-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

For platforms which boot with device-tree and use the MIPS CPU interrupt
controller binding, a generic plat_irq_dispatch() can be used since all
CPU interrupts should be mapped through the CPU IRQ domain.  Implement a
plat_irq_dispatch() which simply handles the highest pending interrupt.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/irq_cpu.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index e498f2b..9cf8459 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -116,6 +116,24 @@ void __init mips_cpu_irq_init(void)
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
+static struct irq_domain *mips_intc_domain;
+
+asmlinkage void __weak plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	unsigned int hw;
+	int irq;
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	hw = fls(pending) - CAUSEB_IP - 1;
+	irq = irq_linear_revmap(mips_intc_domain, hw);
+	do_IRQ(irq);
+}
+
 static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 			     irq_hw_number_t hw)
 {
@@ -141,15 +159,15 @@ static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
 int __init mips_cpu_intc_init(struct device_node *of_node,
 			      struct device_node *parent)
 {
-	struct irq_domain *domain;
-
 	/* Mask interrupts. */
 	clear_c0_status(ST0_IM);
 	clear_c0_cause(CAUSEF_IP);
 
-	domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
-				       &mips_cpu_intc_irq_domain_ops, NULL);
-	if (!domain)
+	mips_intc_domain = irq_domain_add_legacy(of_node, 8,
+						 MIPS_CPU_IRQ_BASE, 0,
+						 &mips_cpu_intc_irq_domain_ops,
+						 NULL);
+	if (!mips_intc_domain)
 		panic("Failed to add irqdomain for MIPS CPU");
 
 	return 0;
-- 
2.1.0.rc2.206.gedb03e5
