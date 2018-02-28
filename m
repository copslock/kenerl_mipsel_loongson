Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:16:03 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53697 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993004AbeB1QPQKYsfz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:15:16 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006XP-DC; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008WA-6D; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.603528692@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 096/254] MIPS: Respect the FCSR exception mask for
 `si_code'
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit ed2d72c1eb3643b7c109bdf387563d9b9a30c279 upstream.

Respect the FCSR exception mask when interpreting the IEEE 754 exception
condition to report with SIGFPE in `si_code', so as not to use one that
has been masked where a different one set in parallel caused the FPE
hardware exception to trigger.  As per the IEEE Std 754 the Inexact
exception can happen together with Overflow or Underflow.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9703/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/traps.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2000, 2001, 2012 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2014, Imagination Technologies Ltd.
  */
+#include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
@@ -785,7 +786,15 @@ asmlinkage void do_fpe(struct pt_regs *r
 		process_fpemu_return(sig, fault_addr);
 
 		goto out;
-	} else if (fcr31 & FPU_CSR_INV_X)
+	}
+
+	/*
+	 * Inexact can happen together with Overflow or Underflow.
+	 * Respect the mask to deliver the correct exception.
+	 */
+	fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
+		 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
+	if (fcr31 & FPU_CSR_INV_X)
 		info.si_code = FPE_FLTINV;
 	else if (fcr31 & FPU_CSR_DIV_X)
 		info.si_code = FPE_FLTDIV;
