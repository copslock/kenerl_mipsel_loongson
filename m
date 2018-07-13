Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2018 09:32:37 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:35682
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeGMHcaYUj15 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2018 09:32:30 +0200
Received: by mail-pg1-x543.google.com with SMTP id e6-v6so4718982pgv.2;
        Fri, 13 Jul 2018 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Hx8k3mbZUyYRmrUsMevyLKCIulK+SAGlRCl87X6OZvo=;
        b=DH0X5WzB05M8+mMlfafOz7Dv4tdPFulDOxiQfQJey0eOiTgCLUI7FzXUS5X1HD3767
         yjSgu20qy3Ol6/d7finRfL+fBmjFJrZkiJjglOCqjfMHVs/qRePJIqcYWVycCPXpYYSu
         X0PqOwFAQiLP0DIFooDsEJH7zfB/wksm9A2SgZq5+4ItSls1zl38HUHJp1KAJdvOBdO/
         p0IZQa6Fzn1JGuJ7ZLOQX0ZJS7cfRJBOxh8piPF50fKhzTHlLFiioywVGxvxH1iNG2Vd
         459CBvvs3eOph7g/FtZUwv4ZBDXhHBOwFeD/jPqZMbhR2vB/V9wMUMmw7TeSV5rOS8Fr
         lP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Hx8k3mbZUyYRmrUsMevyLKCIulK+SAGlRCl87X6OZvo=;
        b=SMRUCY6IRk1TMSwnzvkeSMffvri5gk9iHyrpKHqGxWkG1keYNNf6aOtYXMxdn9lYsT
         sEX/+6pK0p60ESJ0qY2Y+izlO6jVnhydmopA5mxJvNybn7456N7HVkKyZJCiyWZZWOmQ
         QbnRzZaHKHI17tCaK57fFsY9+2k9xkzNJZwXAqT46dqM9qF7CoRrcnFhlXfbJl4OIs02
         H6iqJZ1hJWz6pKC3PvxdLUg+SWXXwIgpm1nvjOsM3mPioBwH0leyMRyQkwycyZ7ylaUQ
         Fibe9xgk/d7kiGKkcdxic9p39+84+q4BxqJMoC0HZJCSibfgJk9pkrc6VL23kumWknKK
         to8Q==
X-Gm-Message-State: AOUpUlFTD8/h3VdHTFuZOMhZInF8I1ftyI+Fu1+XjKjGfwQtJxyDj0wk
        evoLYZ2Zlyhrz/3i82b9iga2iQ==
X-Google-Smtp-Source: AAOMgpcFlyu4ZqED7gjpsGrbGpdVu6kAV5skJN+Xgef+lXFfNjyTzTxGYmdFTWC1nojIMtW2hBzLYg==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr4973587pgq.174.1531467143624;
        Fri, 13 Jul 2018 00:32:23 -0700 (PDT)
Received: from software.domain.org ([104.251.228.27])
        by smtp.gmail.com with ESMTPSA id 10-v6sm52900611pfs.111.2018.07.13.00.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 00:32:22 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Date:   Fri, 13 Jul 2018 15:37:57 +0800
Message-Id: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64824
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

Linux expects that if a CPU modifies a memory location, then that
modification will eventually become visible to other CPUs in the system.

On Loongson-3 processor with SFB (Store Fill Buffer), loads may be
prioritised over stores so it is possible for a store operation to be
postponed if a polling loop immediately follows it. If the variable
being polled indirectly depends on the outstanding store [for example,
another CPU may be polling the variable that is pending modification]
then there is the potential for deadlock if interrupts are disabled.
This deadlock occurs in qspinlock code.

This patch changes the definition of cpu_relax() to smp_mb() for
Loongson-3, forcing a flushing of the SFB on SMP systems before the
next load takes place. If the Kernel is not compiled for SMP support,
this will expand to a barrier() as before.

References: 534be1d5a2da940 (ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore)
Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/processor.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index af34afb..a8c4a3a 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
 
+#ifdef CONFIG_CPU_LOONGSON3
+/*
+ * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
+ * loop. Since spin loops of any kind should have a cpu_relax() in them, force
+ * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
+ * become available as expected.
+ */
+#define cpu_relax()	smp_mb()
+#else
 #define cpu_relax()	barrier()
+#endif
 
 /*
  * Return_address is a replacement for __builtin_return_address(count)
-- 
2.7.0
