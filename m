Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:40:33 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:55524 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225328AbSLRBhr>;
	Wed, 18 Dec 2002 01:37:47 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id D2314D657; Wed, 18 Dec 2002 02:43:43 +0100 (CET)
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: remove warnings on promlib
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:43 +0100
Message-ID: <m2u1hcp0ds.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

       remove compile warnings about undefined symbols.

Later, Juan.

Index: arch/mips/lib/promlib.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/promlib.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 promlib.c
--- arch/mips/lib/promlib.c	28 Sep 2002 22:28:38 -0000	1.1.2.1
+++ arch/mips/lib/promlib.c	18 Dec 2002 00:49:18 -0000
@@ -1,3 +1,7 @@
+
+#include <asm/sgialib.h>
+#include <linux/kernel.h>
+
 #include <stdarg.h>
 
 void prom_printf(char *fmt, ...)


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
