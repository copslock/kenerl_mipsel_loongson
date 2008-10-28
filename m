Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 07:30:27 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:24800 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22551599AbYJ1HaT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 07:30:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9S7UGUO020986;
	Tue, 28 Oct 2008 07:30:16 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9S7UGEB020985;
	Tue, 28 Oct 2008 07:30:16 GMT
Date:	Tue, 28 Oct 2008 07:30:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 09/36] Enable mips32 style bitops for Cavium OCTEON.
Message-ID: <20081028073016.GA20858@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:41PM -0700, David Daney wrote:

> Enable the basic bitops like __ffs and so forth that would normally be
> on if we were MIPS32 or MIPS64, but aren't since Cavium sets neither.
> 
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Signed-off-by: David Daney<ddaney@caviumnetworks.com>

Counter proposal.  Instead of making the #ifdefery worse get rid of it
entirely and give the optimizer a little hand with __builtin_constant_p
to get things right for every platform.

(This patch has gone through it-looks-good-so-it-must-be-good QA ...)

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/bitops.h       |  108 +++++++++++++++++++++++------------
 arch/mips/include/asm/cpu-features.h |    2 
 2 files changed, 75 insertions(+), 35 deletions(-)

Index: linux-mips/arch/mips/include/asm/bitops.h
===================================================================
--- linux-mips.orig/arch/mips/include/asm/bitops.h
+++ linux-mips/arch/mips/include/asm/bitops.h
@@ -558,39 +558,67 @@ static inline void __clear_bit_unlock(un
 	__clear_bit(nr, addr);
 }
 
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-
 /*
  * Return the bit position (0..63) of the most significant 1 bit in a word
  * Returns -1 if no 1 bit exists
  */
 static inline unsigned long __fls(unsigned long x)
 {
-	int lz;
+	int num;
 
-	if (sizeof(x) == 4) {
+	if (BITS_PER_LONG == 32 &&
+	    __builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r) {
 		__asm__(
 		"	.set	push					\n"
 		"	.set	mips32					\n"
 		"	clz	%0, %1					\n"
 		"	.set	pop					\n"
-		: "=r" (lz)
+		: "=r" (num)
 		: "r" (x));
 
-		return 31 - lz;
+		return 31 - num;
 	}
 
-	BUG_ON(sizeof(x) != 8);
+	if (BITS_PER_LONG == 64 &&
+	    __builtin_constant_p(cpu_has_mips64) && cpu_has_mips64) {
+		__asm__(
+		"	.set	push					\n"
+		"	.set	mips64					\n"
+		"	dclz	%0, %1					\n"
+		"	.set	pop					\n"
+		: "=r" (num)
+		: "r" (x));
+
+		return 63 - num;
+	}
 
-	__asm__(
-	"	.set	push						\n"
-	"	.set	mips64						\n"
-	"	dclz	%0, %1						\n"
-	"	.set	pop						\n"
-	: "=r" (lz)
-	: "r" (x));
+	num = BITS_PER_LONG - 1;
 
-	return 63 - lz;
+#if BITS_PER_LONG == 64
+	if (!(word & (~0ul << 32))) {
+		num -= 32;
+		word <<= 32;
+	}
+#endif
+	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
+		num -= 16;
+		word <<= 16;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
+		num -= 8;
+		word <<= 8;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
+		num -= 4;
+		word <<= 4;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
+		num -= 2;
+		word <<= 2;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG-1))))
+		num -= 1;
+	return num;
 }
 
 /*
@@ -614,21 +642,41 @@ static inline unsigned long __ffs(unsign
  */
 static inline int fls(int word)
 {
-	__asm__("clz %0, %1" : "=r" (word) : "r" (word));
+	int r;
 
-	return 32 - word;
-}
+	if (__builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r) {
+		__asm__("clz %0, %1" : "=r" (word) : "r" (word));
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPS64)
-static inline int fls64(__u64 word)
-{
-	__asm__("dclz %0, %1" : "=r" (word) : "r" (word));
+		return 32 - word;
+	}
 
-	return 64 - word;
+	r = 32;
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
 }
-#else
+
 #include <asm-generic/bitops/fls64.h>
-#endif
 
 /*
  * ffs - find first bit set.
@@ -646,16 +694,6 @@ static inline int ffs(int word)
 	return fls(word & -word);
 }
 
-#else
-
-#include <asm-generic/bitops/__ffs.h>
-#include <asm-generic/bitops/__fls.h>
-#include <asm-generic/bitops/ffs.h>
-#include <asm-generic/bitops/fls.h>
-#include <asm-generic/bitops/fls64.h>
-
-#endif /*defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) */
-
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/find.h>
 
Index: linux-mips/arch/mips/include/asm/cpu-features.h
===================================================================
--- linux-mips.orig/arch/mips/include/asm/cpu-features.h
+++ linux-mips/arch/mips/include/asm/cpu-features.h
@@ -141,6 +141,8 @@
 #define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2)
 #define cpu_has_mips_r1	(cpu_has_mips32r1 | cpu_has_mips64r1)
 #define cpu_has_mips_r2	(cpu_has_mips32r2 | cpu_has_mips64r2)
+#define cpu_has_mips_r	(cpu_has_mips32r1 | cpu_has_mips32r2 | \
+			 cpu_has_mips64r1 | cpu_has_mips64r2)
 
 #ifndef cpu_has_dsp
 #define cpu_has_dsp		(cpu_data[0].ases & MIPS_ASE_DSP)
