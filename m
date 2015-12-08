Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 21:00:06 +0100 (CET)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35903 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013427AbbLHUADvzC5n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 21:00:03 +0100
Received: by pfdd184 with SMTP id d184so17006168pfd.3
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2015 11:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMZOZ1XZnT+HiZTY068AqR4dLGpIz0D427ZmGFMv91I=;
        b=saWiyMoT0r8v9BJmMNjUtrdC83CTHlGIKdAUPt9w1HTrCJt7dTLPx15Bbk3TFU55mO
         mm8EQhXUjWddjmxFUEsHRSm7jGd+sHJKMw+4zGYz0ej9vd+v23jO8yS12yjpPFKL0FEh
         Em+6EVaNW4TBEMRQzqBPi3Yan9Dli234A+xbJYULSCfktOEpqWAGsDUBDqJQe4Kxyy6m
         C7lY8KH2chAoa4bOSgd9pkxY2Hg6KdOFpUT+xcK+6YdZlDNHSqmLDhHG+fctXq+LAPQV
         uEgpFVeaAEB6Kn0PuzIkE9MX9TXnRPS/qLKXqlgB78Apu9M53pFdWZ3QDdYNqIfUF4N0
         8lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMZOZ1XZnT+HiZTY068AqR4dLGpIz0D427ZmGFMv91I=;
        b=eOZtfuGC9SMjh9g6ghY0RWcONOjsJFcXX0Rxx1Q+texG+ZT0tERVgd+rkSSPeGASbX
         TNxL38+H+yZ2giV8SLXOPBgTOEZ51LxRr+cHGYZztJpEo4sXiMUzbo3TQV6IYLr/0Eux
         lazInOBjfZUsQJrv9OnW1tOu0FjJlxAdyzDCvsadg5DekxmIPAb8idyFNwZG01K/GRQ/
         +3lZPI2+adikcLv4aHAfpx1Ni28iwcK7qIboF3priLAKkCbADy9OIqlQBTVmN3I/twDM
         ACRkYQnpax7zHqYD6GCQVHJ9b+VS6rWVIQZmN6sw3dDQ1tBdHCRrM7jq5PnElC542JpO
         DFlA==
X-Gm-Message-State: ALoCoQkb5THxwFW6iu+2RYCPAWxn8lTAcMukVrh9goSz4WwYAXx8QAO/VIkEB8eQVSN5kV9cqAmFl7xBcg1Bm4jaHBmJ1FowNg==
X-Received: by 10.98.19.12 with SMTP id b12mr7461567pfj.78.1449604797368;
        Tue, 08 Dec 2015 11:59:57 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (unknown-216-82.windriver.com. [147.11.216.82])
        by smtp.gmail.com with ESMTPSA id 25sm6479658pfp.62.2015.12.08.11.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2015 11:59:56 -0800 (PST)
From:   Yang Shi <yang.shi@linaro.org>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linaro-kernel@lists.linaro.org, yang.shi@linaro.org,
        linux-mips@linux-mips.org
Subject: [PATCH v3 4/7] mips: mm/gup: add gup trace points
Date:   Tue,  8 Dec 2015 11:39:52 -0800
Message-Id: <1449603595-718-5-git-send-email-yang.shi@linaro.org>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1449603595-718-1-git-send-email-yang.shi@linaro.org>
References: <1449603595-718-1-git-send-email-yang.shi@linaro.org>
Return-Path: <yang.shi@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50449
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
index 349995d..2107499 100644
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
 
+	trace_gup_get_user_pages_fast(start, (unsigned long) nr_pages);
+
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
@@ -291,6 +296,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
 
+	trace_gup_get_user_pages_fast(start, (unsigned long) nr_pages);
+
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
 slow:
-- 
2.0.2
