Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2007 02:04:02 +0100 (BST)
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43471 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20022417AbXGGBDe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jul 2007 02:03:34 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id A3CD6181C33;
	Sat,  7 Jul 2007 03:04:17 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 369BD5E68F8; Sat,  7 Jul 2007 03:03:30 +0200 (CEST)
Date:	Sat, 7 Jul 2007 03:03:30 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-mips/processor.h: "extern inline" ->
	"static inline"
Message-ID: <20070707010330.GY3492@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

"extern inline" will have different semantics with gcc 4.3,
and "static inline" is correct here.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.22-rc6-mm1/include/asm-mips/processor.h.old	2007-07-07 01:06:35.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/asm-mips/processor.h	2007-07-07 01:06:57.000000000 +0200
@@ -237,7 +237,7 @@
 
 #define ARCH_HAS_PREFETCH
 
-extern inline void prefetch(const void *addr)
+static inline void prefetch(const void *addr)
 {
 	__asm__ __volatile__(
 	"	.set	mips4		\n"
