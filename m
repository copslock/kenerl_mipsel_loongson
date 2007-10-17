Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 16:55:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52677 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035764AbXJQPzZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2007 16:55:25 +0100
Received: from localhost (p2023-ipad307funabasi.chiba.ocn.ne.jp [123.217.180.23])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9D2C29A61; Thu, 18 Oct 2007 00:55:19 +0900 (JST)
Date:	Thu, 18 Oct 2007 00:57:07 +0900 (JST)
Message-Id: <20071018.005707.82350767.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix typo in sibyte clockevent drivers
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 17092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix some typo introduced on clockevent conversion.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/sibyte/bcm1480/time.c |    2 +-
 arch/mips/sibyte/sb1250/time.c  |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/time.c b/arch/mips/sibyte/bcm1480/time.c
index 40d7126..5b4bfbb 100644
--- a/arch/mips/sibyte/bcm1480/time.c
+++ b/arch/mips/sibyte/bcm1480/time.c
@@ -84,7 +84,7 @@ static void sibyte_set_mode(enum clock_event_mode mode,
 	void __iomem *timer_cfg, *timer_init;
 
 	timer_cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
-	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
+	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT));
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
diff --git a/arch/mips/sibyte/sb1250/time.c b/arch/mips/sibyte/sb1250/time.c
index 38199ad..fe11fed 100644
--- a/arch/mips/sibyte/sb1250/time.c
+++ b/arch/mips/sibyte/sb1250/time.c
@@ -83,7 +83,7 @@ static void sibyte_set_mode(enum clock_event_mode mode,
 	void __iomem *timer_cfg, *timer_init;
 
 	timer_cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
-	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
+	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT));
 
 	switch(mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -111,7 +111,7 @@ sibyte_next_event(unsigned long delta, struct clock_event_device *evt)
 	void __iomem *timer_cfg, *timer_init;
 
 	timer_cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
-	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
+	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT));
 
 	__raw_writeq(0, timer_cfg);
 	__raw_writeq(delta, timer_init);
@@ -155,7 +155,7 @@ static void sibyte_set_mode(enum clock_event_mode mode,
 	void __iomem *timer_cfg, *timer_init;
 
 	timer_cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
-	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
+	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT));
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -183,7 +183,7 @@ sibyte_next_event(unsigned long delta, struct clock_event_device *evt)
 	void __iomem *timer_cfg, *timer_init;
 
 	timer_cfg = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
-	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_CFG));
+	timer_init = IOADDR(A_SCD_TIMER_REGISTER(cpu, R_SCD_TIMER_INIT));
 
 	__raw_writeq(0, timer_cfg);
 	__raw_writeq(delta, timer_init);
