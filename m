Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 12:52:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23426 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013292AbbEMKvM2QYza (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 12:51:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6052D2956C700;
        Wed, 13 May 2015 11:51:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 11:51:09 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 11:51:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 6/9] MIPS: dump_tlb: Take EHINV bit into account
Date:   Wed, 13 May 2015 11:50:52 +0100
Message-ID: <1431514255-3030-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47362
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

The EHINV bit in EntryHi allows a TLB entry to be properly marked
invalid so that EntryHi doesn't have to be set to a unique value to
avoid machine check exceptions due to multiple matching entries.

Unfortunately dump_tlb() doesn't take this into account so it will print
all the uninteresting invalid TLB entries if the current ASID happens to
be 00. Therefore add a condition to skip entries which are marked
invalid with the EHINV bit.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 70e0a6bdb322..f58962c11c75 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -67,6 +67,9 @@ static void dump_tlb(int first, int last)
 		entrylo0 = read_c0_entrylo0();
 		entrylo1 = read_c0_entrylo1();
 
+		/* EHINV bit marks entire entry as invalid */
+		if (cpu_has_tlbinv && entryhi & MIPS_ENTRYHI_EHINV)
+			continue;
 		/*
 		 * Prior to tlbinv, unused entries have a virtual address of
 		 * CKSEG0.
-- 
2.3.6
