Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:54:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014076AbbLPXuRelm40 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:17 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 36B315EC0A7F9;
        Wed, 16 Dec 2015 23:50:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:10 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:09 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 10/16] MIPS: Use EXCCODE_ constants with set_except_vector()
Date:   Wed, 16 Dec 2015 23:49:35 +0000
Message-ID: <1450309781-28030-11-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The first argument to set_except_vector is the ExcCode, which we now
have definitions for. Lets make use of them.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/cpu-bugs64.c |  8 +++----
 arch/mips/kernel/traps.c      | 52 +++++++++++++++++++++----------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index 09f4034f239f..6392dbe504fb 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -190,7 +190,7 @@ static inline void check_daddi(void)
 	printk("Checking for the daddi bug... ");
 
 	local_irq_save(flags);
-	handler = set_except_vector(12, handle_daddi_ov);
+	handler = set_except_vector(EXCCODE_OV, handle_daddi_ov);
 	/*
 	 * The following code fails to trigger an overflow exception
 	 * when executed on R4000 rev. 2.2 or 3.0 (PRId 00000422 or
@@ -214,7 +214,7 @@ static inline void check_daddi(void)
 		".set	pop"
 		: "=r" (v), "=&r" (tmp)
 		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
-	set_except_vector(12, handler);
+	set_except_vector(EXCCODE_OV, handler);
 	local_irq_restore(flags);
 
 	if (daddi_ov) {
@@ -225,14 +225,14 @@ static inline void check_daddi(void)
 	printk("yes, workaround... ");
 
 	local_irq_save(flags);
-	handler = set_except_vector(12, handle_daddi_ov);
+	handler = set_except_vector(EXCCODE_OV, handle_daddi_ov);
 	asm volatile(
 		"addiu	%1, $0, %2\n\t"
 		"dsrl	%1, %1, 1\n\t"
 		"daddi	%0, %1, %3"
 		: "=r" (v), "=&r" (tmp)
 		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
-	set_except_vector(12, handler);
+	set_except_vector(EXCCODE_OV, handler);
 	local_irq_restore(flags);
 
 	if (daddi_ov) {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 886cb1976e90..bafcb7ad5c85 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2250,7 +2250,7 @@ void __init trap_init(void)
 	 * Only some CPUs have the watch exceptions.
 	 */
 	if (cpu_has_watch)
-		set_except_vector(23, handle_watch);
+		set_except_vector(EXCCODE_WATCH, handle_watch);
 
 	/*
 	 * Initialise interrupt handlers
@@ -2277,27 +2277,27 @@ void __init trap_init(void)
 	if (board_be_init)
 		board_be_init();
 
-	set_except_vector(0, using_rollback_handler() ? rollback_handle_int
-						      : handle_int);
-	set_except_vector(1, handle_tlbm);
-	set_except_vector(2, handle_tlbl);
-	set_except_vector(3, handle_tlbs);
+	set_except_vector(EXCCODE_INT, using_rollback_handler() ?
+					rollback_handle_int : handle_int);
+	set_except_vector(EXCCODE_MOD, handle_tlbm);
+	set_except_vector(EXCCODE_TLBL, handle_tlbl);
+	set_except_vector(EXCCODE_TLBS, handle_tlbs);
 
-	set_except_vector(4, handle_adel);
-	set_except_vector(5, handle_ades);
+	set_except_vector(EXCCODE_ADEL, handle_adel);
+	set_except_vector(EXCCODE_ADES, handle_ades);
 
-	set_except_vector(6, handle_ibe);
-	set_except_vector(7, handle_dbe);
+	set_except_vector(EXCCODE_IBE, handle_ibe);
+	set_except_vector(EXCCODE_DBE, handle_dbe);
 
-	set_except_vector(8, handle_sys);
-	set_except_vector(9, handle_bp);
-	set_except_vector(10, rdhwr_noopt ? handle_ri :
+	set_except_vector(EXCCODE_SYS, handle_sys);
+	set_except_vector(EXCCODE_BP, handle_bp);
+	set_except_vector(EXCCODE_RI, rdhwr_noopt ? handle_ri :
 			  (cpu_has_vtag_icache ?
 			   handle_ri_rdhwr_vivt : handle_ri_rdhwr));
-	set_except_vector(11, handle_cpu);
-	set_except_vector(12, handle_ov);
-	set_except_vector(13, handle_tr);
-	set_except_vector(14, handle_msa_fpe);
+	set_except_vector(EXCCODE_CPU, handle_cpu);
+	set_except_vector(EXCCODE_OV, handle_ov);
+	set_except_vector(EXCCODE_TR, handle_tr);
+	set_except_vector(EXCCODE_MSAFPE, handle_msa_fpe);
 
 	if (current_cpu_type() == CPU_R6000 ||
 	    current_cpu_type() == CPU_R6000A) {
@@ -2318,25 +2318,25 @@ void __init trap_init(void)
 		board_nmi_handler_setup();
 
 	if (cpu_has_fpu && !cpu_has_nofpuex)
-		set_except_vector(15, handle_fpe);
+		set_except_vector(EXCCODE_FPE, handle_fpe);
 
-	set_except_vector(16, handle_ftlb);
+	set_except_vector(MIPS_EXCCODE_TLBPAR, handle_ftlb);
 
 	if (cpu_has_rixiex) {
-		set_except_vector(19, tlb_do_page_fault_0);
-		set_except_vector(20, tlb_do_page_fault_0);
+		set_except_vector(EXCCODE_TLBRI, tlb_do_page_fault_0);
+		set_except_vector(EXCCODE_TLBXI, tlb_do_page_fault_0);
 	}
 
-	set_except_vector(21, handle_msa);
-	set_except_vector(22, handle_mdmx);
+	set_except_vector(EXCCODE_MSADIS, handle_msa);
+	set_except_vector(EXCCODE_MDMX, handle_mdmx);
 
 	if (cpu_has_mcheck)
-		set_except_vector(24, handle_mcheck);
+		set_except_vector(EXCCODE_MCHECK, handle_mcheck);
 
 	if (cpu_has_mipsmt)
-		set_except_vector(25, handle_mt);
+		set_except_vector(EXCCODE_THREAD, handle_mt);
 
-	set_except_vector(26, handle_dsp);
+	set_except_vector(EXCCODE_DSPDIS, handle_dsp);
 
 	if (board_cache_error_setup)
 		board_cache_error_setup();
-- 
2.4.10
