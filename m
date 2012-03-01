Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2012 01:57:47 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:32809 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903793Ab2CAA5Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2012 01:57:16 +0100
Received: by yenm10 with SMTP id m10so15172yen.36
        for <multiple recipients>; Wed, 29 Feb 2012 16:57:10 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.100.212.4 as permitted sender) client-ip=10.100.212.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.100.212.4 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.100.212.4])
        by 10.100.212.4 with SMTP id k4mr1243418ang.35.1330563430517 (num_hops = 1);
        Wed, 29 Feb 2012 16:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wAGQX8lcMO9izpgUahDOm4Axwj1rxFTJWe9QkEmdyNE=;
        b=ad/67eeit0xyZD5m78t/mbx6pAjVC0iBK4Tw5DE1gakM4J0FM7i7+3EVB1zRRq2g/E
         rmS6TDBIAxYpxE+2AgQA1CKnDeqJsEg998rQeMW0jtUdVCCfAC+dS6BK/nFZzjou4FkO
         GwYPW76IjXgTmL4P+EL/q8uBRf8CVWfzwMgnU=
Received: by 10.100.212.4 with SMTP id k4mr976793ang.35.1330563430465;
        Wed, 29 Feb 2012 16:57:10 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id j22sm354117ann.0.2012.02.29.16.57.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 16:57:09 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q210v8w3014123;
        Wed, 29 Feb 2012 16:57:08 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q210v8ol014122;
        Wed, 29 Feb 2012 16:57:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 2/5] MIPS: Don't define early_init_devtree() and device_tree_init() in prom.c for CPU_CAVIUM_OCTEON
Date:   Wed, 29 Feb 2012 16:56:59 -0800
Message-Id: <1330563422-14078-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com>
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32586
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
