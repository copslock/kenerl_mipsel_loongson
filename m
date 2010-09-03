Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2010 02:51:48 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:55615 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491070Ab0ICAvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Sep 2010 02:51:44 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o830pVZt020267;
        Fri, 3 Sep 2010 09:51:34 +0900
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To:     akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        fujita.tomonori@lab.ntt.co.jp, linux-mips@linux-mips.org
Subject: [PATCH -mm 4/8] mips: enable ARCH_DMA_ADDR_T_64BIT with (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
Date:   Fri,  3 Sep 2010 09:49:12 +0900
Message-Id: <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Fri, 03 Sep 2010 09:51:35 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
X-archive-position: 27710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2141

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ad59dd..3e9db47 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -830,6 +830,9 @@ config GPIO_TXX9
 config CFE
 	bool
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
+
 config DMA_COHERENT
 	bool
 
-- 
1.7.1
