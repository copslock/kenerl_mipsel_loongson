Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 16:08:11 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:48369 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225198AbUIAPIH>; Wed, 1 Sep 2004 16:08:07 +0100
Received: from localhost (p6055-ipad204funabasi.chiba.ocn.ne.jp [222.146.93.55])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 03E4A74F3; Thu,  2 Sep 2004 00:08:03 +0900 (JST)
Date: Thu, 02 Sep 2004 00:16:35 +0900 (JST)
Message-Id: <20040902.001635.92589944.anemo@mba.ocn.ne.jp>
To: rsandifo@redhat.com
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040902.001433.59461413.anemo@mba.ocn.ne.jp>
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp>
	<87656yqsmz.fsf@redhat.com>
	<20040902.001433.59461413.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 02 Sep 2004 00:14:33 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> Thank you.  I create a patch for kernel with this workaround.
anemo> # This patch assumes gcc 3.5 will be free from this problem :-)

anemo> Could you apply, Ralf?

And this is for 2.4 tree.

diff -u linux-mips-2.4-cvs/include/asm-mips/paccess.h linux-mips-2.4/include/asm-mips/paccess.h
--- linux-mips-2.4-cvs/include/asm-mips/paccess.h	Tue Nov 11 21:49:34 2003
+++ linux-mips-2.4/include/asm-mips/paccess.h	Wed Sep  1 23:21:41 2004
@@ -14,6 +14,7 @@
 #define _ASM_PACCESS_H
 
 #include <linux/errno.h>
+#include <asm/war.h>
 
 #define put_dbe(x,ptr) __put_dbe((x),(ptr),sizeof(*(ptr)))
 #define get_dbe(x,ptr) __get_dbe((x),(ptr),sizeof(*(ptr)))
@@ -25,7 +26,7 @@
 int __gu_err; \
 __typeof(*(ptr)) __gu_val; \
 unsigned long __gu_addr; \
