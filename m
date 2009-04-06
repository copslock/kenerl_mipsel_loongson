Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 16:05:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:19178 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022127AbZDFPEz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2009 16:04:55 +0100
Received: from localhost.localdomain (p7250-ipad207funabasi.chiba.ocn.ne.jp [222.145.89.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8E2F0A320; Tue,  7 Apr 2009 00:04:49 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, "Kevin D. Kissell" <kevink@paralogos.com>
Subject: [PATCH] Fix build error if CONFIG_CEVT_R4K was not defined
Date:	Tue,  7 Apr 2009 00:04:55 +0900
Message-Id: <1239030295-14080-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch fixes build error introduced by "MIPS: SMTC:
Fix xxx_clockevent_init() naming conflict for SMT".

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/time.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index e46f23f..df6a430 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -61,7 +61,7 @@ static inline int mips_clockevent_init(void)
 	extern int smtc_clockevent_init(void);
 
 	return smtc_clockevent_init();
-#elif CONFIG_CEVT_R4K
+#elif defined(CONFIG_CEVT_R4K)
 	return r4k_clockevent_init();
 #else
 	return -ENXIO;
-- 
1.5.6.3
