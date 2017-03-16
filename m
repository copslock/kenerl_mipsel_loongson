Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 14:00:31 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:43449 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991955AbdCPNAPVcLq- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 14:00:15 +0100
X-QQ-mid: bizesmtp3t1489669173tepg7l0ul
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 16 Mar 2017 20:59:16 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: YSSoAXAEBlFIW5G79t3aGXQHbqQ3NJ39M9YI5e6EwcZRZjCuuSpJJorS/DS2q
        6xtgZ7eiYqFpiwRN5AiAwcPzX2lh1W9iSZCJCnuJJxaZArwQ4FTvPYCzmTgrlizJ9imW5xR
        OraO85XVlCcFhundhCNhcQoJ0lLOujdZxKbpXjg1WFSfJpqDUm5aagXm7CJSk4IJfQ1QGlQ
        1e58qq1Erb1P+7ZiF3tVcsaXl/dAbSiqyU2PvX4/EbGB59pOdkbxSNqr6jBjdUOHijvZ3Ky
        /xA5Yh1heCpRbbommTSz845aod06m/gtwjgg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH RESEND V2 1/7] MIPS: Add MIPS_CPU_FTLB for Loongson-3A R2
Date:   Thu, 16 Mar 2017 21:00:25 +0800
Message-Id: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57323
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
