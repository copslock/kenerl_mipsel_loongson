Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQ4VRd01878
	for linux-mips-outgoing; Sun, 25 Nov 2001 20:31:27 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQ4V4o01869;
	Sun, 25 Nov 2001 20:31:04 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 26 Nov 2001 03:31:03 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 3AC96B475; Mon, 26 Nov 2001 12:30:59 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA18754; Mon, 26 Nov 2001 12:30:59 +0900 (JST)
Date: Mon, 26 Nov 2001 12:35:45 +0900 (JST)
Message-Id: <20011126.123545.41627333.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: new asm-mips/io.h
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

A last cleanups for io.h looks bit wrong.  Please apply.

--- linux-sgi-cvs/include/asm-mips/io.h	Mon Nov 26 10:49:40 2001
+++ linux.new/include/asm-mips/io.h	Mon Nov 26 12:06:31 2001
@@ -283,7 +283,7 @@
 {
 	while(count--) {
 		outb(*(__u8 *)addr, port);
-		addr++; port++;
+		addr++;
 	}
 }
 
@@ -291,7 +291,7 @@
 {
 	while(count--) {
 		*(__u8 *)addr = inb(port);
-		addr++; port++;
+		addr++;
 	}
 }
 
@@ -299,7 +299,7 @@
 {
 	while(count--) {
 		outw(*(__u16 *)addr, port);
-		addr+=2; port+=2;
+		addr+=2;
 	}
 }
 
@@ -307,7 +307,7 @@
 {
 	while(count--) {
 		*(__u16 *)addr = inw(port);
-		addr+=2; port+=2;
+		addr+=2;
 	}
 }
 
@@ -315,7 +315,7 @@
 {
 	while(count--) {
 		outl(*(__u32 *)addr, port);
-		addr+=4; port+=4;
+		addr+=4;
 	}
 }
 
@@ -323,7 +323,7 @@
 {
 	while(count--) {
 		*(__u32 *)addr = inw(port);
-		addr+=4; port+=4;
+		addr+=4;
 	}
 }
 
---

By the way, I have some boards which require special I/O routines.
Some of these boards need byteswap on PCI I/O region but noswap on ISA
region.  And some of these boards do not require byteswap but need
swap the address ('port' values).  I added following codes to support
these boards.  Is it worth to apply?

--- linux-sgi-cvs/include/asm-mips/io.h	Mon Nov 26 10:49:40 2001
+++ linux.new/include/asm-mips/io.h	Mon Nov 26 12:06:31 2001
@@ -352,5 +352,88 @@
 #define dma_cache_wback_inv(start,size)	_dma_cache_wback_inv(start,size)
 #define dma_cache_wback(start,size)	_dma_cache_wback(start,size)
 #define dma_cache_inv(start,size)	_dma_cache_inv(start,size)
