Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 17:01:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20699 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030761AbZDBQBY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 17:01:24 +0100
Received: from localhost.localdomain (p2240-ipad309funabasi.chiba.ocn.ne.jp [123.217.196.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3B783A7D1; Fri,  3 Apr 2009 01:01:17 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TXx9: Fix possible overflow in clock calculations
Date:	Fri,  3 Apr 2009 01:01:21 +0900
Message-Id: <1238688081-6329-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Addition of -fwrapv option in 2.6.29 discloses possible overflow with
signed arithmetics.  For example, result of "a * 6 / 12" (int a =
400000000) is 200000000 without -fwrapv but -157913941 with -fwrapv.

Change some variable to unsigned to avoid such overflows.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup_tx4927.c |    2 +-
 arch/mips/txx9/generic/setup_tx4938.c |    2 +-
 arch/mips/txx9/generic/setup_tx4939.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 778078a..6b681cd 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -89,7 +89,7 @@ void __init tx4927_setup(void)
 {
 	int i;
 	__u32 divmode;
-	int cpuclk = 0;
+	unsigned int cpuclk = 0;
 	u64 ccfg;
 
 	txx9_reg_res_init(TX4927_REV_PCODE(), TX4927_REG_BASE,
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 5d2cbbf..b2b8529 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -94,7 +94,7 @@ void __init tx4938_setup(void)
 {
 	int i;
 	__u32 divmode;
-	int cpuclk = 0;
+	unsigned int cpuclk = 0;
 	u64 ccfg;
 
 	txx9_reg_res_init(TX4938_REV_PCODE(), TX4938_REG_BASE,
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index d48eee1..f0beba8 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -115,7 +115,7 @@ void __init tx4939_setup(void)
 	int i;
 	__u32 divmode;
 	__u64 pcfg;
-	int cpuclk = 0;
+	unsigned int cpuclk = 0;
 
 	txx9_reg_res_init(TX4939_REV_PCODE(), TX4939_REG_BASE,
 			  TX4939_REG_SIZE);
-- 
1.5.6.3
