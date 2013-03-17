Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 13:50:41 +0100 (CET)
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58235 "EHLO
        mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820116Ab3CQMuh0vCsy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Mar 2013 13:50:37 +0100
Received: by mail-pb0-f42.google.com with SMTP id xb4so5681326pbc.1
        for <multiple recipients>; Sun, 17 Mar 2013 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=3QMQEsWa2R036gGik8dH4ba7G/3NZjjSQ9FR4k2hK6w=;
        b=Wc0RGFFgMG6yoqLGWtTlDJ2eWg+lvtZwEunRRWu6xCCu1NtzBc/Zb1nFayczw6qhBb
         069Ee2uth/MmtO4KKjVvO2iN82Z2/RO4/ZChLOrxoXS5HatY3Bw+Rp57e0bU/DemyacV
         9gtHwiFDTEbrhkdz9hbEEj3hukmHRMtOsbTJOxnriGIN32naX8KWh3ydVude0JUx/1C/
         qqNWH0FyZm/KB1uTuRQ4q66mO1hFIDyUkNXSjYbYTI1baS35s/XItD6kcy+EWaGo3hld
         +/WfvbwAWiArzDFynSymF5Mq2LPkInn2LGJsNmmWpprj3fdqYEM8bh2WrIq88Zqoyyky
         9/Pg==
X-Received: by 10.68.116.169 with SMTP id jx9mr27600511pbb.94.1363524630913;
        Sun, 17 Mar 2013 05:50:30 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id m18sm4365093pad.17.2013.03.17.05.50.26
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 05:50:29 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 02/02] MIPS: Init new mmu_context for each possible CPU to avoid memory corruption
Date:   Sun, 17 Mar 2013 20:50:14 +0800
Message-Id: <1363524614-3823-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 35900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Currently, init_new_context() only for each online CPU, this may cause
memory corruption when CPU hotplug and fork() happens at the same time.
To avoid this, we make init_new_context() cover each possible CPU.

Scenario:
1, CPU#1 is being offline;
2, On CPU#0, do_fork() call dup_mm() and copy a mm_struct to the child;
3, On CPU#0, dup_mm() call init_new_context(), since CPU#1 is offline
   and init_new_context() only covers the online CPUs, child has the
   same asid as its parent on CPU#1 (however, child's asid should be 0);
4, CPU#1 is being online;
5, Now, if both parent and child run on CPU#1, memory corruption (e.g.
   segfault, bus error, etc.) will occur.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mmu_context.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index e81d719..49d220c 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -133,7 +133,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int i;
 
-	for_each_online_cpu(i)
+	for_each_possible_cpu(i)
 		cpu_context(i, mm) = 0;
 
 	return 0;
-- 
1.7.7.3