+
+#ifdef CONFIG_HAVE_BOARD_IO_FUNCS
+/* redefine all I/O access routines */
+struct mips_io_funcs {
+	void (*writeb)(unsigned char b, volatile unsigned char *addr);
+	void (*writew)(unsigned short b, volatile unsigned short *addr);
+	void (*writel)(unsigned int b, volatile unsigned int *addr);
+	unsigned char (*readb)(volatile unsigned char *addr);
+	unsigned short (*readw)(volatile unsigned short *addr);
+	unsigned int (*readl)(volatile unsigned int *addr);
+	void (*outb)(unsigned int value, unsigned long port);
+	void (*outw)(unsigned int value, unsigned long port);
+	void (*outl)(unsigned int value, unsigned long port);
+	unsigned char (*inb)(unsigned long port);
+	unsigned short (*inw)(unsigned long port);
+	unsigned int (*inl)(unsigned long port);
+	void (*outsb)(unsigned long port, const void *addr, unsigned int count);
+	void (*outsw)(unsigned long port, const void *addr, unsigned int count);
+	void (*outsl)(unsigned long port, const void *addr, unsigned int count);
+	void (*insb)(unsigned long port, void *addr, unsigned int count);
+	void (*insw)(unsigned long port, void *addr, unsigned int count);
+	void (*insl)(unsigned long port, void *addr, unsigned int count);
+	void (*memset_io)(volatile void *addr, int c, int len);
+	void (*memcpy_fromio)(void *to, volatile void *from, int len);
+	void (*memcpy_toio)(volatile void *to, const void *from, int len);
+};
+/* board dependent part should declare this variable. */
+extern struct mips_io_funcs mips_io_funcs;
+#undef writeb
+#undef writew
+#undef writel
+#undef readb
+#undef readw
+#undef readl
+#undef outb
+#undef inb
+#undef outb_p
+#undef inb_p
+#undef outw
+#undef inw
+#undef outw_p
+#undef inw_p
+#undef outl
+#undef inl
+#undef outl_p
+#undef inl_p
+#undef outsb
+#undef insb
+#undef outsw
+#undef insw
+#undef outsl
+#undef insl
+#undef memset_io
+#undef memcpy_fromio
+#undef memcpy_toio
+#define writeb(b,addr) (*mips_io_funcs.writeb)(b, (volatile unsigned char *)(addr))
+#define writew(b,addr) (*mips_io_funcs.writew)(b, (volatile unsigned short *)(addr))
+#define writel(b,addr) (*mips_io_funcs.writel)(b, (volatile unsigned int *)(addr))
+#define readb(addr) (*mips_io_funcs.readb)((volatile unsigned char *)(addr))
+#define readw(addr) (*mips_io_funcs.readw)((volatile unsigned short *)(addr))
+#define readl(addr) (*mips_io_funcs.readl)((volatile unsigned int *)(addr))
+#define outb(val,port)	(*mips_io_funcs.outb)((val),(port))
+#define inb(port)	(*mips_io_funcs.inb)(port)
+#define outb_p(val,port)	(*mips_io_funcs.outb)((val),(port))
+#define inb_p(port)	(*mips_io_funcs.inb)(port)
+#define outw(val,port)	(*mips_io_funcs.outw)((val),(port))
+#define inw(port)	(*mips_io_funcs.inw)(port)
+#define outw_p(val,port)	(*mips_io_funcs.outw)((val),(port))
+#define inw_p(port)	(*mips_io_funcs.inw)(port)
+#define outl(val,port)	(*mips_io_funcs.outl)((val),(port))
+#define inl(port)	(*mips_io_funcs.inl)(port)
+#define outl_p(val,port)	(*mips_io_funcs.outl)((val),(port))
+#define inl_p(port)	(*mips_io_funcs.inl)(port)
+#define outsb(port,addr,count)	(*mips_io_funcs.outsb)((port),(addr),(count))
+#define insb(port,addr,count)	(*mips_io_funcs.insb)((port),(addr),(count))
+#define outsw(port,addr,count)	(*mips_io_funcs.outsw)((port),(addr),(count))
+#define insw(port,addr,count)	(*mips_io_funcs.insw)((port),(addr),(count))
+#define outsl(port,addr,count)	(*mips_io_funcs.outsl)((port),(addr),(count))
+#define insl(port,addr,count)	(*mips_io_funcs.insl)((port),(addr),(count))
+#define memset_io(a,b,c)	(*mips_io_funcs.memset_io)((volatile void *)(a),(b),(c))
+#define memcpy_fromio(a,b,c)	(*mips_io_funcs.memcpy_fromio)((a),(volatile void *)(b),(c))
+#define memcpy_toio(a,b,c)	(*mips_io_funcs.memcpy_toio)((volatile void *)(a),(b),(c))
+#endif /* CONFIG_HAVE_BOARD_IO_FUNCS */
 
 #endif /* _ASM_IO_H */
---
Atsushi Nemoto
