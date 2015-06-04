Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 08:56:11 +0200 (CEST)
Received: from smtpbgbr1.qq.com ([54.207.19.206]:36420 "EHLO smtpbgbr1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007206AbbFDG4IxfwRR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jun 2015 08:56:08 +0200
X-QQ-mid: bizesmtp2t1433400926t892t302
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 04 Jun 2015 14:55:02 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK52B00A0000000
X-QQ-FEAT: /peYvah/M2WrrR/HAcXUUdcMMPln0EEoxMCqmpYoXpxUk6gGPOCJynmnRvQL9
        QV8i//I4jB4WuXEharSgGfrH09hlxQRR+GyWYSujnyBnDK2UT0TlphLpcUvBCjrt3s7czHl
        B07s7adqtnYHDXwHAK5wc8I88ehV/jh2ZDGGeXT1WdHqRXrWguIw+ClcQiU6ZF2SLW+c5hd
        Gb8jyXwLbPGnqcqPc7pq56p0fc+GlEcOHronqI0JfUPQQrQtRGu4w
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Loongson-3: Fix a cpu-hotplug issue in loongson3_ipi_interrupt()
Date:   Thu,  4 Jun 2015 14:53:47 +0800
Message-Id: <1433400827-27684-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47844
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

setup_per_cpu_areas() only setup __per_cpu_offset[] for each possible
cpu, but loongson_sysconf.nr_cpus can be greater than possible cpus
(due to reserved_cpus_mask). So in loongson3_ipi_interrupt(), percpu
access will touch the original varible in .data..percpu section which
has been freed. Without this patch, cpu-hotplug will cause memery
corruption.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson/loongson-3/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
index e3c68b5..509877c 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -272,7 +272,7 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	if (action & SMP_ASK_C0COUNT) {
 		BUG_ON(cpu != 0);
 		c0count = read_c0_count();
-		for (i = 1; i < loongson_sysconf.nr_cpus; i++)
+		for (i = 1; i < num_possible_cpus(); i++)
 			per_cpu(core0_c0count, i) = c0count;
 	}
 }
-- 
1.7.7.3
