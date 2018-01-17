Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:26:35 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:37781
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994701AbeAQWXeOM1XK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:34 +0100
Received: by mail-lf0-x243.google.com with SMTP id f3so24012372lfe.4;
        Wed, 17 Jan 2018 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MofHb4+HfYI85igX1XANA7SFdmsbUGWvRXh/9bwD6Nc=;
        b=BLD21bLevcL9D6xxsBLq0qUl0oxFIHeFDoiFWSEzge47zXl51Jr7vZo1l1xtIgGHt/
         OjN6g4pWzI+ZEA4jPbK/nKYHhTTOml7Eofsm/4++Fg6RyPPj9AZazs3pnY7AKAjGkaAM
         uQQclQ6fOkUg1NbAKRLsmYmi40P4eAy5/6kua+Npn+2/gxuprfqNZ4YBnLb/p8MaijeH
         +xSIY+xYFgr5UZ7SpqputuKGI4Lij4qeiLgGWdAi/bUsnJVsBQvjWPlzeXFkfg0sBH48
         2k//ejFmFVZMm0VCpbXLbqBfx/h4dc+BZEhnUuVH7R4l7SY8rRxiWJpSPhTBBgUTtD8w
         N+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MofHb4+HfYI85igX1XANA7SFdmsbUGWvRXh/9bwD6Nc=;
        b=VtkbOgXhbrEXW7m86SI2l67iS/sO7NvbnSmuPrH+0g4JvZiDFgn4QIi2Rfz3u2gUBp
         BkriyCsHgMhwxgNJ3jy6LUiXAvrBY91pj4BJRDiNXZHnGIdOttpdg5/e2Q3YqIpjZBMy
         BrDOVYFqH0+WpBiMQiXlVBZ+dmr1MzkoLlgM7uld+mnDeRfH/3SDufCFXPxbyupxfcad
         RM5YjGkuNyeueQkV4zk0VQHqhSMZO2F3PgCT92AksSncaQ9tFdPQAC21GQC/rPwYid/U
         e2H+cidCtI6NbB9g5/yrvGeSJbqGeylNgS3O8uUQzyOqH5GZjxklEcsJu+yRajvyMXaW
         rc9Q==
X-Gm-Message-State: AKwxytc3PMquFiIdrNsgW6twTqOuW+mxHkasfoUTnhTS8jlf3UoMkLyL
        vAP+gz+bXbo9prQNP+1dNeEQtMVW
X-Google-Smtp-Source: ACJfBosVJpGKDInLMbwiecma/1U7lBnLe2uJvD7gpDKfHvHfUfzuaebo8VQUdwgYoQGAdYrDBVeNsA==
X-Received: by 10.46.27.10 with SMTP id b10mr9383488ljb.60.1516227808532;
        Wed, 17 Jan 2018 14:23:28 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:27 -0800 (PST)
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
Subject: [PATCH 07/14] MIPS: memblock: Mark present sparsemem sections
Date:   Thu, 18 Jan 2018 01:23:05 +0300
Message-Id: <20180117222312.14763-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62218
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
 arch/mips/kernel/setup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b121fa702..6df1eaf38 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -778,7 +778,7 @@ static void __init request_crashkernel(struct resource *res)
 
 static void __init arch_mem_init(char **cmdline_p)
 {
-	struct memblock_region *reg;
+	struct memblock_region *reg __maybe_unused;
 	extern void plat_mem_setup(void);
 
 	/* call board setup routine */
@@ -860,6 +860,11 @@ static void __init arch_mem_init(char **cmdline_p)
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
