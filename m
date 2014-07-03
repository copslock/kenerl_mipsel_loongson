Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:25:10 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40801 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861097AbaGCNXMhTirk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:23:12 +0200
Received: by mail-wi0-f169.google.com with SMTP id hi2so10668091wib.2
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bHbwEjpo+Gc+0zk1TusDOYFg5Nnn5X+7tSrLXcpenOI=;
        b=AkadpEtWuPaMNkY332KtehPog5yv0YTXKNb77P7h9eyabu79tSGcVQ6OXjtHjGYFO9
         gcdajcFVpUuO+5YsQ54MDGl1Lo8bd6FuASCbRZEmloQHkhA6oBJ0AgwVtoz0p4RMhopY
         yJDP0D9JEbZmO63ZzKWCRnYErAyuIBlX2Xvfo9zb1X24kykh31fse0T5bvPoQgu/tR2b
         SRSry37/FPsUTP48h2ObSC5fF/28jBkf/9yVnhrLISfrRk2tLcWahdlhT5mSRw2P5XEt
         xWHUKDj8nvj+nL3H/m8Rb1uHWn+FI5XKI+KBiqPAuG1fxM4XZ17jYl2bgJ810qV6cYNl
         fU6g==
X-Received: by 10.180.189.44 with SMTP id gf12mr49256849wic.14.1404393787346;
        Thu, 03 Jul 2014 06:23:07 -0700 (PDT)
Received: from localhost.localdomain (p57A34891.dip0.t-ipconnect.de. [87.163.72.145])
        by mx.google.com with ESMTPSA id ev9sm67079017wic.24.2014.07.03.06.23.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jul 2014 06:23:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2 06/11] MIPS: Alchemy: db1200: use clk framework
Date:   Thu,  3 Jul 2014 15:22:37 +0200
Message-Id: <1404393762-858019-7-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41000
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

Make use of the clk framework to give us a rate as close to 50MHz
as possible.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200.c | 45 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 8c71cde..f255586 100644
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
-	pfc = AU1X_RDSYS(AU1000_SYS_PINFUNC);
-	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
-	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
-	pfc |= SYS_PINFUNC_P1C; /* SPI is configured later */
-	AU1X_WRSYS(pfc, AU1000_SYS_PINFUNC);
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
-	AU1X_WRSYS(freq0, AU1000_SYS_FREQCTRL0);
-	freq0 |= SYS_FC_FE0;	/* enable F0 */
-	AU1X_WRSYS(freq0, AU1000_SYS_FREQCTRL0);
-
-	/* psc0_intclk comes 1:1 from F0 */
-	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
-	AU1X_WRSYS(clksrc, AU1000_SYS_CLKSRC);
-
 	return 0;
 }
 
@@ -845,6 +821,7 @@ int __init db1200_dev_setup(void)
 	unsigned long pfc;
 	unsigned short sw;
 	int swapped, bid;
+	struct clk *c;
 
 	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
 	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
@@ -857,6 +834,24 @@ int __init db1200_dev_setup(void)
 	irq_set_irq_type(AU1200_GPIO7_INT, IRQ_TYPE_LEVEL_LOW);
 	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
 
+	/* SMBus/SPI on PSC0, Audio on PSC1 */
+	pfc = AU1X_RDSYS(AU1000_SYS_PINFUNC);
+	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
+	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
+	pfc |= SYS_PINFUNC_P1C; /* SPI is configured later */
+	AU1X_WRSYS(pfc, AU1000_SYS_PINFUNC);
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
-- 
2.0.0
