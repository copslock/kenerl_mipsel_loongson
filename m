Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2003 23:06:39 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:61857
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225198AbTANXGj>; Tue, 14 Jan 2003 23:06:39 +0000
Received: from bogon.sigxcpu.org (kons-d9bb5464.pool.mediaWays.net [217.187.84.100])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 5E6E92BC2D; Wed, 15 Jan 2003 00:06:35 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 1FF114B45E; Wed, 15 Jan 2003 00:06:08 +0100 (CET)
Date: Wed, 15 Jan 2003 00:06:08 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: libc-alpha@sources.redhat.com
Cc: linux-mips@linux-mips.org
Subject: [PATCH] INTERNAL_SYSCALL for linux-mips
Message-ID: <20030114230607.GH27645@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
the attached patch brings mips up to date concerning the
{INTERNAL,INLINE}_SYSCALL macros. I'm aware that we can probably
save some more cycles by defining INLINE_SYSCALL directly and avoiding
the err variable, but I'd like to leave this asside until the
cancelation handling is fixed.
With the attached patch glibc passess all the tests it passes without it
and is able to "replicate itself" (compile glibc with a glibc installed
that uses this patch).
I'm cc'ing the linux-mips list for comments.
 -- Guido

P.S.: many thanks to Thiemo and aj for their explanations.

--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inline-syscall-mips.diff"

2003-01-14  Guido Guenther  <agx@sigxcpu.org>

	* sysdeps/unix/sysv/linux/mips/sysdep.h
	(INTERNAL_SYSCALL, INTERNAL_SYSCALL_DECL, 
	INTERNAL_SYSCALL_ERRNO, INTERNAL_SYSCALL_ERROR_P,
	INLINE_SYSCALL): Define.

Index: sysdeps/unix/sysv/linux/mips/sysdep.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/mips/sysdep.h,v
retrieving revision 1.2
diff -u -r1.2 sysdep.h
--- sysdeps/unix/sysv/linux/mips/sysdep.h	6 Jul 2001 04:56:18 -0000	1.2
+++ sysdeps/unix/sysv/linux/mips/sysdep.h	13 Jan 2003 20:35:27 -0000
@@ -33,4 +33,242 @@
 # define SYS_ify(syscall_name)	__NR_/**/syscall_name
 #endif
 
