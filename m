Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 02:06:39 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57980 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2EOAFD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 02:05:03 +0200
Received: by pbbrq13 with SMTP id rq13so7650932pbb.36
        for <multiple recipients>; Mon, 14 May 2012 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yQRzfAtsL+nOZj2k3RrxeM8MN3oiRWqCAwE+0OxHxM8=;
        b=I8S1kv/XOLiDoKNfzm1orlSsnNsjzXBxD5/Dp1eqgNpxS2Q9MGosZQizjGCwOYiivf
         iOVBm6c3Y/sOZgM3OMh0dBobF+br9g0lIUFt5Qk1lhaH/cvYePU2+sYyFMRTo+FEeiqU
         SzmrO6THATS3O1WbC1e/oGb/Jv3NcHS2IlUgYV1zaPpdqBh+M4GVKZxmFi4Y8l6QUinC
         M7sNN6obVtPPT0FUBI/XQGRjBIgBD1qJLZilwWGUzrPjhalse1dOOsS+6VO543XdGtdB
         WduR+I+UBUTfi/sd+7UlgwFHK7YveNpOWwDww4OTvbBjKIdDqSxeQCOm4yiSBXzJQhsF
         pUWA==
Received: by 10.68.226.99 with SMTP id rr3mr27297390pbc.48.1337040296918;
        Mon, 14 May 2012 17:04:56 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i1sm23678685pbv.49.2012.05.14.17.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:04:55 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4F04q61016069;
        Mon, 14 May 2012 17:04:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4F04qIt016068;
        Mon, 14 May 2012 17:04:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/5] MIPS: Use board_cache_error_setup for r4k cache error handler setup.
Date:   Mon, 14 May 2012 17:04:49 -0700
Message-Id: <1337040290-16015-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/c-r4k.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index bda8eb2..5109be9 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -32,7 +32,7 @@
 #include <asm/mmu_context.h>
 #include <asm/war.h>
 #include <asm/cacheflush.h> /* for run_uncached() */
-
+#include <asm/traps.h>
 
 /*
  * Special Variant of smp_call_function for use by cache functions:
@@ -1385,10 +1385,8 @@ static int __init setcoherentio(char *str)
 __setup("coherentio", setcoherentio);
 #endif
 
-void __cpuinit r4k_cache_init(void)
+static void __cpuinit r4k_cache_error_setup(void)
 {
-	extern void build_clear_page(void);
-	extern void build_copy_page(void);
 	extern char __weak except_vec2_generic;
 	extern char __weak except_vec2_sb1;
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -1403,6 +1401,13 @@ void __cpuinit r4k_cache_init(void)
 		set_uncached_handler(0x100, &except_vec2_generic, 0x80);
 		break;
 	}
+}
+
+void __cpuinit r4k_cache_init(void)
+{
+	extern void build_clear_page(void);
+	extern void build_copy_page(void);
+	struct cpuinfo_mips *c = &current_cpu_data;
 
 	probe_pcache();
 	setup_scache();
@@ -1465,4 +1470,5 @@ void __cpuinit r4k_cache_init(void)
 	local_r4k___flush_cache_all(NULL);
 #endif
 	coherency_setup();
+	board_cache_error_setup = r4k_cache_error_setup;
 }
-- 
1.7.2.3
