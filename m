Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2015 04:24:49 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36645 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006783AbbG2CYpN5xbl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jul 2015 04:24:45 +0200
Received: by obnw1 with SMTP id w1so98529187obn.3;
        Tue, 28 Jul 2015 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=c2sk8rcU2ZIo12uw1iG8r/SJgTXDLCl/ee7JwcJ0Nkc=;
        b=sQskVqcGHiASloqESHnZp+P/KZyyO8mabLK3WEaZlEjLKko+FEI5qcK512yvskAhxr
         w3KiLyqaqmiD5nWXD5rvjolQNcdjENSmP0f3oT9d+Ndx2Pqg6kHDWxt8px0L2fTQ3k8X
         56EnzQc/U+VW4RLN336L4Bs35tNNSiLSIYcbfQzwV4sh+GfeZq+gGWI3zgzSGkPQykAT
         ogLS0s2tMu3aFaVbHWxH0BlHp1Kyi2OV+z5MODXPbXAqCbPI5CYzHY3s+xQbdgn04Bw+
         P2MgWeAWDvyJJjBrZwQlGeiBehKcPGqW2tXSY+jbQbDnO6NJHupE56nrRktF+bVzBFs3
         kcdw==
X-Received: by 10.60.178.99 with SMTP id cx3mr39062734oec.50.1438136679175;
        Tue, 28 Jul 2015 19:24:39 -0700 (PDT)
Received: from bender.lan (ip68-96-94-194.oc.oc.cox.net. [68.96.94.194])
        by smtp.gmail.com with ESMTPSA id s185sm13594484oia.21.2015.07.28.19.24.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 19:24:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, noltari@gmail.com,
        jogo@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>,
        stable@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH] Revert "MIPS: BCM63xx: Provide a plat_post_dma_flush hook"
Date:   Tue, 28 Jul 2015 19:24:24 -0700
Message-Id: <1438136664-775-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

This reverts commit 3cf29543413207d3ab1c3f62a88c09bb46f2264e ("MIPS:
BCM63xx: Provide a plat_post_dma_flush hook") since this commit was
found to prevent BCM6358 (early BMIPS4350 cores) and some BCM6368
(BMIPS4380 cores) from booting reliably.

Alvaro was able to track this down to an issue specifically located to
devices that use the second thread (TP1) when booting. Since BCM63xx did
not have a need for plat_post_dma_flush() hook before, let's just keep
things the way they were.

CC: stable@vger.kernel.org
CC: Kevin Cernekee <cernekee@gmail.com>
CC: Nicolas Schichan <nschichan@freebox.fr>
Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reported-by: Jonas Gorski <jogo@openwrt.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h

diff --git a/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
deleted file mode 100644
index 11d3b572b1b3..000000000000
--- a/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __ASM_MACH_BCM63XX_DMA_COHERENCE_H
-#define __ASM_MACH_BCM63XX_DMA_COHERENCE_H
-
-#include <asm/bmips.h>
-
-#define plat_post_dma_flush	bmips_post_dma_flush
-
-#include <asm/mach-generic/dma-coherence.h>
-
-#endif /* __ASM_MACH_BCM63XX_DMA_COHERENCE_H */
-- 
2.1.4
