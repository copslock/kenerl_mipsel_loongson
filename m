Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:11:09 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:34096
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995035AbdEWWGzIfNac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:55 +0200
Received: by mail-pf0-x241.google.com with SMTP id w69so30199598pfk.1
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=1IdsS2x40/slPR+NSYlmtDIEeUnBiQpbvVGSJoQDp4I=;
        b=P16Am3GddGi2m+tvkNGPzFtU+sytNNlJmQ2+BI8mEOF3IFmYjoLNb6wlc1qc6vYf/n
         mgSkE6PYU4g6ignq7TtVx4dZQICz+gylkz19naZh90wbSF4ewLddNFhhTzRcs/SKeolE
         0BZYS04oMeG9L+gefyappl8zMhrvrxqcwobj3DbUKtqFgIT4+4MWN6e9E4CqdZSEQNFT
         lT0xUk7AV9bqZycYmrZ3THI9IrvSguzCjmmlGJFcRYcWMtPmAbKhVFFwxxmD/3br8WNn
         60OjSB8vJRPUu4dx6q3MN2lQ2u0W6icbiukdeccKWIbuBtHIdWfVT0vY1fEbHyDIDuKi
         +SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=1IdsS2x40/slPR+NSYlmtDIEeUnBiQpbvVGSJoQDp4I=;
        b=nifl2ICs3aQ3vZw48TG3PuclVorQ009v+vINFDevOCt0HqbBH+ULRALHDFtE7rckk6
         /DT1DNgmNX+UW8ZVTIMd1E7KbTkMu7kXKJRG1q3Lu154MC0XjfWfa891DrxoLDsvrN+O
         HpV2Vqs/9DZJGYHRLjJCPFL/KH1KtxCxE+EavwHeCnszF81RLk1NM2m8gWyL/DeG2gDm
         u0nDvfZxA9jQnNnRi8c2of+u89qUkoxYUfE28T7oMzZE1uHE05KDpwdO2hF75ssSEMRN
         YyWfVZMikm5M9ZT4NVi0HoB1fpIvfjRPnJbdy2MUIJAnRHvyBotDsy1MjsN2xFuzMVe/
         LdUA==
X-Gm-Message-State: AODbwcBmN5IiqaaD4RgrnegDzDGWVtWsMxzRE17GuOOSJ7vjB9gaBuCO
        LUzSF718ASTZg5SB
X-Received: by 10.98.31.89 with SMTP id f86mr33415072pff.8.1495577206095;
        Tue, 23 May 2017 15:06:46 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id k79sm3753358pfj.6.2017.05.23.15.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:45 -0700 (PDT)
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
Subject: [PATCH 7/7] sparc: Use lib/{cmpdi2,ucmpdi2}.c
Date:   Tue, 23 May 2017 15:05:46 -0700
Message-Id: <20170523220546.16758-8-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57975
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
 arch/sparc/Kconfig       |  2 ++
 arch/sparc/lib/Makefile  |  4 ++--
 arch/sparc/lib/cmpdi2.c  | 27 ---------------------------
 arch/sparc/lib/libgcc.h  | 18 ------------------
 arch/sparc/lib/ucmpdi2.c | 19 -------------------
 5 files changed, 4 insertions(+), 66 deletions(-)
 delete mode 100644 arch/sparc/lib/cmpdi2.c
 delete mode 100644 arch/sparc/lib/libgcc.h
 delete mode 100644 arch/sparc/lib/ucmpdi2.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 58243b0d21c0..80ed2338812b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -52,6 +52,8 @@ config SPARC32
 	select CLZ_TAB
 	select HAVE_UID16
 	select OLD_SIGACTION
+	select LIB_CMPDI2
+	select LIB_UCMPDI2
 
 config SPARC64
 	def_bool 64BIT
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 69912d2f8b54..815b4a336aa8 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -14,7 +14,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
-lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
+lib-$(CONFIG_SPARC32) += muldi3.o bitext.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
@@ -42,5 +42,5 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
-obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
+obj-$(CONFIG_SPARC32) += atomic32.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
diff --git a/arch/sparc/lib/cmpdi2.c b/arch/sparc/lib/cmpdi2.c
deleted file mode 100644
index 8c1306437ed1..000000000000
--- a/arch/sparc/lib/cmpdi2.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include <linux/module.h>
-
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
-
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/sparc/lib/libgcc.h b/arch/sparc/lib/libgcc.h
deleted file mode 100644
index b84fd797f3ea..000000000000
--- a/arch/sparc/lib/libgcc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__ ((mode (__word__)));
-
-struct DWstruct {
-	int high, low;
-};
-
-typedef union
-{
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/sparc/lib/ucmpdi2.c b/arch/sparc/lib/ucmpdi2.c
deleted file mode 100644
index 1e06ed500682..000000000000
--- a/arch/sparc/lib/ucmpdi2.c
+++ /dev/null
@@ -1,19 +0,0 @@
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
