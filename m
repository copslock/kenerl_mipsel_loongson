Received:  by oss.sgi.com id <S553747AbRCNN6S>;
	Wed, 14 Mar 2001 05:58:18 -0800
Received: from NEVYN.RES.CMU.EDU ([128.2.145.225]:54692 "EHLO nevyn.them.org")
	by oss.sgi.com with ESMTP id <S553740AbRCNN6K>;
	Wed, 14 Mar 2001 05:58:10 -0800
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14dBmT-0006kF-00
	for <linux-mips@oss.sgi.com>; Wed, 14 Mar 2001 08:57:37 -0500
Date:   Wed, 14 Mar 2001 08:57:37 -0500
From:   Daniel Jacobowitz <dan@debian.org>
To:     linux-mips@oss.sgi.com
Subject: [patch] <asm/io.h> troubles - [dmj+@andrew.cmu.edu: Inlining bug on MIPS - both 2.95.3 and 3.0 branches]
Message-ID: <20010314085737.A25751@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I submitted the following GCC bug report a couple of days ago, and had
a discussion with Geoff Keating about asm constraints.  It looks as if
the problem I was seeing is a (very) longstanding bug in GCC's reload
pass, and is very unlikely to get fixed.

How does this workaround patch look?  I changed the constant-using
functions from io.h into macros.  I'm not thrilled by it, but it does
seem to be correct.  I have a suspicion we could change the confusing
"i#*X" constraints back to simply "i" - they were part of my effort to
make the inline functions work, before I was defeated by reload.  It
should be correct either way, though. 

----- Forwarded message from Daniel Jacobowitz <dmj+@andrew.cmu.edu> -----

Date: Fri, 9 Mar 2001 18:10:02 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
Subject: Inlining bug on MIPS - both 2.95.3 and 3.0 branches
To: gcc-bugs@gcc.gnu.org
Mail-Followup-To: gcc-bugs@gcc.gnu.org

I've put together a testcase for a bug exposed by (accidentally) trying to
build a mipsel-linux kernel with VGA console enabled.

The problem seems to be that we lift a constant term out of a loop into a
spare register.  Of course, __builtin_constant_p is still true for it, so in
the original case we chose to use an inline function which required that
argument to be constant.  We inline the function using the scratch register
instead of the constant, and we lose.

The inline function seems to me to be doing something dodgy - it specifies
the operand with the constraint "ir", implying that a register would be
acceptable.  We're lying to the compiler, so it's not that startling that it
bites us.  On the other hand, there's no need to waste a register on this,
so I'm not sure why the constant gets stored in a temporary.

Is the invalid result a compiler bug?  I'd say that there is at least a
small optimization bug here, but the "ir" constraint might mean that the
compiler's doing everything as best it can.  There doesn't seem to be a way
to use an inline function safely and specify a constant constraint on one
argument to the function - does this need to be a macro?

Dan

----- End forwarded message -----

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hhl-kernel-2.4.2-1.64.patch"

Version 1.64  (Mon Mar 12 2001 drow <source@mvista.com>)
    Use macros instead of inline functions for constant io macros, and
    change "ir" to "i#*X" on Geoff's advice.


# This is a BitKeeper generated patch for the following project:
# Project Name: HHL 2.4.2 kernel sources, based on linux-2.4.2
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	linux/include/asm-mips/io.h	1.2     -> 1.3    
diff -Nru a/linux/include/asm-mips/io.h b/linux/include/asm-mips/io.h
--- a/linux/include/asm-mips/io.h	Mon Mar 12 16:52:50 2001
+++ b/linux/include/asm-mips/io.h	Mon Mar 12 16:52:50 2001
@@ -248,12 +248,21 @@
 
 #define __OUT(m,s,w) \
 __OUT1(s) __OUT2(m) : : "r" (__ioswab##w(value)), "i" (0), "r" (mips_io_port_base+port)); } \
-__OUT1(s##c) __OUT2(m) : : "r" (__ioswab##w(value)), "ir" (port), "r" (mips_io_port_base)); } \
 __OUT1(s##_p) __OUT2(m) : : "r" (__ioswab##w(value)), "i" (0), "r" (mips_io_port_base+port)); \
-	SLOW_DOWN_IO; } \
-__OUT1(s##c_p) __OUT2(m) : : "r" (__ioswab##w(value)), "ir" (port), "r" (mips_io_port_base)); \
 	SLOW_DOWN_IO; }
 
+#define __OUTMAC(m,w,value,port) ({ __OUT2(m) : : "r" (__ioswab##w(value)), "i#*X" (port), \
+		"r" (mips_io_port_base)); })
+#define __OUTMAC_P(m,w,value,port) ({ __OUT2(m) : : "r" (__ioswab##w(value)), "i#*X" (port), \
+		"r" (mips_io_port_base)); SLOW_DOWN_IO; })
+
+#define __outbc(value,port) __OUTMAC(b,8,value,port)
+#define __outwc(value,port) __OUTMAC(h,16,value,port)
+#define __outlc(value,port) __OUTMAC(w,32,value,port)
+#define __outbc_p(value,port) __OUTMAC_P(b,8,value,port)
+#define __outwc_p(value,port) __OUTMAC_P(h,16,value,port)
+#define __outlc_p(value,port) __OUTMAC_P(w,32,value,port)
+
 #define __IN1(t,s) \
 extern __inline__ t __in##s(unsigned int port) { t _v;
 
