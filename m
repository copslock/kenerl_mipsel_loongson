Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 04:06:06 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:24076 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S98555AbUJTDFz>; Wed, 20 Oct 2004 04:05:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 29352FD8A4; Wed, 20 Oct 2004 05:05:42 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13964-06; Wed, 20 Oct 2004 05:05:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C7AF5F59B2; Wed, 20 Oct 2004 05:05:41 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id i9K35efD028478;
	Wed, 20 Oct 2004 05:05:42 +0200
Date: Wed, 20 Oct 2004 04:05:40 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: macro@mips.com, linux-mips@linux-mips.org,
	Dominic Sweetman <dom@mips.com>,
	Nigel Stephens <nigel@mips.com>
Subject: Re: [patch] glibc 2.3: Memory clobber missing from syscalls
In-Reply-To: <20041018.103737.74754888.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.58L.0410200227140.13131@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com>
 <20041018.103737.74754888.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/538/Tue Oct 19 12:04:13 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Oct 2004, Atsushi Nemoto wrote:

> Then, kernel header (include/asm-mips/unistd.h) should be fixed too?

 Absolutely.  These macros are not used extensively -- apparently only
_syscall3() is used for execve, but that does not mean they are meant to
be broken.  Thanks for pointing the problem out.

 Here is an update to a patch I proposed a while ago and which is still
needed.  The patch applies to 2.4.  For 2.6 just ignore missing files and
the single reject in unistd.h -- I think there is no point wasting
resources by sending another patch just to cover these bits.

 Ralf, may I ask for approval?  Please -- this has waited for too long 
already IMHO...

  Maciej

