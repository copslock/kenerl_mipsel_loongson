Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 18:55:17 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:1391 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834930Ab3DHQx1u6z2n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Apr 2013 18:53:27 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 4/5] MIPS: let amon_cpu_start() report results
Date:   Mon, 8 Apr 2013 09:53:01 -0700
Message-ID: <1365439982-4117-5-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01181__2013_04_08_17_53_23
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Change the return type of amon_cpu_start() from void to int.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/include/asm/amon.h     |    2 +-
 arch/mips/mti-malta/malta-amon.c |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
index c3dc1a6..c8af6b0 100644
--- a/arch/mips/include/asm/amon.h
+++ b/arch/mips/include/asm/amon.h
@@ -3,5 +3,5 @@
  */
 
 int amon_cpu_avail(int);
-void amon_cpu_start(int, unsigned long, unsigned long,
+int amon_cpu_start(int, unsigned long, unsigned long,
 		    unsigned long, unsigned long);
diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 1e47844..9502631 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -48,7 +48,7 @@ int amon_cpu_avail(int cpu)
 	return 1;
 }
 
-void amon_cpu_start(int cpu,
+int amon_cpu_start(int cpu,
 		    unsigned long pc, unsigned long sp,
 		    unsigned long gp, unsigned long a0)
 {
@@ -56,10 +56,10 @@ void amon_cpu_start(int cpu,
 		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
 
 	if (!amon_cpu_avail(cpu))
-		return;
+		return -1;
 	if (cpu == smp_processor_id()) {
 		pr_debug("launch: I am cpu%d!\n", cpu);
-		return;
+		return -1;
 	}
 	launch += cpu;
 
@@ -78,4 +78,6 @@ void amon_cpu_start(int cpu,
 		;
 	smp_rmb();	/* Target will be updating flags soon */
 	pr_debug("launch: cpu%d gone!\n", cpu);
+
+	return 0;
 }
-- 
1.7.1
