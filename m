Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 08:44:52 +0200 (CEST)
Received: from mo11.iij4u.or.jp ([210.138.174.79]:52697 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903745Ab2HAGnd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2012 08:43:33 +0200
Received: by mo.iij4u.or.jp (mo11) id q716hVxN031066; Wed, 1 Aug 2012 15:43:31 +0900
Received: from delta (UQ1-221-171-15-92.tky.mesh.ad.jp [221.171.15.92])
        by mbox.iij4u.or.jp (mbox10) id q716hTUj030358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 1 Aug 2012 15:43:30 +0900
Date:   Wed, 1 Aug 2012 15:42:16 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 4/4] MIPS: loongson1: more clk support and add select
 HAVE_CLK
Message-Id: <20120801154216.294110ab8af9f733752e85f3@linux-mips.org>
In-Reply-To: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
References: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34010
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

arch/mips/loongson1/common/clock.c:23:13: error: redefinition of 'clk_get'
include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
arch/mips/loongson1/common/clock.c:41:15: error: redefinition of 'clk_get_rate'
include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was here
make[3]: *** [arch/mips/loongson1/common/clock.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/loongson1/Kconfig        |    1 +
 arch/mips/loongson1/common/clock.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
index 237fa21..a9a14d6 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson1/Kconfig
@@ -15,6 +15,7 @@ config LOONGSON1_LS1B
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_HAS_EARLY_PRINTK
+	select HAVE_CLK
 
 endchoice
 
diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/common/clock.c
index 2d98fb0..1bbbbec 100644
--- a/arch/mips/loongson1/common/clock.c
+++ b/arch/mips/loongson1/common/clock.c
@@ -38,12 +38,28 @@ struct clk *clk_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL(clk_get);
 
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	return clk->rate;
 }
 EXPORT_SYMBOL(clk_get_rate);
 
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
+
 static void pll_clk_init(struct clk *clk)
 {
 	u32 pll;
-- 
1.7.0.4
