Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:38:14 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:52196 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225321AbSLRBhH>;
	Wed, 18 Dec 2002 01:37:07 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 18060D657; Wed, 18 Dec 2002 02:43:04 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: c-r4k.c, printing longs as longs
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:04 +0100
Message-ID: <m2el8gqezb.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        printing a long as a int is a bad idea :(

Later, Juan.

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.13
diff -u -r1.3.2.13 c-r4k.c
--- arch/mips/mm/c-r4k.c	11 Dec 2002 14:23:12 -0000	1.3.2.13
+++ arch/mips/mm/c-r4k.c	18 Dec 2002 00:49:18 -0000
@@ -1107,7 +1107,7 @@
 	}
 	ic_lsize = 16 << ((config >> 5) & 1);
 
-	printk("Primary instruction cache %dkb, linesize %ld bytes.\n",
+	printk("Primary instruction cache %ldkb, linesize %ld bytes.\n",
 	       icache_size >> 10, ic_lsize);
 }
 
@@ -1129,7 +1129,7 @@
 	}
 	dc_lsize = 16 << ((config >> 4) & 1);
 
-	printk("Primary data cache %dkb, linesize %ld bytes.\n",
+	printk("Primary data cache %ldkb, linesize %ld bytes.\n",
 	       dcache_size >> 10, dc_lsize);
 }
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
