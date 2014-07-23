Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:42:22 +0200 (CEST)
Received: from mail-we0-f181.google.com ([74.125.82.181]:47258 "EHLO
        mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842532AbaGWOh1rJNdN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:27 +0200
Received: by mail-we0-f181.google.com with SMTP id k48so1315043wev.40
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUbgd0L5mHol10lJnL4Muh6KN+eWckr4nDFioYur460=;
        b=sTQZ4eP242qPxYvhUhTY9qHAxD8Q6wKINK19RwykmXq2elmVjBjh3KEchEGB2nZ+Hp
         M1zVt6g+D5EHTJDRxlO7kL/7HCBOFhPhGhgJeenuJsHwPlhju6AN66ICJMn1IrC0Xb00
         9EjOCj7I+PUmRovNmj2/CZ5Fqhi3w1X9MIewWlEryy73fZp55jpXLPNz3uB5fXm2SeBI
         m2CX5SR7rHXViYaiJHg7PhtqSo8Xv52C/n5EQrtBwbE6wy0KM6kXIfDaJX+E0SG0dPfn
         koG6dj1bFxCxYnMU05Weg0cqhhm/3M4MxFyXjW/XuHxCX2vko1R0zIgL6h25NzecK1cT
         dIsg==
X-Received: by 10.194.103.38 with SMTP id ft6mr2621426wjb.18.1406126239602;
        Wed, 23 Jul 2014 07:37:19 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:18 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 05/10] MIPS: Alchemy: db1x00: use clk framework
Date:   Wed, 23 Jul 2014 16:36:52 +0200
Message-Id: <1406126217-471265-6-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Make use of the clk framework to set up and enable all PSC clocks.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200.c | 50 ++++++++++++++++++------------------
 arch/mips/alchemy/devboards/db1300.c |  7 +++++
 arch/mips/alchemy/devboards/db1550.c | 13 ++++++++++
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 5ccfd83..7761889 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -129,7 +130,6 @@ static int __init db1200_detect_board(void)
 
 int __init db1200_board_setup(void)
 {
-	unsigned long freq0, clksrc, div, pfc;
 	unsigned short whoami;
 
 	if (db1200_detect_board())
@@ -149,30 +149,6 @@ int __init db1200_board_setup(void)
 		"  Board-ID %d	Daughtercard ID %d\n", get_system_type(),
 		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
 
-	/* SMBus/SPI on PSC0, Audio on PSC1 */
-	pfc = alchemy_rdsys(AU1000_SYS_PINFUNC);
-	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
-	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
-	pfc |= SYS_PINFUNC_P1C; /* SPI is configured later */
-	alchemy_wrsys(pfc, AU1000_SYS_PINFUNC);
-
-	/* Clock configurations: PSC0: ~50MHz via Clkgen0, derived from
-	 * CPU clock; all other clock generators off/unused.
-	 */
-	div = (get_au1x00_speed() + 25000000) / 50000000;
-	if (div & 1)
-		div++;
-	div = ((div >> 1) - 1) & 0xff;
-
-	freq0 = div << SYS_FC_FRDIV0_BIT;
-	alchemy_wrsys(freq0, AU1000_SYS_FREQCTRL0);
-	freq0 |= SYS_FC_FE0;	/* enable F0 */
-	alchemy_wrsys(freq0, AU1000_SYS_FREQCTRL0);
-
-	/* psc0_intclk comes 1:1 from F0 */
-	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
-	alchemy_wrsys(clksrc, AU1000_SYS_CLKSRC);
-
 	return 0;
 }
 
@@ -843,6 +819,7 @@ int __init db1200_dev_setup(void)
 	unsigned long pfc;
 	unsigned short sw;
 	int swapped, bid;
+	struct clk *c;
 
 	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
 	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
@@ -855,6 +832,24 @@ int __init db1200_dev_setup(void)
 	irq_set_irq_type(AU1200_GPIO7_INT, IRQ_TYPE_LEVEL_LOW);
 	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
 
+	/* SMBus/SPI on PSC0, Audio on PSC1 */
+	pfc = alchemy_rdsys(AU1000_SYS_PINFUNC);
+	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
+	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
+	pfc |= SYS_PINFUNC_P1C; /* SPI is configured later */
+	alchemy_wrsys(pfc, AU1000_SYS_PINFUNC);
+
+	/* get 50MHz for I2C driver on PSC0 */
+	c = clk_get(NULL, "psc0_intclk");
+	if (!IS_ERR(c)) {
+		pfc = clk_round_rate(c, 50000000);
+		if ((pfc < 1) || (abs(50000000 - pfc) > 2500000))
+			pr_warn("DB1200: cant get I2C close to 50MHz\n");
+		else
+			clk_set_rate(c, pfc);
+		clk_put(c);
+	}
+
 	/* insert/eject pairs: one of both is always screaming.	 To avoid
 	 * issues they must not be automatically enabled when initially
 	 * requested.
@@ -927,6 +922,11 @@ int __init db1200_dev_setup(void)
 	}
 
 	/* Audio PSC clock is supplied externally. (FIXME: platdata!!) */
+	c = clk_get(NULL, "psc1_intclk");
+	if (!IS_ERR(c)) {
+		clk_prepare_enable(c);
+		clk_put(c);
+	}
 	__raw_writel(PSC_SEL_CLK_SERCLK,
 	    (void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index e0ed9b9..00ce895 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -4,6 +4,7 @@
  * (c) 2009 Manuel Lauss <manuel.lauss@googlemail.com>
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -771,6 +772,7 @@ static struct platform_device *db1300_dev[] __initdata = {
 int __init db1300_dev_setup(void)
 {
 	int swapped, cpldirq;
+	struct clk *c;
 
 	/* setup CPLD IRQ muxer */
 	cpldirq = au1300_gpio_to_irq(AU1300_PIN_EXTCLK1);
@@ -804,6 +806,11 @@ int __init db1300_dev_setup(void)
 	    (void __iomem *)KSEG1ADDR(AU1300_PSC2_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
 	/* I2C uses internal 48MHz EXTCLK1 */
+	c = clk_get(NULL, "psc3_intclk");
+	if (!IS_ERR(c)) {
+		clk_prepare_enable(c);
+		clk_put(c);
+	}
 	__raw_writel(PSC_SEL_CLK_INTCLK,
 	    (void __iomem *)KSEG1ADDR(AU1300_PSC3_PHYS_ADDR) + PSC_SEL_OFFSET);
 	wmb();
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index d132066..7e89936 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -4,6 +4,7 @@
  * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -574,6 +575,7 @@ static void __init pb1550_devices(void)
 int __init db1550_dev_setup(void)
 {
 	int swapped, id;
+	struct clk *c;
 
 	id = (BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI)) != BCSR_WHOAMI_DB1550);
 
@@ -582,6 +584,17 @@ int __init db1550_dev_setup(void)
 	spi_register_board_info(db1550_spi_devs,
 				ARRAY_SIZE(db1550_i2c_devs));
 
+	c = clk_get(NULL, "psc0_intclk");
+	if (!IS_ERR(c)) {
+		clk_prepare_enable(c);
+		clk_put(c);
+	}
+	c = clk_get(NULL, "psc2_intclk");
+	if (!IS_ERR(c)) {
+		clk_prepare_enable(c);
+		clk_put(c);
+	}
+
 	/* Audio PSC clock is supplied by codecs (PSC1, 3) FIXME: platdata!! */
 	__raw_writel(PSC_SEL_CLK_SERCLK,
 	    (void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
-- 
2.0.1
