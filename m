Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:52:50 +0200 (CEST)
Received: from mail-oa0-f73.google.com ([209.85.219.73]:55284 "EHLO
        mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009008AbaIOXvnUwTYy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:43 +0200
Received: by mail-oa0-f73.google.com with SMTP id jd19so747408oac.0
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vsRzbQxC2HfyLNfDC87T9T2YeePcMvuueYe077TTuP4=;
        b=KXNVSgoApvpfZBziMoOoseqpo5x3NqUul7WCmoJPyHJvzu2QTEDbREKGIT5tcdp6IU
         x0/rzgkHZHT6kADrtfe8YrEzhTsZ0S4HkeP0Xad6D7b3JPcrbteJd/WFCwHzeIk7IcNW
         vZi87TRLFZ1mNpUXqv84/mjwl191FaCa4egbqjfgI/sW5s0Q59tk8J/yAGE/ZhOTgMah
         aWSKOxMXrcBopxwgRERuyePWxOHvehCRVs2bRxkJQXubwLuW2zzfF0fkqQtrw2yuFYYl
         CpHyCasMNr5PLZIuN7NjGngDXkdHvAs/0B+z+dMJrvbTM7RQ20B0oStw7j35tssiSEPv
         qoJw==
X-Gm-Message-State: ALoCoQlnAS/Tqv+ryOeG+jOsjVmz3vKWCN/DTLZFH7mEvsh9t21pl31i3vHn17VBZSP2EvB/Jvsz
X-Received: by 10.50.92.104 with SMTP id cl8mr13887886igb.1.1410825096926;
        Mon, 15 Sep 2014 16:51:36 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si630576yhe.3.2014.09.15.16.51.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:36 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id pSykdCfm.2; Mon, 15 Sep 2014 16:51:36 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C86A9220868; Mon, 15 Sep 2014 16:51:35 -0700 (PDT)
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
Subject: [PATCH 05/24] MIPS: i8259: Use IRQ domains
Date:   Mon, 15 Sep 2014 16:51:08 -0700
Message-Id: <1410825087-5497-6-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42622
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

Create a legacy IRQ domain for the 16 i8259 interrupts.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Kconfig        |  1 +
 arch/mips/kernel/i8259.c | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9fc335c..de72c92 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -971,6 +971,7 @@ config SYS_SUPPORTS_HOTPLUG_CPU
 
 config I8259
 	bool
+	select IRQ_DOMAIN
 
 config MIPS_BONITO64
 	bool
diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index 50b3648..a74ec3a 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
@@ -308,6 +309,19 @@ static struct resource pic2_io_resource = {
 	.flags = IORESOURCE_BUSY
 };
 
+static int i8259A_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				 irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &i8259A_chip, handle_level_irq);
+	irq_set_probe(virq);
+	return 0;
+}
+
+static struct irq_domain_ops i8259A_ops = {
+	.map = i8259A_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
 /*
  * On systems with i8259-style interrupt controllers we assume for
  * driver compatibility reasons interrupts 0 - 15 to be the i8259
@@ -315,17 +329,17 @@ static struct resource pic2_io_resource = {
  */
 void __init init_i8259_irqs(void)
 {
-	int i;
+	struct irq_domain *domain;
 
 	insert_resource(&ioport_resource, &pic1_io_resource);
 	insert_resource(&ioport_resource, &pic2_io_resource);
 
 	init_8259A(0);
 
-	for (i = I8259A_IRQ_BASE; i < I8259A_IRQ_BASE + 16; i++) {
-		irq_set_chip_and_handler(i, &i8259A_chip, handle_level_irq);
-		irq_set_probe(i);
-	}
+	domain = irq_domain_add_legacy(NULL, 16, I8259A_IRQ_BASE, 0,
+				       &i8259A_ops, NULL);
+	if (!domain)
+		panic("Failed to add i8259 IRQ domain");
 
 	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
 }
-- 
2.1.0.rc2.206.gedb03e5
