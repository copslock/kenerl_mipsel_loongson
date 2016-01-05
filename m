Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 06:56:05 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:58643 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008336AbcAEFy6M2F0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 06:54:58 +0100
X-QQ-mid: bizesmtp4t1451973256t923t238
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 05 Jan 2016 13:54:15 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: Ve5uy8pOtqBcj0dskjrQIMFOFcqil2+CLiQuotJ+MrdGzWBbC28sc9MJAKjQa
        iuS8apGfF3Y6eY6tjw5581t7eh5wqGZD2baWr0X9MfFZ7D9mGbb8iJ6wKGmNnQbkQA7DeTF
        7H/lYwwdoAAsVdt4MM8DjQ1IAF1Dpe0spU7s2hY8FfXJVkTW4rZ8ltLXSdemoeubSFCVkXu
        mXtpQOkzj/cHJrQ+5plklPAOSGhO4at0FY/vra55Ky6/bGMWF6cEHQtv2mpxtS7XrwB0sYU
        3d2Fxc6wfaJQOz
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/6] MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler
Date:   Tue,  5 Jan 2016 13:59:06 +0800
Message-Id: <1451973549-16198-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
References: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50901
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

BTW, there is a corner should be avoid: C0_Count of Core-0 is really 0.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 1a4738a..55d0f5f 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -275,8 +275,10 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	if (action & SMP_ASK_C0COUNT) {
 		BUG_ON(cpu != 0);
 		c0count = read_c0_count();
+		c0count = c0count ? c0count : 1;
 		for (i = 1; i < num_possible_cpus(); i++)
 			per_cpu(core0_c0count, i) = c0count;
+		__wbflush(); /* Let others see the result ASAP */
 	}
 }
 
-- 
2.4.6



ÿÿ		
