Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2009 14:59:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:28128 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035307AbZDHN65 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2009 14:58:57 +0100
Received: from localhost.localdomain (p7136-ipad212funabasi.chiba.ocn.ne.jp [58.91.171.136])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3FB90AA2F; Wed,  8 Apr 2009 22:58:51 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Do not include seccomp.h from compat.h
Date:	Wed,  8 Apr 2009 22:59:00 +0900
Message-Id: <1239199140-32756-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The compat.h does not need seccomp.h since TIF_32BIT was moved to
thread_info.h

This fixes a build error of 64-bit kernel without CONFIG_SECCOMP.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/compat.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 6c5b409..f58aed3 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -3,7 +3,6 @@
 /*
  * Architecture specific compatibility types
  */
-#include <linux/seccomp.h>
 #include <linux/thread_info.h>
 #include <linux/types.h>
 #include <asm/page.h>
-- 
1.5.6.3
