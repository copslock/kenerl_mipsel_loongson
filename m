Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7IIcJ17680
	for linux-mips-outgoing; Fri, 7 Dec 2001 10:18:38 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7IIBo17674;
	Fri, 7 Dec 2001 10:18:16 -0800
Received: from dev1 (unknown [10.1.1.85])
	by ns1.ltc.com (Postfix) with ESMTP
	id BFC3F590A9; Fri,  7 Dec 2001 12:17:08 -0500 (EST)
Received: from brad by dev1 with local (Exim 3.32 #1 (Debian))
	id 16COZo-0002Uc-00; Fri, 07 Dec 2001 12:14:20 -0500
Date: Fri, 7 Dec 2001 12:14:16 -0500
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: PATCH: io.h remove detrimental do {...} whiles, add sequence points, add const modifiers
Message-ID: <20011207121416.A9583@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde" <brad@ltc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

2001-12-07  Bradley D. LaRonde <brad@ltc.com>

* remove detrimental do {...} whiles
* add sequence point to in[b,w,l] to prevent compiler from reordering
* add const modifier to outs[b,w,l] (quiets some compiler warnings)


--- linux-oss-2.4-2001-12-04/include/asm-mips/io.h	Thu Dec  6 17:07:24 2001
+++ linux-patch/include/asm-mips/io.h	Thu Dec  6 16:47:20 2001
@@ -63,7 +63,7 @@
 extern const unsigned long mips_io_port_base;
 
 #define set_io_port_base(base)	\
-	do { * (unsigned long *) &mips_io_port_base = (base); } while (0)
+	*(unsigned long *)&mips_io_port_base = (base);
 
 /*
  * Thanks to James van Artsdalen for a better timing-fix than
@@ -215,41 +215,37 @@
 
 
 #define outb(val,port)							\
-do {									\
-	*(volatile u8 *)(mips_io_port_base + (port)) = __ioswab8(val);	\
-} while(0)
+	*(volatile u8 *)(mips_io_port_base + (port)) = __ioswab8(val)
 
 #define outw(val,port)							\
-do {									\
-	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val);	\
-} while(0)
+	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val)
 
 #define outl(val,port)							\
-do {									\
-	*(volatile u32 *)(mips_io_port_base + (port)) = __ioswab32(val);\
-} while(0)
+	*(volatile u32 *)(mips_io_port_base + (port)) = __ioswab32(val)
 
+/* Don't do {...} while(0) these. */
 #define outb_p(val,port)						\
-do {									\
+({									\
 	*(volatile u8 *)(mips_io_port_base + (port)) = __ioswab8(val);	\
 	SLOW_DOWN_IO;							\
-} while(0)
+})
 
 #define outw_p(val,port)						\
-do {									\
+{									\
 	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val);\
 	SLOW_DOWN_IO;							\
-} while(0)
+}
 
 #define outl_p(val,port)						\
-do {									\
+{									\
 	*(volatile u32 *)(mips_io_port_base + (port)) = __ioswab32(val);\
 	SLOW_DOWN_IO;							\
-} while(0)
+}
 
-#define inb(port) (__ioswab8(*(volatile u8 *)(mips_io_port_base + (port))))
-#define inw(port) (__ioswab16(*(volatile u16 *)(mips_io_port_base + (port))))
-#define inl(port) (__ioswab32(*(volatile u32 *)(mips_io_port_base + (port))))
+/* As in include/asm-arm/io.h, introduce sequence points ({...}) to prevent gcc * from reordering. */
+#define inb(port) ({ unsigned int __v = __ioswab8(*(volatile u8 *)(mips_io_port_base + (port))); __v; })
+#define inw(port) ({ unsigned int __v = __ioswab16(*(volatile u16 *)(mips_io_port_base + (port))); __v; })
+#define inl(port) ({ unsigned int __v = __ioswab32(*(volatile u32 *)(mips_io_port_base + (port))); __v; })
 
 #define inb_p(port)							\
 ({									\
@@ -278,7 +274,7 @@
 	__ioswab32(__val);						\
 })
 
-static inline void outsb(unsigned long port, void *addr, unsigned int count)
+static inline void outsb(unsigned long port, const void *addr, unsigned int count)
 {
 	while (count--) {
 		outb(*(u8 *)addr, port);
@@ -294,7 +290,7 @@
 	}
 }
 
-static inline void outsw(unsigned long port, void *addr, unsigned int count)
+static inline void outsw(unsigned long port, const void *addr, unsigned int count)
 {
 	while (count--) {
 		outw(*(u16 *)addr, port);
@@ -310,7 +306,7 @@
 	}
 }
 
-static inline void outsl(unsigned long port, void *addr, unsigned int count)
+static inline void outsl(unsigned long port, const void *addr, unsigned int count)
 {
 	while (count--) {
 		outl(*(u32 *)addr, port);
