Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 00:05:07 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:33625 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992841AbeEOWE748omZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 00:04:59 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1413.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 15 May 2018 22:04:52 +0000
Received: from [10.20.78.107] (10.20.78.107) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 15
 May 2018 15:05:21 -0700
Date:   Tue, 15 May 2018 23:04:44 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
Message-ID: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526421892-531715-3345-22758-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193019
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e. 
Status.FR) is not supported as the lone purpose of Config5.FRE is to 
emulate Status.FR=0 handling on FPU hardware that has Status.FR=1 
hardwired[1][2].  Also we do not handle this case elsewhere, and assume 
throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot 
be set both at once for a task, leading to inconsistent behaviour if 
this does happen.

Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting 
PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to 
modes allowed by `mips_set_personality_fp'.

References:

[1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
    Privileged Resource Architecture", Imagination Technologies,
    Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69 
    "Config5 Register Field Descriptions", p. 262

[2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64 
    Privileged Resource Architecture", Imagination Technologies, 
    Document Number: MD00091, Revision 6.03, December 22, 2015, Table 
    9.72 "Config5 Register Field Descriptions", p. 288

Cc: stable@vger.kernel.org # 4.0+
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/process.c |    4 ++++
 1 file changed, 4 insertions(+)

linux-mips-set-process-fp-mode-fr-fre.diff
Index: linux/arch/mips/kernel/process.c
===================================================================
--- linux.orig/arch/mips/kernel/process.c	2018-05-12 22:52:11.000000000 +0100
+++ linux/arch/mips/kernel/process.c	2018-05-12 23:07:15.147112000 +0100
@@ -721,6 +721,10 @@ int mips_set_process_fp_mode(struct task
 	if (value & ~known_bits)
 		return -EOPNOTSUPP;
 
+	/* Setting FRE without FR is not supported.  */
+	if ((value & (PR_FP_MODE_FR | PR_FP_MODE_FRE)) == PR_FP_MODE_FRE)
+		return -EOPNOTSUPP;
+
 	/* Avoid inadvertently triggering emulation */
 	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
 	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
