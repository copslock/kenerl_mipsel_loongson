Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 02:52:03 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:5901 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225370AbVAVCv5>; Sat, 22 Jan 2005 02:51:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 03F4EE1CB3; Sat, 22 Jan 2005 03:51:44 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21860-09; Sat, 22 Jan 2005 03:51:43 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A333BE1CAC; Sat, 22 Jan 2005 03:51:43 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0M2pV9j023219;
	Sat, 22 Jan 2005 03:51:45 +0100
Date:	Sat, 22 Jan 2005 02:51:47 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@mips.com, Richard Sandiford <rsandifo@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <20050122.015040.108744446.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.61L.0501211739410.16576@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0501131824350.21179@perivale.mips.com>
 <87k6qh2e6j.fsf@redhat.com> <Pine.LNX.4.61.0501141956520.21179@perivale.mips.com>
 <20050122.015040.108744446.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 22 Jan 2005, Atsushi Nemoto wrote:

> Revised.
> 
> 1. How about using 'const void *' for outs*()/reads*() ?  This will
>    remove some compiler warnings too.  Also, it seems 'volatile' for
>    memory buffer are unneeded.
> 
> 2. In *in*()/*out*(), it would be better to call __swizzle_addr*()
>    AFTER adding mips_io_port_base.  This unifies the meaning of the
>    argument of __swizzle_addr*() (always virtual address).  Then,
>    mach-specific __swizzle_addr*() can to every evil thing based on
>    the argument.
> 
> 3. How about Moving generic ioswab*() to mangle-port.h ?  Also how
>    about passing virtual address to *ioswab*() ?  Then we can provide
>    mach-specific ioswab*() and can do every evil thing based on its
>    argument.  It is usefull on machines which have regions with
>    different endian conversion scheme.

 Thanks for your insight -- your comments are not lost and I am working on 
taking them into account.  But meanwhile a confusion around the semantics 
of these operations arose (there is no documentation on them and some 
drivers expect some of these functions to swap, while others expect them 
not to) and changes were made to the tree that invalidated some of the 
fixes.  That needs to be addressed first and I expect another update to 
the file.  Here's a patch I'm going to start with.  Functions it adds have 
been named dma_* to indicate they are meant to preserve memory byte 
ordering.

  Maciej

patch-mips-2.6.11-rc1-20050120-mips-io-0
--- linux-mips-2.6.11-rc1-20050120.macro/include/asm-mips/io.h	19 Jan 2005 17:00:32 -0000	1.81
+++ linux-mips-2.6.11-rc1-20050120/include/asm-mips/io.h	20 Jan 2005 01:44:07 -0000
@@ -34,7 +34,7 @@
 #undef CONF_SLOWDOWN_IO
 
 /*
- * Raw operations are never swapped in software.  Otoh values that raw
+ * Raw operations are never swapped in software.  OTOH values that raw
  * operations are working on may or may not have been swapped by the bus
  * hardware.  An example use would be for flash memory that's used for
  * execute in place.
@@ -43,6 +43,7 @@
 # define __raw_ioswabw(x)	(x)
 # define __raw_ioswabl(x)	(x)
 # define __raw_ioswabq(x)	(x)
+# define ____raw_ioswabq(x)	(x)
 
 /*
  * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
@@ -51,37 +52,36 @@
 #if defined(CONFIG_SWAP_IO_SPACE)
 
 # define ioswabb(x)		(x)
+# define dma_ioswabb(x)		(x)
 # ifdef CONFIG_SGI_IP22
 /*
  * IP22 seems braindead enough to swap 16bits values in hardware, but
  * not 32bits.  Go figure... Can't tell without documentation.
  */
 #  define ioswabw(x)		(x)
+#  define dma_ioswabw(x)	le16_to_cpu(x)
 # else
 #  define ioswabw(x)		le16_to_cpu(x)
+#  define dma_ioswabw(x)	(x)
 # endif
 # define ioswabl(x)		le32_to_cpu(x)
+# define dma_ioswabl(x)		(x)
 # define ioswabq(x)		le64_to_cpu(x)
+# define dma_ioswabq(x)		(x)
 
 #else
 
 # define ioswabb(x)		(x)
+# define dma_ioswabb(x)		(x)
 # define ioswabw(x)		(x)
+# define dma_ioswabw(x)		cpu_to_le16(x)
 # define ioswabl(x)		(x)
+# define dma_ioswabl(x)		cpu_to_le32(x)
 # define ioswabq(x)		(x)
+# define dma_ioswabq(x)		cpu_to_le32(x)
 
 #endif
 
-/*
- * Native bus accesses never swapped.
- */
-#define bus_ioswabb(x)		(x)
-#define bus_ioswabw(x)		(x)
-#define bus_ioswabl(x)		(x)
-#define bus_ioswabq(x)		(x)
-
-#define __bus_ioswabq		bus_ioswabq
-
 #define IO_SPACE_LIMIT 0xffff
 
 /*
@@ -386,15 +386,15 @@ __BUILD_IOPORT_SINGLE(bus, bwlq, type, _
 
 #define BUILDIO(bwlq, type)						\
 									\
-__BUILD_MEMORY_PFX(, bwlq, type)					\
 __BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
-__BUILD_MEMORY_PFX(bus_, bwlq, type)					\
+__BUILD_MEMORY_PFX(, bwlq, type)					\
+__BUILD_MEMORY_PFX(dma_, bwlq, type)					\
 __BUILD_IOPORT_PFX(, bwlq, type)					\
-__BUILD_IOPORT_PFX(__raw_, bwlq, type)
+__BUILD_IOPORT_PFX(dma_, bwlq, type)
 
 #define __BUILDIO(bwlq, type)						\
 									\
-__BUILD_MEMORY_SINGLE(__bus_, bwlq, type, 0)
+__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 0)
 
 BUILDIO(b, u8)
 BUILDIO(w, u16)
@@ -422,7 +422,7 @@ static inline void writes##bwlq(volatile
 	volatile type *__addr = addr;					\
 									\
 	while (count--) {						\
-		__raw_write##bwlq(*__addr, mem);			\
+		dma_write##bwlq(*__addr, mem);				\
 		__addr++;						\
 	}								\
 }									\
@@ -433,7 +433,7 @@ static inline void reads##bwlq(volatile 
 	volatile type *__addr = addr;					\
 									\
 	while (count--) {						\
-		*__addr = __raw_read##bwlq(mem);			\
+		*__addr = dma_read##bwlq(mem);				\
 		__addr++;						\
 	}								\
 }
@@ -446,7 +446,7 @@ static inline void outs##bwlq(unsigned l
 	volatile type *__addr = addr;					\
 									\
 	while (count--) {						\
-		__raw_out##bwlq(*__addr, port);				\
+		dma_out##bwlq(*__addr, port);				\
 		__addr++;						\
 	}								\
 }									\
@@ -457,7 +457,7 @@ static inline void ins##bwlq(unsigned lo
 	volatile type *__addr = addr;					\
 									\
 	while (count--) {						\
-		*__addr = __raw_in##bwlq(port);				\
+		*__addr = dma_in##bwlq(port);				\
 		__addr++;						\
 	}								\
 }
