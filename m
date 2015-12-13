Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 03:29:39 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:48384 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008791AbbLMC3UBuxZ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Dec 2015 03:29:20 +0100
X-QQ-mid: bizesmtp5t1449973731t714t125
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 13 Dec 2015 10:28:48 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK62B00A0000000
X-QQ-FEAT: S4ZkIUfyYTN3lva1dyHk4Vm3/PXdeq4CZPnOGFA9rO5tB/m8X8KIpsninyPZT
        Yu32jELmzRAQE7EpRjxavlQd1PuplQbtQNNPMm8q7QPHZHwVmDwVeEKMyWJSSNre77UKshd
        m5LBcn47YceArjjyDO2gVsEG8qmepiH+6C3RoaBDfNRfO9PZFgg8Y/4g+Yqy8HvoVPg1Ltg
        B9qqCQiTxmKapydQ5me3zxTpbFuSyXz9skwwYRv27hOn7Lmc5HRD7FwC/+1WxwHM3bJYz5z
        mk9jBIDnYsjXfW
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler
Date:   Sun, 13 Dec 2015 10:32:42 +0800
Message-Id: <1449973962-16405-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1449973962-16405-1-git-send-email-chenhc@lemote.com>
References: <1449973962-16405-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50567
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

When Core-0 handle SMP_ASK_C0COUNT IPI, we should make other cores to
see the result as soon as possible (especially when Store-Fill-Buffer
is enabled). Otherwise, C0_Count syncronization makes no sense.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 1a4738a..38c775b 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -277,6 +277,7 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 		c0count = read_c0_count();
 		for (i = 1; i < num_possible_cpus(); i++)
 			per_cpu(core0_c0count, i) = c0count;
+		__wbflush(); /* Let others see the result ASAP */
 	}
 }
 
-- 
2.4.6
