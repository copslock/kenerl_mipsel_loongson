Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76Adhm02721
	for linux-mips-outgoing; Mon, 6 Aug 2001 03:39:43 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76AdeV02715
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 03:39:40 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15ThnE-0001l3-00; Mon, 06 Aug 2001 12:39:28 +0200
Date: Mon, 6 Aug 2001 12:39:28 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: linux-mips@oss.sgi.com
Subject: Re: XFree86 generic.c problem
Message-ID: <20010806123928.G5525@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
References: <200108060733.f767XtV29057@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108060733.f767XtV29057@oss.sgi.com>; from fxzhang@ict.ac.cn on Mon, Aug 06, 2001 at 03:36:29PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2001 at 03:36:29PM +0800, Fuxin Zhang wrote:
> hello,linux-mips
> 
>    When trying to crossing compile XFree86 server for my linux on mipsel
> Mr. Guido Guenther has posted a patch to work around it.But could 
> it be right somewhere?Just curious:)
>   Thank you in advance.
I have fixed this(and some other problems) in the debian XFree86
Packages but not submitted upstream yet. I've attched the patch.
 -- Guido

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="350_mips_compiler_h.diff"

--- xc/programs/Xserver/hw/xfree86/common/compiler.h.orig	Tue Jul 24 22:33:42 2001
+++ xc/programs/Xserver/hw/xfree86/common/compiler.h	Tue Jul 24 22:37:37 2001
@@ -862,6 +862,67 @@
 	return r1;
 }
 
+#ifdef linux	/* don't mess with other OSs */
+
+/*
+ * EGCS 1.1 knows about arbitrary unaligned loads (and we don't support older
+ * versions anyway. Define some packed structures to talk about such things
+ * with.
+ */
+
+struct __una_u32 { unsigned int   x __attribute__((packed)); };
+struct __una_u16 { unsigned short x __attribute__((packed)); };
+
+static __inline__ void stw_u(unsigned long val, unsigned short *p)
+{
+	struct __una_u16 *ptr = (struct __una_u16 *) p;
+	ptr->x = val;
+}
+
+static __inline__ void stl_u(unsigned long val, unsigned int *p)
+{
+	struct __una_u32 *ptr = (struct __una_u32 *) p;
+	ptr->x = val;
+}
+
+#if X_BYTE_ORDER == X_BIG_ENDIAN
+static __inline__ unsigned int
+xf86ReadMmio32Be(__volatile__ void *base, const unsigned long offset)
+{
+	unsigned long addr = ((unsigned long)base) + offset;
+	unsigned int ret;
+
+	__asm__ __volatile__("lw %0, 0(%1)"
+			     : "=r" (ret)
+			     : "r" (addr));
+	return ret;
+}
+
+static __inline__ void
+xf86WriteMmio32Be(__volatile__ void *base, const unsigned long offset,
+		  const unsigned int val)
+{
+	unsigned long addr = ((unsigned long)base) + offset;
+
+	__asm__ __volatile__("sw %0, 0(%1)"
+			     : /* No outputs */
+			     : "r" (val), "r" (addr));
+}
+#endif
+
+#define mem_barrier() \
+__asm__ __volatile__(					\
+	"# prevent instructions being moved around\n\t"	\
+	".set\tnoreorder\n\t"				\
+	"# 8 nops to fool the R4400 pipeline\n\t"	\
+	"nop;nop;nop;nop;nop;nop;nop;nop\n\t"		\
+	".set\treorder"					\
+	: /* no output */				\
+	: /* no input */				\
+	: "memory")
+#define write_mem_barrier() mem_barrier()
+
+#else  /* !linux */
 #define stq_u(v,p)	stl_u(v,p)
 #define stl_u(v,p)	(*(unsigned char *)(p)) = (v); \
 			(*(unsigned char *)(p)+1) = ((v) >> 8);  \
@@ -872,6 +934,7 @@
 			(*(unsigned char *)(p)+1) = ((v) >> 8)
 
 #define mem_barrier()   /* NOP */
+#endif /* !linux */
 #endif /* __mips__ */
 
 #if defined(__arm32__)

--lEGEL1/lMxI0MVQ2--
