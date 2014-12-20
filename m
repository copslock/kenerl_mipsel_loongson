Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 01:33:19 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51128 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009080AbaLTAdRY0xlH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 01:33:17 +0100
Received: by mail-ie0-f181.google.com with SMTP id tp5so1658880ieb.26;
        Fri, 19 Dec 2014 16:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fgquaNO8p/fScZRxSmK6yIeUdsCa+1FoZDfoVtW/0tk=;
        b=P0IP1CsDHazr4ycaqObzjNtt8Tbeg8bMRchBSCmalvYq5am3eIGao8WFE2TBrVVAoz
         6YEP9pUl/sevtH3f0WVbm4GAm3zozVKteWhI8QfaeR3tTXILBv4wnVNbSvrf+ijTOXVa
         slkb8VjgF/RnBwAyukXsYugiF2DXsf+QsLCFq8c+rPVO80t8hh70D798Pk5guhXviHg6
         EZ0dre+ZnOuXh4QcqXAzdrROOqqV9sXoS/sF4fuTlc/vMSFtKQWQmFwyyWRbBe5KyzDB
         4azYorPKM8b8DtGoaWQsdFTyut2c2W0kGkYCc5Y0zvNAFjkX8PgZD5bgGfI3qqCRNbes
         EsDQ==
X-Received: by 10.107.164.213 with SMTP id d82mr10448449ioj.75.1419035591602;
        Fri, 19 Dec 2014 16:33:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id l3sm1616534igj.9.2014.12.19.16.33.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 16:33:11 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK0X9JJ021712;
        Fri, 19 Dec 2014 16:33:09 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK0X9QE021711;
        Fri, 19 Dec 2014 16:33:09 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] Revert "MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions"
Date:   Fri, 19 Dec 2014 16:33:04 -0800
Message-Id: <1419035585-21671-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

This reverts commit 5890f70f15c52d0204a578422f8da828a0ba1096.

The patch was not tested, It sets PG_IEC in cpu-probe.  But this value
is clobbered in tlb_init() so the system is never configured to take
the RIXI specific exceptions, and we end up in an endless loop in
handle_tlbl because that code is not expecting the XI condition.

Cc: <stable@vger.kernel.org>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/traps.c | 7 -------
 arch/mips/mm/tlbex.c     | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ad3d203..722ed75 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -90,7 +90,6 @@ extern asmlinkage void handle_mt(void);
 extern asmlinkage void handle_dsp(void);
 extern asmlinkage void handle_mcheck(void);
 extern asmlinkage void handle_reserved(void);
-extern void tlb_do_page_fault_0(void);
 
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
@@ -2205,12 +2204,6 @@ void __init trap_init(void)
 		set_except_vector(15, handle_fpe);
 
 	set_except_vector(16, handle_ftlb);
-
-	if (cpu_has_rixiex) {
-		set_except_vector(19, tlb_do_page_fault_0);
-		set_except_vector(20, tlb_do_page_fault_0);
-	}
-
 	set_except_vector(21, handle_msa);
 	set_except_vector(22, handle_mdmx);
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3978a3d..c9e0150 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1934,7 +1934,7 @@ static void build_r4000_tlb_load_handler(void)
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 
-	if (cpu_has_rixi && !cpu_has_rixiex) {
+	if (cpu_has_rixi) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
@@ -2001,7 +2001,7 @@ static void build_r4000_tlb_load_handler(void)
 	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
 
-	if (cpu_has_rixi && !cpu_has_rixiex) {
+	if (cpu_has_rixi) {
 		/*
 		 * If the page is not _PAGE_VALID, RI or XI could not
 		 * have triggered it.  Skip the expensive test..
-- 
1.7.11.7
