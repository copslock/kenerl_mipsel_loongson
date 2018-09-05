Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:33:00 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:34503
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994611AbeIEJc5bWx5C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:32:57 +0200
Received: by mail-pg1-x543.google.com with SMTP id d19-v6so3164527pgv.1;
        Wed, 05 Sep 2018 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uZ+55UcUX/4Yn9fwPrxov+q+WijMDiKyWq5Q+FqUkoo=;
        b=KnhPaq7itNsS/XuevyJQtjyq7nYFCE0eUmasEZrh7Hf6yqJKJdziHvEGaXcbzZTpCX
         5JUYDO7u4KcwmPPxWFbctXWCnAup12XsAU36XYwWTeWKll7a1m8/Ib9VpLE/gZ+3sawV
         suBCDzXhzmlTd2ZzseW+GJoh2sq75/Hg2ScnbyoNu6N76ZkJpNq1ymA4C6EKvWSdBIAH
         2MguApUKgeQAwdIuKmmzRD8KQHLhAYN15WZIhhKIS4JQ4u6QU2K/7mBA+AhimJYiA5B9
         bQKJ7meMTEyLhLXIz0Xur0vUnWHxlnFm5Mdu3alp12ILoYIVPjW4jxbMAJVHxXcI6LOe
         8ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=uZ+55UcUX/4Yn9fwPrxov+q+WijMDiKyWq5Q+FqUkoo=;
        b=QwXomE7nrjWOiX0NBdfjpUEmyWfYjBguokppJr0im9YFrMYmNMyup4/yMA6tDsYCiX
         V1CZtARwMSyQeCVFiE0+pXDOTmZXGIGtzUmPGAv1VUlBCgSkv3N82ZJLnRmsQttQVKLT
         B+UHFM2duxpReCJo0unqhHlxXXbdhVJzZKwCN/U/1Rd67re5G0utleU1kzy07S67o3ux
         RWoWhmvXn9RFLYpKne7zMJoyfAFbso7ngm9gPUcCb6r10/RqVezEoAi7GvvWGSay4SwC
         0IBKXTFn3C2p00eDpSZm25cYdk+gZovVCGw0m8ELswAd3DiuaYy79M4o0xUDTjHh1TCx
         sQEA==
X-Gm-Message-State: APzg51BIObaQ1YBsCukXN97M9eMTZvn9KoIOGH1wXJi9M7rM6vMWz6oa
        c7qbP/jKoL5jHqAxCCE57a6LZKDKaNw=
X-Google-Smtp-Source: ANB0Vda+6HZsKeRDzDclm8xKPkZTkZ6+xpc9vvS4fnEednEJyAT0RRqM9LbNx+Qu097F3X7N0cfxQA==
X-Received: by 2002:a63:ee56:: with SMTP id n22-v6mr35695493pgk.402.1536139970818;
        Wed, 05 Sep 2018 02:32:50 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:32:50 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 01/10] MIPS: Loongson-3: Enable Store Fill Buffer at runtime
Date:   Wed,  5 Sep 2018 17:33:01 +0800
Message-Id: <1536139990-11665-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65939
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

New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
(Store Fill Buffer) which can improve the performance of memory access.
Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
the generic kernel has no benefit from SFB (even it is running on a new
Loongson-3 machine). With this patch, we can enable SFB at runtime by
detecting the CPU type (the expense is war_io_reorder_wmb() will always
be a 'sync', which will hurt the performance of old Loongson-3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/io.h                               |  2 +-
 .../mips/include/asm/mach-loongson64/kernel-entry-init.h | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 44f766b..eb357c9 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -289,7 +289,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #undef __IS_KSEG1
 }
 
-#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
+#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_CPU_LOONGSON3)
 #define war_io_reorder_wmb()		wmb()
 #else
 #define war_io_reorder_wmb()		barrier()
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 3127391..cbac603 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
 #define __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
 
+#include <asm/cpu.h>
+
 /*
  * Override macros used in arch/mips/kernel/head.S.
  */
@@ -26,12 +28,15 @@
 	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
 	mtc0	t0, CP0_PAGEGRAIN
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
+	mfc0	t0, CP0_PRID
+	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
 	mtc0	t0, CP0_CONFIG6
-#endif
+1:
 	_ehb
 	.set	pop
 #endif
@@ -52,12 +57,15 @@
 	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
 	mtc0	t0, CP0_PAGEGRAIN
-#ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
+	mfc0	t0, CP0_PRID
+	andi	t0, (PRID_IMP_MASK | PRID_REV_MASK)
+	slti	t0, (PRID_IMP_LOONGSON_64 | PRID_REV_LOONGSON3A_R2)
+	bnez	t0, 1f
 	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
 	mtc0	t0, CP0_CONFIG6
-#endif
+1:
 	_ehb
 	.set	pop
 #endif
-- 
2.7.0
