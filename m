Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2004 17:25:01 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:62172 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225244AbULYRY4>; Sat, 25 Dec 2004 17:24:56 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 6F9011EA0F; Sat, 25 Dec 2004 18:24:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 7AA171ED41;
	Sat, 25 Dec 2004 18:24:42 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 370061EA0F;
	Sat, 25 Dec 2004 18:24:40 +0100 (CET)
Subject: [patch 1/9] delete unused file
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:24:50 +0100
Message-Id: <20041225172440.370061EA0F@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/mips/arc/salone.c |   24 ------------------------
 1 files changed, 24 deletions(-)

diff -L arch/mips/arc/salone.c -puN arch/mips/arc/salone.c~remove_file-arch_mips_arc_salone.c /dev/null
--- kj/arch/mips/arc/salone.c
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
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
_
