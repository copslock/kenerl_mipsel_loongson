Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Mar 2004 15:04:46 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:64384 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225204AbUC1OEp>; Sun, 28 Mar 2004 15:04:45 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1B7ZxI-0007Kl-00; Sun, 28 Mar 2004 14:04:00 +0100
Date: Sun, 28 Mar 2004 14:04:00 +0100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: pdh@colonel-panic.org, phorton@bitbox.co.uk,
	linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
Message-ID: <20040328130400.GA28177@skeleton-jack>
References: <4062F1A1.9070005@bitbox.co.uk> <20040326.122258.41628012.nemoto@toshiba-tops.co.jp> <20040326184317.GA3661@skeleton-jack> <20040327.224952.74755860.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327.224952.74755860.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 27, 2004 at 10:49:52PM +0900, Atsushi Nemoto wrote:
> 
> pdh> True. A proper fix would flush the relevant page after PIO
> pdh> transfers into the page cache / swap pages. Unfortunately this
> pdh> would require a hook in the generic kernel.
> 
> I found somewhat long discussions in linux-kernel ML.
> 
> Subject: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
> http://www.ussg.iu.edu/hypermail/linux/kernel/0305.2/1205.html
> http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/0151.html
> 
> Still I do not understand whole story on the thread, David S. Miller
> said that architecture defined IDE insw/outsw macro should do the
> flushing in this case, if I understand correctly.  Definitely sparc64
> __ide_insw do it.  Hmm ...
> 

I've ditched the original Cobalt hack in c-r4k.c, and am using the patch
below instead. Seems to work okay ...

P.

--- linux.cvs/include/asm-mips/io.h	Tue Feb 25 22:03:12 2003
+++ linux.pdh/include/asm-mips/io.h	Sun Mar 28 13:53:54 2004
@@ -400,35 +400,35 @@
 	}
 }
 
-static inline void __insb(unsigned long port, void *addr, unsigned int count)
+static inline void __outsw(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
-		*(u8 *)addr = inb(port);
-		addr++;
+		outw(*(u16 *)addr, port);
+		addr += 2;
 	}
 }
 
-static inline void __outsw(unsigned long port, void *addr, unsigned int count)
+static inline void __outsl(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
-		outw(*(u16 *)addr, port);
-		addr += 2;
+		outl(*(u32 *)addr, port);
+		addr += 4;
 	}
 }
 
-static inline void __insw(unsigned long port, void *addr, unsigned int count)
+static inline void __insb(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
-		*(u16 *)addr = inw(port);
-		addr += 2;
+		*(u8 *)addr = inb(port);
+		addr++;
 	}
 }
 
-static inline void __outsl(unsigned long port, void *addr, unsigned int count)
+static inline void __insw(unsigned long port, void *addr, unsigned int count)
 {
 	while (count--) {
-		outl(*(u32 *)addr, port);
-		addr += 4;
+		*(u16 *)addr = inw(port);
+		addr += 2;
 	}
 }
 
@@ -440,12 +440,69 @@
 	}
 }
 
+/*
+ * String "in" operations which additionally write back & invalidate the
+ * data that's read into the D-cache to prevent unexpected aliases.
+ *
+ * We have no flush_data_cache_range(from, to) so we blast a whole page
+ * at a time.
+ */
+
+static inline void __insb_f(unsigned long port, void *addr, unsigned int count)
+{
+	u8 *ptr, *end;
+
+	ptr = addr;
+	end = ptr + count;
+
+	while (ptr < end)
+		*ptr++ = inb(port);
+
+	for (; addr < (void *) end; addr += PAGE_SIZE)
+		flush_data_cache_page((unsigned long) addr);
+}
+
+static inline void __insw_f(unsigned long port, void *addr, unsigned int count)
+{
+	u16 *ptr, *end;
+
+	ptr = addr;
+	end = ptr + count;
+
+	while (ptr < end)
+		*ptr++ = inw(port);
+
+	for (; addr < (void *) end; addr += PAGE_SIZE)
+		flush_data_cache_page((unsigned long) addr);
+}
+
+static inline void __insl_f(unsigned long port, void *addr, unsigned int count)
+{
+	u32 *ptr, *end;
+
+	ptr = addr;
+	end = ptr + count;
+
+	while (ptr < end)
+		*ptr++ = inl(port);
+
+	for (; addr < (void *) end; addr += PAGE_SIZE)
+		flush_data_cache_page((unsigned long) addr);
+}
+
 #define outsb(port, addr, count) __outsb(port, addr, count)
-#define insb(port, addr, count) __insb(port, addr, count)
 #define outsw(port, addr, count) __outsw(port, addr, count)
-#define insw(port, addr, count) __insw(port, addr, count)
 #define outsl(port, addr, count) __outsl(port, addr, count)
-#define insl(port, addr, count) __insl(port, addr, count)
+
+#ifdef CONFIG_MIPS_COBALT
+# define insb(port, addr, count) __insb_f(port, addr, count)
+# define insw(port, addr, count) __insw_f(port, addr, count)
+# define insl(port, addr, count) __insl_f(port, addr, count)
+#else
+# define insb(port, addr, count) __insb(port, addr, count)
+# define insw(port, addr, count) __insw(port, addr, count)
+# define insl(port, addr, count) __insl(port, addr, count)
+#endif
 
 /*
  * The caches on some architectures aren't dma-coherent and have need to
