Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2013 10:58:56 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42440 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833241Ab3ASJ6zoO3hJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jan 2013 10:58:55 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: show correct cpu name for 24KEc
Date:   Sat, 19 Jan 2013 10:56:15 +0100
Message-Id: <1358589375-11631-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Make sure 24KEc is properly identified inside /proc/cpuinfo

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/kernel/cpu-probe.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 8db7a47..ba16902 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -841,10 +841,13 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "MIPS 20Kc";
 		break;
 	case PRID_IMP_24K:
-	case PRID_IMP_24KE:
 		c->cputype = CPU_24K;
 		__cpu_name[cpu] = "MIPS 24Kc";
 		break;
+	case PRID_IMP_24KE:
+		c->cputype = CPU_24K;
+		__cpu_name[cpu] = "MIPS 24KEc";
+		break;
 	case PRID_IMP_25KF:
 		c->cputype = CPU_25KF;
 		__cpu_name[cpu] = "MIPS 25Kc";
-- 
1.7.10.4
