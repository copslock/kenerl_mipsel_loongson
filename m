Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 12:51:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43843 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993302AbdCaKvnZLwmd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 12:51:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5D81793CB10D3;
        Fri, 31 Mar 2017 11:51:34 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 11:51:37 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH] MIPS: KASLR: Add missing header files
Date:   Fri, 31 Mar 2017 11:51:33 +0100
Message-ID: <1490957493-27329-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

After the split of linux/sched.h, KASLR stopped building.

Fix this by including the correct header file for init_thread_union

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/kernel/relocate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 9103bebc9a8e..2d1a0c438771 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/libfdt.h>
 #include <linux/of_fdt.h>
-#include <linux/sched.h>
+#include <linux/sched/task.h>
 #include <linux/start_kernel.h>
 #include <linux/string.h>
 #include <linux/printk.h>
-- 
2.7.4
