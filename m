Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 00:13:33 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35093 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007195AbbLBXNbCRT49 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 00:13:31 +0100
Received: by pacej9 with SMTP id ej9so53658098pac.2
        for <linux-mips@linux-mips.org>; Wed, 02 Dec 2015 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vVHPaTQerbTD2JvQX+Si+mQovKI7ynbHnNaKg+gyvU8=;
        b=hzhQyjEYd2htj0EBOXLcFRYOfMrilsgyxciSv1t/tMH5mN7n4+aUqVTFeliRr6I8O9
         PZSXesI9EcoBBrv4gXf/jiPiWSZfGOPq0rpzoKqUszYl0cWi92NkGR60hTBKmJ+hxTcY
         Tixw9GPE2NxOMyobBpNcm2VplcIpLTfhobDzVOhQddACX3Zr2iQ60dG6he3OU76n0faM
         qI+AJ5G0w+IYwNzeUOVOgeb2PYGNjMkWHx9MBQb1mxIXLaqkk2jQUqYx8EMDkskAHcgY
         4jVcrvhzXDXt0jCYDYg3BakFFOMA8MSmMbjJr4afhX3TnlVPWDdmeBSjcfMz0NZCx+vb
         RlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vVHPaTQerbTD2JvQX+Si+mQovKI7ynbHnNaKg+gyvU8=;
        b=K5t4DqloKWAtPEQ/ZrRAUi6PyXuWeSb6bJl3cp7q4gjg08CMHBMeHYx+KPoYsnsX4m
         mz6ov2iiCmRwtB/PDviLeacZFcg/umBBGlzCnZwvUrvJj4eZig1yzrtZ0nDfnor0v1uD
         mgotNkt+8ieisTJ72kE8M5w65VEVVwHWCJEb3ceVG7bbq2Uwx5DAiYWXEyGjkpkg0lAi
         sBAnM5mklBEjSbg1e7JOvkjPjBq8gIZIhJ8rAsFV0jGOLwBehU1ijosQiEfW390W9FLv
         TzENU4wpc7wyETw2WjV5gnSX6ryBCts78hkWT3OGs+eYzWMilM8KlPGOQPVKigYBfV+1
         rtqw==
X-Gm-Message-State: ALoCoQkqg+ehPglFeleU7emZbLhFTo856shUtVdYUX3KzcvjjXHaf5yowgBov5BPFHByyEnfGdIi
X-Received: by 10.98.80.198 with SMTP id g67mr8467585pfj.107.1449098004805;
        Wed, 02 Dec 2015 15:13:24 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (unknown-216-82.windriver.com. [147.11.216.82])
        by smtp.gmail.com with ESMTPSA id ga13sm6429030pac.47.2015.12.02.15.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2015 15:13:24 -0800 (PST)
From:   Yang Shi <yang.shi@linaro.org>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linaro-kernel@lists.linaro.org, yang.shi@linaro.org,
        linux-mips@linux-mips.org
Subject: [PATCH V2 4/7] mips: mm/gup: add gup trace points
Date:   Wed,  2 Dec 2015 14:53:30 -0800
Message-Id: <1449096813-22436-5-git-send-email-yang.shi@linaro.org>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1449096813-22436-1-git-send-email-yang.shi@linaro.org>
References: <1449096813-22436-1-git-send-email-yang.shi@linaro.org>
Return-Path: <yang.shi@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50301
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
index 349995d..3c5b8c8 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -12,6 +12,9 @@
 #include <linux/swap.h>
 #include <linux/hugetlb.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 #include <asm/cpu-features.h>
 #include <asm/pgtable.h>
 
@@ -211,6 +214,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
@@ -277,6 +282,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (end < start || cpu_has_dc_aliases)
 		goto slow_irqon;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/* XXX: batch / limit 'nr' */
 	local_irq_disable();
 	pgdp = pgd_offset(mm, addr);
-- 
2.0.2
