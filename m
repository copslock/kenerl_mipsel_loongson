Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2007 19:10:40 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:55529 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022839AbXEASKi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2007 19:10:38 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 27EBEB937F;
	Tue,  1 May 2007 20:10:33 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Hiwor-0004LC-AF; Tue, 01 May 2007 19:11:21 +0100
Date:	Tue, 1 May 2007 19:11:21 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Use do_div for a subtract loop
Message-ID: <20070501181121.GC30083@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch switches the subtract loop in timespec_add_ns to use
do_div. The latest GCC SVN version grew intelligent enough to
optimize the loop to a division which calls libgcc's __udivdi3,
which breaks kernel builds.

Tested by building and booting a little endian qemu MIPS kernel.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>

diff --git a/include/linux/time.h b/include/linux/time.h
index 8ea8dea..e1a11d7 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 # include <linux/seqlock.h>
+# include <asm/div64.h>
 #endif
 
 #ifndef _STRUCT_TIMESPEC
@@ -169,9 +170,10 @@ extern struct timeval ns_to_timeval(const s64 nsec);
 static inline void timespec_add_ns(struct timespec *a, u64 ns)
 {
 	ns += a->tv_nsec;
-	while(unlikely(ns >= NSEC_PER_SEC)) {
-		ns -= NSEC_PER_SEC;
-		a->tv_sec++;
+	if(unlikely(ns >= NSEC_PER_SEC)) {
+		u64 tmp = ns;
+		ns = do_div(tmp, NSEC_PER_SEC);
+		a->tv_sec += tmp;
 	}
 	a->tv_nsec = ns;
 }
