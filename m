Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 22:54:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45546 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014125AbaKTVyU6idZ1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Nov 2014 22:54:20 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAKLsID7020038;
        Thu, 20 Nov 2014 22:54:18 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAKLsIqJ020037;
        Thu, 20 Nov 2014 22:54:18 +0100
Date:   Thu, 20 Nov 2014 22:54:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, aaro.koskinen@iki.fi,
        david.daney@cavium.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, dengcheng.zhu@imgtec.com,
        chenhc@lemote.com, akpm@linux-foundation.org
Subject: Re: [PATCH] MIPS: Remove a temporary hack for debugging cache
 flushes in SMTC configuration
Message-ID: <20141120215417.GA20017@linux-mips.org>
References: <20140906022738.6957.53838.stgit@linux-yegoshin>
 <20141120214557.GA19608@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141120214557.GA19608@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44327
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

On Thu, Nov 20, 2014 at 10:45:58PM +0100, Ralf Baechle wrote:

> So I'm more thinking of something like below.

And while we're at it, these were unused rsp. only used by other
unused macros.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/r4kcache.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index cd6e0af..392b159 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -124,10 +124,6 @@ extern void mt_cflush_release(void);
 
 #define __inv_dflush_prologue __dflush_prologue
 #define __inv_dflush_epilogue __dflush_epilogue
-#define __sflush_prologue {
-#define __sflush_epilogue }
-#define __inv_sflush_prologue __sflush_prologue
-#define __inv_sflush_epilogue __sflush_epilogue
 
 #else /* CONFIG_MIPS_MT */
 
@@ -137,10 +133,6 @@ extern void mt_cflush_release(void);
 #define __dflush_epilogue }
 #define __inv_dflush_prologue {
 #define __inv_dflush_epilogue }
-#define __sflush_prologue {
-#define __sflush_epilogue }
-#define __inv_sflush_prologue {
-#define __inv_sflush_epilogue }
 
 #endif /* CONFIG_MIPS_MT */
 
