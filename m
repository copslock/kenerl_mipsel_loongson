Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:45:53 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:39307 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133578AbWAOSp1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:45:27 +0000
Received: from mailout.stusta.mhn.de ([IPv6:::ffff:141.84.69.5]:3602 "HELO
	mailout.stusta.mhn.de") by linux-mips.net with SMTP
	id <S875130AbWANBfq>; Sat, 14 Jan 2006 02:35:46 +0100
Received: (qmail 4174 invoked from network); 14 Jan 2006 01:34:40 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailout.stusta.mhn.de with SMTP; 14 Jan 2006 01:34:40 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 7CD0319F917; Sat, 14 Jan 2006 02:34:41 +0100 (CET)
Date:	Sat, 14 Jan 2006 02:34:41 +0100
From:	Adrian Bunk <bunk@stusta.de>
To:	Andrew Morton <akpm@osdl.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [2.6 patch] Remove arch/mips/arc/salone.c
Message-ID: <20060114013440.GV29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

ArcLoad(), ArcInvoke(), ArcExecute() aren't used.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Jan 2006

This patch was sent by Alexey Dobriyan on:
- 8 Nov 2005

 arch/mips/arc/Makefile |    2 +-
 arch/mips/arc/salone.c |   25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)

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