patch-mips-2.4.27-20041019-mips-asm-2
diff -up --recursive --new-file linux-mips-2.4.27-20041019.macro/include/asm-mips/sgiarcs.h linux-mips-2.4.27-20041019/include/asm-mips/sgiarcs.h
--- linux-mips-2.4.27-20041019.macro/include/asm-mips/sgiarcs.h	2004-10-17 03:58:21.000000000 +0000
+++ linux-mips-2.4.27-20041019/include/asm-mips/sgiarcs.h	2004-10-20 02:49:40.000000000 +0000
@@ -462,7 +462,7 @@ struct linux_smonblock {
 	long __vec = (long) romvec->dest;				\
 	__asm__ __volatile__(						\
 	"dsubu\t$29, 32\n\t"						\
-	"sw\t%6, 16($29)\n\t"						\
+	"sw\t%7, 16($29)\n\t"						\
 	"jalr\t%1\n\t"							\
 	"daddu\t$29, 32\n\t"						\
 	"move\t%0, $2"							\
diff -up --recursive --new-file linux-mips-2.4.27-20041019.macro/include/asm-mips/uaccess.h linux-mips-2.4.27-20041019/include/asm-mips/uaccess.h
--- linux-mips-2.4.27-20041019.macro/include/asm-mips/uaccess.h	2004-10-17 03:58:21.000000000 +0000
+++ linux-mips-2.4.27-20041019/include/asm-mips/uaccess.h	2004-10-20 02:57:02.000000000 +0000
@@ -502,8 +502,7 @@ extern size_t __copy_user(void *__to, co
 	".set\tnoat\n\t"						\
 	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
-	".set\treorder\n\t"						\
-	"move\t%0, $6"		/* XXX */				\
+	".set\treorder"							\
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
diff -up --recursive --new-file linux-mips-2.4.27-20041019.macro/include/asm-mips/unistd.h linux-mips-2.4.27-20041019/include/asm-mips/unistd.h
--- linux-mips-2.4.27-20041019.macro/include/asm-mips/unistd.h	2004-04-09 02:58:05.000000000 +0000
+++ linux-mips-2.4.27-20041019/include/asm-mips/unistd.h	2004-10-20 00:50:11.000000000 +0000
@@ -491,7 +491,7 @@
 #define __NR_semtimedop			(__NR_Linux + 214)
 
 /*
- * Offset of the last Linux flavoured syscall
+ * Offset of the last Linux 64-bit flavoured syscall
  */
 #define __NR_Linux_syscalls		214
 
@@ -730,7 +730,7 @@
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_N32_Linux_syscalls		219
+#define __NR_Linux_syscalls		219
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
@@ -754,7 +754,8 @@ type name(void) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -781,7 +782,8 @@ type name(atype a) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "r" (__a0), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -805,7 +807,8 @@ type name(atype a, btype b) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "r" (__a0), "r" (__a1), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -830,7 +833,8 @@ type name(atype a, btype b, ctype c) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -855,7 +859,8 @@ type name(atype a, btype b, ctype c, dty
 	".set\treorder" \
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -891,7 +896,8 @@ type name(atype a, btype b, ctype c, dty
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name), \
 	  "m" ((unsigned long)e) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -923,7 +929,8 @@ type name(atype a, btype b, ctype c, dty
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name), \
 	  "m" ((unsigned long)e), "m" ((unsigned long)f) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -951,9 +958,10 @@ type name (atype a,btype b,ctype c,dtype
 	"syscall\n\t" \
 	"move\t%0, $2\n\t" \
 	".set\treorder" \
-	: "=&r" (__v0), "+r" (__a3), "+r" (__a4) \
-	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "=&r" (__v0), "+r" (__a3) \
+	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "i" (__NR_##name) \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -981,7 +989,8 @@ type name (atype a,btype b,ctype c,dtype
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "r" (__a5), \
 	  "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
diff -up --recursive --new-file linux-mips-2.4.27-20041019.macro/include/asm-mips64/sgiarcs.h linux-mips-2.4.27-20041019/include/asm-mips64/sgiarcs.h
--- linux-mips-2.4.27-20041019.macro/include/asm-mips64/sgiarcs.h	2004-10-17 03:58:27.000000000 +0000
+++ linux-mips-2.4.27-20041019/include/asm-mips64/sgiarcs.h	2004-10-20 02:49:40.000000000 +0000
@@ -462,7 +462,7 @@ struct linux_smonblock {
 	long __vec = (long) romvec->dest;				\
 	__asm__ __volatile__(						\
 	"dsubu\t$29, 32\n\t"						\
-	"sw\t%6, 16($29)\n\t"						\
+	"sw\t%7, 16($29)\n\t"						\
 	"jalr\t%1\n\t"							\
 	"daddu\t$29, 32\n\t"						\
 	"move\t%0, $2"							\
diff -up --recursive --new-file linux-mips-2.4.27-20041019.macro/include/asm-mips64/uaccess.h linux-mips-2.4.27-20041019/include/asm-mips64/uaccess.h
--- linux-mips-2.4.27-20041019.macro/include/asm-mips64/uaccess.h	2004-10-17 03:58:28.000000000 +0000
+++ linux-mips-2.4.27-20041019/include/asm-mips64/uaccess.h	2004-10-20 02:57:12.000000000 +0000
@@ -499,8 +499,7 @@ extern size_t __copy_user(void *__to, co
 	".set\tnoat\n\t"						\
 	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
-	".set\treorder\n\t"						\
-	"move\t%0, $6"		/* XXX */				\
+	".set\treorder"							\
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
diff -up --recursive --new-file linux-mips-2.4.27-20041019.macro/include/asm-mips64/unistd.h linux-mips-2.4.27-20041019/include/asm-mips64/unistd.h
--- linux-mips-2.4.27-20041019.macro/include/asm-mips64/unistd.h	2004-04-09 02:58:06.000000000 +0000
+++ linux-mips-2.4.27-20041019/include/asm-mips64/unistd.h	2004-10-20 00:53:47.000000000 +0000
@@ -268,8 +268,6 @@
 #define __NR_O32_Linux			4000
 #define __NR_O32_Linux_syscalls		240
 
-#define __NR_O32_Linux_syscalls		240
-
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
 /*
@@ -493,7 +491,7 @@
 #define __NR_semtimedop			(__NR_Linux + 214)
 
 /*
- * Offset of the last Linux flavoured syscall
+ * Offset of the last Linux 64-bit flavoured syscall
  */
 #define __NR_Linux_syscalls		214
 
@@ -732,7 +730,7 @@
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_N32_Linux_syscalls		219
+#define __NR_Linux_syscalls		219
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
@@ -756,7 +754,8 @@ type name(void) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -783,7 +782,8 @@ type name(atype a) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "r" (__a0), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -807,7 +807,8 @@ type name(atype a, btype b) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "r" (__a0), "r" (__a1), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -832,7 +833,8 @@ type name(atype a, btype b, ctype c) \
 	".set\treorder" \
 	: "=&r" (__v0), "=r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -857,7 +859,8 @@ type name(atype a, btype b, ctype c, dty
 	".set\treorder" \
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -893,7 +896,8 @@ type name(atype a, btype b, ctype c, dty
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name), \
 	  "m" ((unsigned long)e) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -925,7 +929,8 @@ type name(atype a, btype b, ctype c, dty
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name), \
 	  "m" ((unsigned long)e), "m" ((unsigned long)f) \
-	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -953,9 +958,10 @@ type name (atype a,btype b,ctype c,dtype
 	"syscall\n\t" \
 	"move\t%0, $2\n\t" \
 	".set\treorder" \
-	: "=&r" (__v0), "+r" (__a3), "+r" (__a4) \
-	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "=&r" (__v0), "+r" (__a3) \
+	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "i" (__NR_##name) \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -983,7 +989,8 @@ type name (atype a,btype b,ctype c,dtype
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "r" (__a5), \
 	  "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
+	  "memory"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
