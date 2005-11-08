Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 17:47:08 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.198]:65439 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8135892AbVKHRqs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2005 17:46:48 +0000
Received: by nproxy.gmail.com with SMTP id l37so178055nfc
        for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 09:48:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=pgUhAJZ1jfY4pZSU9gRd1cKAe1LT2QzxO6zqByg1OTf3n1kiVGXzTtxCLDaeyTln/jKIy6XfLDxr+RKUyLdEWY75idCs4bb78m04iROhiGAMgdjkMGF3UZFnLd/pxNstEvMz4Y1jz97wCH3dhBiPXIrAisxCUHV7KRhsE8IOu0U=
Received: by 10.48.157.3 with SMTP id f3mr1358898nfe;
        Tue, 08 Nov 2005 09:48:07 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id z73sm3608298nfb.2005.11.08.09.48.05;
        Tue, 08 Nov 2005 09:48:07 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Tue,  8 Nov 2005 21:01:33 +0300 (MSK)
Date:	Tue, 8 Nov 2005 21:01:31 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Remove arch/mips/arc/salone.c
Message-ID: <20051108180131.GF7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

ArcLoad(), ArcInvoke(), ArcExecute() aren't used.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/arch/mips/arc/Makefile
===================================================================
--- linux-kj.orig/arch/mips/arc/Makefile	2005-11-08 20:46:24.000000000 +0300
+++ linux-kj/arch/mips/arc/Makefile	2005-11-08 20:47:36.000000000 +0300
@@ -3,7 +3,7 @@
 #
 
 lib-y				+= cmdline.o env.o file.o identify.o init.o \
-				   misc.o salone.o time.o tree.o
+				   misc.o time.o tree.o
 
 lib-$(CONFIG_ARC_MEMORY)	+= memory.o
 lib-$(CONFIG_ARC_CONSOLE)	+= arc_con.o
Index: linux-kj/arch/mips/arc/salone.c
===================================================================
--- linux-kj.orig/arch/mips/arc/salone.c	2005-11-08 20:46:24.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,24 +0,0 @@
-/*
- * Routines to load into memory and execute stand-along program images using
- * ARCS PROM firmware.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <asm/sgialib.h>
-
-LONG __init ArcLoad(CHAR *Path, ULONG TopAddr, ULONG *ExecAddr, ULONG *LowAddr)
-{
-	return ARC_CALL4(load, Path, TopAddr, ExecAddr, LowAddr);
-}
-
-LONG __init ArcInvoke(ULONG ExecAddr, ULONG StackAddr, ULONG Argc, CHAR *Argv[],
-	CHAR *Envp[])
-{
-	return ARC_CALL5(invoke, ExecAddr, StackAddr, Argc, Argv, Envp);
-}
-
-LONG __init ArcExecute(CHAR *Path, LONG Argc, CHAR *Argv[], CHAR *Envp[])
-{
-	return ARC_CALL4(exec, Path, Argc, Argv, Envp);
-}
