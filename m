Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 12:53:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59144 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27015047AbbEMKwP07lUu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 12:52:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6706E612E9CD5;
        Wed, 13 May 2015 11:52:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 11:51:08 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 11:51:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 5/9] MIPS: dump_tlb: Take global bit into account
Date:   Wed, 13 May 2015 11:50:51 +0100
Message-ID: <1431514255-3030-6-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 47366
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

The TLB only matches the ASID when the global bit isn't set, so
dump_tlb() shouldn't really be skipping global entries just because the
ASID doesn't match. Fix the condition to read the TLB entry's global bit
from EntryLo0. Note that after a TLB read the global bits in both
EntryLo registers reflect the same global bit in the TLB entry.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 17d05caa776d..70e0a6bdb322 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -73,7 +73,8 @@ static void dump_tlb(int first, int last)
 		 */
 		if ((entryhi & ~0x1ffffUL) == CKSEG0)
 			continue;
-		if ((entryhi & 0xff) != asid)
+		/* ASID takes effect in absense of global bit */
+		if (!(entrylo0 & 1) && (entryhi & 0xff) != asid)
 			continue;
 
 		/*
-- 
2.3.6
