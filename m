Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Sep 2004 20:18:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:15091 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224930AbUIQTSl>; Fri, 17 Sep 2004 20:18:41 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP id EA4171836D
	for <linux-mips@linux-mips.org>; Fri, 17 Sep 2004 12:18:37 -0700 (PDT)
Message-ID: <414B388D.8060705@mvista.com>
Date: Fri, 17 Sep 2004 12:18:37 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: IDE woos in BE mode 2.6 kernel
Content-Type: multipart/mixed;
 boundary="------------050903050607020903060201"
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050903050607020903060201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello !

In response to Jun Suns mail sent on 06/24/2004

Anybody has tried IDE disks in big endian mode with 2.6 kernel?
I seem to have troubles with Malta board.

Current malta board has CONFIG_SWAP_IO_SPACE defined and therefore
all inw, inl and their friends are byte-swapped in BE mode.  As a
results all IDE IO ops (such as ide_inw, etc) do swapping too.

A quick experiement shows those IDE IO ops should not do swapping.
Anybody knows why?

Apparently fixing the above is not enough.  I either encountered
failure to read partition table or having DMA error.  Any clues
here?

I suppose this problem really should exist for other arches
with BE support.  Anybody knows how other arches deal with this?

Thanks.

Jun

---

The following patch gets the Malta to work well. However, this patch introduces board specific changes in the IDE subsystem.
This is not a final patch but maybe there can be a better approach to this issue

Thanks
Manish



--------------050903050607020903060201
Content-Type: text/plain;
 name="patch-26-ide-malta"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-26-ide-malta"

--- drivers/ide/ide-iops.c.orig	2004-09-16 19:20:52.000000000 -0700
+++ drivers/ide/ide-iops.c	2004-09-16 18:55:37.000000000 -0700
@@ -95,13 +95,23 @@
 	hwif->OUTBSYNC	= ide_outbsync;
 	hwif->OUTW	= ide_outw;
 	hwif->OUTL	= ide_outl;
+#if defined(CONFIG_MIPS_MALTA) && !defined(CONFIG_CPU_LITTLE_ENDIAN)
+	hwif->OUTSW	= malta_ide_outsw;
+	hwif->OUTSL	= malta_ide_outsl;
+#else
 	hwif->OUTSW	= ide_outsw;
 	hwif->OUTSL	= ide_outsl;
+#endif
 	hwif->INB	= ide_inb;
 	hwif->INW	= ide_inw;
 	hwif->INL	= ide_inl;
+#if defined(CONFIG_MIPS_MALTA) && !defined(CONFIG_CPU_LITTLE_ENDIAN)
+	hwif->INSW	= malta_ide_insw;
+	hwif->INSL	= malta_ide_insl;
+#else
 	hwif->INSW	= ide_insw;
 	hwif->INSL	= ide_insl;
+#endif
 }
 
 EXPORT_SYMBOL(default_hwif_iops);
--- include/asm-mips/ide.h.orig	2004-09-16 15:41:00.000000000 -0700
+++ include/asm-mips/ide.h	2004-09-16 18:12:26.000000000 -0700
@@ -20,6 +20,42 @@
 #define __ide_mm_outsw  ide_outsw
 #define __ide_mm_outsl  ide_outsl
 
+#if defined(CONFIG_MIPS_MALTA) && !defined(CONFIG_CPU_LITTLE_ENDIAN)
+extern const unsigned long mips_io_port_base;
+
+static inline void malta_ide_insw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
+		addr += 2;
+	}
+}
+
+static inline void malta_ide_outsw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u16 *)(mips_io_port_base + (port)) = *(u16 *)addr;
+		addr += 2;
+	}
+}
+
+static inline void malta_ide_insl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
+		addr += 4;
+	}
+}
+
+static inline void malta_ide_outsl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u32 *)(mips_io_port_base + (port)) = *(u32 *)addr;
+		addr += 4;
+	}
+}
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IDE_H */

--------------050903050607020903060201--
