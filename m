Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 02:48:30 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:40047 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903615Ab2D0AsN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 02:48:13 +0200
Received: by dakb39 with SMTP id b39so222807dak.35
        for <multiple recipients>; Thu, 26 Apr 2012 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wAGQX8lcMO9izpgUahDOm4Axwj1rxFTJWe9QkEmdyNE=;
        b=wguA5x+qMezNvPaAP/4zprjQzXxw1Bq2SYl2vDm4WRtPV+0JWTtTxWbtAN7tj8d5c5
         Z+OFVrqQG3OjBYuKqkhK6cUM35Zn/NJH4IrMqntduFmtIPAQs6xZEIkGQvZiUu/Avg8n
         bBHOTFzPAG5hTyEphr+DTvNt+cfxdOaP4+XZzmBF+7uDAn9P7VnGCcQmYwSyQhwZ3m6K
         ztSW2fX6TINMHKdY9yXAF9rcZuUsdpf2iC2irYCHYj5hDkutHahziDYZ168K6G++/loR
         Bh8bhSn1x5dDhQ7hS/AcrsE2uW2Lbs5bdv3gzNyyS4fw9WgBUjjy0jkaUhWus8ZwWYEL
         zVGw==
Received: by 10.68.239.37 with SMTP id vp5mr2907798pbc.137.1335487686478;
        Thu, 26 Apr 2012 17:48:06 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id gl7sm1816461pbc.10.2012.04.26.17.48.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 17:48:04 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3R0m3xu026263;
        Thu, 26 Apr 2012 17:48:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3R0m35r026262;
        Thu, 26 Apr 2012 17:48:03 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v8 1/4] MIPS: Don't define early_init_devtree() and device_tree_init() in prom.c for CPU_CAVIUM_OCTEON
Date:   Thu, 26 Apr 2012 17:47:55 -0700
Message-Id: <1335487678-26223-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335487678-26223-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335487678-26223-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33014
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
