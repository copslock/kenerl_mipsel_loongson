Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:05:57 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:38156 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3468144AbWAQTFi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 19:05:38 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HJ90EO004354;
	Tue, 17 Jan 2006 19:09:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HJ8xql004353;
	Tue, 17 Jan 2006 19:08:59 GMT
Date:	Tue, 17 Jan 2006 19:08:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060117190859.GA2061@linux-mips.org>
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601171617.16147.p_christ@hol.gr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 17, 2006 at 04:17:14PM +0200, P. Christeas wrote:

> On Tuesday 17 January 2006 3:48 pm, Martin Michlmayr wrote:
> > Has anyone else seen the following error when compiling a kernel with GCC
> > 4.0 (GCC 3.3 works) and knows what to do about it?
> >
> > arch/mips/kernel/built-in.o: In function `time_init':
> > : undefined reference to `__lshrdi3'

Thanks to Martin Michlmayr's testing I now know this problem is limited
to kernels built with gcc 4.0 and newer when optimizing for size.

> I think I've solved it by copying the files
> ashldi3.c ashrdi3.c lshrdi3.c
> from arch/ppc/lib to arch/mips/lib

There is an awful lot of libgcc bits flying around in the kernel and I guess
I'd be flamed for submitting even more ;-)  so I tried to come up with
something to make most if not all unnecessary.  Still needs a little
polishing but below for testing and commenting.

  Ralf

diff --git a/include/asm-mips/libgcc.h b/include/asm-mips/libgcc.h
new file mode 100644
index 0000000..0aef711
 include/asm-mips/libgcc.h |    8 ++++++++
 include/linux/libgcc.h    |   32 ++++++++++++++++++++++++++++++++
 lib/Makefile              |    1 +
 lib/ashldi3.c             |   32 ++++++++++++++++++++++++++++++++
 lib/ashrdi3.c             |   36 ++++++++++++++++++++++++++++++++++++
 lib/lshrdi3.c             |   34 ++++++++++++++++++++++++++++++++++
 6 files changed, 143 insertions(+)

Index: linux-mips/include/asm-mips/libgcc.h
===================================================================
--- /dev/null
+++ linux-mips/include/asm-mips/libgcc.h
@@ -0,0 +1,8 @@
+#ifndef __ASM_LIBGCC_H
+#define __ASM_LIBGCC_H
+
+#define ARCH_NEEDS_ashldi3
+#define ARCH_NEEDS_ashrdi3
+#define ARCH_NEEDS_lshrdi3
+
+#endif /* __ASM_LIBGCC_H */
Index: linux-mips/include/linux/libgcc.h
===================================================================
--- /dev/null
+++ linux-mips/include/linux/libgcc.h
@@ -0,0 +1,32 @@
+#ifndef __LINUX_LIBGCC_H
+#define __LINUX_LIBGCC_H
+
+#include <asm/byteorder.h>
+#include <asm/libgcc.h>
+
+typedef long long DWtype;
+typedef int Wtype;
+typedef unsigned int UWtype;
+typedef int word_type __attribute__ ((mode (__word__)));
+
+#define BITS_PER_UNIT 8
+
+#ifdef __BIG_ENDIAN
+struct DWstruct {
+	Wtype high, low;
+};
+#elif defined(__LITTLE_ENDIAN)
+struct DWstruct {
+	Wtype low, high;
+};
+#else
+#error I feel sick.
+#endif
+
+typedef union
+{
+	struct DWstruct s;
+	DWtype ll;
+} DWunion;
+
+#endif /* __LINUX_LIBGCC_H */
Index: linux-mips/lib/Makefile
===================================================================
--- linux-mips.orig/lib/Makefile
+++ linux-mips/lib/Makefile
@@ -8,6 +8,7 @@ lib-y := errno.o ctype.o string.o vsprin
 	 sha1.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
+lib-y	+= ashldi3.o ashrdi3.o lshrdi3.o
 
 obj-y += sort.o parser.o halfmd4.o
 
Index: linux-mips/lib/ashldi3.c
===================================================================
--- /dev/null
+++ linux-mips/lib/ashldi3.c
@@ -0,0 +1,32 @@
+#include <linux/libgcc.h>
+#include <linux/module.h>
+
+#ifdef ARCH_NEEDS_ashldi3
+
+DWtype __ashldi3(DWtype u, word_type b)
+{
+	DWunion uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = (sizeof(Wtype) * BITS_PER_UNIT) - b;
+
+	if (bm <= 0) {
+		w.s.low = 0;
+		w.s.high = (UWtype) uu.s.low << -bm;
+	} else {
+		const UWtype carries = (UWtype) uu.s.low >> bm;
+
+		w.s.low = (UWtype) uu.s.low << b;
+		w.s.high = ((UWtype) uu.s.high << b) | carries;
+	}
+
+	return w.ll;
+}
+
+EXPORT_SYMBOL(__ashldi3);
+
+#endif /* ARCH_NEEDS_ashldi3 */
Index: linux-mips/lib/ashrdi3.c
===================================================================
--- /dev/null
+++ linux-mips/lib/ashrdi3.c
@@ -0,0 +1,36 @@
+#include <linux/libgcc.h>
+#include <linux/module.h>
+
+/* Unless shift functions are defined with full ANSI prototypes,
+   parameter b will be promoted to int if word_type is smaller than an int.  */
+#ifdef ARCH_NEEDS_ashrdi3
+
+DWtype __ashrdi3(DWtype u, word_type b)
+{
+	DWunion uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = (sizeof(Wtype) * BITS_PER_UNIT) - b;
+
+	if (bm <= 0) {
+		/* w.s.high = 1..1 or 0..0 */
+		w.s.high =
+		    uu.s.high >> (sizeof(Wtype) * BITS_PER_UNIT - 1);
+		w.s.low = uu.s.high >> -bm;
+	} else {
+		const UWtype carries = (UWtype) uu.s.high << bm;
+
+		w.s.high = uu.s.high >> b;
+		w.s.low = ((UWtype) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
+
+EXPORT_SYMBOL(__ashrdi3);
+
+#endif /* ARCH_NEEDS_ashrdi3 */
Index: linux-mips/lib/lshrdi3.c
===================================================================
--- /dev/null
+++ linux-mips/lib/lshrdi3.c
@@ -0,0 +1,34 @@
+#include <linux/libgcc.h>
+#include <linux/module.h>
+
+/* Unless shift functions are defined with full ANSI prototypes,
+   parameter b will be promoted to int if word_type is smaller than an int.  */
+#ifdef ARCH_NEEDS_lshrdi3
+
+DWtype __lshrdi3(DWtype u, word_type b)
+{
+	DWunion uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = (sizeof(Wtype) * BITS_PER_UNIT) - b;
+
+	if (bm <= 0) {
+		w.s.high = 0;
+		w.s.low = (UWtype) uu.s.high >> -bm;
+	} else {
+		const UWtype carries = (UWtype) uu.s.high << bm;
+
+		w.s.high = (UWtype) uu.s.high >> b;
+		w.s.low = ((UWtype) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
+
+EXPORT_SYMBOL(__lshrdi3);
+
+#endif /* ARCH_NEEDS_lshrdi3 */
