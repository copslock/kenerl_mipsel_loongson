Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:01:47 +0200 (CEST)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34089 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031005AbcEUMA2asGpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:28 +0200
Received: by mail-lf0-f68.google.com with SMTP id 65so24063lfq.1;
        Sat, 21 May 2016 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=E90LepMdA8CbZsSpqlEij3B372D6juwoWMKbDWC4S/Q=;
        b=bIyJIaq2+FDO3VxtGw6pF4V4n+z1orfZaQnvmpTGh/ovbCcr7tVTJ5ko1ckKsFVIxh
         nB3zz+IGNQ+fx6S82ESlEezNJC51aFgl6hwK43O5aSNrARBNc4ou3Tv2B3LJF72QbzjJ
         2Am0AGJI5wBAHsC+nEgIB73xP3dthBcqq6ZkIDyDr53BweLNzXF5WGIEwhS8FkhpAX2v
         b/UoLTTH1XFmhxedWPyLtmi5UGOZ6vTx7pqV2BeV3iLw5ewetJJbRfxFd/tTa3r1J1pQ
         yxMuqQngflz57PRUaSQ1nadACN9wqsBzyOYMG54pTyXbddW285yTlTV3O+R5LoGSANt7
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=E90LepMdA8CbZsSpqlEij3B372D6juwoWMKbDWC4S/Q=;
        b=SWQY4GD7RBTlzFdtsYd2NopEqQWsfS638d/D+Q1iRVQt7L6h80TCvMmUNcTN6+rFhF
         NE1OyQM682P8w/cvDP1x2CGjYI236+w7N0muJtp41LAd2gA2ZX4bokF2dKy/s0xsSzQM
         /TFo+HDhRSiCT4JTrCLRhc9vv8RCC2bR9mNcKbayYZE0Q8c3Q3XAxvubuH9c0pdFgEna
         nXWH/HJMzhp/Ws3gqfoAJCMoXYJFEVc+NPH8ktJyiEGq7qHmrbyGcQz26DlI7BBttXUU
         N9rkszb+aiZUtNUTQLNPHS9rNsbmVbepjdkSboWXvBrDxX+wf6LktC9IvIebVBplKkj/
         Nbdw==
X-Gm-Message-State: AOPr4FXb7pVos8JUSdNJXzB3yTew2G1hh2QhwdFL0YZfs1pVzLLX1ODLZiF3kIxt/tfjnQ==
X-Received: by 10.25.148.16 with SMTP id w16mr2693201lfd.40.1463832023199;
        Sat, 21 May 2016 05:00:23 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id p67sm4136600lfp.49.2016.05.21.05.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:22 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0185/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:18 +0200
Message-Id: <20160521120018.9496-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/include/asm/mach-ip32/dma-coherence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-ip32/dma-coherence.h b/arch/mips/include/asm/mach-ip32/dma-coherence.h
index 0a0b0e2..7bdf212 100644
--- a/arch/mips/include/asm/mach-ip32/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ip32/dma-coherence.h
@@ -86,7 +86,7 @@ static inline void plat_post_dma_flush(struct device *dev)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-	return 0;		/* IP32 is non-cohernet */
+	return 0;		/* IP32 is non-coherent */
 }
 
 #endif /* __ASM_MACH_IP32_DMA_COHERENCE_H */
-- 
2.8.2.534.g1f66975
