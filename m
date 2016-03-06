Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 04:50:37 +0100 (CET)
Received: from smtpbg65.qq.com ([103.7.28.233]:26213 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27005160AbcCFDubtl5d0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Mar 2016 04:50:31 +0100
X-QQ-mid: bizesmtp10t1457236176t363t17
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2016 11:49:29 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: aw+KFSrh3BD+BEsi/chEUAgh9uXZtnENhUy4RYPC4FxsWoxvXRQeiuFf0eU1E
        Fju1X/Wc0pFZk29VBs/kCtdhaTE1z4u9ZJ0wVwPTA+Et60HTRS1MAlakWxil7hFHY2dbpVF
        u8gU1zM+caLjyxQi5IIeSFoVp/BPEqBuMflsPAqzZW8axqJpRUOLocHdS3tv0CP5fpQLbqN
        FEMAvdaf9U/xxZvNalSRz0hrqiNKBH/4P8cH9nNbQkS8f48ya1mzo2UAoBm0eCIfxFRzeOA
        qaCqAyS3sCy+HR
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/3] MIPS: Reserve nosave data for hibernation
Date:   Sun,  6 Mar 2016 11:50:00 +0800
Message-Id: <1457236202-16321-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52470
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

After commit 92923ca3aacef63c92dc (mm: meminit: only set page reserved
in the memblock region), the MIPS hibernation is broken. Because pages
in nosave data section should be "reserved", but currently they aren't
set to "reserved" at initialization. This patch makes hibernation work
again.

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
