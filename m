Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2014 11:33:16 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53293 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900AbaDSJdNqoS1j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Apr 2014 11:33:13 +0200
Received: by mail-pa0-f46.google.com with SMTP id kx10so2166136pab.5
        for <linux-mips@linux-mips.org>; Sat, 19 Apr 2014 02:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=85cH4Lgz8yBC1ubIwphaETVZaVdXJH+h72Zwxwdicjo=;
        b=fb5q98OBP1DnEAemgnUdCVRs6FL41Hoo3CovxvRAXNrrPGCUPmzqixJ104sZQKRkEW
         bJSeV6nbv7wLm+RAXHTUz1RrLe3lYO2Q6/M+jAkVAbCZgNnR5/Gli+QyGqymKqZyAlPa
         Gi/SEBW6KDmuH5zGUs6edPlRkR9ONJOJFzP/08YbA5LVUm5YCLu+jDvuNlKyendTmQ6N
         9WfJxxTghz55btNWJyxS8LjP93eHz8U5UmY4cmlVt3xg6Goq9C5Lss12spha9cmXpFQ1
         6DX01ojs/NWZ8GlcHVHB0az8kmG3VpKjiHkD3jithSDLQ6HhaZSTtkwhGlC0MWwdyvmg
         KVoQ==
X-Gm-Message-State: ALoCoQlPmJf2684KT25jqql8+GlU7B7q624upj7xCfzCTfLeLSKA7Vyvv5czXlRxa9q0y0CqgjZG
X-Received: by 10.66.147.202 with SMTP id tm10mr26638450pab.75.1397899987319;
        Sat, 19 Apr 2014 02:33:07 -0700 (PDT)
Received: from localhost ([111.93.218.67])
        by mx.google.com with ESMTPSA id te2sm154206812pac.25.2014.04.19.02.33.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 02:33:06 -0700 (PDT)
Date:   Sat, 19 Apr 2014 15:03:02 +0530
From:   Prem Karat <pkarat@mvista.com>
To:     linux-mips@linux-mips.org
Cc:     ddaney.cavm@gmail.com
Subject: [RFC PATCH 1/1] MIPS: Enable VDSO randomization.
Message-ID: <20140419093302.GH2717@064904.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pkarat@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkarat@mvista.com
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

Based on commit 1091458d09e1a (mmap randomization)

For 32-bit address spaces randomize within a
16MB space, for 64-bit within a 256MB space.

Signed-off-by: Prem Karat <pkarat@mvista.com>
---
 arch/mips/kernel/vdso.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 0f1af58..b49c705 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -16,9 +16,11 @@
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/unistd.h>
+#include <linux/random.h>
 
 #include <asm/vdso.h>
 #include <asm/uasm.h>
+#include <asm/processor.h>
 
 /*
  * Including <asm/unistd.h> would give use the 64-bit syscall numbers ...
@@ -67,7 +69,18 @@ subsys_initcall(init_vdso);
 
 static unsigned long vdso_addr(unsigned long start)
 {
-	return STACK_TOP;
+	unsigned long offset = 0UL;
+
+	if (current->flags & PF_RANDOMIZE) {
+		offset = get_random_int();
+		offset = offset << PAGE_SHIFT;
+		if (TASK_IS_32BIT_ADDR)
+			offset &= 0xfffffful;
+		else
+			offset &= 0xffffffful;
+	}
+
+	return (STACK_TOP + offset);
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-- 
1.7.9.5
