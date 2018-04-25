Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 12:43:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994675AbeDYKnAgb2Hi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 12:43:00 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FBB04A5;
        Wed, 25 Apr 2018 10:42:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 137/183] MIPS: Generic: Support GIC in EIC mode
Date:   Wed, 25 Apr 2018 12:35:57 +0200
Message-Id: <20180425103247.924745420@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>


[ Upstream commit 7bf8b16d1b60419c865e423b907a05f413745b3e ]

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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18191/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/generic/irq.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

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
 
