Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 20:38:47 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:9180 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S24207730AbYLJUim (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2008 20:38:42 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 958A8C8012;
	Wed, 10 Dec 2008 22:38:36 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id o2+HzzLZNqRu; Wed, 10 Dec 2008 22:38:36 +0200 (EET)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 72A36C8010;
	Wed, 10 Dec 2008 22:38:36 +0200 (EET)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 49342108009; Wed, 10 Dec 2008 22:38:36 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Subject: [PATCH v2] [MIPS] Kconfig: fix the arch-specific header path
Date:	Wed, 10 Dec 2008 22:38:36 +0200
Message-Id: <1228941516-22487-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The header path in the help text for the RUNTIME_DEBUG config
option is obsolete and needs to be updated to match the new
location of architecture-specific header files. While at it,
fix the spelling mistake.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 765c8e2..aab004f 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -48,7 +48,7 @@ config RUNTIME_DEBUG
 	help
 	  If you say Y here, some debugging macros will do run-time checking.
 	  If you say N here, those macros will mostly turn to no-ops.  See
-	  include/asm-mips/debug.h for debuging macros.
+	  arch/mips/include/asm/debug.h for debugging macros.
 	  If unsure, say N.
 
 endmenu
-- 
1.5.4.3
