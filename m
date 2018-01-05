Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 11:33:13 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:58348 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbeAEKcZu5u0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 11:32:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 10:32:19 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 5 Jan 2018 02:32:17 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] MIPS: Generic: Support GIC in EIC mode
Date:   Fri, 5 Jan 2018 10:31:07 +0000
Message-ID: <1515148270-9391-4-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1515148338-637139-22014-548897-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188674
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

The GIC supports running in External Interrupt Controller (EIC) mode,
and will signal this via cpu_has_veic if enabled in hardware. Currently
the generic kernel will panic if cpu_has_veic is set - but the GIC can
legitimately set this flag if either configured to boot in EIC mode, or
if the GIC driver enables this mode. Make the kernel not panic in this
case, and instead just check if the GIC is present. If so, use it's CPU
local interrupt routing functions. If an EIC is present, but it is not
the GIC, then the kernel does not know how to get the VIRQ for the CPU
local interrupts and should panic. Support for alternative EICs being
present is needed here for the generic kernel to support them.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/generic/irq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
index 394f8161e462..cb7fdaeef426 100644
--- a/arch/mips/generic/irq.c
+++ b/arch/mips/generic/irq.c
@@ -22,10 +22,10 @@ int get_c0_fdc_int(void)
 {
 	int mips_cpu_fdc_irq;
 
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_fdc_irq = gic_get_c0_fdc_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_fdc_irq >= 0)
 		mips_cpu_fdc_irq = MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
 	else
@@ -38,10 +38,10 @@ int get_c0_perfcount_int(void)
 {
 	int mips_cpu_perf_irq;
 
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_perf_irq = gic_get_c0_perfcount_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_perfcount_irq >= 0)
 		mips_cpu_perf_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	else
@@ -54,10 +54,10 @@ unsigned int get_c0_compare_int(void)
 {
 	int mips_cpu_timer_irq;
 
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_timer_irq = gic_get_c0_compare_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else
 		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 
-- 
2.7.4
