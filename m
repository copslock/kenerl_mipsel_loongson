Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HCCI710890
	for linux-mips-outgoing; Thu, 17 Jan 2002 04:12:18 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HCBhP10880;
	Thu, 17 Jan 2002 04:11:43 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA24066;
	Thu, 17 Jan 2002 03:11:33 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA29695;
	Thu, 17 Jan 2002 03:11:31 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0HBBDA08373;
	Thu, 17 Jan 2002 12:11:14 +0100 (MET)
Message-ID: <3C46B151.7A15C5F4@mips.com>
Date: Thu, 17 Jan 2002 12:11:13 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: IDE driver broken in bigendian 2.4.17 kernel
Content-Type: multipart/mixed;
 boundary="------------0FA5C1CF8BAED1C4D153EBA3"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------0FA5C1CF8BAED1C4D153EBA3
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Due to changes in the string port macros/functions (insl, outsl, insw,
...) the bigendian IDE driver doesn't work anymore.
I think we need to have local versions of these functions in
include/asm-mips/ide.h, therefore these functions should be macros
(#define) and not static functions in include/asm-mips/io.h (in order to
redefine them).
I have attached a patch that solves this problem.

I have also attached a patch for the Malta board.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------0FA5C1CF8BAED1C4D153EBA3
Content-Type: text/plain; charset=iso-8859-15;
 name="ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide.patch"

Index: include/asm-mips/ide.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/ide.h,v
retrieving revision 1.11
diff -u -r1.11 ide.h
--- include/asm-mips/ide.h	2001/08/17 12:17:58	1.11
+++ include/asm-mips/ide.h	2002/01/17 12:01:03
@@ -125,6 +125,57 @@
 
 #if defined(__MIPSEB__)
 
+/* get rid of defs from io.h - ide has its private and conflicting versions */
+#ifdef insw
+#undef insw
+#endif
+#ifdef outsw
+#undef outsw
+#endif
+#ifdef insl
+#undef insl
+#endif
+#ifdef outsl
+#undef outsl
+#endif
+
+#define insw(port, addr, count) ide_insw(port, addr, count)
+#define insl(port, addr, count) ide_insl(port, addr, count)
+#define outsw(port, addr, count) ide_outsw(port, addr, count)
+#define outsl(port, addr, count) ide_outsl(port, addr, count)
+
+static inline void ide_insw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
+		addr += 2;
+	}
+}
+
+static inline void ide_outsw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u16 *)(mips_io_port_base + (port)) = *(u16 *)addr;
+		addr += 2;
+	}
+}
+
+static inline void ide_insl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
+		addr += 4;
+	}
+}
+
+static inline void ide_outsl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u32 *)(mips_io_port_base + (port)) = *(u32 *)addr;
+		addr += 4;
+	}
+}
+
 #define T_CHAR          (0x0000)        /* char:  don't touch  */
 #define T_SHORT         (0x4000)        /* short: 12 -> 21     */
 #define T_INT           (0x8000)        /* int:   1234 -> 4321 */
Index: include/asm-mips/io.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/io.h,v
retrieving revision 1.29.2.4
diff -u -r1.29.2.4 io.h
--- include/asm-mips/io.h	2001/12/26 23:41:26	1.29.2.4
+++ include/asm-mips/io.h	2002/01/17 12:01:03
@@ -249,22 +249,29 @@
 	SLOW_DOWN_IO;							\
 } while(0)
 
-static inline unsigned char inb(unsigned long port)
+#define inb(port) __inb(port)
+#define inw(port) __inw(port)
+#define inl(port) __inl(port)
+#define inb_p(port) __inb_p(port)
+#define inw_p(port) __inw_p(port)
+#define inl_p(port) __inl_p(port)
+
+static inline unsigned char __inb(unsigned long port)
 {
 	return __ioswab8(*(volatile u8 *)(mips_io_port_base + port));
 }
 
-static inline unsigned short inw(unsigned long port)
+static inline unsigned short __inw(unsigned long port)
 {
 	return __ioswab16(*(volatile u16 *)(mips_io_port_base + port));
 }
 
-static inline unsigned int inl(unsigned long port)
+static inline unsigned int __inl(unsigned long port)
 {
 	return __ioswab32(*(volatile u32 *)(mips_io_port_base + port));
 }
 
-static inline unsigned char inb_p(unsigned long port)
+static inline unsigned char __inb_p(unsigned long port)
 {
 	u8 __val;
 
@@ -274,7 +281,7 @@
 	return __ioswab8(__val);
 }
 
