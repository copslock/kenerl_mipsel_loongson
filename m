Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 15:00:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:5586 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580943AbYHSNz1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:27 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D6956C237; Tue, 19 Aug 2008 22:55:21 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 14/14] TXx9: Declare smsc_fdc37m81x_config_get() in smsc_fdc37m81x.h
Date:	Tue, 19 Aug 2008 22:55:18 +0900
Message-Id: <1219154118-21193-14-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 include/asm-mips/txx9/smsc_fdc37m81x.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/txx9/smsc_fdc37m81x.h b/include/asm-mips/txx9/smsc_fdc37m81x.h
index 02e161d..d1d6332 100644
--- a/include/asm-mips/txx9/smsc_fdc37m81x.h
+++ b/include/asm-mips/txx9/smsc_fdc37m81x.h
@@ -62,6 +62,7 @@ void smsc_fdc37m81x_config_beg(void);
 
 void smsc_fdc37m81x_config_end(void);
 
+u8 smsc_fdc37m81x_config_get(u8 reg);
 void smsc_fdc37m81x_config_set(u8 reg, u8 val);
 
 #endif
-- 
1.5.6.3
