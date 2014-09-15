Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:51:59 +0200 (CEST)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:49672 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008998AbaIOXvlkfF0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:41 +0200
Received: by mail-ob0-f201.google.com with SMTP id m8so746255obr.4
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NcfggpnTvFYurEg4nvcSLGmKoYx9nL3gxaVrO8FrEzY=;
        b=ddzPqVwYEj1LZMW6oaQN8MCVVIp01iqZn3ptas4Y4mhVtiASuO8LRbzCKtKO1M0L5i
         XUmbkLfP0lj0UCSXh8BRbHcgmMYvaby7aaJB2+3Tt2xHZ1fVyO7ADNA73X6lE4xtB9e7
         t4uwzDl/e0CgmH03yH68PQX3wQlVPs4nAnrenEIeeZ3LVY+ejjIH1pI9rH5BQyvUcAAy
         Sip5ZKwLp0ViSRl+68Hik4IRg3F2ySbsR4MDEi/gzhxihM7tGdPYMwp635PfKEsdwJV8
         J4KxJEi1R5jUuNIxfdHQcwTdTa4b3IUJdOIqCxC6Ht4vqOCFNhu1sYnU5WtOSEDmUm/5
         +/pQ==
X-Gm-Message-State: ALoCoQkk40FqF3zH383A3m4s66arvbGa3y/AolqpJnbTpUrZiyTcXHegQjchQdK5XuB6+ohf0tts
X-Received: by 10.182.213.105 with SMTP id nr9mr17714210obc.36.1410825094386;
        Mon, 15 Sep 2014 16:51:34 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si629273yho.5.2014.09.15.16.51.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:34 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 4wJpECu2.1; Mon, 15 Sep 2014 16:51:34 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 14C0922093F; Mon, 15 Sep 2014 16:51:33 -0700 (PDT)
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
Subject: [PATCH 01/24] MIPS: Always use IRQ domains for CPU IRQs
Date:   Mon, 15 Sep 2014 16:51:04 -0700
Message-Id: <1410825087-5497-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42619
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
