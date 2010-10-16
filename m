Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 23:46:44 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:52877 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491852Ab0JPVoX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 23:44:23 +0200
Received: (qmail 13931 invoked from network); 16 Oct 2010 21:44:20 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Oct 2010 21:44:20 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Oct 2010 14:44:20 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH resend 8/9] MIPS: Honor L2 bypass bit
Date:   Sat, 16 Oct 2010 14:22:37 -0700
Message-Id: <a87064966b36ed9982d8cf05169c5524@localhost>
In-Reply-To: <17ebecce124618ddf83ec6fe8e526f93@localhost>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

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
