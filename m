Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 05:23:09 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:44521 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490951Ab0JUDXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Oct 2010 05:23:05 +0200
Received: (qmail 7574 invoked from network); 21 Oct 2010 03:23:00 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Oct 2010 03:23:00 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Wed, 20 Oct 2010 20:23:00 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH v2 8/9] MIPS: Honor L2 bypass bit
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Oct 2010 20:05:42 -0700
Message-Id: <74b5d3ba9506b2e6d885546bd6dcdaec@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On many of the newer MIPS32 cores, CP0 CONFIG2 bit 12 (L2B) indicates
that the L2 cache is disabled and therefore Linux should not attempt
to use it.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/sc-mips.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 5ab5fa8..f2e2886 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -79,6 +79,17 @@ static inline int __init mips_sc_probe(void)
 		return 0;
 
 	config2 = read_c0_config2();
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
 	tmp = (config2 >> 4) & 0x0f;
 	if (0 < tmp && tmp <= 7)
 		c->scache.linesz = 2 << tmp;
-- 
1.7.0.4
