Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:56:12 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:42611
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeBBDzLctS20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:11 +0100
Received: by mail-lf0-x242.google.com with SMTP id q17so29429541lfa.9;
        Thu, 01 Feb 2018 19:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1pr3vE4s/hDCygPHVKmSOsXHVyT0Dcd/BmISwbScu14=;
        b=BEcHmmqYxgsq1iRoBfnJOcHryx8RdYIkCy8OU70lo+5gL26S/XjZVLOdhFQamZPe9S
         taTbpTXUui7HtNE2ousLkL65/RRPdWDqOFPCaHqt+MHIAtJa7wTp2+yqlBRzeJcBZkH4
         1H/vWfyIMROp/HidSuYGz8Bd39B6MKIXHJotJi9ADHERlSx2efBJgC7tjjF1waV3w+vr
         BXf1xCy9Ymn/4YW6aGv1GCs71ojueoRFbkXgmJoZ0gXPsEP5HBpisat5e+4jGoTv1VmM
         vQf6b0VuQWUrd22om1SNna1w2zTl/0klHp8OxA8j+BqSNOOK1N0mvxDEd8dLIKQmYb4Q
         o6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1pr3vE4s/hDCygPHVKmSOsXHVyT0Dcd/BmISwbScu14=;
        b=rOPwA+DFT7C3t44ORyWUeXwng1EYofqi1sDATtQYpk85qG/P/s/lkGhP/MeYYCxvjX
         rmiBUqsXnsFJcHHVCQ+BzSSbiqx7x5gdQKftlXoR1MeztKNn1NLoOD57q2y1btVwI29C
         asOBizRRFv8VLR6KjRu9Y1OzgAUeHhjaHh6DAwpva19sOw2DZKXjrLOVP16T2A6TFIm4
         V2dbmtmLGQsexwPUK/jJ25qrX6rZCYH6c/jIsXtslV4nLhk8wMCJmoNbBlsbAbSmuwek
         d0DnKhyT5AqiC14mEdjZBU8dBpAMJvIdt6RZivuv7TBAC0KFUMpCilSUMWz/ol7HGMGy
         Dk0w==
X-Gm-Message-State: AKwxytck1ny5Ot4c3NWx+eeAwHaYHNbF9BFoLZHMFKz+0VjHyyOVOcfR
        Bui97jCwFydHXPNYqKf6Sm/L3EWf
X-Google-Smtp-Source: AH8x226Rl4P1HQ2oKFKkMpLwqzlPq64dI4WTPTOSZKd5UZoPglMgP+AZtiJbkWzQqEUigeEF5JF5ig==
X-Received: by 10.25.78.155 with SMTP id u27mr25730280lfk.86.1517543705837;
        Thu, 01 Feb 2018 19:55:05 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:05 -0800 (PST)
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
Subject: [PATCH v2 02/15] MIPS: memblock: Surely map BSS kernel memory section
Date:   Fri,  2 Feb 2018 06:54:45 +0300
Message-Id: <20180202035458.30456-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62409
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

The current MIPS code makes sure the kernel code/data/init
sections are in the maps, but BSS should also be there.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1a4d64410303..f502cd702fa7 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
 			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
 			 BOOT_MEM_INIT_RAM);
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
-- 
2.12.0
