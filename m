Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 20:49:33 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.204]:58345 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224982AbVINTtP>;
	Wed, 14 Sep 2005 20:49:15 +0100
Received: by zproxy.gmail.com with SMTP id j2so22975nzf
        for <linux-mips@linux-mips.org>; Wed, 14 Sep 2005 12:49:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Clp8IQqkEGtCyCBxyqQSeGudr+Zgif+du2oYs0d5pXqniammiJp+Bz1HjU9PyHfZ30+Gmt1ufthstiahsZGdv0Cfp56wq96G+PE4yRVLMMpT6gWSnxG+SqiaWTzwQLorh6e6BM+VrWwIz3mbs6TOcF0T8jus4+YiCESSAqVCt4I=
Received: by 10.36.96.5 with SMTP id t5mr1962925nzb;
        Wed, 14 Sep 2005 12:49:02 -0700 (PDT)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id 10sm151704nzo.2005.09.14.12.48.55;
        Wed, 14 Sep 2005 12:48:58 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Wed, 14 Sep 2005 23:59:16 +0400 (MSD)
Date:	Wed, 14 Sep 2005 23:59:11 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Domen Puncer <domen@coderock.org>
Subject: [PATCH] Remove arch/mips/arc/salone.c
Message-ID: <20050914195911.GH19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file (grep salone -r . didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/arc/salone.c |   24 ------------------------
 1 files changed, 24 deletions(-)

--- a/arch/mips/arc/salone.c	2005-09-14 19:05:26.000000000 +0400
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
