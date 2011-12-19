Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2011 00:18:42 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:39865 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903757Ab1LSXQ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Dec 2011 00:16:56 +0100
Received: by yenl2 with SMTP id l2so3851983yen.36
        for <multiple recipients>; Mon, 19 Dec 2011 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AG6v+/bMhNzRCvyg5yrr8Q8pCDyi1zXuAAfIvONETMw=;
        b=Leoxg5Q1ggjs2QSyG3ro9eYzKLbprB0QYm2N4RGQBdZlbFN7oScYNe7zJ+Lx4nhGpm
         ofFozfNvnRJ2Icwqn9OUxJgOASCXjKIqlk6Z1IeYUBUjY7e/nZlbuaa+7U93sD3dZlI4
         dr2p+o157Sn1AItRriODIxAaeWtFUtXY0bZ5Q=
Received: by 10.236.155.194 with SMTP id j42mr31967789yhk.34.1324336609848;
        Mon, 19 Dec 2011 15:16:49 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id q16sm50921411anb.19.2011.12.19.15.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 15:16:48 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBJNGkIh029857;
        Mon, 19 Dec 2011 15:16:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBJNGkb6029856;
        Mon, 19 Dec 2011 15:16:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/5] MIPS: Make set_handler() __cpuinit.
Date:   Mon, 19 Dec 2011 15:16:39 -0800
Message-Id: <1324336602-29812-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
References: <1324336602-29812-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15609

From: David Daney <david.daney@cavium.com>

Follow-on patched require this.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f305c04..0430700 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1623,7 +1623,7 @@ void __cpuinit per_cpu_trap_init(void)
 }
 
 /* Install CPU exception handler */
-void __init set_handler(unsigned long offset, void *addr, unsigned long size)
+void __cpuinit set_handler(unsigned long offset, void *addr, unsigned long size)
 {
 	memcpy((void *)(ebase + offset), addr, size);
 	local_flush_icache_range(ebase + offset, ebase + offset + size);
-- 
1.7.2.3
