Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2005 10:46:14 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:13227 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225439AbVCFKpz>; Sun, 6 Mar 2005 10:45:55 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id A18D81F23E; Sun,  6 Mar 2005 11:45:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 9E7641F203;
	Sun,  6 Mar 2005 11:45:50 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 56C701F1F0;
	Sun,  6 Mar 2005 11:45:48 +0100 (CET)
Subject: [patch 1/8] delete unused file arch_mips_arc_salone.c
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, domen@coderock.org
From:	domen@coderock.org
Date:	Sun, 06 Mar 2005 11:45:48 +0100
Message-Id: <20050306104548.56C701F1F0@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7375
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
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
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
