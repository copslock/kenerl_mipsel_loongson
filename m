Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2005 22:51:00 +0100 (BST)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:2968 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225377AbVFTVuk>; Mon, 20 Jun 2005 22:50:40 +0100
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 97D741EDCD; Mon, 20 Jun 2005 23:50:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 686C21E8EF;
	Mon, 20 Jun 2005 23:50:30 +0200 (CEST)
Received: from nd47.coderock.org (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 5BF801ED16;
	Mon, 20 Jun 2005 23:49:52 +0200 (CEST)
Received: (from domen@localhost)
	by nd47.coderock.org (8.13.3/8.13.3/Submit) id j5KLnpX2021538;
	Mon, 20 Jun 2005 23:49:51 +0200
Message-Id: <20050620214951.416375000@nd47.coderock.org>
Date:	Mon, 20 Jun 2005 23:49:52 +0200
From:	domen@coderock.org
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, domen@coderock.org
Subject: [patch 1/8] delete arch/mips/arc/salone.c
Content-Disposition: inline; filename=remove_file-arch_mips_arc_salone.c.patch
Return-Path: <domen@nd47.coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips



Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---
 salone.c |   24 ------------------------
 1 files changed, 24 deletions(-)

Index: quilt/arch/mips/arc/salone.c
===================================================================
--- quilt.orig/arch/mips/arc/salone.c
+++ /dev/null
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

--
