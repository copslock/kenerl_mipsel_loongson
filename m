Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:09:07 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:36434
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994961AbdEWWGuSBrxc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:50 +0200
Received: by mail-pf0-x242.google.com with SMTP id n23so30173986pfb.3
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=qMs6oZi0uM3Sac2NlyWBKjsXgXzb8KqZkawcTRQy0TI=;
        b=GiXL70BHTOJj0w/qd6XAXeUz9Ilwwbt4tgnctHYTahhwLUdRDFCr7s58n9Fyu4M3nq
         qwkQ9bekBG2IGWi+cNiYbRQi5Z8ipdCtvcsEw1J0GFLcwQA3g+kVuPboOWbm5bzobhTc
         8iBQTtJms1utkIB33oJpLX7vVLyXUds8Pmc+N24e17OOMiOWvz9xzCTTmsy9xiGSwgzu
         gg6lyeWvrT4tDywoYVCscDK3vDNLDMFycDl9WTHxsVNS7MMtIyjaUgxnc/iRIDwBxlxG
         sTqt/gHHsLM9tecD2h+J7JVEGtIyYL4QZxhaR7OY4gkfNUs609MbMeiEJKITLx6O9JNc
         dX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=qMs6oZi0uM3Sac2NlyWBKjsXgXzb8KqZkawcTRQy0TI=;
        b=HZsrgP66ZA8rSoWdrX3YIaFPSRgaNxPLljcRYEKdPLo/WMuUrj8GxHcBqaISz2K+xb
         cdKsBzlFEVPWBPS+CMC/FfwaLxco2VyPYaewKVDxJ3j5WV++L0+XPUnCkGHVvu1A9zlK
         Vs2KJ89hjFRRf4CePlhPx50upGgWm4qDGhdxuPR5JFDTrvwPVPAuMadiVwbcaGm+WueI
         +AV9JLTBDSnhXFRYpPwj6kVqizFn76p+V5EypSF5HDwRH0ZOlRvYPhF+MjZVEOCZxEgk
         lc+cYY7MD03MoPUPGPDU9HZL2vwZBnQKWTCyYgCr39XC0sOWEUv18p2w2lfSpCF1gaAY
         37Mw==
X-Gm-Message-State: AODbwcC82EJlrkl3rc/DCSJ/pOQld+ELMC5Y7p5DzvsSPDF8h7AJXdpU
        bk8hgAO1uu30dYxY
X-Received: by 10.84.216.30 with SMTP id m30mr39115585pli.161.1495577204228;
        Tue, 23 May 2017 15:06:44 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id i63sm3273914pgc.26.2017.05.23.15.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:43 -0700 (PDT)
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
Subject: [PATCH 5/7] score: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Date:   Tue, 23 May 2017 15:05:44 -0700
Message-Id: <20170523220546.16758-6-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57972
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

These files are functionally identical to the shared copies that I
recently added.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/score/Kconfig       |  5 +++++
 arch/score/lib/Makefile  |  3 ---
 arch/score/lib/ashldi3.c | 46 ----------------------------------------------
 arch/score/lib/ashrdi3.c | 48 ------------------------------------------------
 arch/score/lib/cmpdi2.c  | 44 --------------------------------------------
 arch/score/lib/libgcc.h  | 37 -------------------------------------
 arch/score/lib/lshrdi3.c | 47 -----------------------------------------------
 arch/score/lib/ucmpdi2.c | 38 --------------------------------------
 8 files changed, 5 insertions(+), 263 deletions(-)
 delete mode 100644 arch/score/lib/ashldi3.c
 delete mode 100644 arch/score/lib/ashrdi3.c
 delete mode 100644 arch/score/lib/cmpdi2.c
 delete mode 100644 arch/score/lib/libgcc.h
 delete mode 100644 arch/score/lib/lshrdi3.c
 delete mode 100644 arch/score/lib/ucmpdi2.c

diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 507d63181389..5959a981061c 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -15,6 +15,11 @@ config SCORE
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
 	select CPU_NO_EFFICIENT_FFS
+	select LIB_ASHLDI3
+	select LIB_ASHRDI3
+	select LIB_CMPDI2
+	select LIB_LSHRDI3
+	select LIB_UCMPDI2
 
 choice
 	prompt "System type"
diff --git a/arch/score/lib/Makefile b/arch/score/lib/Makefile
index 553e30e81faf..ea3f3aba8c71 100644
--- a/arch/score/lib/Makefile
+++ b/arch/score/lib/Makefile
@@ -3,6 +3,3 @@
 #
 
 lib-y += string.o checksum.o checksum_copy.o
-
-# libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/score/lib/ashldi3.c b/arch/score/lib/ashldi3.c
deleted file mode 100644
index 15691a910431..000000000000
--- a/arch/score/lib/ashldi3.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * arch/score/lib/ashldi3.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-long long __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/score/lib/ashrdi3.c b/arch/score/lib/ashrdi3.c
deleted file mode 100644
index d9814a5d8d30..000000000000
--- a/arch/score/lib/ashrdi3.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * arch/score/lib/ashrdi3.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-long long __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high =
-		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/score/lib/cmpdi2.c b/arch/score/lib/cmpdi2.c
deleted file mode 100644
index 1ed5290c66ed..000000000000
--- a/arch/score/lib/cmpdi2.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * arch/score/lib/cmpdi2.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-word_type __cmpdi2(long long a, long long b)
-{
-	const DWunion au = {
-		.ll = a
-	};
-	const DWunion bu = {
-		.ll = b
-	};
-
-	if (au.s.high < bu.s.high)
-		return 0;
-	else if (au.s.high > bu.s.high)
-		return 2;
-
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-
-	return 1;
-}
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/score/lib/libgcc.h b/arch/score/lib/libgcc.h
deleted file mode 100644
index 0f12543d9f31..000000000000
--- a/arch/score/lib/libgcc.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * arch/score/lib/libgcc.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__((mode(__word__)));
-
-struct DWstruct {
-	int low, high;
-};
-
-typedef union {
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/score/lib/lshrdi3.c b/arch/score/lib/lshrdi3.c
deleted file mode 100644
index ce21175fd791..000000000000
--- a/arch/score/lib/lshrdi3.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * arch/score/lib/lshrdi3.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-long long __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__lshrdi3);
diff --git a/arch/score/lib/ucmpdi2.c b/arch/score/lib/ucmpdi2.c
deleted file mode 100644
index b15241e0b079..000000000000
--- a/arch/score/lib/ucmpdi2.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * arch/score/lib/ucmpdi2.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include "libgcc.h"
-
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-		return 0;
-	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-		return 2;
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-	return 1;
-}
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0
