Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 10:54:14 +0100 (CET)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33293 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010845AbbA2JyMbT-3a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 10:54:12 +0100
Received: by mail-wi0-f178.google.com with SMTP id bs8so13624931wib.5;
        Thu, 29 Jan 2015 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nVkcSKb/BYl87V9jn99HGDWqZQ1BaJ9vf2bIw+1qEd4=;
        b=R6wZGslvMpXuBKMMOEE5uW3HEscUjCcXtxhdsvbLxQl08F+j8dBzmDCFMtP9VItbZ+
         LBOcBtLs9tjriXwzRRRgskLJdE7xXO8TOAqiRZA08/DLA9IZ/rIUCFNGXjl5VXYWoPyW
         fSqd9sGUfUegExj876H8wI9+SW/pa1NEmPpxVBSl6cr5mRoUZqQJS3dDz2kIzV1TaRQ1
         warmsApzF61Q3BqY35dFi/yHj8lR/sWeN55tyb6kwQRUB+VqcfmNsNLP/feHPDs3OAZU
         1JVEQ1flr/IigakdseZR8ZyP/eRUeRw6GXyZEc/ZJvLTDbgsPJMLVi9OaVxSztks+XNS
         B67A==
X-Received: by 10.180.206.47 with SMTP id ll15mr2711457wic.34.1422525246483;
        Thu, 29 Jan 2015 01:54:06 -0800 (PST)
Received: from dargo.Speedport_W_724V_01011603_00_005 (p5484D55C.dip0.t-ipconnect.de. [84.132.213.92])
        by mx.google.com with ESMTPSA id ej10sm1762691wib.2.2015.01.29.01.54.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jan 2015 01:54:05 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/2] MIPS: Alchemy: fix Au1000/Au1500 LRCLK calculation
Date:   Thu, 29 Jan 2015 10:54:02 +0100
Message-Id: <1422525243-1756-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.2.2
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45519
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

The Au1000 and Au1500 calculate the LRCLK a bit differently than
newer models: a single bit in MEM_STCFG0 selects if pclk is divided
by 4 or 5.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/clock.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 48a9dfc..428c9f0 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -315,17 +315,27 @@ static struct clk __init *alchemy_clk_setup_mem(const char *pn, int ct)
 
 /* lrclk: external synchronous static bus clock ***********************/
 
-static struct clk __init *alchemy_clk_setup_lrclk(const char *pn)
+static struct clk __init *alchemy_clk_setup_lrclk(const char *pn, int t)
 {
-	/* MEM_STCFG0[15:13] = divisor.
+	/* Au1000, Au1500: MEM_STCFG0[11]: If bit is set, lrclk=pclk/5,
+	 * otherwise lrclk=pclk/4.
+	 * All other variants: MEM_STCFG0[15:13] = divisor.
 	 * L/RCLK = periph_clk / (divisor + 1)
 	 * On Au1000, Au1500, Au1100 it's called LCLK,
 	 * on later models it's called RCLK, but it's the same thing.
 	 */
 	struct clk *c;
-	unsigned long v = alchemy_rdsmem(AU1000_MEM_STCFG0) >> 13;
+	unsigned long v;
 
-	v = (v & 7) + 1;
+	switch (t) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+		v = 4 + ((alchemy_rdsmem(AU1000_MEM_STCFG0) >> 11) & 1);
+		break;
+	default:	/* all other models */
+		v = alchemy_rdsmem(AU1000_MEM_STCFG0) >> 13;
+		v = (v & 7) + 1;
+        }
 	c = clk_register_fixed_factor(NULL, ALCHEMY_LR_CLK,
 				      pn, 0, 1, v);
 	if (!IS_ERR(c))
@@ -1060,7 +1070,7 @@ static int __init alchemy_clk_init(void)
 	ERRCK(c)
 
 	/* L/RCLK: external static bus clock for synchronous mode */
-	c = alchemy_clk_setup_lrclk(ALCHEMY_PERIPH_CLK);
+	c = alchemy_clk_setup_lrclk(ALCHEMY_PERIPH_CLK, ctype);
 	ERRCK(c)
 
 	/* Frequency dividers 0-5 */
-- 
2.2.2
