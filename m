Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 00:18:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10834 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859957AbaGKWSWZG0fS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2014 00:18:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2ADB9C494F586;
        Fri, 11 Jul 2014 23:18:11 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 23:18:15 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 23:18:15 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 11 Jul
 2014 15:18:05 -0700
Subject: [PATCH] MIPS: bugfix: missed cache flush of TLB refill handler
To:     <linux-mips@linux-mips.org>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <paul.gortmaker@windriver.com>, <jchandra@broadcom.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <david.daney@cavium.com>
Date:   Fri, 11 Jul 2014 15:18:05 -0700
Message-ID: <20140711221805.17764.743.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Commit

    Commit 1d40cfcd3442a53e98468cdb3e6d4d9a568d76cf
    Author: Ralf Baechle <ralf@linux-mips.org>
    Date:   Fri Jul 15 15:23:23 2005 +0000

    Avoid SMP cacheflushes.  This is a minor optimization of startup but
    will also avoid smp_call_function from doing stupid things when called
    from a CPU that is not yet marked online.

missed an appropriate cache flush of TLB refill handler because that time it was
at fixed location CAC_BASE. After years the refill handler in EBASE vector
is not at that location and can be allocated in some another memory and needs
I-cache sync as other TLB exception vectors.

Besides that, the new function - local_flash_icache_range() was introduced
to avoid SMP cacheflushes.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/mm/tlbex.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e80e10b..661bc3d 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -429,6 +429,7 @@ static void build_r3000_tlb_refill_handler(void)
 		 (unsigned int)(p - tlb_handler));
 
 	memcpy((void *)ebase, tlb_handler, 0x80);
+	local_flush_icache_range(ebase, ebase + 0x80);
 
 	dump_handler("r3000_tlb_refill", (u32 *)ebase, 32);
 }
@@ -1415,6 +1416,7 @@ static void build_r4000_tlb_refill_handler(void)
 		 final_len);
 
 	memcpy((void *)ebase, final_handler, 0x100);
+	local_flush_icache_range(ebase, ebase + 0x100);
 
 	dump_handler("r4000_tlb_refill", (u32 *)ebase, 64);
 }
