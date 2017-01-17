Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:24:56 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:60204 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993901AbdAQPXEH0bwd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:23:04 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lyvjs-1cY3wi2vo0-0149Rl; Tue, 17 Jan 2017 16:21:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] MIPS: octeon: avoid empty-body warning
Date:   Tue, 17 Jan 2017 16:18:45 +0100
Message-Id: <20170117151911.4109452-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:qtMHpH37Zb8aQVMBYla4j1iiwzvSe+Yx77kHSi+6jKhnDcHtckb
 gAccpt1n8HfZOLBuB4TgrEGJ8QDF0iiTBMwfBOxYLrlhcV01ANZ1CsEEtOFAhGjzys9lv/+
 vYiMGln9A8TLiAbrQ6P4R+D3EagCvb0xv5GVoGgcpx2CZXlxfmyyYPaLnrfnxrbcwsH4V9k
 H6R/WS/9AMvEuD0MiUsYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nh8Qxknzg+E=:AGr4XiMQc8B8iS8AdSslv/
 PShlRyxO+ROOgo5KlmW4mfVmjX3jph/x1tTpyAmgRbAM1shivJ6OlaMmsye2TMcSFkYunhS83
 v9ApAM01iwKb9LLwzFj8TZtvlRGvDKvsf9vv3FDXQETnz4TfnwuOeUM1o8WSoVaY2gnjjUsm4
 EikYwhhc8L1Gis5BCQoJpRAXFPqkwfy0lvbOyi2wOo9jzZb3JOz5SVWoyOOUvUGxontXHxlQt
 u5+zxudz7yQEKe1tmWg3BDdWHrxBRCyKNtVKH9vEhofmDxw8t5XuhKyFloMXhbITnqP2+U+8x
 xFKDKiYRAqnOFrq99FfKY9YwQz0xZvh5ku3GjfUNGFGbpZB3xu8CUG859kLOMLyUcKzbBTtPY
 aH96Wys1lBTAZymko4KBj7TDi4V9GcdM/w6Od53y6jUr8TJDaZvAfpZMrhAkbyYRVk3AwtpPs
 JHm+KAwx9+kDzYKWJQXryONP6L3C6KY0Jk4RT5Ow0KpwwyK9rs6pWyDLV7On518wBdd8M79nE
 7H1bglyL/M1MTHj84hhWQo+IsNtxQM47hOHSCNiw15OU0OyUZE+Lm5Oa1IkyBb7A3PT8w0BDK
 9NGd53AD9a88oBY2xxFpFxl/y5vUl2PpW2n8qgcO2o19SZohVqC2JWd6ksXmCByh/LJW7EiUc
 LFYO196NNWeeX3+jhr7DL+96+hAGRE8pmSeWRM5MY1OmrFFb3uikjmwVWxR38jlnH2EA=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

gcc-6 reports a harmless build warning:

arch/mips/cavium-octeon/dma-octeon.c: In function 'octeon_dma_alloc_coherent':
arch/mips/cavium-octeon/dma-octeon.c:179:3: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]

We can fix this by rearranging the code slightly using the
IS_ENABLED() macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/cavium-octeon/dma-octeon.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index fd69528b24fb..1226965e1e4f 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -164,19 +164,14 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-#ifdef CONFIG_ZONE_DMA
-	if (dev == NULL)
+	if (IS_ENABLED(CONFIG_ZONE_DMA) && dev == NULL)
 		gfp |= __GFP_DMA;
-	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
+	else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
+		 dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		gfp |= __GFP_DMA;
-	else
-#endif
-#ifdef CONFIG_ZONE_DMA32
-	     if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
+	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+		 dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
-	else
-#endif
-		;
 
 	/* Don't invoke OOM killer */
 	gfp |= __GFP_NORETRY;
-- 
2.9.0
