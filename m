Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Feb 2010 18:04:32 +0100 (CET)
Received: from astoria.ccjclearline.com ([64.235.106.9]:52342 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492215Ab0B0RE3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Feb 2010 18:04:29 +0100
Received: from cpe002129c56f16-cm001ceab6425a.cpe.net.cable.rogers.com ([99.235.238.149] helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1NlQ5W-0004a7-AA
        for linux-mips@linux-mips.org; Sat, 27 Feb 2010 12:04:22 -0500
Date:   Sat, 27 Feb 2010 12:02:51 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Initialize an atomic_t properly with ATOMIC_INIT(0).
Message-ID: <alpine.LFD.2.00.1002271201230.20373@localhost>
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
X-archive-position: 26068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  AFAIK, the technically correct way to initialize atomic variables is
with ATOMIC_INIT(n).


diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 23499b5..0a5ad2d 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -181,7 +181,7 @@ static int vpemask[2][8] = {
 	{0, 0, 0, 0, 0, 0, 0, 1}
 };
 int tcnoprog[NR_CPUS];
-static atomic_t idle_hook_initialized = {0};
+static atomic_t idle_hook_initialized = ATOMIC_INIT(0);
 static int clock_hang_reported[NR_CPUS];

 #endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
