Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2014 11:57:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34985 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822090AbaC0K5kcrG1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2014 11:57:40 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B542A581B03C3
        for <linux-mips@linux-mips.org>; Thu, 27 Mar 2014 10:57:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 27 Mar 2014 10:57:34 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 27 Mar 2014 10:57:34 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 04/13] MIPS: fix core number detection for MT cores
Date:   Thu, 27 Mar 2014 10:57:30 +0000
Message-ID: <1395917850-11160-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395402961-39632-4-git-send-email-paul.burton@imgtec.com>
References: <1395402961-39632-4-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39591
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

In cores which implement the MT ASE, the CPUNum in the EBase register is
a concatenation of the core number & the VPE ID within that core. In
order to retrieve the correct core number CPUNum must be shifted
appropriately to remove the VPE ID bits.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Use the new core_vpes() function to fix a build error for UP kernels
    where smp_num_siblings is not declared.
---
 arch/mips/kernel/cpu-probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 34df5af..8133d8f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -23,6 +23,7 @@
 #include <asm/cpu-type.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
 #include <asm/msa.h>
 #include <asm/watch.h>
 #include <asm/elf.h>
@@ -421,8 +422,11 @@ static void decode_configs(struct cpuinfo_mips *c)
 	mips_probe_watch_registers(c);
 
 #ifndef CONFIG_MIPS_CPS
-	if (cpu_has_mips_r2)
+	if (cpu_has_mips_r2) {
 		c->core = read_c0_ebase() & 0x3ff;
+		if (cpu_has_mipsmt)
+			c->core >>= fls(core_nvpes()) - 1;
+	}
 #endif
 }
 
-- 
1.8.5.3
