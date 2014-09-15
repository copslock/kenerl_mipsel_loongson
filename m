Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 21:47:56 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38551 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009016AbaIOTrVHl0wW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 21:47:21 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44006A70;
        Mon, 15 Sep 2014 19:47:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jie Chen <chenj@lemote.com>, Rui Wang <wangr@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.10 22/71] MIPS: Remove BUG_ON(!is_fpu_owner()) in do_ade()
Date:   Mon, 15 Sep 2014 12:26:20 -0700
Message-Id: <20140915192639.448447285@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <20140915192638.702282534@linuxfoundation.org>
References: <20140915192638.702282534@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 2e5767a27337812f6850b3fa362419e2f085e5c3 upstream.

In do_ade(), is_fpu_owner() isn't preempt-safe. For example, when an
unaligned ldc1 is executed, do_cpu() is called and then FPU will be
enabled (and TIF_USEDFPU will be set for the current process). Then,
do_ade() is called because the access is unaligned.  If the current
process is preempted at this time, TIF_USEDFPU will be cleard.  So when
the process is scheduled again, BUG_ON(!is_fpu_owner()) is triggered.

This small program can trigger this BUG in a preemptible kernel:

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

V2: Remove the BUG_ON() unconditionally due to Paul's suggestion.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Rui Wang <wangr@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/unaligned.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -604,7 +604,6 @@ static void emulate_load_store_insn(stru
 	case sdc1_op:
 		die_if_kernel("Unaligned FP access in kernel code", regs);
 		BUG_ON(!used_math());
-		BUG_ON(!is_fpu_owner());
 
 		lose_fpu(1);	/* Save FPU state for the emulator. */
 		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
