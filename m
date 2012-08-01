Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 08:43:37 +0200 (CEST)
Received: from mo10.iij4u.or.jp ([210.138.174.78]:40592 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903693Ab2HAGn0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2012 08:43:26 +0200
Received: by mo.iij4u.or.jp (mo10) id q716hMvq016957; Wed, 1 Aug 2012 15:43:22 +0900
Received: from delta (UQ1-221-171-15-92.tky.mesh.ad.jp [221.171.15.92])
        by mbox.iij4u.or.jp (mbox10) id q716hHJ1030252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 1 Aug 2012 15:43:21 +0900
Date:   Wed, 1 Aug 2012 15:38:00 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 1/4] MIPS: AR7: add select HAVE_CLK
Message-Id: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

fix redefinition of clk_*

arch/mips/ar7/clock.c:420:5: error: redefinition of 'clk_enable'
include/linux/clk.h:295:19: note: previous definition of 'clk_enable' was here
arch/mips/ar7/clock.c:426:6: error: redefinition of 'clk_disable'
include/linux/clk.h:300:20: note: previous definition of 'clk_disable' was here
arch/mips/ar7/clock.c:431:15: error: redefinition of 'clk_get_rate'
include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was here
arch/mips/ar7/clock.c:437:13: error: redefinition of 'clk_get'
include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
arch/mips/ar7/clock.c:454:6: error: redefinition of 'clk_put'
include/linux/clk.h:291:20: note: previous definition of 'clk_put' was here
make[2]: *** [arch/mips/ar7/clock.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7e78a83..50fc7a1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -78,6 +78,7 @@ config AR7
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select ARCH_REQUIRE_GPIOLIB
 	select VLYNQ
+	select HAVE_CLK
 	help
 	  Support for the Texas Instruments AR7 System-on-a-Chip
 	  family: TNETD7100, 7200 and 7300.
-- 
1.7.0.4
