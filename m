Received:  by oss.sgi.com id <S553661AbRBHUos>;
	Thu, 8 Feb 2001 12:44:48 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:53501 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553651AbRBHUoX>;
	Thu, 8 Feb 2001 12:44:23 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f18KeZ830959;
	Thu, 8 Feb 2001 12:40:35 -0800
Message-ID: <3A8304C0.D3CFFEF7@mvista.com>
Date:   Thu, 08 Feb 2001 12:42:40 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Andreas Jaeger <aj@suse.de>
CC:     "Kevin D. Kissell" <kevink@mips.com>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [RESUME] fpu emulator
References: <20010208122030.A5408@paradigm.rfc822.org>
		<005d01c091c4$69940620$0deca8c0@Ulysses> <hor919tm4a.fsf@gee.suse.de>
Content-Type: multipart/mixed;
 boundary="------------E064D9D48094491B5D63083D"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------E064D9D48094491B5D63083D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andreas Jaeger wrote:
> 
 
> > saves/restores the FP registers in setjmp/longjmp, the
> 
> Any ideas how this can be done?
> 
> > model of "simply sending SIGILL/SIGFPE" will result
> > in *all* processes being terminated with extreme prejudice,
> > starting with init!
> 

There is a patch for glibc2.0.7, which I think was done by Jay Carlson.  It
basically works for glibc2.0.6 as well.  See the one for glibc2.0.6 attached
below.

I think the patch is not "clean", in the sense that you only want to apply it
if you want to configure with "--without-fp".  Otherwise the patch will break
other configurations.

Jun
--------------E064D9D48094491B5D63083D
Content-Type: text/plain; charset=us-ascii;
 name="glibc-2.0.6-mips-softfloat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-2.0.6-mips-softfloat.patch"

--- glibc-2.0.6/sysdeps/mips/__longjmp.c.orig-rpm	Sat Sep 11 00:01:44 1999
+++ glibc-2.0.6/sysdeps/mips/__longjmp.c	Sat Sep 11 00:02:36 1999
@@ -35,6 +35,7 @@
      along the way.  */
   register int val asm ("a1");
 
+#ifdef __HAVE_FPU__
   /* Pull back the floating point callee-saved registers.  */
   asm volatile ("l.d $f20, %0" : : "m" (env[0].__fpregs[0]));
   asm volatile ("l.d $f22, %0" : : "m" (env[0].__fpregs[1]));
@@ -42,13 +43,16 @@
   asm volatile ("l.d $f26, %0" : : "m" (env[0].__fpregs[3]));
   asm volatile ("l.d $f28, %0" : : "m" (env[0].__fpregs[4]));
   asm volatile ("l.d $f30, %0" : : "m" (env[0].__fpregs[5]));
+#endif
   
   /* Restore the stack pointer.  */
   asm volatile ("lw $29, %0" : : "m" (env[0].__sp));
 
+#ifdef __HAVE_FPU__
   /* Get and reconstruct the floating point csr.  */
   asm volatile ("lw $2, %0" : : "m" (env[0].__fpc_csr));
   asm volatile ("ctc1 $2, $31");
+#endif
 
   /* Get the FP.  */
   asm volatile ("lw $30, %0" : : "m" (env[0].__fp));
--- glibc-2.0.6/sysdeps/mips/setjmp_aux.c.orig-rpm	Sat Sep 11 00:04:00 1999
+++ glibc-2.0.6/sysdeps/mips/setjmp_aux.c	Sat Sep 11 00:04:24 1999
@@ -26,6 +26,7 @@
 int
 __sigsetjmp_aux (jmp_buf env, int savemask, int sp, int fp)
 {
+#ifdef __HAVE_FPU__
   /* Store the floating point callee-saved registers...  */
   asm volatile ("s.d $f20, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[0]));
   asm volatile ("s.d $f22, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[1]));
@@ -33,6 +34,7 @@
   asm volatile ("s.d $f26, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[3]));
   asm volatile ("s.d $f28, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[4]));
   asm volatile ("s.d $f30, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[5]));
+#endif
 
   /* .. and the PC;  */
   asm volatile ("sw $31, %0" : : "m" (env[0].__jmpbuf[0].__pc));
@@ -56,8 +58,10 @@
   asm volatile ("sw $22, %0" : : "m" (env[0].__jmpbuf[0].__regs[6]));
   asm volatile ("sw $23, %0" : : "m" (env[0].__jmpbuf[0].__regs[7]));
 
+#ifdef __HAVE_FPU__
   /* .. and finally get and reconstruct the floating point csr.  */
   asm ("cfc1 %0, $31" : "=r" (env[0].__jmpbuf[0].__fpc_csr));
+#endif
 
   /* Save the signal mask if requested.  */
   return __sigjmp_save (env, savemask);
--- glibc-2.0.6/sysdeps/mips/fpu_control.h.orig-rpm	Sat Sep 11 00:18:51 1999
+++ glibc-2.0.6/sysdeps/mips/fpu_control.h	Sat Sep 11 00:10:44 1999
@@ -83,8 +83,13 @@
 typedef unsigned int fpu_control_t __attribute__ ((__mode__ (__HI__)));
 
 /* Macros for accessing the hardware control word.  */
+#ifdef __HAVE_FPU__
 #define _FPU_GETCW(cw) __asm__ ("cfc1 %0,$31" : "=r" (cw) : )
 #define _FPU_SETCW(cw) __asm__ ("ctc1 %0,$31" : : "r" (cw))
+#else
+#define _FPU_GETCW(cw) (_FPU_DEFAULT)
+#define _FPU_SETCW(cw) 
+#endif
 
 /* Default control word set at startup.  */
 extern fpu_control_t __fpu_control;

--------------E064D9D48094491B5D63083D--
