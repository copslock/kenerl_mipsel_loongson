Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:59:14 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:46903
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994855AbeBBDzV6Zi60 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:21 +0100
Received: by mail-lf0-x244.google.com with SMTP id q194so29414770lfe.13;
        Thu, 01 Feb 2018 19:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qe+jeju5c0xk13GQNkrFJsA7pQ5xm3AiUWEjRkNB9v8=;
        b=oFDk4Emk6ROVEWnVg8ZhtN86TIvqgLk7/axRRH7WH4JgyqRDS2TrCSMX/HoHXiK/0L
         iUPJ2V3vgo/jdRkrbXKoskH4o8FYgFdFKe8IJ8ANRGeezMrAZv3Kn6NxIzegsYATSPw9
         8QgAH8OIH27Fo8MBb9+tnbcg3LOjW8oE+Zfh/vE+hlfGfDo9f3ibGD+2UTqwvflhACn5
         +WoSz0+vru2MzrMAGCGt9zqgHnEcIexl7dt8SVG+LYU80Y+6kuy6hvEwbAMX8xNCnRj7
         STsDn4Us01N0vaI3lfVTV6NZh5RNlignWHaAPbGgEf6WHC/+vTS8uP+CxFDy0RLfN3jB
         8MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qe+jeju5c0xk13GQNkrFJsA7pQ5xm3AiUWEjRkNB9v8=;
        b=RwHmlu/Wf7QOwMtYrZdxiFy5FMdEZPUNyZOd3Mo3zbBz2ls74LnRDMIBQtCkiWI9bQ
         S9ZYTwdC3yUdEbJJZCcm6LDGzBx5jcLwS7SSHISPT6ydLeFH1DpqJou+IEIx1GNUycuV
         dL9qakF2eWlyrJ/JtZFlLRIf885CFbXMRZbq0kh50qRfNnqj0afGURCvwUwYun9Z7XJ/
         82URbsK0VvhApXCT9qB6VhPXshqXS3gOOmN3a2WRFuM+wg9iv5Em3iLAifqTDCYdsWnm
         x7/iAxXFIOwCC2qIa4crQTZ3lFKrQB+Xd2G0OZ4O/68P4mOrKozAGwDszVQcAaSg6xQA
         l62w==
X-Gm-Message-State: AKwxytc53SS+1Yu2+N1o8uaKn0RTwZAWVD9IFXY7mFZJR6QUTPPVQt+w
        NBdvaI8LgIy8juckFum4p3UHw+kZ
X-Google-Smtp-Source: AH8x224ciKAmbmbQ+zEOrFc54y/TjR6tZxlxtP5Ll7cSyZGU5XVWIcYq9ySVdhL75YCnu+LSPezzEw==
X-Received: by 10.46.69.4 with SMTP id s4mr12113003lja.73.1517543713994;
        Thu, 01 Feb 2018 19:55:13 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:13 -0800 (PST)
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
Subject: [PATCH v2 08/15] MIPS: memblock: Mark present sparsemem sections
Date:   Fri,  2 Feb 2018 06:54:51 +0300
Message-Id: <20180202035458.30456-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62416
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

If sparsemem is activated all sections with present pages must
be accordingly marked after memblock is fully initialized.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b2a5b89ae6b2..54302319ce1c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -837,6 +837,11 @@ static void __init arch_mem_init(char **cmdline_p)
 				 crashk_res.end - crashk_res.start + 1);
 #endif
 	device_tree_init();
+#ifdef CONFIG_SPARSEMEM
+	for_each_memblock(memory, reg)
+		memory_present(0, memblock_region_memory_base_pfn(reg),
+				memblock_region_memory_end_pfn(reg));
+#endif /* CONFIG_SPARSEMEM */
 	sparse_init();
 	plat_swiotlb_setup();
 
-- 
2.12.0
