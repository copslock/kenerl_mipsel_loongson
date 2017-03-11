Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Mar 2017 06:19:40 +0100 (CET)
Received: from smtpbg65.qq.com ([103.7.28.233]:15842 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992289AbdCKFTeBcMsF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Mar 2017 06:19:34 +0100
X-QQ-mid: bizesmtp8t1489209548tn4qbparb
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 11 Mar 2017 13:19:01 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: 6TGsrbyUWNb/bmDXUIuE43dbmicgfwaRltpVawlSrcWBes0ZPUhmEHnYHKhqI
        grkr8rcaeeAxLhH4cWdivlezJmwpThhsUSIzkwVuE7+uhl63HTUZN0nZfRmKOuCg94rITL4
        yHBvDFvMRevCYG3fu+j4tExs+f7NU+ZOeZ+8SS35x8KGSxMTJnJS0M0UbDZL0qMA4+O25u7
        KNYYT651aUxSe4YMflSJE5UMap185ydjQUYS6X1GE+yPC7ay+Rr2Lje1oJZWStVOyEeU8tk
        QV+Hvc7NhXmCiJ4GURAIwndCw=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2 1/7] MIPS: Add MIPS_CPU_FTLB for Loongson-3A R2
Date:   Sat, 11 Mar 2017 13:19:52 +0800
Message-Id: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57135
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

Loongson-3A R2 and newer CPU have FTLB, but Config0.MT is 1, so add
MIPS_CPU_FTLB to the CPU options.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/cpu-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 07718bb..12422fd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1824,7 +1824,7 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		}
 
 		decode_configs(c);
-		c->options |= MIPS_CPU_TLBINV | MIPS_CPU_LDPTE;
+		c->options |= MIPS_CPU_FTLB | MIPS_CPU_TLBINV | MIPS_CPU_LDPTE;
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
 	default:
-- 
2.7.0
