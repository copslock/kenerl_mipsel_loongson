Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:03:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21748 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010785AbbAPKxYUNiQd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 95098758064B4
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:18 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:17 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 41/70] MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard for the EHB instruction
Date:   Fri, 16 Jan 2015 10:49:20 +0000
Message-ID: <1421405389-15512-42-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45185
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

MIPS uses the cpu_has_mips_r2_exec_hazard macro to determine whether the
EHB instruction is available or not. This is necessary for MIPS R6
which also supports the EHB instruction.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/tlbex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ff8d99ce3b9b..d75ff73a2012 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -501,7 +501,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case tlb_indexed: tlbw = uasm_i_tlbwi; break;
 	}
 
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2_exec_hazard) {
 		/*
 		 * The architecture spec says an ehb is required here,
 		 * but a number of cores do not have the hazard and
@@ -1953,7 +1953,7 @@ static void build_r4000_tlb_load_handler(void)
 
 		switch (current_cpu_type()) {
 		default:
-			if (cpu_has_mips_r2) {
+			if (cpu_has_mips_r2_exec_hazard) {
 				uasm_i_ehb(&p);
 
 		case CPU_CAVIUM_OCTEON:
@@ -2020,7 +2020,7 @@ static void build_r4000_tlb_load_handler(void)
 
 		switch (current_cpu_type()) {
 		default:
-			if (cpu_has_mips_r2) {
+			if (cpu_has_mips_r2_exec_hazard) {
 				uasm_i_ehb(&p);
 
 		case CPU_CAVIUM_OCTEON:
-- 
2.2.1
