Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 11:20:33 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:34434 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010986AbbEDJUYqIHxz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 May 2015 11:20:24 +0200
X-QQ-mid: bizesmtp3t1430731193t971t178
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 04 May 2015 17:19:53 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52000A0000000
X-QQ-FEAT: 59CKXo2AjOyUd5HKZ+M1bG0+rCVUadCcBVNV8D7gchlDNXwepWlsThlLmuVB4
        ZSWwjNn5h//m7Bj34+g5WkdjdAgZswe1QZ1PpcnDFTl5bTUT7Skukwlr61iXxz5BegDnVrI
        CmsN5c9pFBMxT2//K50NOI9HIVar2ywSbWi8u7xB0w3Dx58wuWd669yyZsEEsVTvSI6BGts
        8+t4jWUc3jgpWGAtrzXcvDglWQLnq8gpOSpICP2kFBA==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 4/4] MIPS: Loongson: Make CPU names more clear
Date:   Mon,  4 May 2015 17:19:11 +0800
Message-Id: <1430731151-4808-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
References: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Make names in /proc/cpuinfo more human-readable, Since GCC support the
new-style names for a long time, this may not break -march=native any
more.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/cpu-probe.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e36515d..9933146 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -968,28 +968,28 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON2E:
 			c->cputype = CPU_LOONGSON2;
-			__cpu_name[cpu] = "ICT Loongson-2";
+			__cpu_name[cpu] = "ICT Loongson-2E";
 			set_elf_platform(cpu, "loongson2e");
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
 		case PRID_REV_LOONGSON2F:
 			c->cputype = CPU_LOONGSON2;
-			__cpu_name[cpu] = "ICT Loongson-2";
+			__cpu_name[cpu] = "ICT Loongson-2F";
 			set_elf_platform(cpu, "loongson2f");
 			set_isa(c, MIPS_CPU_ISA_III);
 			c->fpu_msk31 |= FPU_CSR_CONDX;
 			break;
 		case PRID_REV_LOONGSON3A:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "ICT Loongson-3A";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R1);
 			break;
 		case PRID_REV_LOONGSON3B_R1:
 		case PRID_REV_LOONGSON3B_R2:
 			c->cputype = CPU_LOONGSON3;
-			__cpu_name[cpu] = "ICT Loongson-3";
+			__cpu_name[cpu] = "ICT Loongson-3B";
 			set_elf_platform(cpu, "loongson3b");
 			set_isa(c, MIPS_CPU_ISA_M64R1);
 			break;
-- 
1.7.7.3



VÙ4
