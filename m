Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 19:10:22 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:34437 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225541AbSLTTKV>;
	Fri, 20 Dec 2002 19:10:21 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 119D5D657; Fri, 20 Dec 2002 20:16:30 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: getting r4k to work in 64 bits.
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 20:16:30 +0100
Message-ID: <m28yykfqlt.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        without this patch, addresses are bad calculated for 
r4k in 64bits mode.  Notice that the corresponding variables for
instruction and data caches already were unsigned long.

a = addr & ~(sc_lsize - 1);
end = (addr + size - 1) & ~(sc_lsize - 1);

Problem is that in this kind of expression, it uses 32 bits to
calculate ~(sc_lsize -1).  I don't know if this is really a compiler
or kernel bug. 

Later, Juan.

Index: arch/mips64/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 c-r4k.c
--- arch/mips64/mm/c-r4k.c	20 Dec 2002 03:08:32 -0000	1.1.2.10
+++ arch/mips64/mm/c-r4k.c	20 Dec 2002 18:39:48 -0000
@@ -30,7 +30,7 @@
 static unsigned long ic_lsize, dc_lsize;       /* LineSize in bytes */
 
 /* Secondary cache (if present) parameters. */
-static unsigned int scache_size, sc_lsize;	/* Again, in bytes */
+static unsigned long scache_size, sc_lsize;	/* Again, in bytes */
 
 #include <asm/cacheops.h>
 #include <asm/r4kcache.h>


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
