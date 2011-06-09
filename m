Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 20:13:53 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34065 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491051Ab1FISNu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 20:13:50 +0200
From:   John Crispin <blogic@openwrt.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH V2 1/2] MIPS: lantiq: adds missing clk.h functions
Date:   Thu,  9 Jun 2011 20:15:21 +0200
Message-Id: <1307643321-10457-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 30309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8303

The 2 functions clk_enable() and clk_disable were missing.

Signed-of-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/clk.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 9456089..7e9c0ff 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -100,6 +100,19 @@ void clk_put(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_put);
 
+int clk_enable(struct clk *clk)
+{
+	/* not used */
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	/* not used */
+}
+EXPORT_SYMBOL(clk_disable);
+
 static inline u32 ltq_get_counter_resolution(void)
 {
 	u32 res;
-- 
1.7.2.3
