Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:48:03 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:53152 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009226AbaIRVrnLeB9X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:43 +0200
Received: by mail-oi0-f74.google.com with SMTP id u20so310924oif.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S9G7iy27PXJ7v+1DkytUeZ6UckwocCu2Zyq5MC1aFPY=;
        b=EvRmoPH24C/2Hvi7D/GagXnyZsl/m4tMSFQsyzKX5B48RW8nPLOWQX91RuoafvyVRB
         uzdQnRrcEbJBModV+zl48pU2pWjVYaPBA1x++A9GkOMR4u23xBDygnbiooxVJtIS5oMq
         3DeKxtZkNQohXJj/1d6LrF27AabRcNDZfFb2G3nYsbEoGz2krtyN+i/l/cbNEVg5Ocfy
         PiI9rTONbtSiO3PaabSkFe5C2CCqaV8HysycCjCsl3XvyJ4R9vklVpeNiNnpO/emfC8o
         6lJLavwrikwQS8ZCrIBvkrX5/SCXvDZYN6/sbIjLRPCkuhXpaNLB3OYNDBBrDfUu8n9f
         IptA==
X-Gm-Message-State: ALoCoQnATnwjh6jXS4xmm9dNIj7bSGpwBaUkKb5clayV8FELOVHXU5NZvt78VeRnrBqMkWqUKQHj
X-Received: by 10.50.6.78 with SMTP id y14mr19241555igy.3.1411076856872;
        Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id j25si5182yhb.0.2014.09.18.14.47.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:36 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id GFX5IUsx.1; Thu, 18 Sep 2014 14:47:36 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 8A80A220CC1; Thu, 18 Sep 2014 14:47:35 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/24] MIPS: Always use IRQ domains for CPU IRQs
Date:   Thu, 18 Sep 2014 14:47:07 -0700
Message-Id: <1411076851-28242-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42681
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

Use an IRQ domain for the 8 CPU IRQs in both the DT and non-DT cases.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/Kconfig          |  1 +
 arch/mips/kernel/irq_cpu.c | 36 +++++++++++-------------------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 900c7e5..9fc335c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1051,6 +1051,7 @@ config MIPS_HUGE_TLB_SUPPORT
 
 config IRQ_CPU
 	bool
+	select IRQ_DOMAIN
 
 config IRQ_CPU_RM7K
 	bool
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index e498f2b..b097f7d 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -94,28 +94,6 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 	.irq_eoi	= unmask_mips_irq,
 };
 
-void __init mips_cpu_irq_init(void)
-{
-	int irq_base = MIPS_CPU_IRQ_BASE;
-	int i;
-
-	/* Mask interrupts. */
-	clear_c0_status(ST0_IM);
-	clear_c0_cause(CAUSEF_IP);
-
-	/* Software interrupts are used for MT/CMT IPI */
-	for (i = irq_base; i < irq_base + 2; i++)
-		irq_set_chip_and_handler(i, cpu_has_mipsmt ?
-					 &mips_mt_cpu_irq_controller :
-					 &mips_cpu_irq_controller,
-					 handle_percpu_irq);
-
-	for (i = irq_base + 2; i < irq_base + 8; i++)
-		irq_set_chip_and_handler(i, &mips_cpu_irq_controller,
-					 handle_percpu_irq);
-}
-
-#ifdef CONFIG_IRQ_DOMAIN
 static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
 			     irq_hw_number_t hw)
 {
@@ -138,8 +116,7 @@ static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-int __init mips_cpu_intc_init(struct device_node *of_node,
-			      struct device_node *parent)
+static void __init __mips_cpu_irq_init(struct device_node *of_node)
 {
 	struct irq_domain *domain;
 
@@ -151,7 +128,16 @@ int __init mips_cpu_intc_init(struct device_node *of_node,
 				       &mips_cpu_intc_irq_domain_ops, NULL);
 	if (!domain)
 		panic("Failed to add irqdomain for MIPS CPU");
+}
+
+void __init mips_cpu_irq_init(void)
+{
+	__mips_cpu_irq_init(NULL);
+}
 
+int __init mips_cpu_intc_init(struct device_node *of_node,
+			      struct device_node *parent)
+{
+	__mips_cpu_irq_init(of_node);
 	return 0;
 }
-#endif /* CONFIG_IRQ_DOMAIN */
-- 
2.1.0.rc2.206.gedb03e5
