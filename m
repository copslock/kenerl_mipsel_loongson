Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 03:11:28 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57162 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861108AbaGPBLOyaJ8D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 03:11:14 +0200
Received: by mail-pd0-f176.google.com with SMTP id y10so266982pdj.21
        for <multiple recipients>; Tue, 15 Jul 2014 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5FwdJ068zZKJ14eHUKxQUmScCUdo6YbD07Hk+YNEC3k=;
        b=wjZIpbQXnLQa8WwKpWCyYBhvw91+RTyeWS/UX7NpOLijTfbAN/7dWicnT7i19DXMKX
         1Y5oovEuwKdYqrEmd9qetc8YH9D4k6/WpzV3tqGD0qsXeCy7UWa5ST/DglXacrYzby8a
         47svHRpACHPUlp3zZktPUhIfMixpXU7yCSzlh9yuoUH50VPMlcllk+XYmNFPJWoVERci
         J3LQ8SzKu5n9AscTNwzvYKyQ54DgL8wXy5B1bGCTatj2nc9WmjQYbmjoMUvoVVN46Amg
         5QyAOUgSdjPjf8ajLxELMy20nQNxQKhuBNxGcYKrIy8c6XGeSSp7n6XLi7jUrohZczwY
         ZXrA==
X-Received: by 10.68.102.34 with SMTP id fl2mr26141378pbb.2.1405473068369;
        Tue, 15 Jul 2014 18:11:08 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id d13sm8035286pbu.72.2014.07.15.18.11.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 18:11:07 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, Jie Chen <chenj@lemote.com>,
        Rui Wang <wangr@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH V2] MIPS: Don't BUG_ON(!is_fpu_owner()) in do_ade()
Date:   Wed, 16 Jul 2014 09:19:16 +0800
Message-Id: <1405473556-8353-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41212
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

In do_ade(), is_fpu_owner() isn't preempt-reliable. For example, when
an unaligned ldc1 is executed, do_cpu() is called and then FPU will be
enabled (and TIF_USEDFPU will be set for the current process). Then,
do_ade() is called because the access is unaligned. If the current
process is preempted at this time, TIF_USEDFPU will be cleard. When the
process is scheduled again, BUG_ON(!is_fpu_owner()) is triggered.

This small program can trigger this BUG in a preemptible kernel:
--
int main (int argc, char *argv[])
{
        double u64[2];

        while (1) {
                asm volatile (
                        ".set push \n\t"
                        ".set noreorder \n\t"
                        "ldc1 $f3, 4(%0) \n\t"
                        ".set pop \n\t"
                        ::"r"(u64):
                );
        }

        return 0;
}
--

V2: Remove the BUG_ON() unconditionally due to Paul's suggestion.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Rui Wang <wangr@lemote.com>
Cc: <stable@vger.kernel.org>
---
 arch/mips/kernel/unaligned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 2b35172..e11906d 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -690,7 +690,6 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	case sdc1_op:
 		die_if_kernel("Unaligned FP access in kernel code", regs);
 		BUG_ON(!used_math());
-		BUG_ON(!is_fpu_owner());
 
 		lose_fpu(1);	/* Save FPU state for the emulator. */
 		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
-- 
1.9.0
