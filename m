Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:04:47 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46148 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903689Ab2EUGCd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:02:33 +0200
Received: by wibhm14 with SMTP id hm14so1745642wib.6
        for <multiple recipients>; Sun, 20 May 2012 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rnP60ACmOHZurI1fWzau4AdEGXYXilIpY1AfUPZOYUI=;
        b=hWoe1mXDsnPG8lSSGgQfUd8581KvapvtGvvNQDxiI9db1OE+Rf+xWolSV83/YRiRXN
         jz1/iZjxAy3DvIOqleuFlO02wrOFzf0+I6hrjdkE0ZWI7e/gkO1RdBkYZAvmglWsuXA1
         5XucvavocBy7v6LdmkTpYFQLsHnAJxPdn8D8xEsj3zCqog/lGeb1nz91SdYh9LVq5C2T
         i6ZEjrGWd2/e9hoUhM/1rdydKwVopSA1Qi2FVzjK+ZpI+8lfb+cD0dagqS2fVyyJRpQA
         +o08Dno293kstlnWDuXBVxEwCrmg70OL9kILiH0aYx4Il/9hCIWAabllUnS6BXevB/Bp
         zO0Q==
Received: by 10.216.131.24 with SMTP id l24mr12521111wei.76.1337580147760;
        Sun, 20 May 2012 23:02:27 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id e20sm18887091wiv.7.2012.05.20.23.02.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:02:27 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 8/8] MIPS: sync-r4k: remove redundant irq operation
Date:   Mon, 21 May 2012 14:00:08 +0800
Message-Id: <1337580008-7280-9-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

Since we have delayed irq enabling to ->smp_finish()

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/sync-r4k.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 99f913c..842d55e 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -111,7 +111,6 @@ void __cpuinit synchronise_count_master(void)
 void __cpuinit synchronise_count_slave(void)
 {
 	int i;
-	unsigned long flags;
 	unsigned int initcount;
 	int ncpus;
 
@@ -123,8 +122,6 @@ void __cpuinit synchronise_count_slave(void)
 	return;
 #endif
 
-	local_irq_save(flags);
-
 	/*
 	 * Not every cpu is online at the time this gets called,
 	 * so we first wait for the master to say everyone is ready
@@ -154,7 +151,5 @@ void __cpuinit synchronise_count_slave(void)
 	}
 	/* Arrange for an interrupt in a short while */
 	write_c0_compare(read_c0_count() + COUNTON);
-
-	local_irq_restore(flags);
 }
 #undef NR_LOOPS
-- 
1.7.5.4
