Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 17:58:38 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:37260 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993070AbeFPP6cJdfHw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2018 17:58:32 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id B6D104318F;
        Sat, 16 Jun 2018 17:58:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 77-O1JvcWO6C; Sat, 16 Jun 2018 17:58:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, ak@linux.intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: define __current_thread_info inside of function
Date:   Sat, 16 Jun 2018 17:58:15 +0200
Message-Id: <20180616155815.31230-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

__current_thread_info is currently defined in the header file, but when
we link the kernel with LTO it shows up in all files which include this
header file and causes conflicts with itself. Move the definition into
the only function which uses it to prevent these problems.

This fixes the build with LTO.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/include/asm/thread_info.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 4993db40482c..9348776e16a3 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -49,11 +49,11 @@ struct thread_info {
 	.addr_limit	= KERNEL_DS,		\
 }
 
-/* How to get the thread information struct from C.  */
-register struct thread_info *__current_thread_info __asm__("$28");
-
 static inline struct thread_info *current_thread_info(void)
 {
+	/* How to get the thread information struct from C.  */
+	register struct thread_info *__current_thread_info __asm__("$28");
+
 	return __current_thread_info;
 }
 
-- 
2.11.0
