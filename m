Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 17:24:21 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4059 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823123Ab3CVQXiY3F0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Mar 2013 17:23:38 +0100
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 22 Mar 2013 09:16:28 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 22 Mar 2013 09:23:23 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 22 Mar 2013 09:23:22 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4E73E39296; Fri, 22
 Mar 2013 09:23:21 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/5] MIPS: Allow kernel to use coprocessor 2
Date:   Fri, 22 Mar 2013 21:54:59 +0530
Message-ID: <f7db3a902335a1bdc531be67b54f1a1ca740cac3.1363966534.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1363966534.git.jchandra@broadcom.com>
References: <cover.1363966534.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D525C563YC7239991-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Kernel threads should be able to use COP2 if the platform needs it.
Do not call die_if_kernel() for a coprocessor unusable exception if
the exception due to COP2 usage.  Instead, the default notifier for
COP2 exceptions is updated to call die_if_kernel.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/kernel/traps.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a200b5b..36c242f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -970,15 +970,9 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 {
 	struct pt_regs *regs = data;
 
-	switch (action) {
-	default:
-		die_if_kernel("Unhandled kernel unaligned access or invalid "
+	die_if_kernel("COP2: Unhandled kernel unaligned access or invalid "
 			      "instruction", regs);
-		/* Fall through	 */
-
-	case CU2_EXCEPTION:
-		force_sig(SIGILL, current);
-	}
+	force_sig(SIGILL, current);
 
 	return NOTIFY_OK;
 }
@@ -992,10 +986,11 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	int status;
 	unsigned long __maybe_unused flags;
 
-	die_if_kernel("do_cpu invoked from kernel context!", regs);
-
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 
+	if (cpid != 2)
+		die_if_kernel("do_cpu invoked from kernel context!", regs);
+
 	switch (cpid) {
 	case 0:
 		epc = (unsigned int __user *)exception_epc(regs);
-- 
1.7.9.5
