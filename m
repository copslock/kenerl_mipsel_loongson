Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 00:41:09 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:43565 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903771Ab2ECWlF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2012 00:41:05 +0200
Received: by ghbf11 with SMTP id f11so2655364ghb.36
        for <multiple recipients>; Thu, 03 May 2012 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lrybytZ9Y5B/xyXwFJf88y+WIuWRpBUs5DV+T5g4bB0=;
        b=0C4lkCl9m6428UxmIKWOsjv3a1Bnva5zk6EIp1QXGJfRqRT9UlW6yIajHdocX1x/1z
         P9Lvaj5/2QeIisSewIEGjhP4O67T5WRadez/4NkXMphnWcQrxe6oTQFBALImuSLlidGu
         tQ6l5pAivoMbbvmfJfTmirivsSXsKubdZp7nSTZ2WhQ2yaWi3WL5/yg8u1AlNP21Cfpa
         Mc8mvVqTDAJxJvVvLMw1ZVEuAICA4WMt5jJGSzGrJL/JttZu8nlG7TZlpFRpwCX7cyof
         mAPggSBHYA+PoJ3MWTJfcdtlBCPcc+pmdiAKA7xidOTtW03eFr86fCBKqHzf/VxO4oQ3
         D7+Q==
Received: by 10.236.179.40 with SMTP id g28mr5055979yhm.86.1336084859529;
        Thu, 03 May 2012 15:40:59 -0700 (PDT)
Received: from localhost (cpe-174-109-057-184.nc.res.rr.com. [174.109.57.184])
        by mx.google.com with ESMTPS id k35sm10421203ani.3.2012.05.03.15.40.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 15:40:58 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] mips: set ST0_MX flag for MDMX
Date:   Thu,  3 May 2012 18:40:45 -0400
Message-Id: <1336084845-28995-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.3.4
X-archive-position: 33134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

As the comment in commit 3301edcb says, DSP and MDMX share the same
config flag bit.

Without this set, MDMX instructions cause Illegal instruction errors.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Is MDMX implemented by anything other than some Broadcom CPUs? Is it
totally replaced by DSP?

I had a terrible time finding any documentation on it (which is annoying
because Volume IV-b covering MDMX is referenced by all the MIPS64 documents.)
but finally found a copy here: www.enlight.ru/docs/cpu/risc/mips/MDMXspec.pdf

If it's dead, it's too bad because it's a pretty cool ISA.

 arch/mips/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cfdaaa4..89ead75 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1548,7 +1548,7 @@ void __cpuinit per_cpu_trap_init(void)
 #endif
 	if (current_cpu_data.isa_level == MIPS_CPU_ISA_IV)
 		status_set |= ST0_XX;
-	if (cpu_has_dsp)
+	if (cpu_has_dsp || cpu_has_mdmx)
 		status_set |= ST0_MX;
 
 	change_c0_status(ST0_CU|ST0_MX|ST0_RE|ST0_FR|ST0_BEV|ST0_TS|ST0_KX|ST0_SX|ST0_UX,
-- 
1.7.3.4
