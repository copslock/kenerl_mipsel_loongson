Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 23:39:21 +0000 (GMT)
Received: from smtp4-g19.free.fr ([212.27.42.30]:16067 "EHLO smtp4-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S8136301AbVKLXgj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 23:36:39 +0000
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 1E6563F5E8;
	Sun, 13 Nov 2005 00:38:19 +0100 (CET)
Received: from jekyll.groumpf.homeip.net ([192.168.1.1] helo=jekyll)
	by groumpf with esmtp (Exim 4.50)
	id 1Eb4ws-0003IV-LS; Sun, 13 Nov 2005 00:38:18 +0100
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1Eb4ws-00007G-9b; Sun, 13 Nov 2005 00:38:18 +0100
To:	ralf@linux-mips.org
Subject: [PATCH] Add const qualifier to writes##bwlq
Cc:	linux-mips@linux-mips.org
Message-Id: <E1Eb4ws-00007G-9b@jekyll>
From:	Arnaud Giersch <arnaud.giersch@free.fr>
Date:	Sun, 13 Nov 2005 00:38:18 +0100
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Add const qualifier to parameter addr of writes##bwlq.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

 io.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -459,10 +459,10 @@ __BUILDIO(q, u64)
 
 #define __BUILD_MEMORY_STRING(bwlq, type)				\
 									\
-static inline void writes##bwlq(volatile void __iomem *mem, void *addr,	\
-				unsigned int count)			\
+static inline void writes##bwlq(volatile void __iomem *mem,		\
+				const void *addr, unsigned int count)	\
 {									\
-	volatile type *__addr = addr;					\
+	const volatile type *__addr = addr;				\
 									\
 	while (count--) {						\
 		mem_write##bwlq(*__addr, mem);				\