+#ifndef __ASSEMBLER__
+
+/* Define a macro which expands into the inline wrapper code for a system
+   call.  */
+#undef INLINE_SYSCALL
+#define INLINE_SYSCALL(name, nr, args...)                               \
+  ({ INTERNAL_SYSCALL_DECL(err);					\
+     long result_var = INTERNAL_SYSCALL (name, err, nr, args);      	\
+     if ( INTERNAL_SYSCALL_ERROR_P (result_var, err) )  		\
+       {                                                                \
+         __set_errno (INTERNAL_SYSCALL_ERRNO (result_var, err));      	\
+         result_var = -1L;                               		\
+       }                                                                \
+     result_var; })
+
+#undef INTERNAL_SYSCALL_DECL
+#define INTERNAL_SYSCALL_DECL(err) long err
+
+#undef INTERNAL_SYSCALL_ERROR_P
+#define INTERNAL_SYSCALL_ERROR_P(val, err)   ((long) (err))
+
+#undef INTERNAL_SYSCALL_ERRNO
+#define INTERNAL_SYSCALL_ERRNO(val, err)     (val)
+
+#undef INTERNAL_SYSCALL
+#define INTERNAL_SYSCALL(name, err, nr, args...) internal_syscall##nr(name, err, args)
+
+#define internal_syscall0(name, err, dummy...) 				\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a3 asm("$7"); 					\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"li\t$2, %2\t\t\t# " #name "\n\t"				\
+	"syscall\n\t" 							\
+	".set reorder" 							\
+	: "=r" (__v0), "=r" (__a3) 					\
+	: "i" (SYS_ify(name))						\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall1(name, err, arg1) 				\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a3 asm("$7"); 					\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"li\t$2, %3\t\t\t# " #name "\n\t"				\
+	"syscall\n\t" 							\
+	".set reorder" 							\
+	: "=r" (__v0), "=r" (__a3) 					\
+	: "r" (__a0), "i" (SYS_ify(name)) 				\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall2(name, err, arg1, arg2) 			\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a1 asm("$5") = (long) arg2; 			\
+	register long __a3 asm("$7"); 					\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"li\t$2, %4\t\t\t# " #name "\n\t" 				\
+	"syscall\n\t" 							\
+	".set\treorder" 						\
+	: "=r" (__v0), "=r" (__a3) 					\
+	: "r" (__a0), "r" (__a1), "i" (SYS_ify(name))			\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall3(name, err, arg1, arg2, arg3) 			\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a1 asm("$5") = (long) arg2; 			\
+	register long __a2 asm("$6") = (long) arg3; 			\
+	register long __a3 asm("$7"); 					\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"li\t$2, %5\t\t\t# " #name "\n\t" 				\
+	"syscall\n\t" 							\
+	".set\treorder" 						\
+	: "=r" (__v0), "=r" (__a3) 					\
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (SYS_ify(name)) 	\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall4(name, err, arg1, arg2, arg3, arg4) 		\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a1 asm("$5") = (long) arg2; 			\
+	register long __a2 asm("$6") = (long) arg3; 			\
+	register long __a3 asm("$7") = (long) arg4; 			\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"li\t$2, %5\t\t\t# " #name "\n\t" 				\
+	"syscall\n\t" 							\
+	".set\treorder" 						\
+	: "=r" (__v0), "+r" (__a3) 					\
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (SYS_ify(name)) 	\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall5(name, err, arg1, arg2, arg3, arg4, arg5) 	\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a1 asm("$5") = (long) arg2; 			\
+	register long __a2 asm("$6") = (long) arg3; 			\
+	register long __a3 asm("$7") = (long) arg4; 			\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"lw\t$2, %6\n\t" 						\
+	"subu\t$29, 32\n\t" 						\
+	"sw\t$2, 16($29)\n\t" 						\
+	"li\t$2, %5\t\t\t# " #name "\n\t" 				\
+	"syscall\n\t" 							\
+	"addiu\t$29, 32\n\t" 						\
+	".set\treorder" 						\
+	: "=r" (__v0), "+r" (__a3) 					\
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (SYS_ify(name)), 	\
+	  "m" ((long)arg5) 						\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall6(name, err, arg1, arg2, arg3, arg4, arg5, arg6)\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a1 asm("$5") = (long) arg2; 			\
+	register long __a2 asm("$6") = (long) arg3; 			\
+	register long __a3 asm("$7") = (long) arg4; 			\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"lw\t$2, %6\n\t" 						\
+	"lw\t$8, %7\n\t" 						\
+	"subu\t$29, 32\n\t" 						\
+	"sw\t$2, 16($29)\n\t" 						\
+	"sw\t$8, 20($29)\n\t" 						\
+	"li\t$2, %5\t\t\t# " #name "\n\t" 				\
+	"syscall\n\t" 							\
+	"addiu\t$29, 32\n\t" 						\
+	".set\treorder" 						\
+	: "=r" (__v0), "+r" (__a3) 					\
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (SYS_ify(name)), 	\
+	  "m" ((long)arg5), "m" ((long)arg6)				\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define internal_syscall7(name, err, arg1, arg2, arg3, arg4, arg5, arg6, arg7)\
+({ 									\
+	long _sys_result;						\
+									\
+	{								\
+	register long __v0 asm("$2"); 					\
+	register long __a0 asm("$4") = (long) arg1; 			\
+	register long __a1 asm("$5") = (long) arg2; 			\
+	register long __a2 asm("$6") = (long) arg3; 			\
+	register long __a3 asm("$7") = (long) arg4; 			\
+	__asm__ volatile ( 						\
+	".set\tnoreorder\n\t" 						\
+	"lw\t$2, %6\n\t" 						\
+	"lw\t$8, %7\n\t" 						\
+	"lw\t$9, %8\n\t" 						\
+	"subu\t$29, 32\n\t" 						\
+	"sw\t$2, 16($29)\n\t" 						\
+	"sw\t$8, 20($29)\n\t" 						\
+	"sw\t$9, 24($29)\n\t" 						\
+	"li\t$2, %5\t\t\t# " #name "\n\t" 				\
+	"syscall\n\t" 							\
+	"addiu\t$29, 32\n\t" 						\
+	".set\treorder" 						\
+	: "=r" (__v0), "+r" (__a3) 					\
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (SYS_ify(name)), 	\
+	  "m" ((long)arg5), "m" ((long)arg6), "m" ((long)arg7)		\
+	: __SYSCALL_CLOBBERS); 						\
+	err = __a3;							\
+	_sys_result = __v0;						\
+	}								\
+	_sys_result;							\
+})
+
+#define __SYSCALL_CLOBBERS "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25"
+
+#endif /* __ASSEMBLER__ */
+
 #endif /* linux/mips/sysdep.h */

--UFHRwCdBEJvubb2X--
