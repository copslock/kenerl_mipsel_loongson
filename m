Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:11:17 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:34893
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992110AbdFFTKfs9KsB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:10:35 +0200
Received: by mail-pg0-x242.google.com with SMTP id f127so13769907pgc.2
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=34EAhXYVWPqi87KRZQOkLDTgZFOL7epA62NGPJOUlgA=;
        b=hSivm03K9MBwPqPaYGosCSsYzM1QSjwf3vGYq5tXPa2mOYw8FysYELYo97QZSZtVNG
         MHfWmkedfdV6ws/D2pBnSKDj2o4GYxsGWLyhum7LIHVuOyMSUMeEp5h1G6GJMcP2sUNE
         S49Ou1Yys4SQ8JeR/en5Xa6RrGIG+Kg3y2GP1aNP5JDU6lIH41GnzG4v0G9XTo38a6op
         fIX3d9M5gh1Rv7oIVCJIDYrWoigv5zxT7G+HHBmVqXVf4ZCVURZKYKKkZhIt4J9k3uKK
         UNkmkBJtOWNwfIY5VLuC/ZsVKCZgrKX8VqpJkyDZzvNd5lbrZG9lCv1EKvvLXsyLLqSp
         c4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=34EAhXYVWPqi87KRZQOkLDTgZFOL7epA62NGPJOUlgA=;
        b=i67747SNknuWGMBoJKUOnrKfB3vCX8GBLama+waBG+Rd/jOu9kFFdCeHjagSfswAHu
         fvvIYVtEu1tNEpo3h2ZYperbz21C0ryTiYmdgyYF6BfTuu1Iqsc3uJobf+fAPR9xHzrH
         S65YN9ZwokQQZoLsZPADA/lKz+2CkBXFhLlM54AuaVZ5Pl0+7kkRCyOJ4vYlF3c0+gHE
         Vvd+A6G3ukqQZ51eF+s6CdzC8ELJvYeT0HlfXJT1ZGiRFzpyWCOB4XPF4fFa8ODtgNZw
         0LoB7jEwKrw0B29qm/WlKUUznLUBSAgH8Oha4ixiz8Qutj00qYK+STBA+06/HTPTcR8K
         4BHw==
X-Gm-Message-State: AODbwcBNF1Vf02zIBOhwzN8yj4x4URnSTdf7GgtT+n7+rG0pbDInEaHq
        Hexs95AIHTVRLpp8
X-Received: by 10.101.76.79 with SMTP id l15mr28359211pgr.86.1496776229661;
        Tue, 06 Jun 2017 12:10:29 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id v3sm5917660pfi.3.2017.06.06.12.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 12:10:28 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     monstr@monstr.eu
To:     ralf@linux-mips.org
To:     liqin.linux@gmail.com
To:     lennox.wu@gmail.com
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     geert@linux-m68k.org
To:     linux-kernel@vger.kernel.org
To:     linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/7] lib: Add shared copies of some GCC library routines
Date:   Tue,  6 Jun 2017 12:10:17 -0700
Message-Id: <20170606191023.24581-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170606191023.24581-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Many ports (m32r, microblaze, mips, parisc, score, and sparc) use
functionally identical copies of various GCC library routine files,
which came up as we were submitting the RISC-V port (which also uses
some of these).

This patch adds a new copy of these library routine files, which are
functionally identical to the various other copies.  These are
availiable via Kconfig as CONFIG_LIB_$ROUTINE, which currently isn't
used anywhere.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/lib/libgcc.h | 44 ++++++++++++++++++++++++++++++++
 lib/Kconfig          | 18 +++++++++++++
 lib/Makefile         |  8 ++++++
 lib/ashldi3.c        | 45 ++++++++++++++++++++++++++++++++
 lib/ashrdi3.c        | 46 +++++++++++++++++++++++++++++++++
 lib/cmpdi2.c         | 42 ++++++++++++++++++++++++++++++
 lib/lshrdi3.c        | 45 ++++++++++++++++++++++++++++++++
 lib/muldi3.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/ucmpdi2.c        | 35 +++++++++++++++++++++++++
 9 files changed, 355 insertions(+)
 create mode 100644 include/lib/libgcc.h
 create mode 100644 lib/ashldi3.c
 create mode 100644 lib/ashrdi3.c
 create mode 100644 lib/cmpdi2.c
 create mode 100644 lib/lshrdi3.c
 create mode 100644 lib/muldi3.c
 create mode 100644 lib/ucmpdi2.c

