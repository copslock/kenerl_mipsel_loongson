Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2015 14:43:27 +0100 (CET)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:55549 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013312AbbBLNn0RDY0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Feb 2015 14:43:26 +0100
Received: by mail-wg0-f41.google.com with SMTP id b13so10212966wgh.0
        for <linux-mips@linux-mips.org>; Thu, 12 Feb 2015 05:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mPyeE9NcuAYuwYK2iLeEhV5YrZHAHiB0c5n8Yi9C+YE=;
        b=dgP94EfoOdV7HXXs22IDCTlCZFYRMB922BFIvspUjxDXR1mm5jTRTZzcMgcf9iYu4P
         9wZNgsMFlyTM+dSsON6Vg0Nn39nu7gfo2j1oQOqFWcx4UjLEfP4qRrtMR/gT1Ix1gzPB
         gsbTR3lI1yRACCqz5VfgT7ehdiJqh0JzMUZcTJj2NFHkgkS63MgWHKNt0meiZKO4KkDu
         ApX7tQ9C47Q6HeGKKKko0smxQL9zZcUnc/qcHw2ZgXZzZFMFduEjtDvy/OzXu5X2xPdF
         6/ACYNE8mMRoqfjO66zxDowsUbQtmfOWo9LWx2qexb/lvr1MaAsi7J7djxHVp2QB7y6n
         B9zA==
X-Gm-Message-State: ALoCoQnTT96mDDo4mC8h+olgZ3KrfW7jbFF5rRJdX5aEOa4xpCW1klJG//lgJ09Bmzo4BXFtPsUG
X-Received: by 10.180.19.228 with SMTP id i4mr6397060wie.13.1423748599780;
        Thu, 12 Feb 2015 05:43:19 -0800 (PST)
Received: from faui49t.informatik.uni-erlangen.de (faui49t.informatik.uni-erlangen.de. [131.188.42.17])
        by mx.google.com with ESMTPSA id n10sm2621463wic.11.2015.02.12.05.43.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Feb 2015 05:43:19 -0800 (PST)
From:   Andreas Ruprecht <rupran@einserver.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <rupran@einserver.de>
Subject: [PATCH] MIPS: mm: Remove dead macro definitions
Date:   Thu, 12 Feb 2015 14:42:52 +0100
Message-Id: <1423748572-31012-1-git-send-email-rupran@einserver.de>
X-Mailer: git-send-email 1.9.1
Return-Path: <rupran@einserver.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rupran@einserver.de
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

In commit c441d4a54c6e ("MIPS: mm: Only build one microassembler that
is suitable"), the Makefile at arch/mips/mm was rewritten to only
build the "right" microassembler file, depending on whether
CONFIG_CPU_MICROMIPS is set or not.

In the files, however, there are still preprocessor definitions
depending on CONFIG_CPU_MICROMIPS. The #ifdef around them can now
never evaluate to true, so let's remove them altogether.

This inconsistency was found using the undertaker-checkpatch tool.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
---
 arch/mips/mm/uasm-micromips.c | 8 --------
 arch/mips/mm/uasm-mips.c      | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 8399ddf..d78178d 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -38,14 +38,6 @@
 	 | (e) << RE_SH						\
 	 | (f) << FUNC_SH)
 
-/* Define these when we are not the ISA the kernel is being compiled with. */
-#ifndef CONFIG_CPU_MICROMIPS
-#define MM_uasm_i_b(buf, off) ISAOPC(_beq)(buf, 0, 0, off)
-#define MM_uasm_i_beqz(buf, rs, off) ISAOPC(_beq)(buf, rs, 0, off)
-#define MM_uasm_i_beqzl(buf, rs, off) ISAOPC(_beql)(buf, rs, 0, off)
-#define MM_uasm_i_bnez(buf, rs, off) ISAOPC(_bne)(buf, rs, 0, off)
-#endif
-
 #include "uasm.c"
 
 static struct insn insn_table_MM[] = {
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 8e02291..fc442b2 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -38,14 +38,6 @@
 	 | (e) << RE_SH						\
 	 | (f) << FUNC_SH)
 
-/* Define these when we are not the ISA the kernel is being compiled with. */
-#ifdef CONFIG_CPU_MICROMIPS
-#define CL_uasm_i_b(buf, off) ISAOPC(_beq)(buf, 0, 0, off)
-#define CL_uasm_i_beqz(buf, rs, off) ISAOPC(_beq)(buf, rs, 0, off)
-#define CL_uasm_i_beqzl(buf, rs, off) ISAOPC(_beql)(buf, rs, 0, off)
-#define CL_uasm_i_bnez(buf, rs, off) ISAOPC(_bne)(buf, rs, 0, off)
-#endif
-
 #include "uasm.c"
 
 static struct insn insn_table[] = {
-- 
1.9.1
