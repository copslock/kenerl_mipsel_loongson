Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 12:45:48 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:47946 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991111AbdFVKpletIx6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jun 2017 12:45:41 +0200
X-QQ-mid: bizesmtp14t1498128312tyve3mi7
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 22 Jun 2017 18:45:02 +0800 (CST)
X-QQ-SSF: 01100000000000F0FLF2B00A0000000
X-QQ-FEAT: 7ggsqP2qw0rsiy/NzPtXOzTmaD+POyhwDhMesJeJnWHZpuTwyZ+nmdxovWC59
        9NR/AwTkqFNzejFnRTpwQAfs1k5HA5S4bRluIFG41N4uc7hXnJN/lGztcQquqxxEnZWCkle
        bl8gPfdNSU38OnQWhq/gjeyKIO0GxWV2b6Eg4hxh99mUdlLUAFDkpoookIDQ/wSUcsbIcmd
        yFqgMTOSWvVWVRW+yFp1ZM0W/CYBPUYbgqL8uB1Dhhj/PVFouwikdsafBBtkAak7ydGlmcc
        2gSxu70EYQkZj21t8sLR65cCtN8mZ13qKpjg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix a long-standing mistake in mips_atomic_set()
Date:   Thu, 22 Jun 2017 18:45:45 +0800
Message-Id: <1498128345-6827-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58742
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

This mistake comes from the commit f1e39a4a616cd99 ("MIPS: Rewrite
sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler"). In the
common case 'bnez' should be 'beqz' (as same as older kernels before
2.6.32), otherwise this syscall may cause an endless loop.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 1dfa7f5..95e1b30 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -134,7 +134,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
 		"2:	sc	%[tmp], (%[addr])			\n"
-		"	bnez	%[tmp], 4f				\n"
+		"	beqz	%[tmp], 4f				\n"
 		"3:							\n"
 		"	.insn						\n"
 		"	.subsection 2					\n"
-- 
2.7.0
