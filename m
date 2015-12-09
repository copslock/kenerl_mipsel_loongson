Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 18:49:31 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36562 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008700AbbLIRt2yo56m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 18:49:28 +0100
Received: by pacdm15 with SMTP id dm15so33170659pac.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uzSysd9Om8ktWl8t/EnFd35Mc4mrwNQrlVNHjXHchLY=;
        b=q3Uea3tv2B2YCsWwm/l8HEFUFMnr63FeATCZGSoNjA24z+fw+jkEGOAOwQ8uikruu+
         x+0QQOD0uvRlAmbjftwdWpzrmo1LAWifDv9ACzQXybujLJk4KHF21laet2jgbPBxiVtA
         KLNJW2/ho2Ze7eoYF6+X3RuPXCo2+Mxinz43kPXFt1Wz3MRU0ciw34fAd7ZqfXK9234/
         NcE4iHCg94sKSoQ0Tc5tDtBtx2WcCiQTkLGdzoFejpGnFF4NVL+coCcGxbnEteTG2aVD
         wlfMxJ2GNuzYPucNbYz5mZksnsOvDSrZaSCBTfK0EX5qlYVW+vDs9I3ELgKZx48U6JnO
         aOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uzSysd9Om8ktWl8t/EnFd35Mc4mrwNQrlVNHjXHchLY=;
        b=KA5YKD3I4fgcHXYE0BuSUZ0DArQVCxOc5uBtL82cfeUY+Fn8Fds5hzrHTy/ApN5lGR
         7+WSgSqEYzsj2F6cDG6axaoFq24pcEYBuNhsUtn2giivlHz/17vPrpQoceNLpsiNoBHL
         7xwEFKVz74ylWTHn95bH4aSEfPFb7IjglTMxeB0BdXJ6EoDgDRwQ7u++NH1ipCXcvGNV
         /sf+2ZaEbs9SFjQRPYsU5j3LcNJ6p3fOsd4YcNgQkoR4FMvEWfyJNlpPTJWQqU4W9/GM
         dB3SPYv6v2NbQHZLfePEP9R2NzciXKXgbul1lct7voGorzi2bUzOkgnB2+bbwBNi4jTV
         9X0w==
X-Gm-Message-State: ALoCoQlpxqdN15ww+OB+sBXjpBB5uCdq8PjpgRsmXjkPjMc4WNXuq6S7su4MS+oP7eJp6tfUn3qkXvlZZ0HG1ncozf8DxOHKzw==
X-Received: by 10.66.232.202 with SMTP id tq10mr9417025pac.156.1449683362421;
        Wed, 09 Dec 2015 09:49:22 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (unknown-216-82.windriver.com. [147.11.216.82])
        by smtp.gmail.com with ESMTPSA id l20sm13049117pfi.10.2015.12.09.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 09:49:21 -0800 (PST)
From:   Yang Shi <yang.shi@linaro.org>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linaro-kernel@lists.linaro.org, yang.shi@linaro.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 4/7] mips: mm/gup: add gup trace points
Date:   Wed,  9 Dec 2015 09:29:21 -0800
Message-Id: <1449682164-9933-5-git-send-email-yang.shi@linaro.org>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1449682164-9933-1-git-send-email-yang.shi@linaro.org>
References: <1449682164-9933-1-git-send-email-yang.shi@linaro.org>
Return-Path: <yang.shi@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@linaro.org
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

Cc: linux-mips@linux-mips.org
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/mips/mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index 349995d..e0d8838 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -15,6 +15,9 @@
 #include <asm/cpu-features.h>
 #include <asm/pgtable.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
@@ -211,6 +214,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages);
+
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
@@ -291,6 +296,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
 
+	trace_gup_get_user_pages_fast(start, nr_pages);
+
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
 slow:
-- 
2.0.2
