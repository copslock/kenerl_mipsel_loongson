Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2017 17:43:54 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992568AbdGMPnqGk4U6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2017 17:43:46 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1ABCBAE1;
        Thu, 13 Jul 2017 15:43:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yousong Zhou <yszhou4tech@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 02/22] MIPS: UAPI: Ignore __arch_swab{16,32,64} when using MIPS16
Date:   Thu, 13 Jul 2017 17:42:42 +0200
Message-Id: <20170713153934.228855979@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170713153934.089183081@linuxfoundation.org>
References: <20170713153934.089183081@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yousong Zhou <yszhou4tech@gmail.com>

commit 71a0a72456b48de972d7ed613b06a22a3aa9057f upstream.

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

 [1] Inlining nomips16 function into mips16 function can result in
     undefined builtins, https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55777

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11241/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/uapi/asm/swab.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -13,8 +13,9 @@
 
 #define __SWAB_64_THRU_32__
 
-#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
-    defined(_MIPS_ARCH_LOONGSON3A)
+#if !defined(__mips16) &&					\
+	((defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||	\
+	 defined(_MIPS_ARCH_LOONGSON3A))
 
 static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
@@ -65,5 +66,5 @@ static inline __attribute_const__ __u64
 }
 #define __arch_swab64 __arch_swab64
 #endif /* __mips64 */
-#endif /* MIPS R2 or newer or Loongson 3A */
+#endif /* (not __mips16) and (MIPS R2 or newer or Loongson 3A) */
 #endif /* _ASM_SWAB_H */
