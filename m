Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 09:42:49 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51651 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990509AbcKDIlzr0X9t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2016 09:41:55 +0100
X-QQ-mid: bizesmtp1t1478248884tl03y1dpy
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 04 Nov 2016 16:41:04 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72000A0000000
X-QQ-FEAT: vLfL7h4S5Ms/fJR8EhR0eAK//xrPbdzCVQZdpPQiTSwPUkpxWeYQPJhbUFY/w
        VUwmjQNNERIHLltv7lnugr5jMKzJVEhUfQrZkZTGs7w7SALFovRlOdMwOQ7x5AFuSb19WAg
        znEAuTjtxlGTWWhz2eoQ4fqe/4LxP2ipgcTiEl14Mx2uJvP1+cCJUIxR/Jvx2RvHkF92t5P
        6z47pzYa6KI+MppgwJad+bBvtSX4p4q+6AMIh+1peoPzt/do0pqWJD7WevK/Zpervpo1CYf
        hklDJeJTm1AHw6NJTlKwciTsc=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] MIPS: Add MIPS_CPU_FTLB for Loongson-3A R2
Date:   Fri,  4 Nov 2016 16:41:26 +0800
Message-Id: <1478248888-31003-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55663
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
index dd31754..921211b 100644
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
