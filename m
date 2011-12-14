Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2011 18:54:55 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:56671 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab1LNRyv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2011 18:54:51 +0100
Received: by yhpp34 with SMTP id p34so1606406yhp.36
        for <multiple recipients>; Wed, 14 Dec 2011 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=42+owGGElAzj3b6ROZsvinTvdrxeXzDn4gTYL8kzt7Q=;
        b=tB5Ak2c20eceAcV6KNmM+pp5uChbg3uDSyShiVVDrQk4pvgKDGOHplTDio5CwTE6b4
         jB0AgrXB2LWwPBs+YNXaXQ1jyaOSmoW7AfkqGstjDdVeHUd4mfGdbf2zy0Zm86U+XObJ
         6asitujVv38qpVjKJd2TU0UYBC8tuZF+iy6q0=
Received: by 10.236.197.97 with SMTP id s61mr13520535yhn.57.1323885285353;
        Wed, 14 Dec 2011 09:54:45 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id n24sm4760540yhj.13.2011.12.14.09.54.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 09:54:44 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBEHsguM026881;
        Wed, 14 Dec 2011 09:54:42 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBEHsejq026880;
        Wed, 14 Dec 2011 09:54:40 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2a] jump-label: initialize jump-label subsystem somewhat later
Date:   Wed, 14 Dec 2011 09:54:39 -0800
Message-Id: <1323885279-26850-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11560

From: David Daney <david.daney@cavium.com>

commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa
(jump-label: initialize jump-label subsystem much earlier) breaks MIPS.

The jump-label initialization does I-Cache flushing after modifying
code.  On MIPS this is done by calling through the function pointer
flush_icache_range().  This function pointer is initialized by
trap_init().

As things stand, we cannot be calling jump_label_init() until after
trap_init() completes, so we move the call down to satisfy this
constraint.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Sorry for spamming this out again, but Sergei keeps flagging my poor
grammar.

Difference from v2: Fix grammar and spelling issues in changelog.  No
                    change to the patch.

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
