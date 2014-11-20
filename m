Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 22:46:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45400 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014053AbaKTVqIE2gBH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Nov 2014 22:46:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAKLk1eb019831;
        Thu, 20 Nov 2014 22:46:01 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAKLjwXN019830;
        Thu, 20 Nov 2014 22:45:58 +0100
Date:   Thu, 20 Nov 2014 22:45:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, aaro.koskinen@iki.fi,
        david.daney@cavium.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, dengcheng.zhu@imgtec.com,
        chenhc@lemote.com, akpm@linux-foundation.org
Subject: Re: [PATCH] MIPS: Remove a temporary hack for debugging cache
 flushes in SMTC configuration
Message-ID: <20141120214557.GA19608@linux-mips.org>
References: <20140906022738.6957.53838.stgit@linux-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140906022738.6957.53838.stgit@linux-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Sep 05, 2014 at 07:27:38PM -0700, Leonid Yegoshin wrote:

> This patch removes a temporary hack for debugging SMTC configuration from
> 
> 	commit 41c594ab65fc89573af296d192aa5235d09717ab
> 	Author: Ralf Baechle <ralf@linux-mips.org>
> 	Date:   Wed Apr 5 09:45:45 2006 +0100
> 
> which is dropped now. Some performance degradation for multi-VPE systems
> is removed.

Your patch removes the sole location from where PROTECT_CACHE_FLUSHES
was defined leaving all the #ifdef'ed PROTECT_CACHE_FLUSHES code unused.
So I'm more thinking of something like below.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/r4kcache.h | 59 ----------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index cd6e0af..e293a8d 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -47,79 +47,20 @@ extern void (*r4k_blast_icache)(void);
 
 #ifdef CONFIG_MIPS_MT
 
-/*
- * Optionally force single-threaded execution during I-cache flushes.
- */
-#define PROTECT_CACHE_FLUSHES 1
-
-#ifdef PROTECT_CACHE_FLUSHES
-
-extern int mt_protiflush;
-extern int mt_protdflush;
-extern void mt_cflush_lockdown(void);
-extern void mt_cflush_release(void);
-
-#define BEGIN_MT_IPROT \
-	unsigned long flags = 0;			\
-	unsigned long mtflags = 0;			\
-	if(mt_protiflush) {				\
-		local_irq_save(flags);			\
-		ehb();					\
-		mtflags = dvpe();			\
-		mt_cflush_lockdown();			\
-	}
-
-#define END_MT_IPROT \
-	if(mt_protiflush) {				\
-		mt_cflush_release();			\
-		evpe(mtflags);				\
-		local_irq_restore(flags);		\
-	}
-
-#define BEGIN_MT_DPROT \
-	unsigned long flags = 0;			\
-	unsigned long mtflags = 0;			\
-	if(mt_protdflush) {				\
-		local_irq_save(flags);			\
-		ehb();					\
-		mtflags = dvpe();			\
-		mt_cflush_lockdown();			\
-	}
-
-#define END_MT_DPROT \
-	if(mt_protdflush) {				\
-		mt_cflush_release();			\
-		evpe(mtflags);				\
-		local_irq_restore(flags);		\
-	}
-
-#else
-
-#define BEGIN_MT_IPROT
-#define BEGIN_MT_DPROT
-#define END_MT_IPROT
-#define END_MT_DPROT
-
-#endif /* PROTECT_CACHE_FLUSHES */
-
 #define __iflush_prologue						\
 	unsigned long redundance;					\
 	extern int mt_n_iflushes;					\
-	BEGIN_MT_IPROT							\
 	for (redundance = 0; redundance < mt_n_iflushes; redundance++) {
 
 #define __iflush_epilogue						\
-	END_MT_IPROT							\
 	}
 
 #define __dflush_prologue						\
 	unsigned long redundance;					\
 	extern int mt_n_dflushes;					\
-	BEGIN_MT_DPROT							\
 	for (redundance = 0; redundance < mt_n_dflushes; redundance++) {
 
 #define __dflush_epilogue \
-	END_MT_DPROT	 \
 	}
 
 #define __inv_dflush_prologue __dflush_prologue
