Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:36:59 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:64787 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816553Ab3FJLgz4OHVH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 13:36:55 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: ftrace: Add missing CONFIG_DYNAMIC_FTRACE
Date:   Mon, 10 Jun 2013 12:35:26 +0100
Message-ID: <1370864126-24931-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_10_12_36_50
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36799
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

arch_ftrace_update_code and ftrace_modify_all_code are only
available if CONFIG_DYNAMIC_FTRACE is selected.

Fixes the following build problem on MIPS randconfig:

arch/mips/kernel/ftrace.c: In function 'arch_ftrace_update_code':
arch/mips/kernel/ftrace.c:31:2: error: implicit declaration of function
'ftrace_modify_all_code' [-Werror=implicit-function-declaration]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index cf5509f..dba90ec 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -25,12 +25,16 @@
 #define MCOUNT_OFFSET_INSNS 4
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
 /* Arch override because MIPS doesn't need to run this from stop_machine() */
 void arch_ftrace_update_code(int command)
 {
 	ftrace_modify_all_code(command);
 }
 
+#endif
+
 /*
  * Check if the address is in kernel space
  *
-- 
1.8.2.1
