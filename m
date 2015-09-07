Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 17:54:03 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32990 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007250AbbIGPyBQCDY1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 17:54:01 +0200
Received: by pacex6 with SMTP id ex6so99955603pac.0;
        Mon, 07 Sep 2015 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nWuBtO381e8KV4X+xLJ4eFcKT5ro71qS8VRpYr0HAcU=;
        b=zTXvV73BzrO0GGdQ3gO0Sh1JJejKCKW9aRVTlTpW/pllcQg9FXPRX7BxXDdfY1BbRH
         KrmTH/iFAJfyjeserEiUmC7szhhfomt/XP9j+hMSrB1y1irsYQWh0TUxwtldh93UNZML
         jlnkfSrI1IVJeIROqCMd9MLkVlJlyl40/uW6A4amq0UD5PG+qYuzoBI53wq4ZEIHxyuj
         ItYUtLVYv6W4SSbfB46FMDGe7NtUsokzx/aKt6H58nCmSaIum5a78XYq5AsL4iEYgk53
         e/IjcbH2abEbwApLG6Y4WQHdoLB57BiaFwGNrSTRVP/2/n8Yr3pT7mKtUvQ7u8TG1FLi
         gR6Q==
X-Received: by 10.66.218.42 with SMTP id pd10mr47709752pac.106.1441641235201;
        Mon, 07 Sep 2015 08:53:55 -0700 (PDT)
Received: from debian.corp.sankuai.com ([103.29.140.57])
        by smtp.gmail.com with ESMTPSA id xv1sm244379pbb.25.2015.09.07.08.53.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 08:53:53 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH v2] MIPS: UAPI: Ignore __arch_swab{16,32,64} when using MIPS16
Date:   Mon,  7 Sep 2015 23:49:42 +0800
Message-Id: <1441640982-17547-1-git-send-email-yszhou4tech@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

Some GCC versions (e.g. 4.8.3) can incorrectly inline a function with
MIPS32 instructions into another function with MIPS16 code [1], causing
the assembler to genereate incorrect binary code or fail right away
complaining about unrecognized opcode.

In the case of __arch_swab{16,32}, when inlined by the compiler with
flags `-mips32r2 -mips16 -Os', the assembler can fail with the following
error.

    {standard input}:79: Error: unrecognized opcode `wsbh $2,$2'

For performance concerns and to workaround the issue already existing in
older compilers, just ignore these 2 functions when compiling with
mips16 enabled.

 [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55777

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
v2 <- v1

	Also ignore __arch_swab64 instead of just __arch_swab{16,32}.

 arch/mips/include/uapi/asm/swab.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 8f2d184..8b9a390 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -8,6 +8,11 @@
 #ifndef _ASM_SWAB_H
 #define _ASM_SWAB_H
 
+/*
+ * Enable the optimized version only when compiling without MIPS16.
+ */
+#ifndef __mips16
+
 #include <linux/compiler.h>
 #include <linux/types.h>
 
@@ -66,4 +71,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 #define __arch_swab64 __arch_swab64
 #endif /* __mips64 */
 #endif /* MIPS R2 or newer or Loongson 3A */
+#endif /* ifndef __mips16 */
 #endif /* _ASM_SWAB_H */
-- 
1.7.10.4
