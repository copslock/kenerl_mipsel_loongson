Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2012 01:25:57 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45460 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903684Ab2EYXZv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 May 2012 01:25:51 +0200
Received: by pbbrq13 with SMTP id rq13so2581112pbb.36
        for <multiple recipients>; Fri, 25 May 2012 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bfRw+VCUOGZn63H/yRpNNSjTCq1YcMenYxu+esjABnk=;
        b=ZQBizxnZgsFDa2XkbydMBMSov7cSS6le/WR60Vl8ItXNYsxH7uQuz5E+nj/7Dd/C9I
         OYZuSQjONpf9CEibMjb4VjR6okaNbMxei0JZViD6ModqPZovns9RU7+oPmLWPwIa4lSC
         QxEVM2BupVOzM1pW077xPGxCLUmQiSAoPHV65BxlD9MsCf2Sl+kK8F5T8fDA0YUKqfFV
         I/cnGya8wyicCJxUD3B8E6nm5wHl3++MdDdwSUsDC2/s56QNBtpoIsSQ753KuX2tDuwK
         WXMBt6vQxlM7ZqHscmAxmmYNzehFIVy+rttDx9wpiij4S/O52+rUmuFEPleYBnXN7OrG
         fCPw==
Received: by 10.68.131.35 with SMTP id oj3mr1750579pbb.156.1337988344093;
        Fri, 25 May 2012 16:25:44 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id rv8sm10498072pbc.64.2012.05.25.16.25.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 16:25:43 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4PNPfXm007725;
        Fri, 25 May 2012 16:25:41 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4PNPev7007724;
        Fri, 25 May 2012 16:25:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Properly align the .data..init_task section.
Date:   Fri, 25 May 2012 16:25:34 -0700
Message-Id: <1337988334-7693-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Improper alignment can lead to unbootable systems and/or random
crashes.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: <stable@vger.kernel.org>
---
 arch/mips/include/asm/thread_info.h |    4 ++--
 arch/mips/kernel/vmlinux.lds.S      |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index e2eca7d..ca97e0e 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -60,6 +60,8 @@ struct thread_info {
 register struct thread_info *__current_thread_info __asm__("$28");
 #define current_thread_info()  __current_thread_info
 
+#endif /* !__ASSEMBLY__ */
+
 /* thread information allocation */
 #if defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_32BIT)
 #define THREAD_SIZE_ORDER (1)
@@ -85,8 +87,6 @@ register struct thread_info *__current_thread_info __asm__("$28");
 
 #define STACK_WARN	(THREAD_SIZE / 8)
 
-#endif /* !__ASSEMBLY__ */
-
 #define PREEMPT_ACTIVE		0x10000000
 
 /*
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 924da5e..df243a6 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -1,5 +1,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
+#include <asm/thread_info.h>
 #include <asm-generic/vmlinux.lds.h>
 
 #undef mips
@@ -72,7 +73,7 @@ SECTIONS
 	.data : {	/* Data */
 		. = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
 
-		INIT_TASK_DATA(PAGE_SIZE)
+		INIT_TASK_DATA(THREAD_SIZE)
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 		READ_MOSTLY_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
-- 
1.7.2.3
