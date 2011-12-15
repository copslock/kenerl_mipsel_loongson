Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2011 03:32:27 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:58183 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903745Ab1LOCcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Dec 2011 03:32:23 +0100
Received: by yenl2 with SMTP id l2so1214134yen.36
        for <linux-mips@linux-mips.org>; Wed, 14 Dec 2011 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aDO5HkfsBBEDOw/oeSYFDw5G49NMO4pKhT5EY+zzY3k=;
        b=JLJRtqKTsuorHrre5cmewD7fKHaoWhuhGN/q8oGWfLvhnPnouUzGv5IZA5yX8Z18bS
         hz8RkgpC+DozfUJ0+2Tgdt1gcyPA83Nx7As5muladzYuBCWcalqxaGhHosqBE77QEe91
         XGkdWLCP3tOJgK5WaznmCGMkIrNymrT8Bd51o=
Received: by 10.236.190.196 with SMTP id e44mr1636703yhn.95.1323916337404;
        Wed, 14 Dec 2011 18:32:17 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 1sm5845125anp.15.2011.12.14.18.32.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 18:32:17 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBF2WF1D008909;
        Wed, 14 Dec 2011 18:32:15 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBF2WFvK008908;
        Wed, 14 Dec 2011 18:32:15 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/4] irq: Get rid of irq_domain_for_each_hwirq().
Date:   Wed, 14 Dec 2011 18:32:07 -0800
Message-Id: <1323916330-8865-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
References: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11953

From: David Daney <david.daney@cavium.com>

It is not used anywhere in the kernel.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/linux/irqdomain.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 99834e58..0914a54 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -81,9 +81,6 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
 	return d->irq_base + hwirq - d->hwirq_base;
 }
 
-#define irq_domain_for_each_hwirq(d, hw) \
-	for (hw = d->hwirq_base; hw < d->hwirq_base + d->nr_irq; hw++)
-
 #define irq_domain_for_each_irq(d, hw, irq) \
 	for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
 	     hw < d->hwirq_base + d->nr_irq; \
-- 
1.7.2.3