-static inline unsigned short inw_p(unsigned long port)
+static inline unsigned short __inw_p(unsigned long port)
 {
 	u16 __val;
 
@@ -284,7 +291,7 @@
 	return __ioswab16(__val);
 }
 
-static inline unsigned int inl_p(unsigned long port)
+static inline unsigned int __inl_p(unsigned long port)
 {
 	u32 __val;
 
@@ -292,8 +299,15 @@
 	SLOW_DOWN_IO;
 	return __ioswab32(__val);
 }
+
+#define outsb(port, addr, count) __outsb(port, addr, count)
+#define insb(port, addr, count) __insb(port, addr, count)
+#define outsw(port, addr, count) __outsw(port, addr, count)
+#define insw(port, addr, count) __insw(port, addr, count)
+#define outsl(port, addr, count) __outsl(port, addr, count)
+#define insl(port, addr, count) __insl(port, addr, count)
 
-static inline void outsb(unsigned long port, void *addr, unsigned int count)
+static inline void __outsb(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
 		outb(*(u8 *)addr, port);
@@ -301,7 +315,7 @@
 	}
 }
 
-static inline void insb(unsigned long port, void *addr, unsigned int count)
+static inline void __insb(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
 		*(u8 *)addr = inb(port);
@@ -309,7 +323,7 @@
 	}
 }
 
-static inline void outsw(unsigned long port, void *addr, unsigned int count)
+static inline void __outsw(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
 		outw(*(u16 *)addr, port);
@@ -317,7 +331,7 @@
 	}
 }
 
-static inline void insw(unsigned long port, void *addr, unsigned int count)
+static inline void __insw(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
 		*(u16 *)addr = inw(port);
@@ -325,7 +339,7 @@
 	}
 }
 
-static inline void outsl(unsigned long port, void *addr, unsigned int count)
+static inline void __outsl(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
 		outl(*(u32 *)addr, port);
@@ -333,7 +347,7 @@
 	}
 }
 
-static inline void insl(unsigned long port, void *addr, unsigned int count)
+static inline void __insl(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
 		*(u32 *)addr = inl(port);

--------------0FA5C1CF8BAED1C4D153EBA3
Content-Type: text/plain; charset=iso-8859-15;
 name="malta.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta.patch"

Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.154.2.9
diff -u -r1.154.2.9 config.in
--- arch/mips/config.in	2002/01/07 03:33:54	1.154.2.9
+++ arch/mips/config.in	2002/01/17 12:00:53
@@ -149,6 +149,7 @@
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_SWAP_IO_SPACE y
+   define_bool CONFIG_PC_KEYB y
 fi
 if [ "$CONFIG_MOMENCO_OCELOT" = "y" ]; then
    define_bool CONFIG_PCI y
Index: arch/mips/mips-boards/malta/malta_setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/mips-boards/malta/malta_setup.c,v
retrieving revision 1.7.2.1
diff -u -r1.7.2.1 malta_setup.c
--- arch/mips/mips-boards/malta/malta_setup.c	2001/12/12 13:45:58	1.7.2.1
+++ arch/mips/mips-boards/malta/malta_setup.c	2002/01/17 12:00:54
@@ -36,6 +36,12 @@
 #include <asm/floppy.h>
 #endif
 #include <asm/dma.h>
+#ifdef CONFIG_PC_KEYB
+#include <asm/keyboard.h>
+#endif
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#endif
 
 #if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)
 extern void console_setup(char *, int *);
@@ -136,6 +142,26 @@
 #endif
 #ifdef CONFIG_PC_KEYB
 	kbd_ops = &std_kbd_ops;
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+        conswitchp = &vga_con;
+
+	screen_info = (struct screen_info) {
+		0, 25,			/* orig-x, orig-y */
+		0,			/* unused */
+		0,			/* orig-video-page */
+		0,			/* orig-video-mode */
+		80,			/* orig-video-cols */
+		0,0,0,			/* ega_ax, ega_bx, ega_cx */
+		25,			/* orig-video-lines */
+		1,			/* orig-video-isVGA */
+		16			/* orig-video-points */
+	};
+#elif defined(CONFIG_DUMMY_CONSOLE)
+        conswitchp = &dummy_con;
+#endif
 #endif
 	mips_reboot_setup();
 }

--------------0FA5C1CF8BAED1C4D153EBA3--
