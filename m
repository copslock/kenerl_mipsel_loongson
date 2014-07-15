Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 15:10:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58319 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861019AbaGONK2qD-Za (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 15:10:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E808D1C11D3D1
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 14:10:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:21 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:21 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions
Date:   Tue, 15 Jul 2014 14:09:56 +0100
Message-ID: <1405429797-18281-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
References: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Use the regular tlb_do_page_fault_0 (no write) handler to handle
the RI and XI exceptions. Also skip the RI/XI validation check
on TLB load handler since it's redundant when the CPU has
unique RI/XI exceptions.

Singed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 7 +++++++
 arch/mips/mm/tlbex.c     | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 51706d6dd5b0..1a328b1e288b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -90,6 +90,7 @@ extern asmlinkage void handle_mt(void);
 extern asmlinkage void handle_dsp(void);
 extern asmlinkage void handle_mcheck(void);
 extern asmlinkage void handle_reserved(void);
+extern void tlb_do_page_fault_0(void);
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
@@ -2114,6 +2115,12 @@ void __init trap_init(void)
 		set_except_vector(15, handle_fpe);
 
 	set_except_vector(16, handle_ftlb);
+
+	if (cpu_has_rixiex) {
+		set_except_vector(19, tlb_do_page_fault_0);
+		set_except_vector(20, tlb_do_page_fault_0);
+	}
+
 	set_except_vector(21, handle_msa);
 	set_except_vector(22, handle_mdmx);
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0d9d0f06dbb2..ccf8298e7ab2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1919,7 +1919,7 @@ static void build_r4000_tlb_load_handler(void)
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 
-	if (cpu_has_rixi) {
+	if (cpu_has_rixi && !cpu_has_rixiex) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
@@ -1986,7 +1986,7 @@ static void build_r4000_tlb_load_handler(void)
 	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
 
-	if (cpu_has_rixi) {
+	if (cpu_has_rixi && !cpu_has_rixiex) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
-- 
2.0.0
