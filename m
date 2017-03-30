Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 04:45:28 +0200 (CEST)
Received: from smtpbg291.qq.com ([113.108.11.223]:57958 "EHLO smtpbg291.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992209AbdC3CoifKcjR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Mar 2017 04:44:38 +0200
X-QQ-mid: bizesmtp14t1490841827tw48eisi
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 30 Mar 2017 10:43:45 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH61B00A0000000
X-QQ-FEAT: wgl5Lpe0bqGpR8xxWDYRlfI88i4nhKVn2lem/rkTxZ463rFTQMgrdbcjQvtRJ
        MyRj7HjVE1aXO0UU7fWoVMlPZd8x3X+8C/q6Vv3Vzs5ogqXQq/RAGNk1JCIrIB2w9hnURrt
        tKCVQa01ZtCDUSU1RUEPY2BrfhkpDb+qThwqtVwDW7tImhUhr6sLkNh4ir5dhD/7RawfuXw
        le99cMpmQTDO2hMYje5MLQ4ftZU89SI18wICmIIyYKCDRGKTKGPcdFGuTUBzH7QRGH1oawU
        DOg5Ny5+fi8xxb9kXLj2KK6JdkQZR0wgbOD39XQz6JPBWflYmBu8v1OeY=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        linux-mips@linux-mips.org, Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v6 1/8] MIPS: Loongson: Merge PRID macro for Loongson-1A/1B/1C
Date:   Thu, 30 Mar 2017 10:44:42 +0800
Message-Id: <1490841889-13450-2-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1490841889-13450-1-git-send-email-zhoubb@lemote.com>
References: <1490841889-13450-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

As we all know, the Loongson-1 series CPUs(1A/1B/1C) share the same PRID macro.
so I rename them for more readable.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu.h         | 3 +--
 arch/mips/kernel/cpu-probe.c        | 4 +++-
 arch/mips/loongson32/common/setup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9a83724..76c0b56c3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -239,8 +239,7 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
-#define PRID_REV_LOONGSON1C	0x0020	/* Same as Loongson-1B */
+#define PRID_REV_LOONGSON1ABC	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A_R1	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 07718bb..657d65d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1502,8 +1502,10 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_LOONGSON1;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
+		case PRID_REV_LOONGSON1ABC:
+#ifdef CONFIG_CPU_LOONGSON1B
 			__cpu_name[cpu] = "Loongson 1B";
+#endif
 			break;
 		}
 
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 1640744..c8e8b3e 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -21,7 +21,7 @@ const char *get_system_type(void)
 	unsigned int processor_id = (&current_cpu_data)->processor_id;
 
 	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
+	case PRID_REV_LOONGSON1ABC:
 #if defined(CONFIG_LOONGSON1_LS1B)
 		return "LOONGSON LS1B";
 #elif defined(CONFIG_LOONGSON1_LS1C)
-- 
2.9.3
