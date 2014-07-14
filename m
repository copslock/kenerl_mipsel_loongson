Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 13:43:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45565 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860096AbaGNLnpMue0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 13:43:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AB1F03DBECEA8
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 12:43:36 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 12:43:38 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 12:43:38 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 12:43:37 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 2/5] MIPS: cpu: Add new cpu option for Hardware Table Walker.
Date:   Mon, 14 Jul 2014 12:43:28 +0100
Message-ID: <1405338208-10776-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405329246-21643-3-git-send-email-markos.chandras@imgtec.com>
References: <1405329246-21643-3-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41184
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

Moreover, report hardware page table walker support as 'htw' in the ASE
list of /proc/cpuinfo, if the core implements this feature.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- Drop unnecessary new line
- Improve commit message
- Rename HWTW to HTW
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/proc.c              | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c7d8c997d93e..3b9768e92e9e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -29,6 +29,9 @@
 #ifndef cpu_has_eva
 #define cpu_has_eva		(cpu_data[0].options & MIPS_CPU_EVA)
 #endif
+#ifndef cpu_has_htw
+#define cpu_has_htw		(cpu_data[0].options & MIPS_CPU_HTW)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 3b8d993d9d8d..8219c0a5f77e 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -363,6 +363,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_TLBINV		0x02000000ull /* CPU supports TLBINV/F */
 #define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
 #define MIPS_CPU_EVA		0x80000000ull /* CPU supports Enhanced Virtual Addressing */
+#define MIPS_CPU_HTW		0x100000000ull /* CPU support Hardware Page Table Walker */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 037a44d962f3..1ed1b5ae8894 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -113,6 +113,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
 	if (cpu_has_msa)	seq_printf(m, "%s", " msa");
 	if (cpu_has_eva)	seq_printf(m, "%s", " eva");
+	if (cpu_has_htw)	seq_printf(m, "%s", " htw");
 	seq_printf(m, "\n");
 
 	if (cpu_has_mmips) {
-- 
2.0.0
