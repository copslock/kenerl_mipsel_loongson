Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 14:15:05 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:62867 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S3465592AbWAQOOo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 14:14:44 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 8287F1F31B;
	Tue, 17 Jan 2006 16:17:32 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Date:	Tue, 17 Jan 2006 16:17:14 +0200
User-Agent: KMail/1.9
Cc:	linux-mips@linux-mips.org
References: <20060117134838.GJ27047@deprecation.cyrius.com>
In-Reply-To: <20060117134838.GJ27047@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sxPzD6jIUozAkrU"
Message-Id: <200601171617.16147.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_sxPzD6jIUozAkrU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 17 January 2006 3:48 pm, Martin Michlmayr wrote:
> Has anyone else seen the following error when compiling a kernel with GCC
> 4.0 (GCC 3.3 works) and knows what to do about it?
>
> arch/mips/kernel/built-in.o: In function `time_init':
> : undefined reference to `__lshrdi3'

I think I've solved it by copying the files
ashldi3.c ashrdi3.c lshrdi3.c
from arch/ppc/lib to arch/mips/lib

The patch for 2.6 is:


--Boundary-00=_sxPzD6jIUozAkrU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="float.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="float.patch"

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index cf12caf..dfa0b12 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -7,4 +7,7 @@ lib-y	+= csum_partial_copy.o memcpy.o pr
 
 obj-y	+= iomap.o
 
+#ugly hack. Why is this needed?
+lib-$(CONFIG_MIKROTIK_RB500) += ashldi3.o ashrdi3.o lshrdi3.o
+
 EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
new file mode 100644
index 0000000..2f4a3d5
--- /dev/null
+++ b/arch/mips/lib/ashldi3.c
@@ -0,0 +1,66 @@
+/* ashrdi3.c extracted from gcc-2.95.2/libgcc2.c which is: */
+/* Copyright (C) 1989, 92-98, 1999 Free Software Foundation, Inc.
+
+This file is part of GNU CC.
+
+GNU CC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2, or (at your option)
+any later version.
+
+GNU CC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GNU CC; see the file COPYING.  If not, write to
+the Free Software Foundation, 59 Temple Place - Suite 330,
+Boston, MA 02111-1307, USA.  */
+
+#include <linux/linkage.h>
+#include <linux/module.h>
+#define BITS_PER_UNIT 8
+
+typedef		 int SItype	__attribute__ ((mode (SI)));
+typedef unsigned int USItype	__attribute__ ((mode (SI)));
+typedef		 int DItype	__attribute__ ((mode (DI)));
+typedef int word_type __attribute__ ((mode (__word__)));
+
+struct DIstruct {SItype high, low;};
+
+typedef union
+{
+  struct DIstruct s;
+  DItype ll;
+} DIunion;
+
+DItype
+__ashldi3 (DItype u, word_type b)
+{
+  DIunion w;
+  word_type bm;
+  DIunion uu;
+
+  if (b == 0)
+    return u;
+
+  uu.ll = u;
+
+  bm = (sizeof (SItype) * BITS_PER_UNIT) - b;
+  if (bm <= 0)
+    {
+      w.s.low = 0;
+      w.s.high = (USItype)uu.s.low << -bm;
+    }
+  else
+    {
+      USItype carries = (USItype)uu.s.low >> bm;
+      w.s.low = (USItype)uu.s.low << b;
+      w.s.high = ((USItype)uu.s.high << b) | carries;
+    }
+
+  return w.ll;
+}
+
+EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
new file mode 100644
index 0000000..eb6d47d
--- /dev/null
+++ b/arch/mips/lib/ashrdi3.c
@@ -0,0 +1,68 @@
+/* ashrdi3.c extracted from gcc-2.7.2/libgcc2.c which is: */
+/* Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
+
+This file is part of GNU CC.
+
+GNU CC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2, or (at your option)
+any later version.
+
+GNU CC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GNU CC; see the file COPYING.  If not, write to
+the Free Software Foundation, 59 Temple Place - Suite 330,
+Boston, MA 02111-1307, USA.  */
+
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+#define BITS_PER_UNIT 8
+
+typedef		 int SItype	__attribute__ ((mode (SI)));
+typedef unsigned int USItype	__attribute__ ((mode (SI)));
+typedef		 int DItype	__attribute__ ((mode (DI)));
+typedef int word_type __attribute__ ((mode (__word__)));
+
+struct DIstruct {SItype high, low;};
+
+typedef union
+{
+  struct DIstruct s;
+  DItype ll;
+} DIunion;
+
+DItype
+__ashrdi3 (DItype u, word_type b)
+{
+  DIunion w;
+  word_type bm;
+  DIunion uu;
+
+  if (b == 0)
+    return u;
+
+  uu.ll = u;
+
+  bm = (sizeof (SItype) * BITS_PER_UNIT) - b;
+  if (bm <= 0)
+    {
+      /* w.s.high = 1..1 or 0..0 */
+      w.s.high = uu.s.high >> (sizeof (SItype) * BITS_PER_UNIT - 1);
+      w.s.low = uu.s.high >> -bm;
+    }
+  else
+    {
+      USItype carries = (USItype)uu.s.high << bm;
+      w.s.high = uu.s.high >> b;
+      w.s.low = ((USItype)uu.s.low >> b) | carries;
+    }
+
+  return w.ll;
+}
+EXPORT_SYMBOL(__ashrdi3);
+
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
new file mode 100644
index 0000000..c6a02d5
--- /dev/null
+++ b/arch/mips/lib/lshrdi3.c
@@ -0,0 +1,68 @@
+/* lshrdi3.c extracted from gcc-2.7.2/libgcc2.c which is: */
+/* Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
+
+This file is part of GNU CC.
+
+GNU CC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2, or (at your option)
+any later version.
+
+GNU CC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GNU CC; see the file COPYING.  If not, write to
+the Free Software Foundation, 59 Temple Place - Suite 330,
+Boston, MA 02111-1307, USA.  */
+
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+#define BITS_PER_UNIT 8
+
+typedef		 int SItype	__attribute__ ((mode (SI)));
+typedef unsigned int USItype	__attribute__ ((mode (SI)));
+typedef		 int DItype	__attribute__ ((mode (DI)));
+typedef int word_type __attribute__ ((mode (__word__)));
+
+struct DIstruct {SItype high, low;};
+
+typedef union
+{
+  struct DIstruct s;
+  DItype ll;
+} DIunion;
+
+DItype
+__lshrdi3 (DItype u, word_type b)
+{
+  DIunion w;
+  word_type bm;
+  DIunion uu;
+
+  if (b == 0)
+    return u;
+
+  uu.ll = u;
+
+  bm = (sizeof (SItype) * BITS_PER_UNIT) - b;
+  if (bm <= 0)
+    {
+      w.s.high = 0;
+      w.s.low = (USItype)uu.s.high >> -bm;
+    }
+  else
+    {
+      USItype carries = (USItype)uu.s.high << bm;
+      w.s.high = (USItype)uu.s.high >> b;
+      w.s.low = ((USItype)uu.s.low >> b) | carries;
+    }
+
+  return w.ll;
+}
+
+EXPORT_SYMBOL(__lshrdi3);
+

--Boundary-00=_sxPzD6jIUozAkrU--
