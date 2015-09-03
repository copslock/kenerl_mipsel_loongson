Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2015 11:51:49 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35785 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007451AbbICJvsMM0Hg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2015 11:51:48 +0200
Received: by pacfv12 with SMTP id fv12so42819484pac.2;
        Thu, 03 Sep 2015 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FuoMPNilt8iXA8de4lZAo2bp47ilzwBdc4FvErUReNA=;
        b=lxNPe7Itd4iGaUDzRO0p1LJyTvCmQMNf8cI5Ym23GFB5wpcRDbvmXzOb2SzllFk9Jj
         tVFdRnK+KGN/iQ45pUT1d2xsetnM153+adv813ly44JxyYJ1LV6YhS0m1OFczL8Ace7Y
         lo/UFbwxAwdR0gI04KXz3eh0BqlaAFH6aHMh5o+mpNnJHYlq1PAGehXRizCu4zNqCCbS
         3zAw9bVpbSWzyzJqPmuFHyuDb0vK96ioblbRNBzz92kxykStim2dVEyHu5519VcUhO2U
         T880hpXoOKtkFmsYcqzlXzl3B1yBS/Sz5l0VsYS0DEHBzBpNBdbO8svmqJOl0Dpj5cBS
         NFBw==
X-Received: by 10.67.12.166 with SMTP id er6mr66352948pad.40.1441273900792;
        Thu, 03 Sep 2015 02:51:40 -0700 (PDT)
Received: from debian.corp.sankuai.com ([103.29.140.56])
        by smtp.gmail.com with ESMTPSA id fb4sm23949711pdb.32.2015.09.03.02.51.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 02:51:40 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Chen Jie <chenj@lemote.com>, Yousong Zhou <yszhou4tech@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when using MIPS16.
Date:   Thu,  3 Sep 2015 17:47:45 +0800
Message-Id: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49095
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

The nomips16 has to be added both as function attribute and assembler
directive.

When only function attribute is specified, the compiler will inline the
function with -Os optimization.  The generated assembly code cannot be
correctly assembled because ISA mode switch has to be done through jump
instruction.

When only ".set nomips16" directive is used, the generated assembly code
will use MIPS32 code for the inline assembly template and MIPS16 for the
function return.  The compiled binary is invalid:

    00403100 <__arch_swab16>:
      403100:   7c0410a0    wsbh    v0,a0
      403104:   e820ea31    swc2    $0,-5583(at)

while correct code should be:

    00402650 <__arch_swab16>:
      402650:   7c0410a0    wsbh    v0,a0
      402654:   03e00008    jr  ra
      402658:   3042ffff    andi    v0,v0,0xffff

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 arch/mips/include/uapi/asm/swab.h |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 8f2d184..c4ddc4f 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -16,11 +16,13 @@
 #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
     defined(_MIPS_ARCH_LOONGSON3A)
 
-static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
+static inline __attribute__((nomips16)) __attribute_const__
+		__u16 __arch_swab16(__u16 x)
 {
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips32r2		\n"
+	"	.set	nomips16		\n"
 	"	wsbh	%0, %1			\n"
 	"	.set	pop			\n"
 	: "=r" (x)
@@ -30,11 +32,13 @@ static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 }
 #define __arch_swab16 __arch_swab16
 
-static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
+static inline __attribute__((nomips16)) __attribute_const__
+		__u32 __arch_swab32(__u32 x)
 {
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips32r2		\n"
+	"	.set	nomips16		\n"
 	"	wsbh	%0, %1			\n"
 	"	rotr	%0, %0, 16		\n"
 	"	.set	pop			\n"
@@ -50,11 +54,13 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
  * 64-bit kernel on r2 CPUs.
  */
 #ifdef __mips64
-static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
+static inline __attribute__((nomips16)) __attribute_const__
+		__u64 __arch_swab64(__u64 x)
 {
 	__asm__(
 	"	.set	push			\n"
 	"	.set	arch=mips64r2		\n"
+	"	.set	nomips16		\n"
 	"	dsbh	%0, %1			\n"
 	"	dshd	%0, %0			\n"
 	"	.set	pop			\n"
-- 
1.7.10.4
