Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 10:31:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12425 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012958AbaKQJb3HcilF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 10:31:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9063DB1F1539A;
        Mon, 17 Nov 2014 09:31:21 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 09:31:23 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 17 Nov 2014 09:31:23 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 17 Nov 2014 09:31:22 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: mm: tlb-r4k: Add missing HTW stop/start sequences
Date:   Mon, 17 Nov 2014 09:31:07 +0000
Message-ID: <1416216667-24462-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44223
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

HTW needs to stop and start again whenever the EntryHI register
changes otherwise an inflight HTW operation might use the new
EntryHI register for updating an old entry and that could lead
to crashes or even a machine check exception. We fix this by
ensuring the HTW has stop whenever the EntryHI register is about
to change

Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/tlb-r4k.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index fa6ebd4bc9e9..c3917e251f59 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -299,6 +299,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 
 	local_irq_save(flags);
 
+	htw_stop();
 	pid = read_c0_entryhi() & ASID_MASK;
 	address &= (PAGE_MASK << 1);
 	write_c0_entryhi(address | pid);
@@ -346,6 +347,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 			tlb_write_indexed();
 	}
 	tlbw_use_hazard();
+	htw_start();
 	flush_itlb_vm(vma);
 	local_irq_restore(flags);
 }
@@ -422,6 +424,7 @@ __init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 	local_irq_save(flags);
 	/* Save old context and create impossible VPN2 value */
+	htw_stop();
 	old_ctx = read_c0_entryhi();
 	old_pagemask = read_c0_pagemask();
 	wired = read_c0_wired();
@@ -443,6 +446,7 @@ __init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 	write_c0_entryhi(old_ctx);
 	write_c0_pagemask(old_pagemask);
+	htw_start();
 out:
 	local_irq_restore(flags);
 	return ret;
-- 
2.1.3
