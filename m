Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 08:44:03 +0200 (CEST)
Received: from mo11.iij4u.or.jp ([210.138.174.79]:52686 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903704Ab2HAGn3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2012 08:43:29 +0200
Received: by mo.iij4u.or.jp (mo11) id q716hPcp030948; Wed, 1 Aug 2012 15:43:25 +0900
Received: from delta (UQ1-221-171-15-92.tky.mesh.ad.jp [221.171.15.92])
        by mbox.iij4u.or.jp (mbox10) id q716hMKL030294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 1 Aug 2012 15:43:25 +0900
Date:   Wed, 1 Aug 2012 15:39:52 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS: BCM63xx: add select HAVE_CLK
Message-Id: <20120801153952.336f941fa29904099392fc4f@linux-mips.org>
In-Reply-To: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
References: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34008
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

arch/mips/bcm63xx/clk.c:249:5: error: redefinition of 'clk_enable'
include/linux/clk.h:295:19: note: previous definition of 'clk_enable' was here
arch/mips/bcm63xx/clk.c:259:6: error: redefinition of 'clk_disable'
include/linux/clk.h:300:20: note: previous definition of 'clk_disable' was here
arch/mips/bcm63xx/clk.c:268:15: error: redefinition of 'clk_get_rate'
include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was here
arch/mips/bcm63xx/clk.c:275:13: error: redefinition of 'clk_get'
include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
arch/mips/bcm63xx/clk.c:302:6: error: redefinition of 'clk_put'
include/linux/clk.h:291:20: note: previous definition of 'clk_put' was here
make[2]: *** [arch/mips/bcm63xx/clk.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 50fc7a1..1778430 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -126,6 +126,7 @@ config BCM63XX
 	select SYS_HAS_EARLY_PRINTK
 	select SWAP_IO_SPACE
 	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_CLK
 	help
 	 Support for BCM63XX based boards
 
-- 
1.7.0.4
