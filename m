Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:15:33 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1075 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865323Ab3KNQM637d17 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:58 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 08/12] MIPS: kernel: cpu-probe: Add support for probing proAptiv cores
Date:   Thu, 14 Nov 2013 16:12:28 +0000
Message-ID: <1384445552-30573-9-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
References: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_58
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38528
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b534d33..3f2468f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -746,6 +746,14 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_74K;
 		__cpu_name[cpu] = "MIPS 1074Kc";
 		break;
+	case PRID_IMP_PROAPTIV_UP:
+		c->cputype = CPU_PROAPTIV;
+		__cpu_name[cpu] = "MIPS proAptiv";
+		break;
+	case PRID_IMP_PROAPTIV_MP:
+		c->cputype = CPU_PROAPTIV;
+		__cpu_name[cpu] = "MIPS proAptiv (multi)";
+		break;
 	}
 
 	spram_config();
-- 
1.8.4.3
