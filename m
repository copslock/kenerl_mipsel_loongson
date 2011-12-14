Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2011 17:48:58 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:49372 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903621Ab1LNQsv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2011 17:48:51 +0100
Received: by yenl2 with SMTP id l2so813343yen.36
        for <multiple recipients>; Wed, 14 Dec 2011 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=U9W5De5Ejz3VW65pyaCI1ryZWtRW44eMJHCsJdSmkoo=;
        b=kZU0beCZmTbbAtbXGFREVbVWcR+kgyWkRlila/qyeLlJ+ycFiTWcDIhvxsH7Eh1Ui2
         Nt6xGUkZ195bMLZ+htslb3JN+8/+CuM88gymzDFH7f2HyYO17ajrqnnB/WFgqRDvdqpy
         8yCKeKzSdSTEVt1+w0VRQHN5YwnUNRaK0n65Q=
Received: by 10.236.155.36 with SMTP id i24mr13280161yhk.43.1323881325256;
        Wed, 14 Dec 2011 08:48:45 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id w68sm4529410yhe.14.2011.12.14.08.48.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:48:42 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBEGmewc023277;
        Wed, 14 Dec 2011 08:48:40 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBEGmbKI023275;
        Wed, 14 Dec 2011 08:48:37 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] jump-label: initialize jump-label subsystem somewhat later
Date:   Wed, 14 Dec 2011 08:48:35 -0800
Message-Id: <1323881315-23245-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11487

From: David Daney <david.daney@cavium.com>

commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa breaks MIPS.

The jump-lable initialization does I-Cache flushing after modifying
code.  On MIPS this is done by calling through the function pointer
flush_icache_range().  This function pointer is initialized mm_init().

As things stand, we cannot be calling jump_label_init() until after
mm_init() completes, so we move the call down to satisfy this
constraint.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 init/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 217ed23..8c6a155 100644
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
@@ -526,6 +524,8 @@ asmlinkage void __init start_kernel(void)
 	trap_init();
 	mm_init();
 
+	jump_label_init();
+
 	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
 	 * timer interrupt). Full topology setup happens at smp_init()
-- 
1.7.2.3
