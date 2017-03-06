Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 20:14:13 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:59255 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbdCFTOG6B4ZH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 20:14:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eJyycpMTJxoezPK6es+qKQ3dJUt6l3bukPdkEJxI2Po=; b=T0RpQIoTtLDuW+uVALoBaC0wj6
        AziGJdMk53J/cHeSypmmftRgix5C2R1u95RHowuXjfs7Y71A7TCHn7stv29upfPA7QtBjfAcqtY1d
        k+CU4OCkpYDcntiCH88gVBvB2q6Tf5qz//itAWGirt5QzuhFRLrnGFTVjNkOhoKLGcRNHgbYdIQSn
        fgrDp2I8uru8QJabhtcpqBALa5pmMe0tBboMtgKzti6RS+054TvAXpQClb2HfQXzukMNsc7KMJ83z
        44DjaSSLAuHpeiRUMTyV30+5a5RQYoaOcjgIsWo6sZ/PRW8OfGiyrlAXmvKXVLzz/p85wy4uBmGjT
        CbVuh7Yw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55702 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <linux@roeck-us.net>)
        id 1cky50-000skj-Ne; Mon, 06 Mar 2017 19:14:01 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3] MIPS: Fix build breakage caused by header file changes
Date:   Mon,  6 Mar 2017 11:13:55 -0800
Message-Id: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Since commit f3ac60671954 ("sched/headers: Move task-stack related
APIs from <linux/sched.h> to <linux/sched/task_stack.h>") and commit
f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
<linux/sched.h>"), various mips builds fail as follows.

arch/mips/kernel/smp-mt.c: In function ‘vsmp_boot_secondary’:
arch/mips/include/asm/processor.h:384:41: error:
	implicit declaration of function ‘task_stack_page’

In file included from
	/opt/buildbot/slave/hwmon-testing/build/arch/mips/kernel/pm.c:
arch/mips/include/asm/fpu.h: In function '__own_fpu':
arch/mips/include/asm/processor.h:385:31: error:
	invalid application of 'sizeof' to incomplete type 'struct pt_regs'

arch/mips/netlogic/common/smp.c: In function 'nlm_boot_secondary':
arch/mips/netlogic/common/smp.c:157:2: error:
	implicit declaration of function 'task_stack_page'

and more similar errors.

Fixes: f3ac60671954 ("sched/headers: Move task-stack related APIs ...")
Fixes: f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from ...")
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Catch more build errors

 arch/mips/cavium-octeon/cpu.c                  | 3 ++-
 arch/mips/cavium-octeon/crypto/octeon-crypto.c | 1 +
 arch/mips/cavium-octeon/smp.c                  | 2 +-
 arch/mips/kernel/pm.c                          | 1 +
 arch/mips/kernel/smp-mt.c                      | 2 +-
 arch/mips/netlogic/common/smp.c                | 1 +
 arch/mips/netlogic/xlp/cop2-ex.c               | 3 ++-
 arch/mips/power/cpu.c                          | 1 +
 8 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/cpu.c b/arch/mips/cavium-octeon/cpu.c
index a5b427909b5c..b826b7a87c57 100644
--- a/arch/mips/cavium-octeon/cpu.c
+++ b/arch/mips/cavium-octeon/cpu.c
@@ -10,7 +10,8 @@
 #include <linux/irqflags.h>
 #include <linux/notifier.h>
 #include <linux/prefetch.h>
-#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/cop2.h>
 #include <asm/current.h>
diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
index 4d22365844af..cfb4a146cf17 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
@@ -9,6 +9,7 @@
 #include <asm/cop2.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/sched/task_stack.h>
 
 #include "octeon-crypto.h"
 
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 4b94b7fbafa3..d475c0146347 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -10,8 +10,8 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
-#include <linux/sched.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/init.h>
 #include <linux/export.h>
 
diff --git a/arch/mips/kernel/pm.c b/arch/mips/kernel/pm.c
index dc814892133c..fab05022ab39 100644
--- a/arch/mips/kernel/pm.c
+++ b/arch/mips/kernel/pm.c
@@ -11,6 +11,7 @@
 
 #include <linux/cpu_pm.h>
 #include <linux/init.h>
+#include <linux/ptrace.h>
 
 #include <asm/dsp.h>
 #include <asm/fpu.h>
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index e077ea3e11fb..effc1ed18954 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -18,7 +18,7 @@
  * Copyright (C) 2006 Ralf Baechle (ralf@linux-mips.org)
  */
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 10d86d54880a..9035558920c1 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/mmu_context.h>
 
diff --git a/arch/mips/netlogic/xlp/cop2-ex.c b/arch/mips/netlogic/xlp/cop2-ex.c
index 52bc5de42005..d990b7fc84aa 100644
--- a/arch/mips/netlogic/xlp/cop2-ex.c
+++ b/arch/mips/netlogic/xlp/cop2-ex.c
@@ -13,7 +13,8 @@
 #include <linux/irqflags.h>
 #include <linux/notifier.h>
 #include <linux/prefetch.h>
-#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/cop2.h>
 #include <asm/current.h>
diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
index 2129e67723ff..6ecccc26bf7f 100644
--- a/arch/mips/power/cpu.c
+++ b/arch/mips/power/cpu.c
@@ -7,6 +7,7 @@
  * Author: Hu Hongbing <huhb@lemote.com>
  *	   Wu Zhangjin <wuzhangjin@gmail.com>
  */
+#include <linux/ptrace.h>
 #include <asm/sections.h>
 #include <asm/fpu.h>
 #include <asm/dsp.h>
-- 
2.7.4
