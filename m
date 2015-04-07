Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 22:36:04 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33102 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014477AbbDGUfJJe9hu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 22:35:09 +0200
Received: by paboj16 with SMTP id oj16so90377209pab.0;
        Tue, 07 Apr 2015 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k3pu+2IPO5S/ISgCN0lA+fy37NL/y0uzdFzRnatTcVw=;
        b=yisHExPRiculgRLlVyjyjLW4vuk39uTD2KMCl/eeloTlAOXzIKyWnvtRjcWm6v0Hk9
         78DTN95S2VxPc91FnEbbVWiXYNG/dJCRrEpVrpKHYDPXjA1IJUdQkB37BPSVVN0W/YR5
         xIxbutsUe3p/bnxGdO9hl3QUUU4qWVLsKXht+ttOU0W4zBg9YKpD6W5S7IOJhp/ZPIzY
         fHB+SzrxnC0SnjcotjkPOxdrFyf6287STopyo5Jd3wDP15xEzXm5ymLY2XfeMihV+ySk
         qGiAeJsXtIr6tkptI2tQZ82Tfdph8kkUZiw/dIk5VdDiL7acYhBpzK0Cc+rCnyco1B0p
         64PA==
X-Received: by 10.68.136.66 with SMTP id py2mr39807907pbb.29.1428438904751;
        Tue, 07 Apr 2015 13:35:04 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ve3sm8856029pbc.22.2015.04.07.13.35.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 13:35:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/3] MIPS: BCM63xx: Provide a plat_post_dma_flush hook
Date:   Tue,  7 Apr 2015 13:34:02 -0700
Message-Id: <1428438842-5728-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
References: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46820
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

Broadcom BCM63xx DSL SoCs utilize BMIPS CPUs, and as such are required
to perform a read-ahead cache flush after a DMA transfer. Utilize
asm/bmips.h to provide a plat_post_dma_flush_hook, and
mach-generic/dma-coherence.h for everything else.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h

diff --git a/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
new file mode 100644
index 000000000000..11d3b572b1b3
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
@@ -0,0 +1,10 @@
+#ifndef __ASM_MACH_BCM63XX_DMA_COHERENCE_H
+#define __ASM_MACH_BCM63XX_DMA_COHERENCE_H
+
+#include <asm/bmips.h>
+
+#define plat_post_dma_flush	bmips_post_dma_flush
+
+#include <asm/mach-generic/dma-coherence.h>
+
+#endif /* __ASM_MACH_BCM63XX_DMA_COHERENCE_H */
-- 
2.1.0
