Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2015 07:47:24 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34686 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006861AbbIZFrMQhPj9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2015 07:47:12 +0200
Received: by padhy16 with SMTP id hy16so124600867pad.1;
        Fri, 25 Sep 2015 22:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtiANc8sbBpdRXt6xe6GAxSLzgGVChhWnj5SFIrpkog=;
        b=tY7JXOis89xCPy/h5DnXOWklJgGOgsYu/vk/8dH2WI0SspTxKVBPe4IJmgCcfm3AEZ
         yUXIrTYUeaEe5CPacOqrK7qq3g5q5pNtQvPIEC9l5s7hn3N5dLG6BAm3OcfgX4cFYQyx
         9ODKV+tI1CCecrcHdLCshgubRqhAqgFN74UBnMnQO9jvY7pGVgOLDfgZziys8dhN9sms
         0QpufyS9B46CPoUne/XvFURkryxbRGxUgtZLfpSyDIz+M0rUjKiegdyTPVzDQKQ6sFd1
         yIH11OTMRrvlMuSlSN/K4MxMTz10VnMSTE2/yNCxG2iqNe4eUsA6abgPtgN5WNg1j/Iu
         Acyg==
X-Received: by 10.66.253.170 with SMTP id ab10mr12282469pad.135.1443246421650;
        Fri, 25 Sep 2015 22:47:01 -0700 (PDT)
Received: from debian.corp.sankuai.com ([103.29.140.56])
        by smtp.gmail.com with ESMTPSA id gt1sm7074339pbc.10.2015.09.25.22.46.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2015 22:47:00 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH v3 1/2] Revert "MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when using MIPS16."
Date:   Sat, 26 Sep 2015 13:41:42 +0800
Message-Id: <1443246103-31122-2-git-send-email-yszhou4tech@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1443246103-31122-1-git-send-email-yszhou4tech@gmail.com>
References: <1443246103-31122-1-git-send-email-yszhou4tech@gmail.com>
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49372
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

This reverts commit e0d8b2ec532852d4b5aabcec3e7611848c32237d.

For at least GCC 4.8.3, adding nomips16 function attribute still cannot
prevent it from being inlined in mips16 context.  So revert it first in
preparation for a better workaround.

 [1] Inlining nomips16 function into mips16 function can result in
     undefined builtins, https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55777

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 arch/mips/include/uapi/asm/swab.h |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index c4ddc4f..8f2d184 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -16,13 +16,11 @@
 #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
     defined(_MIPS_ARCH_LOONGSON3A)
 
-static inline __attribute__((nomips16)) __attribute_const__
-		__u16 __arch_swab16(__u16 x)
+static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips32r2		\n"
-	"	.set	nomips16		\n"
 	"	wsbh	%0, %1			\n"
 	"	.set	pop			\n"
 	: "=r" (x)
@@ -32,13 +30,11 @@ static inline __attribute__((nomips16)) __attribute_const__
 }
 #define __arch_swab16 __arch_swab16
 
-static inline __attribute__((nomips16)) __attribute_const__
-		__u32 __arch_swab32(__u32 x)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips32r2		\n"
-	"	.set	nomips16		\n"
 	"	wsbh	%0, %1			\n"
 	"	rotr	%0, %0, 16		\n"
 	"	.set	pop			\n"
@@ -54,13 +50,11 @@ static inline __attribute__((nomips16)) __attribute_const__
  * 64-bit kernel on r2 CPUs.
  */
 #ifdef __mips64
-static inline __attribute__((nomips16)) __attribute_const__
-		__u64 __arch_swab64(__u64 x)
+static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips64r2		\n"
-	"	.set	nomips16		\n"
 	"	dsbh	%0, %1			\n"
 	"	dshd	%0, %0			\n"
 	"	.set	pop			\n"
-- 
1.7.10.4
