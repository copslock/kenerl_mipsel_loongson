Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2012 21:31:48 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:58627 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903594Ab2CZTbe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2012 21:31:34 +0200
Received: by ggnk1 with SMTP id k1so4698984ggn.36
        for <multiple recipients>; Mon, 26 Mar 2012 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wAGQX8lcMO9izpgUahDOm4Axwj1rxFTJWe9QkEmdyNE=;
        b=i/KSDTyzh4k33A1286inNTphgIkO37XmKHvdw/l1NBZDlwzxcIMpc0SbZGQ2iOnarY
         973S8WK+os09GeRrOIjnwGnEqwSin5x/W3e0HaiEgDkZEPW5WwEIFAi5nO6m1NvqrquO
         vjQ5479d5Ija1z7OffxdnRI3PHq/MmniHjtTCH1+NAhVXa5gu0vugZokj2KH41U0wpyk
         6AR7IFWsJdFlufcw21pl0oJDhpgH+war9pMWRaJhPWq7rxlqBMed/PI3Sxx/E7Pm25ou
         e/9zjyV6gd8ytsYBx7w5kfU0a6znsbidq1eYXZFQW1yijdYm28Iqkl/J2A7gR2VX3Zbi
         wfFw==
Received: by 10.182.12.37 with SMTP id v5mr29587534obb.16.1332790288328;
        Mon, 26 Mar 2012 12:31:28 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id s2sm13408678oea.2.2012.03.26.12.31.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 12:31:27 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2QJVP9G009696;
        Mon, 26 Mar 2012 12:31:25 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2QJVPkP009695;
        Mon, 26 Mar 2012 12:31:25 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v7 1/4] MIPS: Don't define early_init_devtree() and device_tree_init() in prom.c for CPU_CAVIUM_OCTEON
Date:   Mon, 26 Mar 2012 12:31:18 -0700
Message-Id: <1332790281-9648-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com>
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
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
index 558b539..4aaa5c0 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -60,6 +60,7 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 }
 #endif
 
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 void __init early_init_devtree(void *params)
 {
 	/* Setup flat device-tree pointer */
@@ -95,3 +96,4 @@ void __init device_tree_init(void)
 	/* free the space reserved for the dt blob */
 	free_mem_mach(base, size);
 }
+#endif /* !CONFIG_CPU_CAVIUM_OCTEON */
-- 
1.7.2.3
