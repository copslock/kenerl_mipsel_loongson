Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2015 04:41:55 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35526 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009001AbbDCClTuGZc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Apr 2015 04:41:19 +0200
Received: by pddn5 with SMTP id n5so107817581pdd.2;
        Thu, 02 Apr 2015 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UrTNACSOQZIgPdV4gWj3xQsR0NMMlq+eTA0lrSVXzLA=;
        b=wr+l4Pb1Sqtwwx3gL6AxXYFLKRiMN2B5fwbVpE0TRg9+jt4Xcb0pUGhI8AbxxpnCQ3
         OMAOpPQQrpWx22GTNljyPK1fP87EgFgz9+kYqwq5UYznmw1SncP3FdD0speW59roX2Aj
         o2aDHlF98ROyQmUvpF/eUgu0CId85uH2OAF/1JX+OchB3CWpDhj8oMMUr4dYkqjWv2ip
         iTBOR6/BtstxFh7RyaQJEWABIjAZCIFiIKhicJW+eAF6Ot8bO+eM77fsyZjdQ92cXQms
         WwXfzYoSk3PRldra4qE5gT7EmBtYFNxwTUmZxssDdPBfxkfbHyxiI/piSflbytLEFs5T
         zN9g==
X-Received: by 10.66.240.228 with SMTP id wd4mr564017pac.80.1428028875314;
        Thu, 02 Apr 2015 19:41:15 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id fk4sm6492867pbb.80.2015.04.02.19.41.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 19:41:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        mbizon@freebox.fr, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM63xx: Utilize bmips-dma-coherence.h
Date:   Thu,  2 Apr 2015 19:40:19 -0700
Message-Id: <1428028819-28236-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1428028819-28236-1-git-send-email-f.fainelli@gmail.com>
References: <1428028819-28236-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46713
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

Create a dma-coherence.h file to make sure that we do get a
plat_post_dma_flush() implementation since BCM63xx is using BMIPS CPUs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h

diff --git a/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
new file mode 100644
index 000000000000..932b2b38bbdf
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/dma-coherence.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_BCM63XX_DMA_COHERENCE_H
+#define __ASM_MACH_BCM63XX_DMA_COHERENCE_H
+
+#include <asm/bmips-dma-coherence.h>
+
+#endif /* __ASM_MACH_BCM63XX_DMA_COHERENCE_H */
-- 
2.1.0
