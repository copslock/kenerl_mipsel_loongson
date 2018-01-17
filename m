Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:26:08 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:39076
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994698AbeAQWXcw0fgC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:32 +0100
Received: by mail-lf0-x242.google.com with SMTP id m8so24012047lfc.6;
        Wed, 17 Jan 2018 14:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/0flwQqlo8Ga7Z3uhWMtp+lF0st8GiFoGDX1KCpXWc=;
        b=c5OlaxI0U64aYO4uw5UZGyJPJ65NKebaP49TMfXsoxBkkoYZ6EoxWl2cxDBco1Bq1E
         oq2mrt1bTVKbTrGFsKus53utT2cbXUKc6ZngJA3GVcpY+vPXevyle4o8n6hJ/ohkPI5s
         xSx+f8ecICNEVqYQT0Bl7mF4Jt6ABDyUtD6EFzBw9zLBX91rMj85FomU+ug4zEfeTDkp
         YhoQwtI7P+0GmhrGFm5qst+TI7pPfK9t40UkHczaV8REMYhltrv8nD0QnSfl+pZeX5eh
         m0+KrQW4HgPhP4WCmJZuHSQX/cWMn1mcFQNdJtaGqvC95afKsfoB0ILnCe6AR4gtBvtj
         CW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/0flwQqlo8Ga7Z3uhWMtp+lF0st8GiFoGDX1KCpXWc=;
        b=XbOk595LxfD22cLIzKfJ8tA9Lb4uiVSrFsmUvlRdDEJhlnvBrpMWg4T981Xgitdeny
         jZULKlIXTfhG/wK9r+kP3uH/NAvVHzM7BflG3byMFL0Yysbf6fCN3Y12LnjF8881zPrr
         LDCTgIvhaGOKroDPF13raQqu1N3m7Ik6I7562Bf/jqc3I2ikxixbW+uuirOcYwrG81fC
         ctZYYBnMd/sbE6dcyCk0uFumuZ6KUyoljdW2nGm3CT2+Qfc8Cz8n7jdaSBtXRrdePtlD
         dfkFM/8+YWvc0RMcFu+470aB+KCgWf7JRmijh5IVhkYfLPLTNtpyq1lFJ0pCtn6TUjPt
         mt/A==
X-Gm-Message-State: AKwxytdbVcNJ/yek1mpj37Q48qScK8B42kLeIGNsHU/ogIOwOYoZfISN
        VAYbyckwBmQ3P1t/ZYpwAqXxmGXD
X-Google-Smtp-Source: ACJfBovGw5WsGg3eT4OostTERguwEJIPNc3OUMGR7r6zMICU4XO7iIhSf6/SW1sINKFp5CMP9CzHtw==
X-Received: by 10.46.51.24 with SMTP id d24mr8690686ljc.78.1516227807135;
        Wed, 17 Jan 2018 14:23:27 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:26 -0800 (PST)
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
Subject: [PATCH 06/14] MIPS: memblock: Reserve kdump/crash regions in memblock
Date:   Thu, 18 Jan 2018 01:23:04 +0300
Message-Id: <20180117222312.14763-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62217
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

Kdump/crashkernel memory regions should be reserved in the
memblock allocator so they wouldn't be occupied by any further
allocations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9e14d9833..b121fa702 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -849,17 +849,15 @@ static void __init arch_mem_init(char **cmdline_p)
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
 		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
 		       setup_elfcorehdr, setup_elfcorehdr_size);
-		reserve_bootmem(setup_elfcorehdr, setup_elfcorehdr_size,
-				BOOTMEM_DEFAULT);
+		memblock_reserve(setup_elfcorehdr, setup_elfcorehdr_size);
 	}
 #endif
 
 	mips_parse_crashkernel();
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end)
-		reserve_bootmem(crashk_res.start,
-				crashk_res.end - crashk_res.start + 1,
-				BOOTMEM_DEFAULT);
+		memblock_reserve(crashk_res.start,
+				 crashk_res.end - crashk_res.start + 1);
 #endif
 	device_tree_init();
 	sparse_init();
-- 
2.12.0
