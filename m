Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 12:44:30 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:2695 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026017AbZDULoW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2009 12:44:22 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1LwEOg-00011A-00; Tue, 21 Apr 2009 13:44:18 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id B493CC3318; Tue, 21 Apr 2009 13:44:13 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix SYSCALL_ALIAS for older MIPS assembler
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
cc:	torvalds@linux-foundation.org
Message-Id: <20090421114413.B493CC3318@solo.franken.de>
Date:	Tue, 21 Apr 2009 13:44:13 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Older MIPS assembler don't support .set for defining aliases.
Using = works for old and new assembers.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---

 include/linux/syscalls.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index dabe4ad..40617c1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -148,7 +148,7 @@ struct old_linux_dirent;
 	asm ("\t.globl " #alias "\n\t.set " #alias ", " #name "\n"	\
 	     "\t.globl ." #alias "\n\t.set ." #alias ", ." #name)
 #else
-#ifdef CONFIG_ALPHA
+#if defined(CONFIG_ALPHA) || defined(CONFIG_MIPS)
 #define SYSCALL_ALIAS(alias, name)					\
 	asm ( #alias " = " #name "\n\t.globl " #alias)
 #else
