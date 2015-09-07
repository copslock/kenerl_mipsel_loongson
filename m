Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 14:31:47 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35851 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007763AbbIGMbpY0BT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 14:31:45 +0200
Received: by padhk3 with SMTP id hk3so11511908pad.3;
        Mon, 07 Sep 2015 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DvC8s6wYqqcrIx/2tHSsxuZhPPa6WVpiCWS4DtEwBO8=;
        b=CGw6etrZcujx/OST6fEVaJ9gUH9NbW1FoP1hci6+8SWTFye1NhBO8Za7gRuVmIrbdJ
         UipwooRfHj4toFjqWmywmoe5xIJCxhevSzenE4vIabr+mEo08Z8pMb4zf5TTpOq3uR9L
         5IaP3MG2kNDJoYITmVDYCC5VCkWF6eCUcnq0G/MOl4ChgfAJWOcXfMcxOWUZaGl92xN4
         CX9Cb9r2m+tw59RKIWA5p+z5lBh996dz/gXHMIdlX+1tuyNA66hQqk0QyefyZaShtr9S
         dKZCDIE2mxDh1RKiexElmdhD17uuBsM068kYNddBdbAzh4fpL88FRjXaYxMgQbt4xf0b
         oQQw==
X-Received: by 10.68.218.136 with SMTP id pg8mr45496265pbc.169.1441629098980;
        Mon, 07 Sep 2015 05:31:38 -0700 (PDT)
Received: from debian.corp.sankuai.com ([103.29.140.57])
        by smtp.gmail.com with ESMTPSA id t5sm11918853pde.34.2015.09.07.05.31.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 05:31:38 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH] MIPS: UAPI: Disable __arch_swab{16,32} when using MIPS16
Date:   Mon,  7 Sep 2015 20:27:37 +0800
Message-Id: <1441628857-24342-1-git-send-email-yszhou4tech@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49125
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
 arch/mips/include/uapi/asm/swab.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 8f2d184..8396d5a 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -16,6 +16,10 @@
 #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
     defined(_MIPS_ARCH_LOONGSON3A)
 
+/*
+ * Enable the optimized version only when compiling without MIPS16.
+ */
+#ifndef __mips16
 static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
 	__asm__(
@@ -44,6 +48,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 	return x;
 }
 #define __arch_swab32 __arch_swab32
+#endif /* ifndef __mips16 */
 
 /*
  * Having already checked for MIPS R2, enable the optimized version for
-- 
1.7.10.4
