Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 10:21:17 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:23171 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225527AbSLTKVQ>;
	Fri, 20 Dec 2002 10:21:16 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 1CFDDD657; Fri, 20 Dec 2002 11:27:25 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: scatter list are supposed to have a int length
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Dec 2002 11:27:25 +0100
Message-ID: <m2adj1gf3m.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        
        length is int in: alpha, sparc64, ppc64 and s390x.

Later, Juan.

Index: include/asm-mips64/scatterlist.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/scatterlist.h,v
retrieving revision 1.4.2.5
diff -u -r1.4.2.5 scatterlist.h
--- include/asm-mips64/scatterlist.h	28 Sep 2002 18:51:41 -0000	1.4.2.5
+++ include/asm-mips64/scatterlist.h	20 Dec 2002 09:55:13 -0000
@@ -7,7 +7,7 @@
 	struct page * page;	/* Location for highmem page, if any */
 	unsigned int offset;
 	dma_addr_t dma_address;
-	unsigned long length;
+	unsigned int length;
 };
 
 #define ISA_DMA_THRESHOLD (0x00ffffff)


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
