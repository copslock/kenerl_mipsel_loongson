Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2004 17:27:19 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:2013 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225264AbULYRZQ>; Sat, 25 Dec 2004 17:25:16 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id C57A71F129; Sat, 25 Dec 2004 18:25:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id D41AC1F124;
	Sat, 25 Dec 2004 18:25:02 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 2CFE31F125;
	Sat, 25 Dec 2004 18:24:55 +0100 (CET)
Subject: [patch 6/9] delete unused file
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:25:05 +0100
Message-Id: <20041225172455.2CFE31F125@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-mips/mipsprom.h |   74 -----------------------------------------
 1 files changed, 74 deletions(-)

diff -L include/asm-mips/mipsprom.h -puN include/asm-mips/mipsprom.h~remove_file-include_asm_mips_mipsprom.h /dev/null
--- kj/include/asm-mips/mipsprom.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,74 +0,0 @@
-#ifndef __ASM_MIPS_PROM_H
-#define __ASM_MIPS_PROM_H
-
-#define PROM_RESET		0
-#define PROM_EXEC		1
-#define PROM_RESTART		2
-#define PROM_REINIT		3
-#define PROM_REBOOT		4
-#define PROM_AUTOBOOT		5
-#define PROM_OPEN		6
-#define PROM_READ		7
-#define PROM_WRITE		8
-#define PROM_IOCTL		9
-#define PROM_CLOSE		10
-#define PROM_GETCHAR		11
-#define PROM_PUTCHAR		12
-#define PROM_SHOWCHAR		13	/* XXX */
-#define PROM_GETS		14	/* XXX */
-#define PROM_PUTS		15	/* XXX */
-#define PROM_PRINTF		16	/* XXX */
-
-/* What are these for? */
-#define PROM_INITPROTO		17	/* XXX */
-#define PROM_PROTOENABLE	18	/* XXX */
-#define PROM_PROTODISABLE	19	/* XXX */
-#define PROM_GETPKT		20	/* XXX */
-#define PROM_PUTPKT		21	/* XXX */
-
-/* More PROM shit.  Probably has to do with VME RMW cycles??? */
-#define PROM_ORW_RMW		22	/* XXX */
-#define PROM_ORH_RMW		23	/* XXX */
-#define PROM_ORB_RMW		24	/* XXX */
-#define PROM_ANDW_RMW		25	/* XXX */
-#define PROM_ANDH_RMW		26	/* XXX */
-#define PROM_ANDB_RMW		27	/* XXX */
-
-/* Cache handling stuff */
-#define PROM_FLUSHCACHE		28	/* XXX */
-#define PROM_CLEARCACHE		29	/* XXX */
-
-/* Libc alike stuff */
-#define PROM_SETJMP		30	/* XXX */
-#define PROM_LONGJMP		31	/* XXX */
-#define PROM_BEVUTLB		32	/* XXX */
-#define PROM_GETENV		33	/* XXX */
-#define PROM_SETENV		34	/* XXX */
-#define PROM_ATOB		35	/* XXX */
-#define PROM_STRCMP		36	/* XXX */
-#define PROM_STRLEN		37	/* XXX */
-#define PROM_STRCPY		38	/* XXX */
-#define PROM_STRCAT		39	/* XXX */
-
-/* Misc stuff */
-#define PROM_PARSER		40	/* XXX */
-#define PROM_RANGE		41	/* XXX */
-#define PROM_ARGVIZE		42	/* XXX */
-#define PROM_HELP		43	/* XXX */
-
-/* Entry points for some PROM commands */
-#define PROM_DUMPCMD		44	/* XXX */
-#define PROM_SETENVCMD		45	/* XXX */
-#define PROM_UNSETENVCMD	46	/* XXX */
-#define PROM_PRINTENVCMD	47	/* XXX */
-#define PROM_BEVEXCEPT		48	/* XXX */
-#define PROM_ENABLECMD		49	/* XXX */
-#define PROM_DISABLECMD		50	/* XXX */
-
-#define PROM_CLEARNOFAULT	51	/* XXX */
-#define PROM_NOTIMPLEMENT	52	/* XXX */
-
-#define PROM_NV_GET		53	/* XXX */
-#define PROM_NV_SET		54	/* XXX */
-
-#endif /* __ASM_MIPS_PROM_H */
_
