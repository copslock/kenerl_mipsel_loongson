Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:16:59 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:63751 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903752Ab1LSXQz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:16:55 +0100
Received: by ghrr15 with SMTP id r15so2072895ghr.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=g5vULzkec4WJRXdLD71bRmpzehY9uTHgubWeUgT9zKs=;
        b=A7YRHJU+hYCq5OWf57A8CHhaTWKP/u7K4e2w5KpF1Da82On8ABqNGKcawy0K2dPeh7
         z+usnkSDzJpjF45tpySObEyEcKbg2wvcG+t5YwZLo64xHmmDBw3bXpq5SfXmP4WkGTJh
         qf3JtKP1qF+NuWzaX++XtmsTOaO/lGrtd+lBw=
Received: by 10.236.91.84 with SMTP id g60mr32100329yhf.90.1324336609078;
        Mon, 19 Dec 2011 15:16:49 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id f47sm32547926yhh.8.2011.12.19.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:16:48 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBJNGk8e029861;
        Mon, 19 Dec 2011 15:16:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBJNGkaN029860;
        Mon, 19 Dec 2011 15:16:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 3/5] MIPS: Octeon: Use board_cache_error_setup for cache error handler setup.
Date:   Mon, 19 Dec 2011 15:16:40 -0800
Message-Id: <1324336602-29812-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
References: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15604

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/c-octeon.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index cf7895d..2d99a1d 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -22,6 +22,7 @@
 #include <asm/pgtable.h>
 #include <asm/r4kcache.h>
 #include <asm/system.h>
+#include <asm/traps.h>
 #include <asm/mmu_context.h>
 #include <asm/war.h>
 
@@ -249,6 +250,11 @@ static void __cpuinit probe_octeon(void)
 	}
 }
 
+static void  __cpuinit octeon_cache_error_setup(void)
+{
+	extern char except_vec2_octeon;
+	set_handler(0x100, &except_vec2_octeon, 0x80);
+}
 
 /**
  * Setup the Octeon cache flush routines
@@ -256,12 +262,6 @@ static void __cpuinit probe_octeon(void)
  */
 void __cpuinit octeon_cache_init(void)
 {
-	extern unsigned long ebase;
-	extern char except_vec2_octeon;
-
-	memcpy((void *)(ebase + 0x100), &except_vec2_octeon, 0x80);
-	octeon_flush_cache_sigtramp(ebase + 0x100);
-
 	probe_octeon();
 
 	shm_align_mask = PAGE_SIZE - 1;
@@ -281,6 +281,8 @@ void __cpuinit octeon_cache_init(void)
 
 	build_clear_page();
 	build_copy_page();
+
+	board_cache_error_setup = octeon_cache_error_setup;
 }
 
 /**
-- 
1.7.2.3
