Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 17:49:26 +0100 (BST)
Received: from de01egw02.freescale.net ([IPv6:::ffff:192.88.165.103]:36333
	"EHLO de01egw02.freescale.net") by linux-mips.org with ESMTP
	id <S8225288AbVHXQtF>; Wed, 24 Aug 2005 17:49:05 +0100
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id j7OGx4Zt022303;
	Wed, 24 Aug 2005 09:59:05 -0700 (MST)
Received: from postal.somerset.sps.mot.com ([163.12.132.5])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id j7OH1UuB013925;
	Wed, 24 Aug 2005 12:01:31 -0500 (CDT)
Received: from nylon.am.freescale.net (nylon.sps.mot.com [10.82.19.8])
	by postal.somerset.sps.mot.com (8.11.0/8.11.0) with ESMTP id j7OGsTD05090;
	Wed, 24 Aug 2005 11:54:29 -0500 (CDT)
Received: from nylon.am.freescale.net (localhost.localdomain [127.0.0.1])
	by nylon.am.freescale.net (8.12.11/8.11.0) with ESMTP id j7OGsTBW024012;
	Wed, 24 Aug 2005 11:54:29 -0500
Received: from localhost (galak@localhost)
	by nylon.am.freescale.net (8.12.11/8.12.11/Submit) with ESMTP id j7OGsRPe024009;
	Wed, 24 Aug 2005 11:54:28 -0500
X-Authentication-Warning: nylon.am.freescale.net: galak owned process doing -bs
Date:	Wed, 24 Aug 2005 11:54:27 -0500 (CDT)
From:	Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To:	linux-kernel@vger.kernel.org
cc:	Andrew Morton <akpm@osdl.org>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: [PATCH 06/15] mips: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241153260.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <galak@freescale.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: galak@freescale.com
Precedence: bulk
X-list: linux-mips

Removed MIPS architecture specific users of asm/segment.h and
asm-mips/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 8f20e153d5d5c3efd95835e814fae7b3ccbfcd08
tree 17e9ae88b3fe1762302179a4ea08e61360805a29
parent 503a812c1f9cef08e6f96b2b2cf1f32bbfef2bc6
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:59:09 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:59:09 -0500

 arch/mips/au1000/db1x00/mirage_ts.c |    1 -
 include/asm-mips/segment.h          |    6 ------
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/au1000/db1x00/mirage_ts.c b/arch/mips/au1000/db1x00/mirage_ts.c
--- a/arch/mips/au1000/db1x00/mirage_ts.c
+++ b/arch/mips/au1000/db1x00/mirage_ts.c
@@ -44,7 +44,6 @@
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
 
-#include <asm/segment.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/delay.h>
diff --git a/include/asm-mips/segment.h b/include/asm-mips/segment.h
deleted file mode 100644
--- a/include/asm-mips/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_SEGMENT_H
-#define _ASM_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* _ASM_SEGMENT_H */
