Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:16:22 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:16958 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6841854Ab3JIPQUU189k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 17:16:20 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: MT: Mark existing TCs as present
Date:   Wed, 9 Oct 2013 16:16:25 +0100
Message-ID: <1381331785-15578-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_09_16_16_14
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38290
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

According to Documentation/cpu-hotplug.txt, the cpu_present_mask should
contain all the CPUs which are present in the system. Therefore, all the TCs
currently present in the system should be marked as 'present' even if they
will never be brought online.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/smp-mt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 57a3f7a..35f8d22 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -71,6 +71,7 @@ static unsigned int __init smvp_vpe_init(unsigned int tc, unsigned int mvpconf0,
 
 		/* Record this as available CPU */
 		set_cpu_possible(tc, true);
+		set_cpu_present(tc, true);
 		__cpu_number_map[tc]	= ++ncpu;
 		__cpu_logical_map[ncpu] = tc;
 	}
-- 
1.8.3.2
