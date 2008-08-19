Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:57:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:8145 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573964AbYHSNzY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:24 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 75AB9C235; Tue, 19 Aug 2008 22:55:17 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 06/14] TXx9: Runtime configuration of timeout-error
Date:	Tue, 19 Aug 2008 22:55:10 +0900
Message-Id: <1219154118-21193-6-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add kernel options to control bus timeout error.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |   11 +++++++++++
 arch/mips/txx9/generic/setup_tx3927.c |    5 -----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 48aba94..7021215 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -67,7 +67,12 @@ unsigned int txx9_master_clock;
 unsigned int txx9_cpu_clock;
 unsigned int txx9_gbus_clock;
 
+#ifdef CONFIG_CPU_TX39XX
+/* don't enable by default - see errata */
+int txx9_ccfg_toeon __initdata;
+#else
 int txx9_ccfg_toeon __initdata = 1;
+#endif
 
 /* Minimum CLK support */
 
@@ -314,6 +319,12 @@ static void __init preprocess_cmdline(void)
 		} else if (strcmp(str, "dcdisable") == 0) {
 			txx9_dc_disable = 1;
 			continue;
+		} else if (strcmp(str, "toeoff") == 0) {
+			txx9_ccfg_toeon = 0;
+			continue;
+		} else if (strcmp(str, "toeon") == 0) {
+			txx9_ccfg_toeon = 1;
+			continue;
 		}
 		if (arcs_cmdline[0])
 			strcat(arcs_cmdline, " ");
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
index 4bc2f85..06c4925 100644
--- a/arch/mips/txx9/generic/setup_tx3927.c
+++ b/arch/mips/txx9/generic/setup_tx3927.c
@@ -32,11 +32,6 @@ void __init tx3927_setup(void)
 	int i;
 	unsigned int conf;
 
-	/* don't enable - see errata */
-	txx9_ccfg_toeon = 0;
-	if (strstr(prom_getcmdline(), "toeon") != NULL)
-		txx9_ccfg_toeon = 1;
-
 	txx9_reg_res_init(TX3927_REV_PCODE(), TX3927_REG_BASE,
 			  TX3927_REG_SIZE);
 
-- 
1.5.6.3
