Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 08:06:51 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:33893 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007640AbbJGGGrwyUkj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2015 08:06:47 +0200
X-QQ-mid: bizesmtp11t1444197970t574t17
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 07 Oct 2015 14:06:09 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK62B00A0000000
X-QQ-FEAT: l9DFUSjbYCTqXg+s5kDlp2714a56/g/v8LOwHnA70b3PL7cYVz77uatOnQrw5
        zdPk39bOgq3FoF5hpgmJBLcjE8PhbkPWrBAii7N1s5RknzYQ3/YLEE8xzF6GAPbp05PY2Ey
        ccAaq/uJEvuqLhXs/4B4/RZmSFAsEBTvJ9Dw9sfzJ0AovQRlXLwoddy+0xKVJZNq6xECoze
        MlgThJ8GphG0FR1uWrqbHYxFDfTzCm2XiEX2jcktzJTsIpJZgbt6fz7rtJsNs/idgsPM/J9
        K2YPKIpaCTFxCF
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 4/4] MIPS: Loongson: Make CPU names more clear
Date:   Wed,  7 Oct 2015 14:08:02 +0800
Message-Id: <1444198082-24128-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49461
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
 arch/mips/kernel/cpu-probe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6b90644..fa972de 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -999,28 +999,28 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
2.4.6
