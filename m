Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2011 18:25:47 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:52037 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903621Ab1LNRZn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2011 18:25:43 +0100
Received: by ghbf20 with SMTP id f20so912752ghb.36
        for <multiple recipients>; Wed, 14 Dec 2011 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/69LPH+Z0WgRLp6qnp482QqBv7UEhotNEOHUwcGq5K0=;
        b=eWN8KBBZ0al+uVzHLx2+AvnHUzEVNYfdUvG9Z1fPcvmMjbTwA40PGIvKQ14ht+MXF4
         2/kapnYGnedg2ltg88mCIePv6m/4lkr4EMvkkbnUWT5BybkcNFM01ydigGRzByosjBYr
         mH91fGuA9HgB58qjICzl0yXYCSKWN/5qwYVsc=
Received: by 10.236.181.164 with SMTP id l24mr13757848yhm.22.1323883536887;
        Wed, 14 Dec 2011 09:25:36 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id o7sm4657990yhl.15.2011.12.14.09.25.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 09:25:36 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBEHPYgi026405;
        Wed, 14 Dec 2011 09:25:34 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBEHPXJf026404;
        Wed, 14 Dec 2011 09:25:33 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2] jump-label: initialize jump-label subsystem somewhat later
Date:   Wed, 14 Dec 2011 09:25:32 -0800
Message-Id: <1323883532-26374-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11528

From: David Daney <david.daney@cavium.com>

commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa breaks MIPS.

The jump-lable initialization does I-Cache flushing after modifying
code.  On MIPS this is done by calling through the function pointer
flush_icache_range().  This function pointer is initialized trap_init().

As things stand, we cannot be calling jump_label_init() until after
trap_init() completes, so we move the call down to satisfy this
constraint.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Difference from v1: Move jump_label_init() up one so it is now before
                    mm_init() instead of after it.

 init/main.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 217ed23..68ab12b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -513,8 +513,6 @@ asmlinkage void __init start_kernel(void)
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 
-	jump_label_init();
-
 	/*
 	 * These use large bootmem allocations and must precede
 	 * kmem_cache_init()
@@ -524,6 +522,7 @@ asmlinkage void __init start_kernel(void)
 	vfs_caches_init_early();
 	sort_main_extable();
 	trap_init();
+	jump_label_init();
 	mm_init();
 
 	/*
-- 
1.7.2.3
