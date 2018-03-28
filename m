Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 17:38:31 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:44206 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993928AbeC1PiXgWnpX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 17:38:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Date:   Wed, 28 Mar 2018 17:38:12 +0200
Message-Id: <20180328153812.2592-1-paul@crapouillou.net>
In-Reply-To: <20180305170704.17073-1-paul@crapouillou.net>
References: <20180305170704.17073-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1522251502; bh=igdVHABaT49F8HsCpWv/UGOXBFK7fQgHOiORRIbUc0I=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LN20EwIUVO972jPFERm1wFYKyNsuB0KkXxovLv/NS+U3nGm24AcOZU2/Q4is2BqTwLnxhAXgx16VkRCHobkj5EjvWGH5zPfc5CIIQmvbRGDIijm+Bv6KccVFrPD66t6CA1cJp8vEwZkE0SJzBClVdvwrr1FAQASTMunt3nFNF40=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The debug definitions were missing for MACH_JZ4770, resulting in a build
failure when DEBUG_ZBOOT was set.

Since the UART addresses are the same across all Ingenic SoCs, we just
use a #ifdef CONFIG_MACH_INGENIC instead of checking for individual
Ingenic SoCs.

Additionally, I added a #define for the UART0 address in-code and dropped
the <asm/mach-jz4740/base.h> include, for the reason that this include
file is slowly being phased out as the whole platform is being moved to
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/compressed/uart-16550.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index b3043c08f769..aee8d7b8f091 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -18,9 +18,9 @@
 #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
 #endif
 
-#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
-#include <asm/mach-jz4740/base.h>
-#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
+#ifdef CONFIG_MACH_INGENIC
+#define INGENIC_UART0_BASE_ADDR	0x10030000
+#define PORT(offset) (CKSEG1ADDR(INGENIC_UART0_BASE_ADDR) + (4 * offset))
 #endif
 
 #ifdef CONFIG_CPU_XLR
-- 
2.11.0
