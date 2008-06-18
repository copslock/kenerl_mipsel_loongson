Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 08:17:20 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:11446 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20025202AbYFRHRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 08:17:14 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 79C24C80DE;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id PU9gObH8eGEc; Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 30AFBC80D8;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id A7ED0B4047; Wed, 18 Jun 2008 10:18:23 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 5/5] [MIPS] Add an appropriate header into display.c
Date:	Wed, 18 Jun 2008 10:18:23 +0300
Message-Id: <1213773503-23536-6-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The following errors were caught by sparse:

>>>>>>>>>>>

arch/mips/mips-boards/generic/display.c:30:6: warning: symbol
'mips_display_message' was not declared. Should it be static?

arch/mips/mips-boards/generic/display.c:58:6: warning: symbol
'mips_scroll_message' was not declared. Should it be static?

>>>>>>>>>>>

This patch includes the asm/mips-boards/prom.h header file into
arch/mips/mips-boards/generic/display.c. This adds the needed
function declarations, and the errors are gone.

Compile-tested using defconfigs for Malta, Atlas and SEAD boards.
Runtime test was successfully performed by booting a Malta 4Kc
board up to the shell prompt.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/mips-boards/generic/display.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mips-boards/generic/display.c b/arch/mips/mips-boards/generic/display.c
index 2a0057c..7c8828f 100644
--- a/arch/mips/mips-boards/generic/display.c
+++ b/arch/mips/mips-boards/generic/display.c
@@ -22,6 +22,7 @@
 #include <linux/timer.h>
 #include <asm/io.h>
 #include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
 
 extern const char display_string[];
 static unsigned int display_count;
-- 
1.5.5.GIT
