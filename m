Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 00:57:57 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:33648 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903728Ab2FFW5y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 00:57:54 +0200
Received: by dadm1 with SMTP id m1so10178442dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OwcD34EqlI+208AmXHacsBRSi6Vy5vNGWUdbevOo95k=;
        b=qRtlnR3q1E6qMIb4cJ4ZlMlQFyIMZu3V5EsLj185IkB6u7K2t9wAgkS2lCveJyu4qq
         Ij4oNRU3VcHafFjhYBkmSnHdJlKg8B3nASqC1IdX0mHKTUfdUYauujE1JhDYL64Gcu3+
         ewbojopmpm4VNNKj90SXiXmmZrgB2VMEyPYrUFu96Qf9oyPVxFhdXecCLcLkeLg3RhlG
         s4EZwgtWuoE3BoXaTL4piJBnITsG9xnbzZ5KGbwBVEiZUJVwU6imv6MYjGwk7+HTxdbI
         5DKb2z802snEjFzFIsIFEqA3m8t4wox5S2oPNJc0oMGWoa4Pj9fUC+HBDKPFj+OcX6tX
         6nGA==
Received: by 10.68.217.40 with SMTP id ov8mr1051928pbc.131.1339023467190;
        Wed, 06 Jun 2012 15:57:47 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id to1sm1822044pbc.27.2012.06.06.15.57.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 15:57:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56Mviqm020307;
        Wed, 6 Jun 2012 15:57:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56MviMf020306;
        Wed, 6 Jun 2012 15:57:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v8 1/4] MIPS: Don't define early_init_devtree() and device_tree_init() in prom.c for CPU_CAVIUM_OCTEON
Date:   Wed,  6 Jun 2012 15:57:40 -0700
Message-Id: <1339023463-20267-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339023463-20267-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339023463-20267-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This code is not common enough to be in a shared file, so OCTEON defines
it's own versions.

When the last of this target specific code is moved out, we can remove
all of this.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/prom.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index f11b2bb..fcb325e 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -60,6 +60,7 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 }
 #endif
 
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 void __init early_init_devtree(void *params)
 {
 	/* Setup flat device-tree pointer */
@@ -108,3 +109,4 @@ void __init __dt_setup_arch(struct boot_param_header *bph)
 
 	early_init_devtree(initial_boot_params);
 }
+#endif /* !CONFIG_CPU_CAVIUM_OCTEON */
-- 
1.7.2.3
