Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 02:33:13 +0100 (CET)
Received: from SMTPBG19.QQ.COM ([183.60.61.236]:60415 "EHLO smtpbg19.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006656AbcCGBdIYJPN4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Mar 2016 02:33:08 +0100
X-QQ-mid: bizesmtp11t1457314288t334t22
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 07 Mar 2016 09:31:17 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70
X-QQ-FEAT: gfF3hKh4GIkeJfo8Q3OF8qxYpp7t0r0rjFBuQrYHifpB9g2/Qhe8QajDc5iGu
        Q4qQp1yWqxfzSLZslKlUS00+AMhzfaMfMItj6Afe1aFAYJoOMJ2BexkS13faagAPM2rIPEc
        1NNqvEAySMXG6U+4ZtZXt4JdtisMta9zU6ij81aELmDzoOosVoVCgvxPVYrSNApOiUtoAiU
        HatGbjtH8p1R96gkxLB88soOUOVfWPcjbGOvDl/sIIk5AfH8tLu21C6kknej+FsVRfhXz3B
        bKoWE0im4ESD5v
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2 1/3] MIPS: Reserve nosave data for hibernation
Date:   Mon,  7 Mar 2016 09:31:45 +0800
Message-Id: <1457314307-8510-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52483
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

After commit 92923ca3aacef63c92d ("mm: meminit: only set page reserved
in the memblock region"), the MIPS hibernation is broken. Because pages
in nosave data section should be "reserved", but currently they aren't
set to "reserved" at initialization. This patch makes hibernation work
again.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 5fdaf8b..6f68cdd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -706,6 +706,9 @@ static void __init arch_mem_init(char **cmdline_p)
 	for_each_memblock(reserved, reg)
 		if (reg->size != 0)
 			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
+
+	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
+			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
 }
 
 static void __init resource_init(void)
-- 
2.7.0
