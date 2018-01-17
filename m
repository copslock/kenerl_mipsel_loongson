Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:28:21 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:38489
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994706AbeAQWXjpcCvm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:39 +0100
Received: by mail-lf0-x241.google.com with SMTP id g72so18531492lfg.5;
        Wed, 17 Jan 2018 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RA2GscUDpJWczp6CLDzuq/7nYSVri95Jhta2l7mMQI=;
        b=U6eQ71sik8rjiFxfDoS5JoaZycMSCWUerasefJI2z20E8vE5VpNL4DtVuZlTpiZhKG
         OCa/nK8eABGu2YXQ16zsVKE0InLJm6ampfhBmPZ38umidcZdBgkFLIOHrprGdxIQl/A2
         seHtmME86TQc3uVb1PPTTvt6D273tQjJJt9Wa9MZj+8gg8XL3iYoHGusxoIBgVmt5Y+Q
         RvclbpcKywz/owZ8ZOY49i0hBYPnPK020iLe2hHFbJn9aRqyIJogWv/dcz18J/+cXyKV
         w2/kDHtXbkb/avxlvQAT/ByyVHLeNoCaM+jzNDHgV46MbZ5t3B5sZvH1jVjEqUo1q03x
         szOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RA2GscUDpJWczp6CLDzuq/7nYSVri95Jhta2l7mMQI=;
        b=TH2XNV78adUdUrcjHvc6qQZh17D94PeV4o7sVQ6itNT+f1NR0KjLXk8QrhRDhNzXZi
         JD+4arepz+PjXAnh/2tramp5R9rerEoVHE1j7LbFPSwCWIjpvDzvEo47A0hBilR8Hrrg
         ++xhmLZNkmucUUlJF1WkNf2FyWxqMcQahkAufHNQFV3AYd0/2RlADcXlfo2Stmq31uDE
         CeCnWFiy+BlLWEM6Ayj00YKcF7SmMoY4I22af8eGPImxmiA7LNZ6FhfzSXVMF6ZwBMKP
         MvnEurf7nkc3pCLBxs02SodoFrqNZKfhAFT7hGHiiE6rp5A/oof2Yc5Q/+xNYDL1I6xT
         ZE4g==
X-Gm-Message-State: AKwxytftNR8kJEAsOMqnwZDJldGy9nS0qb4BD1jnxhGXGlmV3XnzGdui
        Ja7UIt6OkxPwTTxNzpAMLpswH1aw
X-Google-Smtp-Source: ACJfBosOWBsOwtcYMGJWo3Amw186efh+Pfkfkn067Ob9KeoamL/qE5kqaa8H7Wco5CHATeCnem3Low==
X-Received: by 10.46.60.15 with SMTP id j15mr1308205lja.140.1516227813983;
        Wed, 17 Jan 2018 14:23:33 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:33 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
Date:   Thu, 18 Jan 2018 01:23:09 +0300
Message-Id: <20180117222312.14763-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

It is useful to have the kernel virtual memory layout printed
at boot time so to have the full information about the booted
kernel. In some cases it might be unsafe to have virtual
addresses freely visible in logs, so the %pK format is used if
one want to hide them.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 15040266b..d3e6bb531 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -32,6 +32,7 @@
 #include <linux/kcore.h>
 #include <linux/export.h>
 #include <linux/initrd.h>
+#include <linux/sizes.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -60,6 +61,51 @@ EXPORT_SYMBOL_GPL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
 /*
+ * Print out the kernel virtual memory layout
+ */
+#define MLK(b, t) (void *)b, (void *)t, ((t) - (b)) >> 10
+#define MLM(b, t) (void *)b, (void *)t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) (void *)b, (void *)t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+static void __init __maybe_unused mem_print_kmap_info(void)
+{
+	pr_notice("Kernel virtual memory layout:\n"
+		  "    lowmem  : 0x%pK - 0x%pK  (%4ld MB)\n"
+		  "      .text : 0x%pK - 0x%pK  (%4td kB)\n"
+		  "      .data : 0x%pK - 0x%pK  (%4td kB)\n"
+		  "      .init : 0x%pK - 0x%pK  (%4td kB)\n"
+		  "      .bss  : 0x%pK - 0x%pK  (%4td kB)\n"
+		  "    vmalloc : 0x%pK - 0x%pK  (%4ld MB)\n"
+#ifdef CONFIG_HIGHMEM
+		  "    pkmap   : 0x%pK - 0x%pK  (%4ld MB)\n"
+#endif
+		  "    fixmap  : 0x%pK - 0x%pK  (%4ld kB)\n",
+		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
+		  MLK_ROUNDUP(_text, _etext),
+		  MLK_ROUNDUP(_sdata, _edata),
+		  MLK_ROUNDUP(__init_begin, __init_end),
+		  MLK_ROUNDUP(__bss_start, __bss_stop),
+		  MLM(VMALLOC_START, VMALLOC_END),
+#ifdef CONFIG_HIGHMEM
+		  MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
+#endif
+		  MLK(FIXADDR_START, FIXADDR_TOP));
+
+	/* Check some fundamental inconsistencies. May add something else? */
+#ifdef CONFIG_HIGHMEM
+	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
+	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
+	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
+	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
+		(unsigned long)high_memory);
+#endif
+	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
+	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
+}
+#undef MLK
+#undef MLM
+#undef MLK_ROUNDUP
+
+/*
  * Not static inline because used by IP27 special magic initialization code
  */
 void setup_zero_pages(void)
@@ -468,6 +514,7 @@ void __init mem_init(void)
 	free_all_bootmem();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
+	mem_print_kmap_info();
 	mem_init_print_info(NULL);
 
 #ifdef CONFIG_64BIT
-- 
2.12.0
