Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2017 01:54:25 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:40405 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992942AbdAUAyRhSTr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2017 01:54:17 +0100
X-QQ-mid: bizesmtp16t1484960016t842g8q6
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 21 Jan 2017 08:53:20 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72B00A0000000
X-QQ-FEAT: lbfA5hRlhlbA2zZcBUmkhhWSROIEm3t22+A7vaRQVjZnhQ8fHueeWkSDa5Ygg
        ZeAIKYJfmN6WgGDgwpp+RE7ZTvRM43fdPdWKqfsWHXRuehLd4qCQeY8OeudZDZKaC4eJvMh
        L1hykT5bZPzsIPKgZ3ImgNDvdmTZOIMZgy/VTqvJKU7ZROye8We/kRjY+uDj5H+vLRoBces
        fggUcbvLLVLa2vd3FNENmGDyLh/yj+U3N4iswjC8jjSPSF1TDx5AjmtEjfdxTUC/CsMuHKu
        0HJsAFOJbrbJug1JQvULFQ0o9mzLhilIzKEQ==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH RESEND 1/4] MIPS: Add MIPS_CPU_FTLB for Loongson-3A R2
Date:   Sat, 21 Jan 2017 08:56:03 +0800
Message-Id: <1484960166-30022-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56436
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
