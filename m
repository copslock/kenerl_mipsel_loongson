Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2004 15:46:44 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:48259 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226138AbUEaOqi>; Mon, 31 May 2004 15:46:38 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7E5A04ADBD; Mon, 31 May 2004 16:46:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 6D5834AC7D; Mon, 31 May 2004 16:46:31 +0200 (CEST)
Date: Mon, 31 May 2004 16:46:31 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] 2.4,2.6: Small inline assembly fixes
Message-ID: <Pine.LNX.4.55.0405311639440.18445@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 These are fixes for a bunch of inline assembly problems.  The ARC_CALL5 
change is important -- others are just clean-ups.  As an extra, a 
duplicate __NR_O32_Linux_syscalls definition is removed.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-mips-asm-0
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/sgiarcs.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/sgiarcs.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/sgiarcs.h	2003-05-29 02:57:12.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/sgiarcs.h	2004-05-30 14:34:33.000000000 +0000
@@ -462,7 +462,7 @@ struct linux_smonblock {
 	long __vec = (long) romvec->dest;				\
 	__asm__ __volatile__(						\
 	"dsubu\t$29, 32\n\t"						\
-	"sw\t%6, 16($29)\n\t"						\
+	"sw\t%7, 16($29)\n\t"						\
 	"jalr\t%1\n\t"							\
 	"daddu\t$29, 32\n\t"						\
 	"move\t%0, $2"							\
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/unistd.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/unistd.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/unistd.h	2003-11-01 03:57:23.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/unistd.h	2004-05-30 14:39:41.000000000 +0000
@@ -951,9 +951,9 @@ type name (atype a,btype b,ctype c,dtype
 	"syscall\n\t" \
 	"move\t%0, $2\n\t" \
 	".set\treorder" \
-	: "=&r" (__v0), "+r" (__a3), "+r" (__a4) \
-	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "=&r" (__v0), "+r" (__a3) \
+	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "i" (__NR_##name) \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -981,7 +981,7 @@ type name (atype a,btype b,ctype c,dtype
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "r" (__a5), \
 	  "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/sgiarcs.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/sgiarcs.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/sgiarcs.h	2004-01-07 23:02:08.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/sgiarcs.h	2004-05-30 14:34:33.000000000 +0000
@@ -462,7 +462,7 @@ struct linux_smonblock {
 	long __vec = (long) romvec->dest;				\
 	__asm__ __volatile__(						\
 	"dsubu\t$29, 32\n\t"						\
-	"sw\t%6, 16($29)\n\t"						\
+	"sw\t%7, 16($29)\n\t"						\
 	"jalr\t%1\n\t"							\
 	"daddu\t$29, 32\n\t"						\
 	"move\t%0, $2"							\
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/uaccess.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/uaccess.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/uaccess.h	2003-09-15 02:57:28.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/uaccess.h	2004-05-30 14:46:22.000000000 +0000
@@ -406,7 +406,6 @@ extern size_t __copy_user(void *__to, co
 	"daddu\t$1, %1, %2\n\t"						\
 	".set\tat\n\t"							\
 	".set\treorder\n\t"						\
-	"move\t%0, $6"							\
 	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31",		\
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/unistd.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/unistd.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/unistd.h	2003-10-29 03:57:28.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/unistd.h	2004-05-30 14:39:41.000000000 +0000
@@ -268,8 +268,6 @@
 #define __NR_O32_Linux			4000
 #define __NR_O32_Linux_syscalls		240
 
-#define __NR_O32_Linux_syscalls		240
-
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
 /*
@@ -953,9 +951,9 @@ type name (atype a,btype b,ctype c,dtype
 	"syscall\n\t" \
 	"move\t%0, $2\n\t" \
 	".set\treorder" \
-	: "=&r" (__v0), "+r" (__a3), "+r" (__a4) \
-	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "=&r" (__v0), "+r" (__a3) \
+	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "i" (__NR_##name) \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
@@ -983,7 +981,7 @@ type name (atype a,btype b,ctype c,dtype
 	: "=&r" (__v0), "+r" (__a3) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "r" (__a5), \
 	  "i" (__NR_##name) \
-	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
+	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
 	if (__a3 == 0) \
 		return (type) __v0; \
