Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 22:42:34 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36492 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013466AbbLIVmbgxeNi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 22:42:31 +0100
Received: by pacdm15 with SMTP id dm15so35952581pac.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 13:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=auEe5BE2UyyLggn0dbi3+mENLaR5mSlgo6fFE9oVkPM=;
        b=vlOpXkadrFqj4I3qw1v42K7tPdclZ9Zn24gScY1HpVRE4pGV1Jg7Z6eVEd7+Y9ylys
         W4RFPyr+Vt14F2BYfq+7bfNNfOnKhd/n0v00jG+lfMeSc3mh3X3VpPZxxsPhWPa8yYIQ
         9wSR1OzfCIwBveo5HGWulYwc4P8bnyApSDcqhmDzOy67Dv6lZrpQm/ZQHLZFn9ff4wxL
         AT0Tx72Zucxp07DJFSVhIT32tCfU0yj44y37mo5q52K/HS50wqVoFH3RdM9KKHAshCSQ
         QGUKROv6tzhFoNt+TgCKYanD1tDKDv9ZeXCUsEWaFSmoWn3yT59Q1JyozNPsunYblORT
         qvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=auEe5BE2UyyLggn0dbi3+mENLaR5mSlgo6fFE9oVkPM=;
        b=HvdP3QzpLV/Z7yDRl9H8V/hMwqWhyCB4qBF50r7iQVvKh/tJpc6BdLc799tiTi5wVa
         8pcHKitebKZQlWEkxuach6KpqVkRAYbSNlVZHeHts4k1hItGlWb12Sp8eHAAc817a7b0
         n1lAjjDCtl+zLLa0jfT9XSiHCVmgn4en6PMo4LpSazP1N23FAVDOZE46iuq3rSW5AzF/
         W9NEY3MqODgzzBoUQ2sFFiESMQ8HR/GdsiZZKCD9nBGF33jvagj52Tj4PoNEMJ+i6v/N
         vwxnEsEmXpAGu3FjHrXZDSI35Pj+b3U+v+oiyxYH0phze8gMzYVJlpc0PjEnBAd5vVnV
         1Fpg==
X-Gm-Message-State: ALoCoQkEP22wUu4+3x5Zc+qLsVrXAfF1v6Sm5XgDEaspcpU+8x0f4OBk3SJvPrXda3zZDaol2yT1XnuTt4OuojLSjnrexZbTkQ==
X-Received: by 10.66.172.164 with SMTP id bd4mr11375405pac.64.1449697345228;
        Wed, 09 Dec 2015 13:42:25 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (unknown-216-82.windriver.com. [147.11.216.82])
        by smtp.gmail.com with ESMTPSA id f76sm13717090pfd.49.2015.12.09.13.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 13:42:24 -0800 (PST)
From:   Yang Shi <yang.shi@linaro.org>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linaro-kernel@lists.linaro.org, yang.shi@linaro.org,
        linux-mips@linux-mips.org
Subject: [PATCH v5 4/7] mips: mm/gup: add gup trace points
Date:   Wed,  9 Dec 2015 13:22:28 -0800
Message-Id: <1449696151-4195-5-git-send-email-yang.shi@linaro.org>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1449696151-4195-1-git-send-email-yang.shi@linaro.org>
References: <1449696151-4195-1-git-send-email-yang.shi@linaro.org>
Return-Path: <yang.shi@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50513
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
 arch/mips/mm/gup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index 349995d..7d90883 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -15,6 +15,8 @@
 #include <asm/cpu-features.h>
 #include <asm/pgtable.h>
 
+#include <trace/events/gup.h>
+
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
@@ -211,6 +213,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages);
+
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
@@ -291,6 +295,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
 
+	trace_gup_get_user_pages_fast(start, nr_pages);
+
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
 slow:
-- 
2.0.2
