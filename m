Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 16:06:54 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51739 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011576AbbA2PGwpgKHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 16:06:52 +0100
Received: by mail-wi0-f177.google.com with SMTP id r20so25787129wiv.4;
        Thu, 29 Jan 2015 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sEF1VSWDPkwhhRHHDGhDmWQ95dq+qhrny78o3tYhaUI=;
        b=wDUNWWVvoyKGSnnpJ06O1VUgxF55JPVicSMCA5NoZyLUAYtKFCTvkYhhjFUYyjPfK4
         mFu1of782Trs6vwWcB8b0yDCGU4oaEGB6kbNupTBYfRQboJt5rH3Zo15cCDhzmB3puiL
         6e1CZPzqRIRrwGFHjCTLH8/28FOCxy/+YMTXclXIzLwVWVFEjTCuSLOpGepw63mcnkK+
         zHaib14jXuZKVBGV37rEv1OLI0u+Msrp70R+ykvrtP7E47WvrMgZxmupTGgKvEZivakk
         JioJAD8RHPsxN/RFD0x6oy+mfC6uIFEHp0V8n4q5g6IotuXSBl1xPqzU8bCl0PwjTMHc
         f18w==
X-Received: by 10.180.182.8 with SMTP id ea8mr2064317wic.48.1422544007585;
        Thu, 29 Jan 2015 07:06:47 -0800 (PST)
Received: from dargo.Speedport_W_724V_01011603_00_005 (p4FCD26FC.dip0.t-ipconnect.de. [79.205.38.252])
        by mx.google.com with ESMTPSA id lk2sm2828460wic.22.2015.01.29.07.06.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jan 2015 07:06:46 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 1/3] MIPS: Alchemy: fix Au1000/Au1500 LRCLK calculation
Date:   Thu, 29 Jan 2015 16:06:42 +0100
Message-Id: <1422544004-25254-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.2.2
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45534
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
v2: address Sergei's comments.

 arch/mips/alchemy/common/clock.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 48a9dfc..f8f54b8 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -315,17 +315,26 @@ static struct clk __init *alchemy_clk_setup_mem(const char *pn, int ct)
 
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
+	unsigned long v = alchemy_rdsmem(AU1000_MEM_STCFG0);
 
-	v = (v & 7) + 1;
+	switch (t) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+		v = 4 + ((v >> 11) & 1);
+		break;
+	default:	/* all other models */
+		v = ((v >> 13) & 7) + 1;
+	}
 	c = clk_register_fixed_factor(NULL, ALCHEMY_LR_CLK,
 				      pn, 0, 1, v);
 	if (!IS_ERR(c))
@@ -1060,7 +1069,7 @@ static int __init alchemy_clk_init(void)
 	ERRCK(c)
 
 	/* L/RCLK: external static bus clock for synchronous mode */
-	c = alchemy_clk_setup_lrclk(ALCHEMY_PERIPH_CLK);
+	c = alchemy_clk_setup_lrclk(ALCHEMY_PERIPH_CLK, ctype);
 	ERRCK(c)
 
 	/* Frequency dividers 0-5 */
-- 
2.2.2
