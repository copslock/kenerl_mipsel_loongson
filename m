Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 11:52:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35790 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010425AbbGWJvubaz2l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jul 2015 11:51:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6N9plUI009316;
        Thu, 23 Jul 2015 11:51:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6N9plcS009315;
        Thu, 23 Jul 2015 11:51:47 +0200
Message-Id: <b02d2b2d33026271c663207dc68bfa0531b16251.1437644062.git.ralf@linux-mips.org>
In-Reply-To: <cover.1437644062.git.ralf@linux-mips.org>
References: <cover.1437644062.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
Date:   Thu, 23 Jul 2015 11:10:38 +0200
Subject: [PATCH 1/2] MIPS: Handle page faults of executable but unreadable
 pages correctly.
To:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Without this we end taking execeptions in an endless loop hanging the
thread.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 36c0f26..852a41c 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -133,7 +133,8 @@ good_area:
 #endif
 				goto bad_area;
 			}
-			if (!(vma->vm_flags & VM_READ)) {
+			if (!(vma->vm_flags & VM_READ) &&
+			    exception_epc(regs) != address) {
 #if 0
 				pr_notice("Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n",
 					  raw_smp_processor_id(),
-- 
2.4.3
