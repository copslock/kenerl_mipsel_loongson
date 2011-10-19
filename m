Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2011 00:33:33 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:56588 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491105Ab1JSWd3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2011 00:33:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 358928BBAC;
        Thu, 20 Oct 2011 01:33:28 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id 3EWl2D2TFavC; Thu, 20 Oct 2011 01:33:27 +0300 (EEST)
Received: from dell.pp.htv.fi (cs178075134192.pp.htv.fi [178.75.134.192])
        by smtp6.welho.com (Postfix) with ESMTP id A9E435BC005;
        Thu, 20 Oct 2011 01:33:27 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fix the build with C=1
Date:   Thu, 20 Oct 2011 01:33:27 +0300
Message-Id: <1319063607-11316-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 31249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14485

When trying to compile the 3.1-rc10 kernel for my MIPS board with C=1
(sparse checking), the build fails early with the error:

	  CHK     include/linux/version.h
	  UPD     include/linux/version.h
	  CHK     include/generated/utsrelease.h
	  UPD     include/generated/utsrelease.h
	  Checking missing-syscalls for N32
	  CALL    scripts/checksyscalls.sh
	  Checking missing-syscalls for O32
	  CALL    scripts/checksyscalls.sh
	  CC      kernel/bounds.s
	  GEN     include/generated/bounds.h
	  CC      arch/mips/kernel/asm-offsets.s
	  GEN     include/generated/asm-offsets.h
	  CALL    scripts/checksyscalls.sh
	  HOSTCC  scripts/genksyms/genksyms.o
	  SHIPPED scripts/genksyms/lex.lex.c
	  SHIPPED scripts/genksyms/keywords.hash.c
	  SHIPPED scripts/genksyms/parse.tab.h
	  HOSTCC  scripts/genksyms/lex.lex.o
	  SHIPPED scripts/genksyms/parse.tab.c
	  HOSTCC  scripts/genksyms/parse.tab.o
	  HOSTLD  scripts/genksyms/genksyms
	/bin/sh: Syntax error: "(" unexpected
	make[3]: *** [scripts/mod/empty.o] Error 2
	make[2]: *** [scripts/mod] Error 2
	make[1]: *** [scripts] Error 2

It seems the shell chokes because sparse is called with command line
arguments such as:

	-D__INT8_C(c)='c'

Converting these to form:

	-D'__INT8_C(c)'='c'

seems to fix the problem.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 53e3514..30346b0 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -226,7 +226,7 @@ LDFLAGS			+= -m $(ld-emul)
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -xc /dev/null | \
 	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
-	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
+	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/")
 ifdef CONFIG_64BIT
 CHECKFLAGS		+= -m64
 endif
-- 
1.7.2.5
