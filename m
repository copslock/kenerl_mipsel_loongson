Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 18:07:53 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:43617 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491134Ab0JUQHu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Oct 2010 18:07:50 +0200
Received: (qmail 22225 invoked from network); 21 Oct 2010 16:07:45 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Oct 2010 16:07:45 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 21 Oct 2010 09:07:45 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH v3 8/9] MIPS: Honor L2 bypass bit
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Oct 2010 08:59:48 -0700
Message-Id: <2e65c61bf8fd3a7b2aa4e24013cb0dba@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

[v3: Fix build errors]

On many of the newer MIPS32 cores, CP0 CONFIG2 bit 12 (L2B) indicates
that the L2 cache is disabled and therefore Linux should not attempt
to use it.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-mips@linux-mips.org>
Cc: <linux-kernel@vger.kernel.org>
---
 arch/mips/mm/sc-mips.c |   38 ++++++++++++++++++++++++++++++++++----
 1 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 5ab5fa8..ef625eb 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -57,6 +57,38 @@ static struct bcache_ops mips_sc_ops = {
 	.bc_inv = mips_sc_inv
 };
 
+/*
+ * Check if the L2 cache controller is activated on a particular platform.
+ * MTI's L2 controller and the L2 cache controller of Broadcom's BMIPS
+ * cores both use c0_config2's bit 12 as "L2 Bypass" bit, that is the
+ * cache being disabled.  However there is no guarantee for this to be
+ * true on all platforms.  In an act of stupidity the spec defined bits
+ * 12..15 as implementation defined so below function will eventually have
+ * to be replaced by a platform specific probe.
+ */
+static inline int mips_sc_is_activated(struct cpuinfo_mips *c,
+	unsigned int config2)
+{
+	unsigned int tmp;
+
+	/* Check the bypass bit (L2B) */
+	switch (c->cputype) {
+	case CPU_34K:
+	case CPU_74K:
+	case CPU_1004K:
+	case CPU_BMIPS5000:
+		if (config2 & (1 << 12))
+			return 0;
+	}
+
+	tmp = (config2 >> 4) & 0x0f;
+	if (0 < tmp && tmp <= 7)
+		c->scache.linesz = 2 << tmp;
+	else
+		return 0;
+	return 1;
+}
+
 static inline int __init mips_sc_probe(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -79,10 +111,8 @@ static inline int __init mips_sc_probe(void)
 		return 0;
 
 	config2 = read_c0_config2();
-	tmp = (config2 >> 4) & 0x0f;
-	if (0 < tmp && tmp <= 7)
-		c->scache.linesz = 2 << tmp;
-	else
+
+	if (!mips_sc_is_activated(c, config2))
 		return 0;
 
 	tmp = (config2 >> 8) & 0x0f;
-- 
1.7.0.4
