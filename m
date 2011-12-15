Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2011 03:33:19 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:61728 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903747Ab1LOCcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Dec 2011 03:32:23 +0100
Received: by yhpp34 with SMTP id p34so1944072yhp.36
        for <linux-mips@linux-mips.org>; Wed, 14 Dec 2011 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d3wQBKkIveWv+NO6YcKXBtWcUtiMX6yvbu5KMcuhctw=;
        b=YcN3uWts52edntR7cBfILNNYqhXOIrHSCh28jB6vKOMA49YXmaJLWDKumF7/1x8jAE
         ziblL+kXfBEuByVc9QVKx+bLdszwb5llYTDy0vZtt2nCIH814MoVbgTJ7RJqYGZtq9kK
         epyvJfqRO6ysh9aCms7D12IFGsso1NoL6lNeM=
Received: by 10.236.189.104 with SMTP id b68mr2236067yhn.21.1323916337753;
        Wed, 14 Dec 2011 18:32:17 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l11sm5828976anm.22.2011.12.14.18.32.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 18:32:17 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBF2WFRE008913;
        Wed, 14 Dec 2011 18:32:15 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBF2WFKk008912;
        Wed, 14 Dec 2011 18:32:15 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/4] irq/of/ARM: Make irq_domain hwirq type consistent throughout the kernel.
Date:   Wed, 14 Dec 2011 18:32:08 -0800
Message-Id: <1323916330-8865-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
References: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11959

From: David Daney <david.daney@cavium.com>

There is a mixture of unsigned long and unsigned int being used with
hwirq and hwirq_base.  Change it so we use unsigned int everywhere.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm/common/gic.c     |    2 +-
 include/linux/irqdomain.h |    6 +++---
 kernel/irq/irqdomain.c    |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b2dc2dd..171061f 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -625,7 +625,7 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 static int gic_irq_domain_dt_translate(struct irq_domain *d,
 				       struct device_node *controller,
 				       const u32 *intspec, unsigned int intsize,
-				       unsigned long *out_hwirq, unsigned int *out_type)
+				       unsigned int *out_hwirq, unsigned int *out_type)
 {
 	if (d->of_node != controller)
 		return -EINVAL;
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 0914a54..16ba5a9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,12 +31,12 @@ struct irq_domain;
  *                the hardware irq number and linux irq type value.
  */
 struct irq_domain_ops {
-	unsigned int (*to_irq)(struct irq_domain *d, unsigned long hwirq);
+	unsigned int (*to_irq)(struct irq_domain *d, unsigned int hwirq);
 
 #ifdef CONFIG_OF
 	int (*dt_translate)(struct irq_domain *d, struct device_node *node,
 			    const u32 *intspec, unsigned int intsize,
-			    unsigned long *out_hwirq, unsigned int *out_type);
+			    unsigned int *out_hwirq, unsigned int *out_type);
 #endif /* CONFIG_OF */
 };
 
@@ -72,7 +72,7 @@ struct irq_domain {
  * be overridden if the irq_domain implements a .to_irq() hook.
  */
 static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
-					     unsigned long hwirq)
+					     unsigned int hwirq)
 {
 	if (d->ops->to_irq)
 		return d->ops->to_irq(d, hwirq);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 200ce83..7bae422 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(irq_domain_mutex);
 void irq_domain_add(struct irq_domain *domain)
 {
 	struct irq_data *d;
-	int hwirq, irq;
+	unsigned int hwirq, irq;
 
 	/*
 	 * This assumes that the irq_domain owner has already allocated
@@ -54,7 +54,7 @@ void irq_domain_add(struct irq_domain *domain)
 void irq_domain_del(struct irq_domain *domain)
 {
 	struct irq_data *d;
-	int hwirq, irq;
+	unsigned int hwirq, irq;
 
 	mutex_lock(&irq_domain_mutex);
 	list_del(&domain->list);
@@ -82,7 +82,7 @@ unsigned int irq_create_of_mapping(struct device_node *controller,
 				   const u32 *intspec, unsigned int intsize)
 {
 	struct irq_domain *domain;
-	unsigned long hwirq;
+	unsigned int hwirq;
 	unsigned int irq, type;
 	int rc = -EINVAL;
 
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 int irq_domain_simple_dt_translate(struct irq_domain *d,
 			    struct device_node *controller,
 			    const u32 *intspec, unsigned int intsize,
-			    unsigned long *out_hwirq, unsigned int *out_type)
+			    unsigned int *out_hwirq, unsigned int *out_type)
 {
 	if (d->of_node != controller)
 		return -EINVAL;
-- 
1.7.2.3