diff --git a/include/lib/libgcc.h b/include/lib/libgcc.h
new file mode 100644
index 000000000000..a5397e34e005
--- /dev/null
+++ b/include/lib/libgcc.h
@@ -0,0 +1,44 @@
+/*
+ * include/lib/libgcc.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+
+#ifndef __LIB_LIBGCC_H
+#define __LIB_LIBGCC_H
+
+#include <asm/byteorder.h>
+
+typedef int word_type __attribute__ ((mode (__word__)));
+
+#ifdef __BIG_ENDIAN
+struct DWstruct {
+	int high, low;
+};
+#elif defined(__LITTLE_ENDIAN)
+struct DWstruct {
+	int low, high;
+};
+#else
+#error I feel sick.
+#endif
+
+typedef union {
+	struct DWstruct s;
+	long long ll;
+} DWunion;
+
+#endif /* __ASM_LIBGCC_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 0c8b78a9ae2e..7a9c934d91fd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -565,3 +565,21 @@ config PRIME_NUMBERS
 	tristate
 
 endmenu
+
+config GENERIC_ASHLDI3
+	def_bool n
+
+config GENERIC_ASHRDI3
+	def_bool n
+
+config GENERIC_LSHRDI3
+	def_bool n
+
+config GENERIC_MULDI3
+	def_bool n
+
+config GENERIC_CMPDI2
+	def_bool n
+
+config GENERIC_UCMPDI2
+	def_bool n
diff --git a/lib/Makefile b/lib/Makefile
index 0166fbc0fa81..5f68242f7774 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -243,3 +243,11 @@ UBSAN_SANITIZE_ubsan.o := n
 obj-$(CONFIG_SBITMAP) += sbitmap.o
 
 obj-$(CONFIG_PARMAN) += parman.o
+
+# GCC library routines
+obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
+obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
+obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
+obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
+obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
+obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
diff --git a/lib/ashldi3.c b/lib/ashldi3.c
new file mode 100644
index 000000000000..ff4ec63d2ab6
--- /dev/null
+++ b/lib/ashldi3.c
@@ -0,0 +1,45 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+
+#include <linux/export.h>
+
+#include <lib/libgcc.h>
+
+long long notrace __ashldi3(long long u, word_type b)
+{
+	DWunion uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = 32 - b;
+
+	if (bm <= 0) {
+		w.s.low = 0;
+		w.s.high = (unsigned int) uu.s.low << -bm;
+	} else {
+		const unsigned int carries = (unsigned int) uu.s.low >> bm;
+
+		w.s.low = (unsigned int) uu.s.low << b;
+		w.s.high = ((unsigned int) uu.s.high << b) | carries;
+	}
+
+	return w.ll;
+}
+EXPORT_SYMBOL(__ashldi3);
diff --git a/lib/ashrdi3.c b/lib/ashrdi3.c
new file mode 100644
index 000000000000..2e67c97ac65a
--- /dev/null
+++ b/lib/ashrdi3.c
@@ -0,0 +1,46 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+#include <linux/export.h>
+
+#include <lib/libgcc.h>
+
+long long notrace __ashrdi3(long long u, word_type b)
+{
+	DWunion uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = 32 - b;
+
+	if (bm <= 0) {
+		/* w.s.high = 1..1 or 0..0 */
+		w.s.high =
+		    uu.s.high >> 31;
+		w.s.low = uu.s.high >> -bm;
+	} else {
+		const unsigned int carries = (unsigned int) uu.s.high << bm;
+
+		w.s.high = uu.s.high >> b;
+		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
+EXPORT_SYMBOL(__ashrdi3);
diff --git a/lib/cmpdi2.c b/lib/cmpdi2.c
new file mode 100644
index 000000000000..6d7ebf6c2b86
--- /dev/null
+++ b/lib/cmpdi2.c
@@ -0,0 +1,42 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+#include <linux/export.h>
+
+#include <lib/libgcc.h>
+
+word_type notrace __cmpdi2(long long a, long long b)
+{
+	const DWunion au = {
+		.ll = a
+	};
+	const DWunion bu = {
+		.ll = b
+	};
+
+	if (au.s.high < bu.s.high)
+		return 0;
+	else if (au.s.high > bu.s.high)
+		return 2;
+
+	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
+		return 0;
+	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
+		return 2;
+
+	return 1;
+}
+EXPORT_SYMBOL(__cmpdi2);
diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
new file mode 100644
index 000000000000..8e845f4bb65f
--- /dev/null
+++ b/lib/lshrdi3.c
@@ -0,0 +1,45 @@
+/*
+ * lib/lshrdi3.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+#include <linux/module.h>
+#include <lib/libgcc.h>
+
+long long notrace __lshrdi3(long long u, word_type b)
+{
+	DWunion uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = 32 - b;
+
+	if (bm <= 0) {
+		w.s.high = 0;
+		w.s.low = (unsigned int) uu.s.high >> -bm;
+	} else {
+		const unsigned int carries = (unsigned int) uu.s.high << bm;
+
+		w.s.high = (unsigned int) uu.s.high >> b;
+		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
+EXPORT_SYMBOL(__lshrdi3);
diff --git a/lib/muldi3.c b/lib/muldi3.c
new file mode 100644
index 000000000000..88938543e10a
--- /dev/null
+++ b/lib/muldi3.c
@@ -0,0 +1,72 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+#include <linux/export.h>
+#include <lib/libgcc.h>
+
+#define W_TYPE_SIZE 32
+
+#define __ll_B ((unsigned long) 1 << (W_TYPE_SIZE / 2))
+#define __ll_lowpart(t) ((unsigned long) (t) & (__ll_B - 1))
+#define __ll_highpart(t) ((unsigned long) (t) >> (W_TYPE_SIZE / 2))
+
+/* If we still don't have umul_ppmm, define it using plain C.  */
+#if !defined(umul_ppmm)
+#define umul_ppmm(w1, w0, u, v)						\
+	do {								\
+		unsigned long __x0, __x1, __x2, __x3;			\
+		unsigned short __ul, __vl, __uh, __vh;			\
+									\
+		__ul = __ll_lowpart(u);					\
+		__uh = __ll_highpart(u);				\
+		__vl = __ll_lowpart(v);					\
+		__vh = __ll_highpart(v);				\
+									\
+		__x0 = (unsigned long) __ul * __vl;			\
+		__x1 = (unsigned long) __ul * __vh;			\
+		__x2 = (unsigned long) __uh * __vl;			\
+		__x3 = (unsigned long) __uh * __vh;			\
+									\
+		__x1 += __ll_highpart(__x0); /* this can't give carry */\
+		__x1 += __x2; /* but this indeed can */			\
+		if (__x1 < __x2) /* did we get it? */			\
+		__x3 += __ll_B; /* yes, add it in the proper pos */	\
+									\
+		(w1) = __x3 + __ll_highpart(__x1);			\
+		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);\
+	} while (0)
+#endif
+
+#if !defined(__umulsidi3)
+#define __umulsidi3(u, v) ({				\
+	DWunion __w;					\
+	umul_ppmm(__w.s.high, __w.s.low, u, v);		\
+	__w.ll;						\
+	})
+#endif
+
+long long notrace __muldi3(long long u, long long v)
+{
+	const DWunion uu = {.ll = u};
+	const DWunion vv = {.ll = v};
+	DWunion w = {.ll = __umulsidi3(uu.s.low, vv.s.low)};
+
+	w.s.high += ((unsigned long) uu.s.low * (unsigned long) vv.s.high
+		+ (unsigned long) uu.s.high * (unsigned long) vv.s.low);
+
+	return w.ll;
+}
+EXPORT_SYMBOL(__muldi3);
diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
new file mode 100644
index 000000000000..49a53505c8e3
--- /dev/null
+++ b/lib/ucmpdi2.c
@@ -0,0 +1,35 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.
+ */
+
+#include <linux/module.h>
+#include <lib/libgcc.h>
+
+word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+{
+	const DWunion au = {.ll = a};
+	const DWunion bu = {.ll = b};
+
+	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
+		return 0;
+	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
+		return 2;
+	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
+		return 0;
+	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
+		return 2;
+	return 1;
+}
+EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0
