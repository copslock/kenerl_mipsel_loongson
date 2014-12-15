Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:08:18 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36680 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008838AbaLOSGorufKl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:44 +0100
Received: by mail-lb0-f178.google.com with SMTP id f15so10551864lbj.37
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDf8aey62v5iPdkZyBgdke0x7q+p+wqHAZ4DxwJ5yrU=;
        b=KmICgDoq2My5L7ELx6Vsv+KOATFlFxU9zXKtDdWtl/DK0kVf4Pf5s9onooM1ayaQqt
         gHuQg05B2mHcU3IlG/8u/PYUzgoKwaC9One3C0BYy/O94MRe/rKZHle2AGqCnPXwN554
         OC6ZH4pRYFnNsbofktY/3LocuOUBRNYggCq2LNOZBpKdZkLCRiyFucTAS8QEgUGgrqGt
         w0qLnHxgo3Y6qNzfB0i+HN9/iFfIC9mEUiYjYsqnmBjUwzlfVZSQL4kkP01kllqOEG/J
         eeWbmM/kY9UTaLMoZP2jxE620YiT+uRtqWY/3Z/hEJMzxvJZ6QdwAarVYd+On5sx5VLW
         JNVg==
X-Received: by 10.152.10.40 with SMTP id f8mr32374854lab.52.1418666799499;
        Mon, 15 Dec 2014 10:06:39 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:38 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 08/14] MIPS: OCTEON: Don't do acknowledge operations for level triggered irqs.
Date:   Mon, 15 Dec 2014 21:03:14 +0300
Message-Id: <1418666603-15159-9-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

From: David Daney <david.daney@cavium.com>

The acknowledge bits don't exist for level triggered irqs, so setting
them causes the simulator to terminate.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 45 ++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 2bc4aa9..5df70c5 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -752,6 +752,18 @@ static struct irq_chip octeon_irq_chip_ciu_v2 = {
 	.name = "CIU",
 	.irq_enable = octeon_irq_ciu_enable_v2,
 	.irq_disable = octeon_irq_ciu_disable_all_v2,
+	.irq_mask = octeon_irq_ciu_disable_local_v2,
+	.irq_unmask = octeon_irq_ciu_enable_v2,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu_set_affinity_v2,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu_v2_edge = {
+	.name = "CIU",
+	.irq_enable = octeon_irq_ciu_enable_v2,
+	.irq_disable = octeon_irq_ciu_disable_all_v2,
 	.irq_ack = octeon_irq_ciu_ack,
 	.irq_mask = octeon_irq_ciu_disable_local_v2,
 	.irq_unmask = octeon_irq_ciu_enable_v2,
@@ -765,6 +777,18 @@ static struct irq_chip octeon_irq_chip_ciu = {
 	.name = "CIU",
 	.irq_enable = octeon_irq_ciu_enable,
 	.irq_disable = octeon_irq_ciu_disable_all,
+	.irq_mask = octeon_irq_ciu_disable_local,
+	.irq_unmask = octeon_irq_ciu_enable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu_set_affinity,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu_edge = {
+	.name = "CIU",
+	.irq_enable = octeon_irq_ciu_enable,
+	.irq_disable = octeon_irq_ciu_disable_all,
 	.irq_ack = octeon_irq_ciu_ack,
 	.irq_mask = octeon_irq_ciu_disable_local,
 	.irq_unmask = octeon_irq_ciu_enable,
@@ -984,6 +1008,7 @@ static int octeon_irq_ciu_xlat(struct irq_domain *d,
 }
 
 static struct irq_chip *octeon_irq_ciu_chip;
+static struct irq_chip *octeon_irq_ciu_chip_edge;
 static struct irq_chip *octeon_irq_gpio_chip;
 
 static bool octeon_irq_virq_in_range(unsigned int virq)
@@ -1014,7 +1039,7 @@ static int octeon_irq_ciu_map(struct irq_domain *d,
 
 	if (octeon_irq_ciu_is_edge(line, bit))
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
-					   octeon_irq_ciu_chip,
+					   octeon_irq_ciu_chip_edge,
 					   handle_edge_irq);
 	else
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
@@ -1196,6 +1221,7 @@ static void __init octeon_irq_init_ciu(void)
 {
 	unsigned int i;
 	struct irq_chip *chip;
+	struct irq_chip *chip_edge;
 	struct irq_chip *chip_mbox;
 	struct irq_chip *chip_wd;
 	struct device_node *gpio_node;
@@ -1212,16 +1238,19 @@ static void __init octeon_irq_init_ciu(void)
 	    OCTEON_IS_MODEL(OCTEON_CN52XX_PASS2_X) ||
 	    OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
 		chip = &octeon_irq_chip_ciu_v2;
+		chip_edge = &octeon_irq_chip_ciu_v2_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
 		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
 		chip = &octeon_irq_chip_ciu;
+		chip_edge = &octeon_irq_chip_ciu_edge;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
 		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio;
 	}
 	octeon_irq_ciu_chip = chip;
+	octeon_irq_ciu_chip_edge = chip_edge;
 	octeon_irq_ip4 = octeon_irq_ip4_mask;
 
 	/* Mips internal */
@@ -1473,6 +1502,18 @@ static struct irq_chip octeon_irq_chip_ciu2 = {
 	.name = "CIU2-E",
 	.irq_enable = octeon_irq_ciu2_enable,
 	.irq_disable = octeon_irq_ciu2_disable_all,
+	.irq_mask = octeon_irq_ciu2_disable_local,
+	.irq_unmask = octeon_irq_ciu2_enable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = octeon_irq_ciu2_set_affinity,
+	.irq_cpu_offline = octeon_irq_cpu_offline_ciu,
+#endif
+};
+
+static struct irq_chip octeon_irq_chip_ciu2_edge = {
+	.name = "CIU2-E",
+	.irq_enable = octeon_irq_ciu2_enable,
+	.irq_disable = octeon_irq_ciu2_disable_all,
 	.irq_ack = octeon_irq_ciu2_ack,
 	.irq_mask = octeon_irq_ciu2_disable_local,
 	.irq_unmask = octeon_irq_ciu2_enable,
@@ -1582,7 +1623,7 @@ static int octeon_irq_ciu2_map(struct irq_domain *d,
 
 	if (octeon_irq_ciu2_is_edge(line, bit))
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
-					   &octeon_irq_chip_ciu2,
+					   &octeon_irq_chip_ciu2_edge,
 					   handle_edge_irq);
 	else
 		octeon_irq_set_ciu_mapping(virq, line, bit, 0,
-- 
2.1.3
