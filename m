Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 14:05:43 +0100 (BST)
Received: from p549F7458.dip.t-dialin.net ([84.159.116.88]:40876 "EHLO
	p549F7458.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28580497AbYGPNFl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 14:05:41 +0100
Received: from smtp.movial.fi ([62.236.91.34]:22181 "EHLO smtp.movial.fi")
	by lappi.linux-mips.net with ESMTP id S1097985AbYGOQ6G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2008 18:58:06 +0200
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id DEED0C80F6;
	Tue, 15 Jul 2008 19:57:34 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 6w3E8LmmVo5O; Tue, 15 Jul 2008 19:57:34 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 60514C8101;
	Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 3CBB6B4049; Tue, 15 Jul 2008 19:57:31 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [MIPS] add missing prototypes to asm/page.h
Date:	Tue, 15 Jul 2008 19:57:32 +0300
Message-Id: <1216141052-28005-4-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

This patch fixes the following sparse warnings:

>>>>>>>>>>>>>>>>>>
arch/mips/mm/page.c:284:16: warning: symbol
'build_clear_page' was not declared. Should it be static?

arch/mips/mm/page.c:426:16: warning: symbol 'build_copy_page'
was not declared. Should it be static?
>>>>>>>>>>>>>>>>>>

The fix is to add appropriate prototypes to the header
include/asm-mips/page.h.

Build-tested against Malta defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 include/asm-mips/page.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 8735aa0..494f00b 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -34,6 +34,9 @@
 #include <linux/pfn.h>
 #include <asm/io.h>
 
+extern void build_clear_page(void);
+extern void build_copy_page(void);
+
 /*
  * It's normally defined only for FLATMEM config but it's
  * used in our early mem init code for all memory models.
-- 
1.5.6
