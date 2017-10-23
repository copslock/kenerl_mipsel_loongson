Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2017 19:21:55 +0200 (CEST)
Received: from frisell.zx2c4.com ([192.95.5.64]:45483 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990504AbdJWRVpF9j9M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Oct 2017 19:21:45 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fea499d6;
        Mon, 23 Oct 2017 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=0fZUxAWunmi8tMqa0f9CRLdip
        AI=; b=BJLW9CXI4sTTKqjdM0DL44lhUdFP6WUpdwzqJSuW1RPeKjXR1L5d0SXUR
        kAUvIaz8DAxiPP7rGox1DQHRCw5TyXEa1LCuuwsrBzKny9HJKuG3TRRsT0eeJDLn
        LXR7anyZDebG1PmzAUfN8Za59c2URwnXR742+vVe6pS3nFILpjisX53UhXCAh97V
        O4yfAn8sL/W9yIpU/vJnN22lBX8GueTvA2Lpt54UL+9h2JM8Kn2pDSNALq1OO1W8
        96+kucWg+Mq8RVbK4fjG6+l3W9KQ/Y39LcUvVp2Qt/DbZsDbmvBvpo7JmmPoelc2
        squFuyJztF+S67t5BQWMgv7NryHVw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5373e618 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 23 Oct 2017 17:19:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org
Subject: [PATCH] mips/smp-cmp: use right include for task_struct
Date:   Mon, 23 Oct 2017 19:20:56 +0200
Message-Id: <20171023172056.12265-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

When task_struct was moved, this MIPS code was neglected. Evidently
nobody is using it anymore. This fixes this build error:

In file included from ./arch/mips/include/asm/thread_info.h:15:0,
                 from ./include/linux/thread_info.h:37,
                 from ./include/asm-generic/current.h:4,
                 from ./arch/mips/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:11,
                 from arch/mips/kernel/smp-cmp.c:22:
arch/mips/kernel/smp-cmp.c: In function ‘cmp_boot_secondary’:
./arch/mips/include/asm/processor.h:384:41: error: implicit declaration
of function ‘task_stack_page’ [-Werror=implicit-function-declaration]
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
                                         ^
arch/mips/kernel/smp-cmp.c:84:21: note: in expansion of macro ‘__KSTK_TOS’
  unsigned long sp = __KSTK_TOS(idle);
                     ^~~~~~~~~~

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/smp-cmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 05295a4909f1..415e4d19f897 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -19,7 +19,7 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
-- 
2.14.2
