Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2004 00:40:32 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:25839 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225287AbUIXXk2>; Sat, 25 Sep 2004 00:40:28 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id BC8DF1848F; Fri, 24 Sep 2004 16:40:25 -0700 (PDT)
Message-ID: <4154B069.8010708@mvista.com>
Date: Fri, 24 Sep 2004 16:40:25 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: IDE woos in BE mode 2.6 kernel
References: <414B388D.8060705@mvista.com> <20040918.231947.74754644.anemo@mba.ocn.ne.jp>
In-Reply-To: <20040918.231947.74754644.anemo@mba.ocn.ne.jp>
Content-Type: multipart/mixed;
 boundary="------------000805080008060208050202"
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000805080008060208050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello !

These changes below work and attached is the patch based on your 
suggestion. However, I have made changes to include/asm-mips/ide.h since 
I think there may be problems with other MIPS boards to in BE mode. 
And,  I have not included the  (dma_cache_wback) in the patch.

Thanks
Manish


Atsushi Nemoto wrote:

>>>>>>On Fri, 17 Sep 2004 12:18:37 -0700, Manish Lachwani <mlachwani@mvista.com> said:
>>>>>>            
>>>>>>
>
>mlachwani> In response to Jun Suns mail sent on 06/24/2004
>
>jsun> Anybody has tried IDE disks in big endian mode with 2.6
>jsun> kernel?  I seem to have troubles with Malta board.
>...
>mlachwani> The following patch gets the Malta to work well. However,
>mlachwani> this patch introduces board specific changes in the IDE
>mlachwani> subsystem.  This is not a final patch but maybe there can
>mlachwani> be a better approach to this issue
>
>FYI, here is my approach.  Not so beautiful but less intrusive...
>
>1. copy include/asm-mips/mach-generic/ide.h to my mach-xxx directory.
>2. add following lines to include/asm-mips/mach-xxx/ide.h
>--- begin ---
>/* get rid of defs from io.h - ide has its private and conflicting versions */
>#ifdef insb
>#undef insb
>#endif
>#ifdef outsb
>#undef outsb
>#endif
>#ifdef insw
>#undef insw
>#endif
>#ifdef outsw
>#undef outsw
>#endif
>#ifdef insl
>#undef insl
>#endif
>#ifdef outsl
>#undef outsl
>#endif
>
>#define insb(port, addr, count) ___ide_insb(port, addr, count)
>#define insw(port, addr, count) ___ide_insw(port, addr, count)
>#define insl(port, addr, count) ___ide_insl(port, addr, count)
>#define outsb(port, addr, count) ___ide_outsb(port, addr, count)
>#define outsw(port, addr, count) ___ide_outsw(port, addr, count)
>#define outsl(port, addr, count) ___ide_outsl(port, addr, count)
>
>static inline void ___ide_insb(unsigned long port, void *addr, unsigned int count)
>{
>	unsigned long start = (unsigned long)addr;
>	unsigned long size = (unsigned long)count;
>	while (count--) {
>		*(u16 *)addr = *(volatile u8 *)(mips_io_port_base + port);
>		addr++;
>	}
>	if (cpu_has_dc_aliases)
>		dma_cache_wback((unsigned long)start, size);
>}
>
>static inline void ___ide_outsb(unsigned long port, void *addr, unsigned int count)
>{
>	while (count--) {
>		*(volatile u8 *)(mips_io_port_base + port) = *(u8 *)addr;
>		addr++;
>	}
>}
>
>static inline void ___ide_insw(unsigned long port, void *addr, unsigned int count)
>{
>	unsigned long start = (unsigned long)addr;
>	unsigned long size = (unsigned long)count * 2;
>	while (count--) {
>		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
>		addr += 2;
>	}
>	if (cpu_has_dc_aliases)
>		dma_cache_wback((unsigned long)start, size);
>}
>
>static inline void ___ide_outsw(unsigned long port, void *addr, unsigned int count)
>{
>	while (count--) {
>		*(volatile u16 *)(mips_io_port_base + port) = *(u16 *)addr;
>		addr += 2;
>	}
>}
>
>static inline void ___ide_insl(unsigned long port, void *addr, unsigned int count)
>{
>	unsigned long start = (unsigned long)addr;
>	unsigned long size = (unsigned long)count * 4;
>	while (count--) {
>		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
>		addr += 4;
>	}
>	if (cpu_has_dc_aliases)
>		dma_cache_wback((unsigned long)start, size);
>}
>
>static inline void ___ide_outsl(unsigned long port, void *addr, unsigned int count)
>{
>	while (count--) {
>		*(volatile u32 *)(mips_io_port_base + port) = *(u32 *)addr;
>		addr += 4;
>	}
>}
>--- end ---
>
>Note that above codes include workarounds for PIO IDE cache problem
>(dma_cache_wback) though I'm not sure this workaround still needed.
>Please refer this ML thread for the workaround.
><http://www.linux-mips.org/archives/linux-mips/2004-03/msg00185.html>
>
>
>And as I wrote before, I think this IDE endian problem still exists in
>current 2.4 tree too.  Please refer my 02/26 mail for this topic.
><http://www.linux-mips.org/archives/linux-mips/2004-02/msg00219.html>
>
>Thank you.
>
>---
>Atsushi Nemoto
>  
>


--------------000805080008060208050202
Content-Type: text/plain;
 name="patch-26-ide-malta"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-26-ide-malta"

--- include/asm-mips/ide.h.orig	2004-09-16 15:41:00.000000000 -0700
+++ include/asm-mips/ide.h	2004-09-20 09:45:14.000000000 -0700
@@ -20,6 +20,91 @@
 #define __ide_mm_outsw  ide_outsw
 #define __ide_mm_outsl  ide_outsl
 
+#ifndef CONFIG_CPU_LITTLE_ENDIAN
+/*
+ * Only for the Big Endian systems, do not do the swapping.
+ * We cannot turn off the CONFIG_SWAP_IO_SPACE since the
+ * other subsystems need it. Hence we need this approach for
+ * IDE only - Manish Lachwani (mlachwani@mvista.com)
+ */
+extern const unsigned long mips_io_port_base;
+
+#ifdef insb
+#undef insb
+#endif
+#ifdef outsb
+#undef outsb
+#endif
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
+#define insb(port, addr, count)		___ide_insb(port, addr, count)
+#define insw(port, addr, count)		___ide_insw(port, addr, count)
+#define insl(port, addr, count)		___ide_insl(port, addr, count)
+#define outsb(port, addr, count)	___ide_outsb(port, addr, count)
+#define outsw(port, addr, count)	___ide_outsw(port, addr, count)
+#define outsl(port, addr, count)	___ide_outsl(port, addr, count)
+
+static inline void ___ide_insb(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = *(volatile u8 *)(mips_io_port_base + port);
+		addr++;
+	}
+}
+
+static inline void ___ide_outsb(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u8 *)(mips_io_port_base + port) = *(u8 *)addr;
+		addr++;
+	}
+}
+
+static inline void ___ide_insw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
+		addr += 2;
+	}
+}
+
+static inline void ___ide_outsw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u16 *)(mips_io_port_base + port) = *(u16 *)addr;
+		addr += 2;
+	}
+}
+
+static inline void ___ide_insl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
+		addr += 4;
+	}
+}
+
+static inline void ___ide_outsl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u32 *)(mips_io_port_base + port) = *(u32 *)addr;
+		addr += 4;
+	}
+}
+
+#endif /* CONFIG_LITTLE_ENDIAN */
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IDE_H */

--------------000805080008060208050202--
