Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 02:05:05 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54509 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903663Ab2EOAFB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 02:05:01 +0200
Received: by pbbrq13 with SMTP id rq13so7650899pbb.36
        for <multiple recipients>; Mon, 14 May 2012 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F4mERDNt9Z70z4IifqRA3YK9p9G0lSV6S+LMbsgkXB8=;
        b=HeFhQyoh82xmCoMUAk+gt5AEjcxiKBukmMowDaZ4UCr5asnyB9dmoKZXhlVBO+Xc3N
         i9P6TBxNZNcf/62grl8bzc8qxA84t0One2GBkwD1+Q0VaI/DE5Had/hpU4aY58OJqbTg
         cnP6wEEsw0a71Ew4OajRigcHEh+ZWGB6PlkmGDxIIYwYqNkthfUitGh6Nt2Tz946Mbcs
         Hq4Tw9yr58fWvXa6nKbc1YUsMEF+oJkWV3L8BHi5Vb8cQte4z2s0EoKdRU608yTuxjfW
         WJJ43LQXUhBx1vYnwcAxD5gCFJ8W/iZa0SmGu7jH4ONoBaynsLVfO5URR1W8cd9mzK2P
         asjg==
Received: by 10.68.233.102 with SMTP id tv6mr27321934pbc.153.1337040294861;
        Mon, 14 May 2012 17:04:54 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id nh5sm4363962pbc.17.2012.05.14.17.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:04:53 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4F04qcE016061;
        Mon, 14 May 2012 17:04:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4F04q7g016060;
        Mon, 14 May 2012 17:04:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/5] MIPS: Make set_handler() __cpuinit.
Date:   Mon, 14 May 2012 17:04:47 -0700
Message-Id: <1337040290-16015-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Follow-on patched require this.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b931eba..2b5675b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1680,7 +1680,7 @@ void __cpuinit per_cpu_trap_init(void)
 }
 
 /* Install CPU exception handler */
-void __init set_handler(unsigned long offset, void *addr, unsigned long size)
+void __cpuinit set_handler(unsigned long offset, void *addr, unsigned long size)
 {
 	memcpy((void *)(ebase + offset), addr, size);
 	local_flush_icache_range(ebase + offset, ebase + offset + size);
-- 
1.7.2.3
