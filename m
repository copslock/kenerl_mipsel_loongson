Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:18:17 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:54528 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903756Ab1LSXQz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:16:55 +0100
Received: by yhpp34 with SMTP id p34so4480305yhp.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZrI+KC2Orbodh45amE49n7ycpbIYL/io/tp2Xz3A2V0=;
        b=AkatDZgDOYeNdwhOrN6ZY3lZ7g/C+YxeFwPtuZt+ppoBMnSi/tGjfzlidgzoENd1qJ
         WS8z7OqHYdqKx3cplUebdDcximXfaziGWd8eop6qBdoBPE3d4DG+CAYWwmELaV+mUUbI
         OkHcIKpn/XT4mtWC0iVq2ZB2+Dk4G1cpNBBJk=
Received: by 10.236.165.98 with SMTP id d62mr32224807yhl.15.1324336609471;
        Mon, 19 Dec 2011 15:16:49 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 3sm50945296anv.7.2011.12.19.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:16:48 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBJNGlWS029865;
        Mon, 19 Dec 2011 15:16:47 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBJNGlQT029864;
        Mon, 19 Dec 2011 15:16:47 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 4/5] MIPS: Use board_cache_error_setup for r4k cache error handler setup.
Date:   Mon, 19 Dec 2011 15:16:41 -0800
Message-Id: <1324336602-29812-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
References: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15608

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/c-r4k.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a79fe9a..036c004 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -33,7 +33,7 @@
 #include <asm/mmu_context.h>
 #include <asm/war.h>
 #include <asm/cacheflush.h> /* for run_uncached() */
-
+#include <asm/traps.h>
 
 /*
  * Special Variant of smp_call_function for use by cache functions:
@@ -1383,10 +1383,8 @@ static int __init setcoherentio(char *str)
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
@@ -1401,6 +1399,13 @@ void __cpuinit r4k_cache_init(void)
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
@@ -1463,4 +1468,5 @@ void __cpuinit r4k_cache_init(void)
 	local_r4k___flush_cache_all(NULL);
 #endif
 	coherency_setup();
+	board_cache_error_setup = r4k_cache_error_setup;
 }
-- 
1.7.2.3
