Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:14:50 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33124 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993096AbcLSCITIFlcK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:19 +0100
Received: by mail-lf0-f65.google.com with SMTP id y21so6157148lfa.0;
        Sun, 18 Dec 2016 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5xBkvVro7bKLvdj+JhtHyKzvlRYUmsN8O8j9lW4GdKA=;
        b=W0T0glnTviIdDvqqchzulVE+2+IAD6G9ETIDf257WNXAcynXawUzZr20t5YqxVtCQf
         WU92ABhlVeeTGMbq9hLX/xmaGwzK1pmhYzzKPOjpw9U1yCXmLMLnH34Bf8ht1nGRmYpi
         AqAwLZMzW9AYIiESZ/mz5zNE32PcCTSEufO4f4UXW88mDtBOJQIC5rRVoYrQa/DRi8oe
         ESiCNKjwygWnICQ0QJVVbykUjgeBEyUzoKub38ACPwsnT19OfpuVQtDFLZpNF6vkzwkk
         5jMCajeg2nFUukdggyAHRTDBPQcpEklhbnv/Bk/GzYLI8e8No8AHp/Ii8IQoCYt79P9K
         zR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5xBkvVro7bKLvdj+JhtHyKzvlRYUmsN8O8j9lW4GdKA=;
        b=IIGD5Ln1+RkR2dUKUcWj6oPkDIOWqapHSg4QmyJBl4+evy4uLaFtW6xz72Qfla2Zoa
         c/VQ1b4kNpRXOQrAxpAo12S4tNd1NF/bfQBxanC+BnTyogC/Kx5qBM+QBg2EkiR+I/qO
         C5kzpN8Rm4SSiiS8Ar6rjewQJT33JLJ0y5s5tX4EtSzQ4DXNjl4biGYaQpODA502aVZ+
         z9jM01BJWwo+SXKxXusEUWlcXLhbgXL69zc4e8VvdUPwgTyxpiki2N5Csio1CJ89SAlL
         wz1OJnZHP1QBXJJIX/pt0kLJSser/UUvVYxgMEk/4HQgRUZZYJI87va1nTLx+GK8eKhX
         AVWw==
X-Gm-Message-State: AIkVDXJhauMnljj/sJEfm8JRK9L/ws1YiB6E2HUbaw/nFRhjpGD6W0fM0MaK2iTWw6kHdA==
X-Received: by 10.46.69.69 with SMTP id s66mr5823117lja.71.1482113293528;
        Sun, 18 Dec 2016 18:08:13 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:13 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 19/21] MIPS memblock: Add print out method of kernel virtual memory layout
Date:   Mon, 19 Dec 2016 05:07:44 +0300
Message-Id: <1482113266-13207-20-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56079
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

It's useful to have some printed map of the kernel virtual memory,
at least for debugging purpose.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/init.c | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 13a032f..35e7ba8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -32,6 +32,7 @@
 #include <linux/hardirq.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/sizes.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -106,6 +107,49 @@ static void __init zone_sizes_init(void)
 }
 
 /*
+ * Print out kernel memory layout
+ */
+#define MLK(b, t) b, t, ((t) - (b)) >> 10
+#define MLM(b, t) b, t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+static void __init mem_print_kmap_info(void)
+{
+	pr_notice("Virtual kernel memory layout:\n"
+		  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+		  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#ifdef CONFIG_HIGHMEM
+		  "    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
+		  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+		  "      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
+		  "      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
+		  "      .init : 0x%p" " - 0x%p" "   (%4td kB)\n",
+		MLM(PAGE_OFFSET, (unsigned long)high_memory),
+		MLM(VMALLOC_START, VMALLOC_END),
+#ifdef CONFIG_HIGHMEM
+		MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
+#endif
+		MLK(FIXADDR_START, FIXADDR_TOP),
+		MLK_ROUNDUP(_text, _etext),
+		MLK_ROUNDUP(_sdata, _edata),
+		MLK_ROUNDUP(__init_begin, __init_end));
+
+	/* Check some fundamental inconsistencies. May add something else? */
+#ifdef CONFIG_HIGHMEM
+	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
+	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
+#endif
+	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
+	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
+					(unsigned long)high_memory);
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
@@ -492,6 +536,9 @@ void __init mem_init(void)
 	/* Free highmemory registered in memblocks */
 	mem_init_free_highmem();
 
+	/* Print out kernel memory layout */
+	mem_print_kmap_info();
+
 	/* Print out memory areas statistics */
 	mem_init_print_info(NULL);
 
-- 
2.6.6
