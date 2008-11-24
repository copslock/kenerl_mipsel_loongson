Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2008 09:21:06 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:59805 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23852951AbYKXJVE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2008 09:21:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mAO9Kp7U013254;
	Mon, 24 Nov 2008 09:20:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mAO9KmsS013253;
	Mon, 24 Nov 2008 09:20:48 GMT
Date:	Mon, 24 Nov 2008 09:20:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
Message-ID: <20081124092048.GA21665@linux-mips.org>
References: <49260E4C.8080500@caviumnetworks.com> <20081121150023.032f7b5b.akpm@linux-foundation.org> <20081123095818.GU30453@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081123095818.GU30453@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 23, 2008 at 10:58:18AM +0100, Ingo Molnar wrote:

> yes - the total image effect is significantly - recently looked at how 
> much larger !CONFIG_BUG builds would get if we inserted an infinite 
> loop into them - it was in the 50K text range (!).
> 
> but in the x86 ud2 case we could guarantee that we wont ever return 
> from that exception. Mind sending a patch with a signoff, a 
> description and an infinite loop in the u2d handler?

The infinite loop is necessary to keep gcc from creating pointless warnings.
But I did play a bit further with bug.h, this time on x86.  Result below.

  Ralf

[PATCH] x86: Optimize BUG() codesize.

Turning the i386 BUG() into an inline function shaves off 4064 bytes for
a defconfig kernel and 16 bytes for the same kernel with
CONFIG_DEBUG_BUGVERBOSE cleared.  Tested with gcc 4.3.0.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 3def206..3b3bf2a 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -1,9 +1,10 @@
 #ifndef _ASM_X86_BUG_H
 #define _ASM_X86_BUG_H
 
-#ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
+#include <asm-generic/bug.h>
 
+#ifdef CONFIG_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
 #ifdef CONFIG_X86_32
@@ -12,28 +13,27 @@
 # define __BUG_C0	"2:\t.quad 1b, %c0\n"
 #endif
 
-#define BUG()							\
-do {								\
-	asm volatile("1:\tud2\n"				\
-		     ".pushsection __bug_table,\"a\"\n"		\
-		     __BUG_C0					\
-		     "\t.word %c1, 0\n"				\
-		     "\t.org 2b+%c2\n"				\
-		     ".popsection"				\
-		     : : "i" (__FILE__), "i" (__LINE__),	\
-		     "i" (sizeof(struct bug_entry)));		\
-	for (;;) ;						\
-} while (0)
+static inline void BUG(void)
+{
+	asm volatile("1:\tud2\n"
+		     ".pushsection __bug_table,\"a\"\n"
+		     __BUG_C0
+		     "\t.word %c1, 0\n"	
+		     "\t.org 2b+%c2\n"
+		     ".popsection"
+		     : : "i" (__FILE__), "i" (__LINE__),
+		     "i" (sizeof(struct bug_entry)));
+	for (;;) ;
+}
 
 #else
-#define BUG()							\
-do {								\
-	asm volatile("ud2");					\
-	for (;;) ;						\
-} while (0)
+static inline void BUG(void)
+{
+	asm volatile("ud2");
+	for (;;) ;
+}
 #endif
 
 #endif /* !CONFIG_BUG */
 
-#include <asm-generic/bug.h>
 #endif /* _ASM_X86_BUG_H */
