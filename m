Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:58:39 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:17539 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225233AbTC0C4T>;
	Thu, 27 Mar 2003 02:56:19 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id DB98C46A59; Thu, 27 Mar 2003 03:54:52 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: missing prototype of unblank_screen
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:52 +0100
Message-ID: <m2y931cydf.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

unblank_screen prototype is declared in <linux/vt_kern.h>.


 build/arch/mips/mm/fault.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN build/arch/mips/mm/fault.c~missing_unblank_screen build/arch/mips/mm/fault.c
--- 24/build/arch/mips/mm/fault.c~missing_unblank_screen	2003-03-27 00:20:19.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/fault.c	2003-03-27 00:20:39.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/version.h>
+#include <linux/vt_kern.h>
 
 #include <asm/branch.h>
 #include <asm/hardirq.h>

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
