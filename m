Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Nov 2010 06:32:39 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:45853 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490990Ab0KCFcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Nov 2010 06:32:35 +0100
Received: (qmail 15360 invoked from network); 3 Nov 2010 05:32:31 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Nov 2010 05:32:31 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Tue, 02 Nov 2010 22:32:30 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Fix build errors in sc-mips.c
Date:   Tue, 02 Nov 2010 22:28:01 -0700
Message-Id: <01184c101e5d39225a6380cce3c5bad5@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Seen with malta_defconfig on Linus' tree:

  CC      arch/mips/mm/sc-mips.o
arch/mips/mm/sc-mips.c: In function 'mips_sc_is_activated':
arch/mips/mm/sc-mips.c:77: error: 'config2' undeclared (first use in this function)
arch/mips/mm/sc-mips.c:77: error: (Each undeclared identifier is reported only once
arch/mips/mm/sc-mips.c:77: error: for each function it appears in.)
arch/mips/mm/sc-mips.c:81: error: 'tmp' undeclared (first use in this function)
make[2]: *** [arch/mips/mm/sc-mips.o] Error 1
make[1]: *** [arch/mips/mm] Error 2
make: *** [arch/mips] Error 2

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/sc-mips.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 505feca..ef625eb 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -66,8 +66,11 @@ static struct bcache_ops mips_sc_ops = {
  * 12..15 as implementation defined so below function will eventually have
  * to be replaced by a platform specific probe.
  */
-static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
+static inline int mips_sc_is_activated(struct cpuinfo_mips *c,
+	unsigned int config2)
 {
+	unsigned int tmp;
+
 	/* Check the bypass bit (L2B) */
 	switch (c->cputype) {
 	case CPU_34K:
@@ -83,6 +86,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 		c->scache.linesz = 2 << tmp;
 	else
 		return 0;
+	return 1;
 }
 
 static inline int __init mips_sc_probe(void)
@@ -108,7 +112,7 @@ static inline int __init mips_sc_probe(void)
 
 	config2 = read_c0_config2();
 
-	if (!mips_sc_is_activated(c))
+	if (!mips_sc_is_activated(c, config2))
 		return 0;
 
 	tmp = (config2 >> 8) & 0x0f;
-- 
1.7.0.4
