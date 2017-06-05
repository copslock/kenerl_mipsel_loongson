Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:23:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8564 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993459AbdFESXIilIvR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:23:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 69909BE1751D4;
        Mon,  5 Jun 2017 19:22:58 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 19:23:02
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/5] MIPS: Remove unused ST_OFF from r2300_switch.S
Date:   Mon, 5 Jun 2017 11:21:30 -0700
Message-ID: <20170605182131.16853-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170605182131.16853-1-paul.burton@imgtec.com>
References: <20170605182131.16853-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Commit 1a3d59579b9f ("MIPS: Tidy up FPU context switching") removed
usage of ST_OFF, leaving it behind as dead code. Commit 828d1e4e9865
("MIPS: Remove dead define of ST_OFF") then removed the definition of
ST_OFF from r4k_switch.S as a cleanup. However the unused definition of
ST_OFF has been left behind in r2300_switch.S. Remove it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/r2300_switch.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 887f836cfa5c..e57703b1de50 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -26,12 +26,6 @@
 	.align	5
 
 /*
- * Offset to the current process status flags, the first 32 bytes of the
- * stack are not used.
- */
-#define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)
-
-/*
  * task_struct *resume(task_struct *prev, task_struct *next,
  *		       struct thread_info *next_ti)
  */
-- 
2.13.0
