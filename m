Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2016 11:52:33 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33883 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27037191AbcE1JwQ4Pac- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2016 11:52:16 +0200
Received: by mail-pa0-f65.google.com with SMTP id yl2so15495497pac.1;
        Sat, 28 May 2016 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HVpwT1GOwwJ3CWryzZC5MPcbr/UxFkGPaGHT9cXNfh8=;
        b=WKUAub7D+G8X2Ge1u6n3iCMJDRsMX78gDfqJDlwwibo7HLReCph88w/a6WZAsyt+kZ
         y4wFcATHHDsC0mwkOInc90FVTuuuX+rKFGd/FC6UJq7mjG1FSBMVKf1NVtHkw+78atCY
         sSLsgw49KDeDXVzPQsxJK93b/gHyObNzqbvtQuP1uOkmS659oXVGvr2PEn/n3JkjQN85
         1MrjkTrdb79rAt7mLyy/LHxuYLgoNBORein6rLytzjJRwa1aJxeDe8mZCTRgC7qMDjsG
         w8pk78aiSDiFzaOZvffOfvh3aIOaDIQIkmcoZ3nsvdkyrp4cuBADlbiRd9PgGks5W616
         KTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HVpwT1GOwwJ3CWryzZC5MPcbr/UxFkGPaGHT9cXNfh8=;
        b=RkPK1s+yafyRXGKx2249LdWa1xaTKYf2oUnX1+KzF2dtKQnfpWUOCMPNYxPT4EDzQ9
         QX2//9BbKp9C7xLd8XL4+V+tlo15+2qbbwunKiNROhjdr5BmBJ/eGBAR6wfP+S1WosUq
         9Mr7nJFD4AXARWJGb8UIC7Dj/TX1k04TEHKj6KqiaxlUhK50E4YQ1+D2oDXsOztQRk8Q
         jISYEioV0v0wkgHqCBhVzj1VJyyaa13BPZeP0JUamcH6tnuP4Wzuk9bgAOfA/9r4HC3c
         l2Xb5eDBFTKkGYmdgd9zcaFu4JiB4A4m+7aRq2J0fkav4ImizonW28Z0USM1NcM1duLC
         sgvA==
X-Gm-Message-State: ALyK8tIKkR/w/EpRAgBm3TJzCSf2lhx2ZMP6gpdrd7cGPHKcuuZ+zEC1Vt+8MU1oiD1RhA==
X-Received: by 10.66.43.51 with SMTP id t19mr29559954pal.48.1464429131141;
        Sat, 28 May 2016 02:52:11 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m64sm19539935pfc.19.2016.05.28.02.52.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2016 02:52:10 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson1B: Provide DMA filter callbacks via platform data
Date:   Sat, 28 May 2016 17:51:52 +0800
Message-Id: <1464429112-27590-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1464429112-27590-1-git-send-email-keguang.zhang@gmail.com>
References: <1464429112-27590-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch provides DMA filter callbacks via platform data
to make NAND driver independent of single DMA engine driver.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/dma.h  | 4 ++++
 arch/mips/include/asm/mach-loongson32/nand.h | 3 +--
 arch/mips/loongson32/ls1b/board.c            | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
index ad1dec7..d3ae391 100644
--- a/arch/mips/include/asm/mach-loongson32/dma.h
+++ b/arch/mips/include/asm/mach-loongson32/dma.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_MACH_LOONGSON32_DMA_H
 #define __ASM_MACH_LOONGSON32_DMA_H
 
+#include <linux/dmaengine.h>
+
 #define LS1X_DMA_CHANNEL0	0
 #define LS1X_DMA_CHANNEL1	1
 #define LS1X_DMA_CHANNEL2	2
@@ -22,4 +24,6 @@ struct plat_ls1x_dma {
 
 extern struct plat_ls1x_dma ls1b_dma_pdata;
 
+bool ls1x_dma_filter(struct dma_chan *chan, void *param);
+
 #endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
index e274912..a1f8704 100644
--- a/arch/mips/include/asm/mach-loongson32/nand.h
+++ b/arch/mips/include/asm/mach-loongson32/nand.h
@@ -21,10 +21,9 @@ struct plat_ls1x_nand {
 
 	int hold_cycle;
 	int wait_cycle;
+	bool (*dma_filter)(struct dma_chan *chan, void *param);
 };
 
 extern struct plat_ls1x_nand ls1b_nand_pdata;
 
-bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
-
 #endif /* __ASM_MACH_LOONGSON32_NAND_H */
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 38a1d40..0a57337 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -38,6 +38,7 @@ struct plat_ls1x_nand ls1x_nand_pdata = {
 	.nr_parts	= ARRAY_SIZE(ls1x_nand_parts),
 	.hold_cycle	= 0x2,
 	.wait_cycle	= 0xc,
+	.dma_filter	= ls1x_dma_filter,
 };
 
 static const struct gpio_led ls1x_gpio_leds[] __initconst = {
-- 
1.9.1
