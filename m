Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 18:54:25 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:34000 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903717Ab2DAQyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Apr 2012 18:54:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 0A95721B020;
        Sun,  1 Apr 2012 19:54:18 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id Qa4hSwoNHeZV; Sun,  1 Apr 2012 19:54:17 +0300 (EEST)
Received: from dell.pp.htv.fi (cs78193253.pp.htv.fi [62.78.193.253])
        by smtp5.welho.com (Postfix) with ESMTP id 910755BC002;
        Sun,  1 Apr 2012 19:54:17 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: [PATCH] mips: cmpxchg: add missing include
Date:   Sun,  1 Apr 2012 19:54:13 +0300
Message-Id: <1333299253-3308-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Fix the following build breakage in v3.4-rc1:

  CC      kernel/irq_work.o
In file included from include/linux/irq_work.h:4:0,
                 from kernel/irq_work.c:10:
include/linux/llist.h: In function 'llist_del_all':
include/linux/llist.h:178:2: error: implicit declaration of function 'BUILD_BUG_ON' [-Werror=implicit-function-declaration]

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/cmpxchg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 285a41f..eee10dc 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_CMPXCHG_H
 #define __ASM_CMPXCHG_H
 
+#include <linux/bug.h>
 #include <linux/irqflags.h>
 #include <asm/war.h>
 
-- 
1.7.2.5
