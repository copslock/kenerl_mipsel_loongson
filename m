Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 17:05:27 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45375 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823084Ab2KVQF0GeLy5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2012 17:05:26 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi1so2831333pad.36
        for <multiple recipients>; Thu, 22 Nov 2012 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XHe+myv199nhaMRYHGC34KsZUo4NJvcad2J8XxBd1Fk=;
        b=F7lFRBzFIWHa8CDYp6GDxM7TV5QHhNqZ9OCPyuZ+FodoMHvKszm5//G08jtbZSJalm
         fFrUSU3lzNr3zY2evJe+z7rDE2PpLlyfy8Pnz+imgmVjJJUn9brOteuEk8dHsVrf4cNy
         2aw5ucBvq5stVrvCyZ/f5ciMSz3vF14S70QjGvKL9X3NltkOJjDJgAxyFtjo58612/Aq
         oJzmJr7gr/Uq6oVDY379lRQplXrZrWr0KsuYFsxMWqq1NhX0LzBmeBaeWCljZdy1BqUR
         bNL3H7KrRL3GYo1ex/IoZexBmzYHQSjhyhuAJ+jLWgGAbSvJKgUCDyHa2OHj9OEK9oBs
         b8Vw==
Received: by 10.68.191.10 with SMTP id gu10mr5849732pbc.115.1353600319132;
        Thu, 22 Nov 2012 08:05:19 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by mx.google.com with ESMTPS id g1sm2110536pax.21.2012.11.22.08.05.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 08:05:18 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id 43F15204E4; Fri, 23 Nov 2012 01:05:15 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org, trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] mips: lantiq: Fix typo endianess in dma.c
Date:   Fri, 23 Nov 2012 01:05:13 +0900
Message-Id: <1353600313-11983-1-git-send-email-standby24x7@gmail.com>
X-Mailer: git-send-email 1.8.0.273.g2d242fb
X-archive-position: 35096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: standby24x7@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Correct spelling typo ENDIANESS to ENDIANNESS in
arc/mips/lantiq/xway/dma.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/mips/lantiq/xway/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 55d2c4f..0f7228d 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -48,7 +48,7 @@
 #define DMA_CLK_DIV4		BIT(6)		/* polling clock divider */
 #define DMA_2W_BURST		BIT(1)		/* 2 word burst length */
 #define DMA_MAX_CHANNEL		20		/* the soc has 20 channels */
-#define DMA_ETOP_ENDIANESS	(0xf << 8) /* endianess swap etop channels */
+#define DMA_ETOP_ENDIANNESS	(0xf << 8) /* endianness swap etop channels */
 #define DMA_WEIGHT	(BIT(17) | BIT(16))	/* default channel wheight */
 
 #define ltq_dma_r32(x)			ltq_r32(ltq_dma_membase + (x))
@@ -191,10 +191,10 @@ ltq_dma_init_port(int p)
 	switch (p) {
 	case DMA_PORT_ETOP:
 		/*
-		 * Tell the DMA engine to swap the endianess of data frames and
+		 * Tell the DMA engine to swap the endianness of data frames and
 		 * drop packets if the channel arbitration fails.
 		 */
-		ltq_dma_w32_mask(0, DMA_ETOP_ENDIANESS | DMA_PDEN,
+		ltq_dma_w32_mask(0, DMA_ETOP_ENDIANNESS | DMA_PDEN,
 			LTQ_DMA_PCTRL);
 		break;
 
-- 
1.8.0.273.g2d242fb
