Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 19:49:24 +0100 (BST)
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23818 "EHLO
	tuxland.pl") by ftp.linux-mips.org with ESMTP id S20021732AbXGaStS
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 19:49:18 +0100
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 01DF4D1F65;
	Tue, 31 Jul 2007 20:47:43 +0200 (CEST)
Received: from [192.168.1.3] (unknown [192.168.1.3])
	by tuxland.pl (AISK); Tue, 31 Jul 2007 20:47:43 +0200 (CEST)
From:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To:	linux-kernel@vger.kernel.org
Subject: [PATCH 48] include/asm-mips/thread_info.h: kmalloc + memset conversion to kzalloc
Date:	Tue, 31 Jul 2007 20:48:41 +0200
User-Agent: KMail/1.9.5
Cc:	kernel-janitors@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
References: <200707311845.48807.m.kozlowski@tuxland.pl>
In-Reply-To: <200707311845.48807.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707312048.42172.m.kozlowski@tuxland.pl>
Return-Path: <m.kozlowski@tuxland.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.kozlowski@tuxland.pl
Precedence: bulk
X-list: linux-mips

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-mips/thread_info.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.23-rc1-mm1-a/include/asm-mips/thread_info.h	2007-07-26 13:07:40.000000000 +0200
+++ linux-2.6.23-rc1-mm1-b/include/asm-mips/thread_info.h	2007-07-31 15:09:01.000000000 +0200
@@ -87,9 +87,8 @@ register struct thread_info *__current_t
 ({								\
 	struct thread_info *ret;				\
 								\
-	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);			\
-	if (ret)						\
-		memset(ret, 0, THREAD_SIZE);			\
+	ret = kzalloc(THREAD_SIZE, GFP_KERNEL);			\
+								\
 	ret;							\
 })
 #else
