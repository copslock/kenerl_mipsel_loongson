Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 01:52:48 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:63462 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904025Ab2DEXwe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 01:52:34 +0200
Received: by obhx4 with SMTP id x4so2945967obh.36
        for <linux-mips@linux-mips.org>; Thu, 05 Apr 2012 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=iB3Qf0Qpr6bF1lspJ0HSloMGWoAYbAf1n2stKU+KFA0=;
        b=uLWo90+ehcrwEOX241RwMIYZSHwCbbIYB3hqA+gIDzINv1Jjv5WA6d4emhoNLvul+h
         sBZUBdwGu8aGjcXTs1DOT+UrD7UIbjbgTIVQs6+UZtLyrl9Ile1yqSiLkQ+JOJ5CGT3t
         Kks6eMcFb4umyLl7uqt/8c72oO+1XQKTUFBHhC3KLx3BuX6Rr8Mgahlfug6pTi4CaC4W
         hcirxb5V5iLi8Niz/XTYAN9upbUE+PAB27Rrk2ItM6OhnL43KQys79BSod7eOu6U3hOm
         WomTwHCy4F3WnbljSFzQLY6VogkvxNM0eD45NF/p2XqV5rZ6gJEzwidMULlgi+ZzsvN/
         pZ+w==
Received: by 10.60.22.70 with SMTP id b6mr6698956oef.5.1333669947669;
        Thu, 05 Apr 2012 16:52:27 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id xb7sm5666960obb.10.2012.04.05.16.52.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 16:52:26 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q35NqLLR025300;
        Thu, 5 Apr 2012 16:52:21 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q35NqFcF025298;
        Thu, 5 Apr 2012 16:52:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().
Date:   Thu,  5 Apr 2012 16:52:13 -0700
Message-Id: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

In commit 4bbdd45a (irq_domain/powerpc: eliminate irq_map; use
irq_alloc_desc() instead) code was added that ignores error returns
from irq_alloc_desc_from() by (silently) casting the return value to
unsigned.  The negitive value error return now suddenly looks like a
valid irq number.

Commits cc79ca69 (irq_domain: Move irq_domain code from powerpc to
kernel/irq) and 1bc04f2c (irq_domain: Add support for base irq and
hwirq in legacy mappings) move this code to its current location in
irqdomain.c

The result of all of this is a null pointer dereference OOPS if one of
the error cases is hit.

The fix: Don't cast away the negativeness of the return value and then
check for errors.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kernel/irq/irqdomain.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index af48e59..9d3e3ae 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -351,6 +351,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 				irq_hw_number_t hwirq)
 {
 	unsigned int virq, hint;
+	int irq;
 
 	pr_debug("irq: irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
 
@@ -380,14 +381,14 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	hint = hwirq % irq_virq_count;
 	if (hint == 0)
 		hint++;
-	virq = irq_alloc_desc_from(hint, 0);
-	if (!virq)
-		virq = irq_alloc_desc_from(1, 0);
-	if (!virq) {
+	irq = irq_alloc_desc_from(hint, 0);
+	if (irq <= 0)
+		irq = irq_alloc_desc_from(1, 0);
+	if (irq <= 0) {
 		pr_debug("irq: -> virq allocation failed\n");
 		return 0;
 	}
-
+	virq = irq;
 	if (irq_setup_virq(domain, virq, hwirq)) {
 		if (domain->revmap_type != IRQ_DOMAIN_MAP_LEGACY)
 			irq_free_desc(virq);
-- 
1.7.2.3
