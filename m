Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 16:06:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:33480 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224988AbUIAPGE>; Wed, 1 Sep 2004 16:06:04 +0100
Received: from localhost (p6055-ipad204funabasi.chiba.ocn.ne.jp [222.146.93.55])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 94FAD70C7; Thu,  2 Sep 2004 00:06:00 +0900 (JST)
Date: Thu, 02 Sep 2004 00:14:33 +0900 (JST)
Message-Id: <20040902.001433.59461413.anemo@mba.ocn.ne.jp>
To: rsandifo@redhat.com
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <87656yqsmz.fsf@redhat.com>
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp>
	<87656yqsmz.fsf@redhat.com>
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
X-archive-position: 5762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 01 Sep 2004 09:51:16 +0100, Richard Sandiford <rsandifo@redhat.com> said:
>> Is this a get_user's problem or gcc's?
rsandifo> The latter.  gcc is putting the empty asm:

rsandifo> 	__asm__ ("":"=r" (__gu_val));

rsandifo> into the delay slot of the call.

Thank you for the detailed explanation.

rsandifo> FWIW, I don't think the bug is specific to 3.3 or 3.4.  It
rsandifo> could probably trigger for other gcc versions too.  It is
rsandifo> highly dependent on scheduling though.

Yes, this problem was originally found on gcc 3.2.

rsandifo> The attached 3.4.x patch fixes the problem there, but if you
rsandifo> want to work around it for old versions, just avoid using
rsandifo> empty asms if you can, or make them volatile if you can't.

Thank you.  I create a patch for kernel with this workaround.

# This patch assumes gcc 3.5 will be free from this problem :-)

Could you apply, Ralf?

diff -u linux-mips-cvs/include/asm-mips/paccess.h linux-mips/include/asm-mips/paccess.h
--- linux-mips-cvs/include/asm-mips/paccess.h	Mon Nov 24 20:22:01 2003
+++ linux-mips/include/asm-mips/paccess.h	Wed Sep  1 22:49:30 2004
@@ -15,6 +15,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
+#include <asm/war.h>
 
 #ifdef CONFIG_MIPS32
 #define __PA_ADDR	".word"
@@ -37,7 +38,7 @@
 	long __gu_err;							\
 	__typeof(*(ptr)) __gu_val;					\
 	unsigned long __gu_addr;					\
-	__asm__("":"=r" (__gu_val));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));		\
 	__gu_addr = (unsigned long) (ptr);				\
 	__asm__("":"=r" (__gu_err));					\
 	switch (size) {							\
@@ -78,7 +79,7 @@
 	long __pu_addr;							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	switch (size) {							\
 	case 1: __put_dbe_asm("sb"); break;				\
 	case 2: __put_dbe_asm("sh"); break;				\
diff -u linux-mips-cvs/include/asm-mips/uaccess.h linux-mips/include/asm-mips/uaccess.h
--- linux-mips-cvs/include/asm-mips/uaccess.h	Wed Mar 31 20:21:59 2004
+++ linux-mips/include/asm-mips/uaccess.h	Wed Sep  1 23:24:15 2004
@@ -13,6 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/thread_info.h>
+#include <asm/war.h>
 
 /*
  * The fs value determines whether argument validity checking should be
@@ -235,9 +236,9 @@
 	__typeof(*(ptr)) __gu_val;				\
 	long __gu_addr;						\
 	might_sleep();						\
-	__asm__("":"=r" (__gu_val));				\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));	\
 	__gu_addr = (long) (ptr);				\
-	__asm__("":"=r" (__gu_err));				\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_err));	\
 	switch (size) {						\
 	case 1: __get_user_asm("lb"); break;			\
 	case 2: __get_user_asm("lh"); break;			\
@@ -253,9 +254,9 @@
 	__typeof__(*(ptr)) __gu_val;					\
 	long __gu_addr;							\
 	might_sleep();							\
-	__asm__("":"=r" (__gu_val));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_val));		\
 	__gu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__gu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__gu_err));		\
 	if (access_ok(VERIFY_READ,__gu_addr,size)) {			\
 		switch (size) {						\
 		case 1: __get_user_asm("lb"); break;			\
@@ -329,7 +330,7 @@
 	might_sleep();							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	switch (size) {							\
 	case 1: __put_user_asm("sb"); break;				\
 	case 2: __put_user_asm("sh"); break;				\
@@ -348,7 +349,7 @@
 	might_sleep();							\
 	__pu_val = (x);							\
 	__pu_addr = (long) (ptr);					\
-	__asm__("":"=r" (__pu_err));					\
+	__asm__ GCC_ASM_PROTECT_DSLOT ("":"=r" (__pu_err));		\
 	if (access_ok(VERIFY_WRITE, __pu_addr, size)) {			\
 		switch (size) {						\
 		case 1: __put_user_asm("sb"); break;			\
diff -u linux-mips-cvs/include/asm-mips/war.h linux-mips/include/asm-mips/war.h
--- linux-mips-cvs/include/asm-mips/war.h	Sat Aug 21 00:34:12 2004
+++ linux-mips/include/asm-mips/war.h	Wed Sep  1 23:22:29 2004
@@ -221,4 +221,10 @@
 #define R10000_LLSC_WAR			0
 #endif
 
+#if (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 4))
+#define GCC_ASM_PROTECT_DSLOT
+#else
+#define GCC_ASM_PROTECT_DSLOT	__volatile__
+#endif
+
 #endif /* _ASM_WAR_H */
