Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Dec 2009 21:39:47 +0100 (CET)
Received: from astoria.ccjclearline.com ([64.235.106.9]:50154 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492164AbZLaUjn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Dec 2009 21:39:43 +0100
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com ([174.113.191.234] helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1NQRo0-0004kI-0R
        for linux-mips@linux-mips.org; Thu, 31 Dec 2009 15:39:36 -0500
Date:   Thu, 31 Dec 2009 15:39:00 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Simplify param.h by using <asm-generic/param.h>
Message-ID: <alpine.LFD.2.00.0912311538120.7030@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/mips/include/asm/param.h b/arch/mips/include/asm/param.h
index 1d9bb8c..da3920f 100644
--- a/arch/mips/include/asm/param.h
+++ b/arch/mips/include/asm/param.h
@@ -9,23 +9,8 @@
 #ifndef _ASM_PARAM_H
 #define _ASM_PARAM_H

-#ifdef __KERNEL__
-
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
-# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
-#endif
-
-#ifndef HZ
-#define HZ 100
-#endif
-
 #define EXEC_PAGESIZE	65536

-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
+#include <asm-generic/param.h>

 #endif /* _ASM_PARAM_H */

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
