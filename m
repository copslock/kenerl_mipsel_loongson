Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3AMJhn18431
	for linux-mips-outgoing; Tue, 10 Apr 2001 15:19:43 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3AMJdM18427;
	Tue, 10 Apr 2001 15:19:39 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3AMFd018007;
	Tue, 10 Apr 2001 15:15:39 -0700
Message-ID: <3AD38671.CAE922B7@mvista.com>
Date: Tue, 10 Apr 2001 15:17:21 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Scott A McConnell <samcconn@cotw.com>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: loadaddr
References: <3AD337DA.16570750@cotw.com> <20010410183854.C1932@bacchus.dhis.org> <3AD38E04.696F2085@cotw.com>
Content-Type: multipart/mixed;
 boundary="------------C47890E4DB1ADC20056611C6"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------C47890E4DB1ADC20056611C6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Scott A McConnell wrote:
> 
> Ralf Baechle wrote:
> 
> > On Tue, Apr 10, 2001 at 09:42:02AM -0700, Scott A McConnell wrote:
> >
> > > What am I doing that is causing the  leading ffffffff in the addresses?
> >
> > Everything right :-)
> >
> > 32-bit addresses on MIPS get sign extended into 64-bit addresses.  Binutils
> > had related bugs; I assume you switched binutils versions between the
> > two builds?
> 
> OK, I wasn't sure so I asked. Yes, I changed the tools.
> 
> I have been able to build a 2.4.2 kernel but I can't make it run.
> 
> I have also steped up to the latest kernel in cvs. Having a bit more trouble
> with that:
> 
> mipsel-linux-gcc -I /opt/mips/linux-2.4.3/include/asm/gcc -D__KERNEL__
> -I/opt/mips/linux-2.4.3/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
> -Wa,--trap -pipe    -c -o vgacon.o vgacon.c
> {standard input}: Assembler messages:
> {standard input}:1978: Error: expression too complex
> {standard input}:1978: Fatal error: internal Error, line 1823,
> ../../binutils-patched/gas/config/tc-mips.c
> make[3]: *** [vgacon.o] Error 1
> make[3]: Leaving directory `/opt/mips/linux-2.4.3/drivers/video'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/opt/mips/linux-2.4.3/drivers/video'
> make[1]: *** [_subdir_video] Error 2
> make[1]: Leaving directory `/opt/mips/linux-2.4.3/drivers'
> make: *** [_dir_drivers] Error 2

Known problem.  If I remember correctly, it was caused by a subtle bug
in gcc, triggered by the complex combination of inline functions and
macros in arch/mips/io.h.  I believe Daniel Jacobowitz submitted a match
to Ralf, but I don't know if it has been applied yet. Internally, I
applied it and it works.  I've attached it if you want to give it a try.

Pete
--------------C47890E4DB1ADC20056611C6
Content-Type: text/plain; charset=us-ascii;
 name="hhl-kernel-2.4.2-1.64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hhl-kernel-2.4.2-1.64.patch"

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

--------------C47890E4DB1ADC20056611C6--
