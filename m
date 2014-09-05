Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:31:04 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:40847 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008218AbaIERagm2R4N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:36 +0200
Received: by mail-pa0-f74.google.com with SMTP id lf10so136372pab.1
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eqE6e+rQCbFmSC1Ax1QSu9tqFPsy9lfKg3A9ukmNJ5Y=;
        b=j4nZxUvvEtJNiDJHMTtJ9Sp6tjo0pGDKSUNTr5krPyCRt0Cr4yu8r9D5BpUCJ1Wxqb
         QLEAhZ7HEw70H8OjMou1P7/xJxhEXGWVwWS5KVONrbdYW1zrhj4e4NNebCdlBLWEcL3f
         4k8zTakxKMt+E77uSnaEQsyIjztCivYyPO7D7D9f5+7avtTZ6b0x5hTod8wbj3lL46/Y
         PYQvK40UOwZAF2ag/wP5aRjReFgiTm6gOjedkzwObYU/hMXq4YI1vcX4Tjt36cHZNIN5
         DvHVDyNn4PaGvhwfm8CizfUiBeWL98/Su+I/JiAznkps4AluOfbOEiOYsPz+2iXyOACu
         JAVg==
X-Gm-Message-State: ALoCoQnj1XYRViu0tp1UWaKznusABNsGiLjSSZxghjuDAqVIOVW6YXv8E+86X1bFNcDQv11iVZaE
X-Received: by 10.66.142.229 with SMTP id rz5mr7561077pab.17.1409938230004;
        Fri, 05 Sep 2014 10:30:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c77si506588yha.5.2014.09.05.10.30.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:29 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C95D331C285;
        Fri,  5 Sep 2014 10:30:29 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 68FD9220A1C; Fri,  5 Sep 2014 10:30:29 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/16] MIPS: Provide a generic plat_irq_dispatch
Date:   Fri,  5 Sep 2014 10:30:03 -0700
Message-Id: <1409938218-9026-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42431
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
Tested-by: Jonas Gorski <jogo@openwrt.org>
---
No changes from v1.
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
