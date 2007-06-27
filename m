Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 14:31:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:37335 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022368AbXF0Nba (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2007 14:31:30 +0100
Received: from localhost (p3155-ipad11funabasi.chiba.ocn.ne.jp [219.162.38.155])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 31F6AA5B4; Wed, 27 Jun 2007 22:31:27 +0900 (JST)
Date:	Wed, 27 Jun 2007 22:32:11 +0900 (JST)
Message-Id: <20070627.223211.59651242.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	mlachwani@mvista.com, vagabon.xyz@gmail.com
Subject: Re: [PATCH 2/4] rbtx4938: Convert SPI codes to use generic SPI
 drivers
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070624205444.GC5814@linux-mips.org>
References: <20070622.232206.88704003.anemo@mba.ocn.ne.jp>
	<20070624205444.GC5814@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 24 Jun 2007 22:54:44 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Use rtc-rs5c348 and at25 spi protocol driver and spi_txx9 spi
> > controller driver instead of platform dependent codes.
> > 
> > This patch also removes dependencies to old RTC interfaces such as
> > rtc_mips_get_time, etc.
> 
> Queued also,

Please queue this (or fold this into the patch) too.


Subject: [PATCH] rbtx4938: Provide minimum CLK API implementation

Do not abuse resource framework to pass "baseclk" to txx9spi driver.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |   37 +++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 330ee43..361d89a 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <asm/wbflush.h>
 #include <asm/reboot.h>
@@ -1121,10 +1122,6 @@ static void __init txx9_spi_init(unsigned long base, int irq)
 		}, {
 			.start	= irq,
 			.flags	= IORESOURCE_IRQ,
-		}, {
-			.name	= "baseclk",
-			.start	= txx9_gbus_clock / 2 / 4,
-			.flags	= IORESOURCE_IRQ,
 		},
 	};
 	platform_device_register_simple("txx9spi", 0,
@@ -1149,3 +1146,35 @@ static int __init rbtx4938_spi_init(void)
 	return 0;
 }
 arch_initcall(rbtx4938_spi_init);
+
+/* Minimum CLK support */
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	if (!strcmp(id, "spi-baseclk"))
+		return (struct clk *)(txx9_gbus_clock / 2 / 4);
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
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
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
