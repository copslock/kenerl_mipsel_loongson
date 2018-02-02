Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 05:00:32 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:46904
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994860AbeBBDzZCIeK0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:25 +0100
Received: by mail-lf0-x244.google.com with SMTP id q194so29414969lfe.13;
        Thu, 01 Feb 2018 19:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stUVC8kueTevDIOxLSUIRSRvfp8B3oCnZBRDOk79Es8=;
        b=LXGGfZ0dhKu3FEyB76dnmtzWIb48J7y/j24e+7jpzJcGVggyijcwy/3CUBhH+Mdj8G
         mJkGQ4LEQcULQPPaNm2a3ytVBKliSH9eLi7cclgrYajOtJjGivJitD940Lbo21LxjR07
         p+UrYqsZtsBjiqViHHXLSCdgjCa/ey93dT3U3Ahy4a6tlbqReSnf2pkhxEfzYfGGINNZ
         f5iSf3N4cKiuRML0g6/DXjVN/VIDEK3Hkpx5V5UfJYUQiSelsm512fU8gbk1ObV92WFX
         GuMhOvOsqpHio69tpXpcMXOVYtKlXWbYPrbb88TuhMvsCNlxL3RFV2kB1gVnEuBwNE7v
         qoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stUVC8kueTevDIOxLSUIRSRvfp8B3oCnZBRDOk79Es8=;
        b=MOfEvsSUNculhGiIJ+0fNVwLd3Q/w0COXbo34HolZ4t0fXZVN8lwu5CkRVo9pIjhG+
         XEk69UrMkD1nlujpVJy9p/bI7Csh/Y0PQz9tedjkCkkbyJx/iTndHAEWzovz1EJxku4H
         L97eqdLCIkmHpfGwFGS2JjsT2ifxmaEoxA1lnS1R/D1abLl9jVKrJurQKXLPGhCOPBiE
         aLUGWOq58a2PAkQhxCHO+V1qyQVHlFYnVgyEgc5taCNXOuiD5/NFr+iJDwsgnX9b0zIo
         dFfQainRVogvBjdgSasSZrc2bmZaYW2rVUKEW6zamcXtTWCEsxv17B2FcBY6ByCe52oc
         Sg+w==
X-Gm-Message-State: AKwxytcpjV6IJyOu4AFXN3Ae8MgZK56wxwqfzBH0AhM6s4gh+LzM2iy/
        l3c9WDW31MtKTpRK8A5PBIYyAB5p
X-Google-Smtp-Source: AH8x2247jrcxex/KedXqWHy56fTThZzH106A+BIjUJjxf0fdJ07S/kE5rwtwgmndM1Y1MWK/24xSmw==
X-Received: by 10.46.80.88 with SMTP id v24mr7236837ljd.86.1517543719266;
        Thu, 01 Feb 2018 19:55:19 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:18 -0800 (PST)
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
Subject: [PATCH v2 12/15] MIPS: memblock: Print out kernel virtual mem layout
Date:   Fri,  2 Feb 2018 06:54:55 +0300
Message-Id: <20180202035458.30456-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62419
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
 arch/mips/mm/init.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 84b7b592b834..eec92194d4dc 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -32,6 +32,7 @@
 #include <linux/kcore.h>
 #include <linux/export.h>
 #include <linux/initrd.h>
+#include <linux/sizes.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -60,6 +61,53 @@ EXPORT_SYMBOL_GPL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
 /*
+ * Print out the kernel virtual memory layout
+ */
+#define MLK(b, t) (void *)b, (void *)t, ((t) - (b)) >> 10
+#define MLM(b, t) (void *)b, (void *)t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) (void *)b, (void *)t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+static void __init mem_print_kmap_info(void)
+{
+#ifdef CONFIG_DEBUG_KERNEL
+	pr_notice("Kernel virtual memory layout:\n"
+		  "    lowmem  : 0x%px - 0x%px  (%4ld MB)\n"
+		  "      .text : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .data : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .init : 0x%px - 0x%px  (%4td kB)\n"
+		  "      .bss  : 0x%px - 0x%px  (%4td kB)\n"
+		  "    vmalloc : 0x%px - 0x%px  (%4ld MB)\n"
+#ifdef CONFIG_HIGHMEM
+		  "    pkmap   : 0x%px - 0x%px  (%4ld MB)\n"
+#endif
+		  "    fixmap  : 0x%px - 0x%px  (%4ld kB)\n",
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
+#endif /* CONFIG_DEBUG_KERNEL */
+}
+#undef MLK
+#undef MLM
+#undef MLK_ROUNDUP
+
+/*
  * Not static inline because used by IP27 special magic initialization code
  */
 void setup_zero_pages(void)
@@ -468,6 +516,7 @@ void __init mem_init(void)
 	free_all_bootmem();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
+	mem_print_kmap_info();
 	mem_init_print_info(NULL);
 
 #ifdef CONFIG_64BIT
-- 
2.12.0