@@ -265,14 +274,24 @@
 
 #define __IN(t,m,s,w) \
 __IN1(t,s) __IN2(m) : "=r" (_v) : "i" (0), "r" (mips_io_port_base+port)); return __ioswab##w(_v); } \
-__IN1(t,s##c) __IN2(m) : "=r" (_v) : "ir" (port), "r" (mips_io_port_base)); return __ioswab##w(_v); } \
-__IN1(t,s##_p) __IN2(m) : "=r" (_v) : "i" (0), "r" (mips_io_port_base+port)); SLOW_DOWN_IO; return __ioswab##w(_v); } \
-__IN1(t,s##c_p) __IN2(m) : "=r" (_v) : "ir" (port), "r" (mips_io_port_base)); SLOW_DOWN_IO; return __ioswab##w(_v); }
+__IN1(t,s##_p) __IN2(m) : "=r" (_v) : "i" (0), "r" (mips_io_port_base+port)); SLOW_DOWN_IO; return __ioswab##w(_v); }
+
+#define __INMAC(t,m,w,port) ({ t _v; __IN2(m) : "=r" (_v) : "i#*X" (port), \
+		"r" (mips_io_port_base)); __ioswab##w(_v); })
+#define __INMAC_P(t,m,w,port) ({ t _v; __IN2(m) : "=r" (_v) : "i#*X" (port), \
+		"r" (mips_io_port_base)); SLOW_DOWN_IO; __ioswab##w(_v); })
+
+#define __inbc(port) __INMAC(unsigned char,b,8,port)
+#define __inwc(port) __INMAC(unsigned short,h,16,port)
+#define __inlc(port) __INMAC(unsigned int,w,32,port)
+#define __inbc_p(port) __INMAC_P(unsigned char,b,8,port)
+#define __inwc_p(port) __INMAC_P(unsigned short,h,16,port)
+#define __inlc_p(port) __INMAC_P(unsigned int,w,32,port)
 
 #define __INS1(s) \
 extern inline void __ins##s(unsigned int port, void * addr, unsigned long count) {
 
-#define __INS2(m) \
+#define __INS2(m,count) \
 if (count) \
 __asm__ __volatile__ ( \
 	".set\tnoreorder\n\t" \
@@ -286,21 +305,26 @@
 	".set\treorder"
 
 #define __INS(m,s,i) \
-__INS1(s) __INS2(m) \
+__INS1(s) __INS2(m,count) \
 	: "=r" (addr), "=r" (count) \
 	: "0" (addr), "1" (count), "i" (0), \
 	  "r" (mips_io_port_base+port), "I" (i) \
-	: "$1");} \
-__INS1(s##c) __INS2(m) \
-	: "=r" (addr), "=r" (count) \
-	: "0" (addr), "1" (count), "ir" (port), \
-	  "r" (mips_io_port_base), "I" (i) \
 	: "$1");}
 
+#define __INSMAC(m,i,port,addr,count) ({ void *_a = (addr); unsigned long _c = (count); \
+	__INS2(m,_c) \
+	: "=r" (_a), "=r" (_c) \
+	: "0" (_a), "1" (_c), "i#*X" (port), \
+	  "r" (mips_io_port_base), "I" (i) \
+	: "$1"); })
+#define __insbc(port,addr,count) __INSMAC(b,1,port,addr,count)
+#define __inswc(port,addr,count) __INSMAC(h,2,port,addr,count)
+#define __inslc(port,addr,count) __INSMAC(w,4,port,addr,count)
+
 #define __OUTS1(s) \
 extern inline void __outs##s(unsigned int port, const void * addr, unsigned long count) {
 
-#define __OUTS2(m) \
+#define __OUTS2(m,count) \
 if (count) \
 __asm__ __volatile__ ( \
         ".set\tnoreorder\n\t" \
@@ -314,14 +338,19 @@
         ".set\treorder"
 
 #define __OUTS(m,s,i) \
-__OUTS1(s) __OUTS2(m) \
+__OUTS1(s) __OUTS2(m,count) \
 	: "=r" (addr), "=r" (count) \
 	: "0" (addr), "1" (count), "i" (0), "r" (mips_io_port_base+port), "I" (i) \
-	: "$1");} \
-__OUTS1(s##c) __OUTS2(m) \
-	: "=r" (addr), "=r" (count) \
-	: "0" (addr), "1" (count), "ir" (port), "r" (mips_io_port_base), "I" (i) \
 	: "$1");}
+
+#define __OUTSMAC(m,i,port,addr,count) ({ void *_a = (addr); unsigned long _c = (count); \
+	__OUTS2(m,_c) \
+	: "=r" (_a), "=r" (_c) \
+	: "0" (_a), "1" (_c), "i#*X" (port), "r" (mips_io_port_base), "I" (i) \
+	: "$1"); })
+#define __outsbc(port,addr,count) __OUTSMAC(b,1,port,addr,count)
+#define __outswc(port,addr,count) __OUTSMAC(h,2,port,addr,count)
+#define __outslc(port,addr,count) __OUTSMAC(w,4,port,addr,count)
 
 __IN(unsigned char,b,b,8)
 __IN(unsigned short,h,w,16)

--+HP7ph2BbKc20aGI--
