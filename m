Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:26:58 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:41436
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994703AbeAQWXfh4AnS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:35 +0100
Received: by mail-lf0-x241.google.com with SMTP id f136so2530319lff.8;
        Wed, 17 Jan 2018 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qBQhHKuMEOnhN1ts3drUK/+lIT8zA1haRhS3+VY3DGA=;
        b=imG8EwduiByBhT956GAhR7aEdryy/2QsYW6JPjazhe9mdp4bto0HwprcubORGK3chG
         oumaE0JBSdsHiS7/ecdEOrM9NQkuQf6RklgLYmXSR34w8UCmeL0e2pIAZZSBuCvyeH/r
         pTsgEZ6s/YzJeZVcRlzYWAHID5NJXbTxs3uxk8xeVGpFtpJz+hZvj93BanJ6JEwtLGRU
         u+E0cBMkQf1qKOLaotLDxtCgzpNUo6S7TCcjey03x+jkYk6k4q8E8Cb7UmjJGWNcn/61
         7jykckd3RI9akeE+hW4ETtpSoifvPtsJOR3IuCDzprwICAZbS6iCV67icatr8c7DtWwq
         w1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qBQhHKuMEOnhN1ts3drUK/+lIT8zA1haRhS3+VY3DGA=;
        b=l94lG2ePVIZ5XPUxqlU3dEFEEynaECmziqKxvQc01IFQ33YjoONxlm9VmIEGMn5cWb
         UsujdyDI4QhUugF3xmOM3DTpqHbSLAlWmJBExWDX9c6JSAdnb6Z3c9iRESUlUWFLerP3
         SMm3shNfRxTe4A4xXvYJBsUzygP+4LLJ3DUGPanNBBk/3sIARAg/x2I3BBKOMom5YmvC
         0oT8MW/mco6TubqHU4vJ+mKoSVT37kBwqH16rGG0Q7ZGhiSH9FdOHmXngNghc5x84sws
         XrM1+F7HsJWlAIOEWxJXZH+2R5nPh1bUTzxl88ZI3b/TIHWU0iU9sIXxG984tip0byJs
         6LDA==
X-Gm-Message-State: AKGB3mKj+P2Eiv0U5BlvbtjAjsqO9TYbcbm6A51q7OrhkcC3/XzSRQsU
        4nZ3bU89b60pAr/RiLX8Ojojnbr9
X-Google-Smtp-Source: ACJfBouq1nYJtgkWk7shS8mTFTiEeWl/Md9c2cFNN+V6HoIgALmrnwnM9/YM29L2RxxaRagUgU9SLg==
X-Received: by 10.46.60.22 with SMTP id j22mr27968751lja.111.1516227809873;
        Wed, 17 Jan 2018 14:23:29 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:29 -0800 (PST)
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
Subject: [PATCH 08/14] MIPS: memblock: Simplify DMA contiguous reservation
Date:   Thu, 18 Jan 2018 01:23:06 +0300
Message-Id: <20180117222312.14763-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62219
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

CMA reserves it areas in the memblock allocator. Since we aren't
using bootmem anymore, the reservations copying should be discarded.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 6df1eaf38..e0ca0d2bc 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -869,10 +869,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-	/* Tell bootmem about cma reserved memblock section */
-	for_each_memblock(reserved, reg)
-		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
 }
 
 static void __init resource_init(void)
-- 
2.12.0
