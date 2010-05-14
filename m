Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:11:09 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:57136 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491856Ab0ENLJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:17 +0200
Received: by mail-px0-f177.google.com with SMTP id 1so1300635pxi.36
        for <multiple recipients>; Fri, 14 May 2010 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=slwv/bbbjYCgVQoh39DAkg7F3zvkX2DSoVwGj1DVlS8=;
        b=MnVkeZFAm4Er3uW/hc4752yp3nQKCXG8Idh1pKK4GSu5IeN2wTzi4BWEmVY/8ofzs2
         d0qJ/DprniNJqnl0XXWK2PHeeC1Ib4k0uxTShB4NZwzLLAxZC2SxEbWx+IobPRhtJoTb
         6vzr96Pjo0pPbhQet4gA0sQdrz4yOBf7h/rH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x5Z4W6AV/8nKTL3sMgMqskm8PUgZra9OFzlozLq2+v5Bx+dLSmfuyOqPpsXLLpY3MZ
         ApbVaMyp6RIszgwGQmHu8hrVP+NWBpT9gd+GJsuDuFBihqsYZHcPz17x4khW4BmBcoVr
         AN68FvJM1J6JhSpXdZwuvDS42Sq9a7ahch+bI=
Received: by 10.114.186.35 with SMTP id j35mr1062533waf.13.1273835356625;
        Fri, 14 May 2010 04:09:16 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:09:16 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 5/9] tracing: MIPS: Fixup of the 32bit support with -mmcount-ra-address
Date:   Fri, 14 May 2010 19:08:30 +0800
Message-Id: <e58a53c32186a67c3eb5b23a488ed818331db0b5.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

For 32bit kernel, the -mmcount-ra-address option of gcc 4.5 has
introduced one more instruction before calling to _mcount, so we need to
use a different "b 1f" for it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index e9e64e0..37aa767 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -62,14 +62,26 @@ int ftrace_make_nop(struct module *mod,
 				return -EFAULT;
 		}
 
+#if defined(KBUILD_MCOUNT_RA_ADDRESS) && defined(CONFIG_32BIT)
+		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000005)
+		 * addiu v1, v1, low_16bit_of_mcount
+		 * move at, ra
+		 * move $12, ra_address
+		 * jalr v1
+		 *  sub sp, sp, 8
+		 *                                  1: offset = 5 instructions
+		 */
+		new = 0x10000005;
+#else
 		/* lui v1, hi_16bit_of_mcount        --> b 1f (0x10000004)
 		 * addiu v1, v1, low_16bit_of_mcount
 		 * move at, ra
 		 * jalr v1
-		 * nop
-		 * 				     1f: (ip + 12)
+		 *  nop | move $12, ra_address | sub sp, sp, 8
+		 *                                  1: offset = 4 instructions
 		 */
 		new = 0x10000004;
+#endif
 	} else {
 		/* record/calculate it for ftrace_make_call */
 		if (jal_mcount == 0) {
-- 
1.7.0.4
