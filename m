Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 15:59:18 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:55869 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492715AbZICN7K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Sep 2009 15:59:10 +0200
Received: from localhost.localdomain (p2046-ipad301funabasi.chiba.ocn.ne.jp [122.17.252.46])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BA4AA6AE9; Thu,  3 Sep 2009 22:59:02 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, spi-devel-general@lists.sourceforge.net,
	david-b@pacbell.net
Subject: [PATCH 1/2] txx9: Fix spi-baseclk value
Date:	Thu,  3 Sep 2009 22:59:00 +0900
Message-Id: <1251986341-16938-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TXx9 SPI bit rate is calculated by:
	fBR = fSPI / 2 / (n + 1)
	(fSPI is SPI master clock freq, i.e. imbusclk freq.)
So use imbus_clk / 2 as a spi-baseclk.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index a205e2b..b2613c1 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -85,7 +85,7 @@ int txx9_ccfg_toeon __initdata = 1;
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 4);
+		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 2);
 	if (!strcmp(id, "imbus_clk"))
 		return (struct clk *)((unsigned long)txx9_gbus_clock / 2);
 	return ERR_PTR(-ENOENT);
-- 
1.5.6.5
