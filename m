Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 19:28:37 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:9130 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133709AbWEOR2Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 19:28:24 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id C6DAE44E5C; Mon, 15 May 2006 19:28:20 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FfgrD-0002xJ-7S; Mon, 15 May 2006 18:27:47 +0100
Date:	Mon, 15 May 2006 18:27:47 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix interrupt handling for R2 CPUs
Message-ID: <20060515172747.GF9026@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

This patch ensures that

a) only the low bit is used for status flags if CONFIG_CPU_MIPSR2,
   consistent with the use of di/ei.

b) the ERL/EXL bits get cleared as well.


Signed-off-by:  Thiemo Seufer <ths@networkno.de>


--- linux-orig/include/asm-mips/interrupt.h	2006-04-24 12:02:35.000000000 +0100
+++ linux-work/include/asm-mips/interrupt.h	2006-05-15 18:10:49.000000000 +0100
@@ -102,6 +102,9 @@ __asm__ (
 	"	mfc0	\\flags, $2, 1					\n"
 #else
 	"	mfc0	\\flags, $12					\n"
+#ifdef CONFIG_CPU_MIPSR2
+	"	andi	\\flags, 1					\n"
+#endif
 #endif
 	"	.set	pop						\n"
 	"	.endm							\n");
@@ -169,7 +172,7 @@ __asm__ (
 	 * Fast, dangerous.  Life is fun, life is good.
 	 */
 	"	mfc0	$1, $12						\n"
-	"	ins	$1, \\flags, 0, 1				\n"
+	"	ins	$1, \\flags, 0, 5				\n"
 	"	mtc0	$1, $12						\n"
 #else
 	"	mfc0	$1, $12						\n"
