Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2002 17:36:52 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:35279 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S869811AbSLIQgk>; Mon, 9 Dec 2002 17:36:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB9GaQM32258;
	Mon, 9 Dec 2002 17:36:26 +0100
Date: Mon, 9 Dec 2002 17:36:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
Message-ID: <20021209173626.A27999@linux-mips.org>
References: <3DEF7087.B6DEA7EC@mips.com> <20021209051845.A31939@linux-mips.org> <3DF4629B.F377F711@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF4629B.F377F711@mips.com>; from carstenl@mips.com on Mon, Dec 09, 2002 at 10:30:03AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 09, 2002 at 10:30:03AM +0100, Carsten Langgaard wrote:

> > The patch below adds 32 bytes.  It's still not the right thing though.  It's
> > not fixing all stuff in the assembler code.  I have a better patch but it
> > results in odd userspace behaviour.  Smells like a compiler problem ...
> 
> I tried you patch below, but then nothing seems to work.

The reason for this problem (and a few others is the broken call to
__access_ok() in clear_user().  That should actually be access_ok().
Basically the kernel was only working so far because addresses were just
right ...

Below my working version.  I still needs to make TASK_SIZE variable but
with the clear_user thing fixed that should be easy.

  Ralf

Index: arch/mips64/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.48.2.21
diff -u -r1.48.2.21 scall_o32.S
--- arch/mips64/kernel/scall_o32.S	3 Dec 2002 14:23:05 -0000	1.48.2.21
+++ arch/mips64/kernel/scall_o32.S	8 Dec 2002 06:08:55 -0000
@@ -209,7 +209,7 @@
 	daddiu	a0, a1, 4
 	or	a0, a0, a1
 	and	a0, a0, v1
-	bltz	a0, bad_address
+	bnez	a0, bad_address
 
 	/* Ok, this is the ll/sc case.  World is sane :-)  */
 1:	ll	v0, (a1)
@@ -273,7 +273,7 @@
 	ld	v1, THREAD_CURDS($28)
 	or	v0, v0, t1
 	and	v1, v1, v0
-	bltz	v1, efault
+	bnez	v1, efault
 
 	move	a0, a1			# shift argument registers
 	move	a1, a2
Index: arch/mips64/lib/strlen_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/strlen_user.S,v
retrieving revision 1.4.2.1
diff -u -r1.4.2.1 strlen_user.S
--- arch/mips64/lib/strlen_user.S	1 Jul 2002 15:27:29 -0000	1.4.2.1
+++ arch/mips64/lib/strlen_user.S	8 Dec 2002 06:08:55 -0000
@@ -25,7 +25,7 @@
 LEAF(__strlen_user_asm)
 	ld	v0, THREAD_CURDS($28)			# pointer ok?
 	and	v0, a0
-	bltz	v0, fault
+	bnez	v0, fault
 
 FEXPORT(__strlen_user_nocheck_asm)
 	move	v0, a0
Index: arch/mips64/lib/strncpy_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/strncpy_user.S,v
retrieving revision 1.4
diff -u -r1.4 strncpy_user.S
--- arch/mips64/lib/strncpy_user.S	9 Jul 2001 00:25:37 -0000	1.4
+++ arch/mips64/lib/strncpy_user.S	8 Dec 2002 06:08:55 -0000
@@ -30,7 +30,7 @@
 LEAF(__strncpy_from_user_asm)
 	ld	v0, THREAD_CURDS($28)		# pointer ok?
 	and	v0, a1
-	bltz	v0, fault
+	bnez	v0, fault
 
 FEXPORT(__strncpy_from_user_nocheck_asm)
 	move	v0, zero
Index: arch/mips64/lib/strnlen_user.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/lib/strnlen_user.S,v
retrieving revision 1.2.2.2
diff -u -r1.2.2.2 strnlen_user.S
--- arch/mips64/lib/strnlen_user.S	1 Jul 2002 15:27:29 -0000	1.2.2.2
+++ arch/mips64/lib/strnlen_user.S	8 Dec 2002 06:08:55 -0000
@@ -25,7 +25,7 @@
 LEAF(__strnlen_user_asm)
 	ld	v0, THREAD_CURDS($28)	# pointer ok?
 	and	v0, a0
-	bltz	v0, fault
+	bnez	v0, fault
 
 FEXPORT(__strnlen_user_nocheck_asm)
 	move	v0, a0
Index: include/asm-mips64/processor.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/processor.h,v
retrieving revision 1.32.2.9
diff -u -r1.32.2.9 processor.h
--- include/asm-mips64/processor.h	4 Nov 2002 19:39:56 -0000	1.32.2.9
+++ include/asm-mips64/processor.h	8 Dec 2002 06:09:38 -0000
@@ -208,7 +208,7 @@
 	/* \
 	 * For now the default is to fix address errors \
 	 */ \
-	MF_FIXADE, { 0 }, 0, 0 \
+	MF_FIXADE, KERNEL_DS, 0, 0 \
 }
 
 #ifdef __KERNEL__
Index: include/asm-mips64/uaccess.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/uaccess.h,v
retrieving revision 1.13.2.1
diff -u -r1.13.2.1 uaccess.h
--- include/asm-mips64/uaccess.h	1 Jul 2002 15:27:31 -0000	1.13.2.1
+++ include/asm-mips64/uaccess.h	8 Dec 2002 06:09:39 -0000
@@ -22,8 +22,8 @@
  *
  * For historical reasons, these macros are grossly misnamed.
  */
-#define KERNEL_DS	((mm_segment_t) { (unsigned long) 0L })
-#define USER_DS		((mm_segment_t) { (unsigned long) -1L })
+#define KERNEL_DS	((mm_segment_t) { 0UL })
+#define USER_DS		((mm_segment_t) { -TASK_SIZE })
 
 #define VERIFY_READ    0
 #define VERIFY_WRITE   1
@@ -46,19 +46,19 @@
  *  - OR we are in kernel mode.
  */
 #define __ua_size(size)							\
-	(__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
+	((__builtin_constant_p(size) && (size)) > 0 ? 0 : (size))
 
-#define __access_ok(addr,size,mask)					\
-	(((signed long)((mask)&(addr | (addr + size) | __ua_size(size)))) >= 0)
+#define __access_ok(addr, size, mask)					\
+	(((mask) & ((addr) | ((addr) + (size)) | __ua_size(size))) == 0)
 
-#define __access_mask ((long)(get_fs().seg))
+#define __access_mask get_fs().seg
 
-#define access_ok(type,addr,size) \
-	__access_ok(((unsigned long)(addr)),(size),__access_mask)
+#define access_ok(type, addr, size)					\
+	__access_ok((unsigned long)(addr), (size), __access_mask)
 
 static inline int verify_area(int type, const void * addr, unsigned long size)
 {
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
+	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
 
 /*
@@ -340,8 +340,8 @@
 ({								\
 	void * __cl_addr = (addr);				\
 	unsigned long __cl_size = (n);				\
-	if (__cl_size && __access_ok(VERIFY_WRITE,		\
-	       ((unsigned long)(__cl_addr)), __cl_size))	\
+	if (__cl_size && access_ok(VERIFY_WRITE,		\
+		((unsigned long)(__cl_addr)), __cl_size))	\
 		__cl_size = __clear_user(__cl_addr, __cl_size);	\
 	__cl_size;						\
 })
