Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Sep 2010 06:16:52 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45082 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491118Ab0IGEQo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Sep 2010 06:16:44 +0200
Received: (qmail 7846 invoked from network); 7 Sep 2010 04:16:41 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Sep 2010 04:16:41 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Mon, 06 Sep 2010 21:16:41 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 6 Sep 2010 21:03:50 -0700
Subject: [PATCH 4/5] MIPS: Honor L2 bypass bit
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Message-Id: <fb6665b75d54bd58b8ac890106831e0f@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 27722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4958

If CP0 CONFIG2 bit 12 (L2B) is set, the L2 cache is disabled and
therefore Linux should not attempt to use it.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/sc-mips.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 5ab5fa8..d072b25 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -79,6 +79,11 @@ static inline int __init mips_sc_probe(void)
 		return 0;
 
 	config2 = read_c0_config2();
+
+	/* bypass bit */
+	if (config2 & (1 << 12))
+		return 0;
+
 	tmp = (config2 >> 4) & 0x0f;
 	if (0 < tmp && tmp <= 7)
 		c->scache.linesz = 2 << tmp;
-- 
1.7.0.4
