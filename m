Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:45:08 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56241 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012252AbbHNRnLugpq1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:43:11 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8EB38E6;
        Fri, 14 Aug 2015 17:43:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Jonas Gorski <jogo@openwrt.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org, blogic@openwrt.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 08/84] Revert "MIPS: BCM63xx: Provide a plat_post_dma_flush hook"
Date:   Fri, 14 Aug 2015 10:41:36 -0700
Message-Id: <20150814174210.465331482@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 247bfb65d731350093f5d1a0a8b3d65e49c17baa upstream.

This reverts commit 3cf29543413207d3ab1c3f62a88c09bb46f2264e ("MIPS:
BCM63xx: Provide a plat_post_dma_flush hook") since this commit was
found to prevent BCM6358 (early BMIPS4350 cores) and some BCM6368
(BMIPS4380 cores) from booting reliably.

Alvaro was able to track this down to an issue specifically located to
devices that use the second thread (TP1) when booting. Since BCM63xx did
not have a need for plat_post_dma_flush() hook before, let's just keep
things the way they were.

Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reported-by: Jonas Gorski <jogo@openwrt.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org
Cc: blogic@openwrt.org
Cc: noltari@gmail.com
Cc: jogo@openwrt.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10804/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h |   10 ----------
 1 file changed, 10 deletions(-)

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
