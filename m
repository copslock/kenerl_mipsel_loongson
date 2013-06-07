Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:04:07 +0200 (CEST)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59191 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834882Ab3FGXDwBwO4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:52 +0200
Received: by mail-ie0-f175.google.com with SMTP id a14so1753396iee.34
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ojfb0CTMFfob0/+ZR6EuIZLnV0cZIkwaz7rWXwiA8tg=;
        b=zf5HWhrMsR99+G7T8PBMHREGraSpn1qoLlkwi6AwMdp+ydhPbhZKgHIY+eQ1GNuzT/
         CF359ZUQuSS52DQxc6x5U0sssOb1PglAAPojEl4CWQI30upzx7NBRI0v1dssm5x8QYVV
         Qf4C3tHs7P03QqL7sdlrgjU+xyd20n062BXAv0Fh9MHHgS4gNYVKqLNuMGfnESggPJtd
         pRqR0dvGU8ZeV2Dt6b4Jskv6LrGkJ0FIBKizzG5LKdOyDwEKle1aQOT7ON3xm3xqFLYE
         vNRATnp9YLVLzOuG+ovSnwYShy5+8kT464prRj54jL7iYMpd+od8Z+ImEmlpkcJEHNqa
         p75A==
X-Received: by 10.50.115.67 with SMTP id jm3mr2254772igb.65.1370646225730;
        Fri, 07 Jun 2013 16:03:45 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id wn10sm214761igb.2.2013.06.07.16.03.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:45 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3gF8006614;
        Fri, 7 Jun 2013 16:03:42 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3g5Z006613;
        Fri, 7 Jun 2013 16:03:42 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 01/31] MIPS: Move allocate_kscratch to cpu-probe.c and make it public.
Date:   Fri,  7 Jun 2013 16:03:05 -0700
Message-Id: <1370646215-6543-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36720
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

From: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |  2 ++
 arch/mips/kernel/cpu-probe.c     | 29 +++++++++++++++++++++++++++++
 arch/mips/mm/tlbex.c             | 20 +-------------------
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 87e6207..6e0da5aa 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1806,6 +1806,8 @@ __BUILD_SET_C0(brcm_cmt_ctrl)
 __BUILD_SET_C0(brcm_config)
 __BUILD_SET_C0(brcm_mode)
 
+int allocate_kscratch(void);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_MIPSREGS_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c6568bf..ee1014e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1064,3 +1064,32 @@ __cpuinit void cpu_report(void)
 	if (c->options & MIPS_CPU_FPU)
 		printk(KERN_INFO "FPU revision is: %08x\n", c->fpu_id);
 }
+
+static DEFINE_SPINLOCK(kscratch_used_lock);
+
+static unsigned int kscratch_used_mask;
+
+int allocate_kscratch(void)
+{
+	int r;
+	unsigned int a;
+
+	spin_lock(&kscratch_used_lock);
+
+	a = cpu_data[0].kscratch_mask & ~kscratch_used_mask;
+
+	r = ffs(a);
+
+	if (r == 0) {
+		r = -1;
+		goto out;
+	}
+
+	r--; /* make it zero based */
+
+	kscratch_used_mask |= (1 << r);
+out:
+	spin_unlock(&kscratch_used_lock);
+
+	return r;
+}
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ce9818e..001b87c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -30,6 +30,7 @@
 #include <linux/cache.h>
 
 #include <asm/cacheflush.h>
+#include <asm/mipsregs.h>
 #include <asm/pgtable.h>
 #include <asm/war.h>
 #include <asm/uasm.h>
@@ -307,25 +308,6 @@ static int check_for_high_segbits __cpuinitdata;
 
 static int check_for_high_segbits __cpuinitdata;
 
-static unsigned int kscratch_used_mask __cpuinitdata;
-
-static int __cpuinit allocate_kscratch(void)
-{
-	int r;
-	unsigned int a = cpu_data[0].kscratch_mask & ~kscratch_used_mask;
-
-	r = ffs(a);
-
-	if (r == 0)
-		return -1;
-
-	r--; /* make it zero based */
-
-	kscratch_used_mask |= (1 << r);
-
-	return r;
-}
-
 static int scratch_reg __cpuinitdata;
 static int pgd_reg __cpuinitdata;
 enum vmalloc64_mode {not_refill, refill_scratch, refill_noscratch};
-- 
1.7.11.7