-__asm__("":"=r" (__gu_val)); \
+__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val)); \
 __gu_addr = (unsigned long) (ptr); \
 __asm__("":"=r" (__gu_err)); \
 switch (size) { \
@@ -64,7 +65,7 @@
 unsigned long __pu_addr; \
 __pu_val = (x); \
 __pu_addr = (unsigned long) (ptr); \
-__asm__("":"=r" (__pu_err)); \
+__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err)); \
 switch (size) { \
 case 1: __put_dbe_asm("sb"); break; \
 case 2: __put_dbe_asm("sh"); break; \
diff -u linux-mips-2.4-cvs/include/asm-mips/uaccess.h linux-mips-2.4/include/asm-mips/uaccess.h
--- linux-mips-2.4-cvs/include/asm-mips/uaccess.h	Mon Sep 15 10:28:51 2003
+++ linux-mips-2.4/include/asm-mips/uaccess.h	Wed Sep  1 23:24:00 2004
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <asm/war.h>
 
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
@@ -200,9 +201,9 @@
 	long __gu_err;							\
 	__typeof(*(ptr)) __gu_val;					\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));		\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_err));		\
 	switch (size) {							\
 		case 1: __get_user_asm("lb"); break;			\
 		case 2: __get_user_asm("lh"); break;			\
@@ -218,9 +219,9 @@
 	long __gu_err;							\
 	__typeof__(*(ptr)) __gu_val;					\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));		\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_err));		\
 	if (access_ok(VERIFY_READ, __gu_addr, size)) {			\
 		switch (size) {						\
 		case 1: __get_user_asm("lb"); break;			\
@@ -294,7 +295,7 @@
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	switch (size) {							\
 		case 1: __put_user_asm("sb"); break;			\
 		case 2: __put_user_asm("sh"); break;			\
@@ -312,7 +313,7 @@
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	if (access_ok(VERIFY_WRITE, __pu_addr, size)) {			\
 		switch (size) {						\
 		case 1: __put_user_asm("sb"); break;			\
diff -u linux-mips-2.4-cvs/include/asm-mips/war.h linux-mips-2.4/include/asm-mips/war.h
--- linux-mips-2.4-cvs/include/asm-mips/war.h	Mon Mar  8 20:21:39 2004
+++ linux-mips-2.4/include/asm-mips/war.h	Wed Sep  1 23:23:04 2004
@@ -210,4 +210,10 @@
 #define RM9000_CDEX_SMP_WAR		0
 #endif
 
+#if (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 4))
+#define GCC_ASM_PROTECT_DSLOT
+#else
+#define GCC_ASM_PROTECT_DSLOT	__volatile__
+#endif
+
 #endif /* _ASM_WAR_H */
diff -u linux-mips-2.4-cvs/include/asm-mips64/paccess.h linux-mips-2.4/include/asm-mips64/paccess.h
--- linux-mips-2.4-cvs/include/asm-mips64/paccess.h	Mon Jul  9 09:25:38 2001
+++ linux-mips-2.4/include/asm-mips64/paccess.h	Wed Sep  1 23:21:41 2004
@@ -14,6 +14,7 @@
 #define _ASM_PACCESS_H
 
 #include <linux/errno.h>
+#include <asm/war.h>
 
 #define put_dbe(x,ptr) __put_dbe((x),(ptr),sizeof(*(ptr)))
 #define get_dbe(x,ptr) __get_dbe((x),(ptr),sizeof(*(ptr)))
@@ -25,7 +26,7 @@
 long __gu_err; \
 __typeof(*(ptr)) __gu_val; \
 long __gu_addr; \
-__asm__("":"=r" (__gu_val)); \
+__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val)); \
 __gu_addr = (long) (ptr); \
 __asm__("":"=r" (__gu_err)); \
 switch (size) { \
@@ -61,7 +62,7 @@
 long __pu_addr; \
 __pu_val = (x); \
 __pu_addr = (long) (ptr); \
-__asm__("":"=r" (__pu_err)); \
+__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err)); \
 switch (size) { \
 case 1: __put_dbe_asm("sb"); break; \
 case 2: __put_dbe_asm("sh"); break; \
diff -u linux-mips-2.4-cvs/include/asm-mips64/uaccess.h linux-mips-2.4/include/asm-mips64/uaccess.h
--- linux-mips-2.4-cvs/include/asm-mips64/uaccess.h	Wed Sep 17 23:22:35 2003
+++ linux-mips-2.4/include/asm-mips64/uaccess.h	Wed Sep  1 23:23:35 2004
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <asm/war.h>
 
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
@@ -190,9 +191,9 @@
 	long __gu_err;							\
 	__typeof(*(ptr)) __gu_val;					\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));		\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_err));		\
 	switch (size) {							\
 		case 1: __get_user_asm("lb"); break;			\
 		case 2: __get_user_asm("lh"); break;			\
@@ -208,9 +209,9 @@
 	long __gu_err;							\
 	__typeof__(*(ptr)) __gu_val;					\
 	long __gu_addr;							\
-	__asm__("":"=r" (__gu_val));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));		\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_err));		\
 	if (access_ok(VERIFY_READ, __gu_addr, size)) {			\
 		switch (size) {						\
 		case 1: __get_user_asm("lb"); break;			\
@@ -250,7 +251,7 @@
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	switch (size) {							\
 		case 1: __put_user_asm("sb"); break;			\
 		case 2: __put_user_asm("sh"); break;			\
@@ -268,7 +269,7 @@
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	if (access_ok(VERIFY_WRITE, __pu_addr, size)) {			\
 		switch (size) {						\
 		case 1: __put_user_asm("sb"); break;			\
diff -u linux-mips-2.4-cvs/include/asm-mips64/war.h linux-mips-2.4/include/asm-mips64/war.h
--- linux-mips-2.4-cvs/include/asm-mips64/war.h	Mon Mar  8 20:21:39 2004
+++ linux-mips-2.4/include/asm-mips64/war.h	Wed Sep  1 23:23:12 2004
@@ -210,4 +210,10 @@
 #define RM9000_CDEX_SMP_WAR		0
 #endif
 
+#if (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 4))
+#define GCC_ASM_PROTECT_DSLOT
+#else
+#define GCC_ASM_PROTECT_DSLOT	__volatile__
+#endif
+
 #endif /* _ASM_WAR_H */
