Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2018 10:19:40 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:46659
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeGSIThAtCWi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2018 10:19:37 +0200
Received: by mail-pg1-x544.google.com with SMTP id p23-v6so3264228pgv.13;
        Thu, 19 Jul 2018 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PP84X+OxFJ21UTR88oId1ypuOJWMSzupWAVzwbw8YCs=;
        b=TeSvFK4aTOuYn8P9m3RFFz6niSS14OO2/qimVU0KFUf0/CIoMwbSdTKS4hSsQGZgXU
         YWJ4Lhh1MwnfxIX2WPmZvsvi2cqQ9WYJVVs1sVKk1yaTsfuQ96JRlEnMZCD7vIeJFY81
         KkZgG03hoNQz7orjdepNRdnx3grSJInHY5kFOHtBNTY/FOVEwZvEkW/IbBTwcs+GcJpN
         vEoRZP1rRkW8n/htRGDKiywYUG9IBbpe3jfP6pKdtCkhcJa3Tuo466jEwzs4zwAs2FiM
         kxS2DSxtLsL5dLBpL++fNy0UQih4t3A1Uqywz1Wa5Twg7xivuHsAJTq70wKzJ41RI6Q6
         F2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PP84X+OxFJ21UTR88oId1ypuOJWMSzupWAVzwbw8YCs=;
        b=CrHXiEKo/XC5KhZyzjirtsBXDYEz3QexKd0VTdPIAPI9AkvAGJYlumvLOybZvinJ2s
         knHFBK5LKtD5yWlN/P4R4Q2DTyHuT6yNKqpda351Zmg1RYDziWa3Zs40l8ZRPwjsZ4aP
         a5oyDxIPxlsBpph1biLIa06Q4/acnETrXctIDCV7l+jljlPeup8ffqsUP/vmgsBgWQ6+
         Na4avOZ/z9c17wv7fXC/O3OUviQUGsscsRMyVILkbDPqIYYNLCZnCDXKrLoEZ+L+uwbL
         shVH5xD1301B3VycRIpIHzGCaKge8JNXxCfmhRPmkjy+WhhZ/b1o3qYg73eLBjIgFuGF
         Whww==
X-Gm-Message-State: AOUpUlEDUe/D+qOYrItjzQWYWuWFK3j+YICjsJSQXII7LznThAo75g00
        QXkfp6Xt0ITizTXnPf9TzG8lDkPQ1TQ=
X-Google-Smtp-Source: AAOMgpcpzdldSSZDsC03k++psHpPepWs9KqA3yzKGLZTpxACt+mKfYQ3Ql4hK4bmfokrO84/vkG3lg==
X-Received: by 2002:a65:6411:: with SMTP id a17-v6mr8886836pgv.287.1531988370167;
        Thu, 19 Jul 2018 01:19:30 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id i6-v6sm7728360pfo.107.2018.07.19.01.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 01:19:29 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH 1/2 4.4 Backport] MIPS: Call dump_stack() from show_regs()
Date:   Thu, 19 Jul 2018 16:25:19 +0800
Message-Id: <1531988720-2431-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64943
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

From: Paul Burton <paul.burton@mips.com>

commit 5a267832c2ec47b2dad0fdb291a96bb5b8869315 upstream.

The generic nmi_cpu_backtrace() function calls show_regs() when a struct
pt_regs is available, and dump_stack() otherwise. If we were to make use
of the generic nmi_cpu_backtrace() with MIPS' current implementation of
show_regs() this would mean that we see only register data with no
accompanying stack information, in contrast with our current
implementation which calls dump_stack() regardless of whether register
state is available.

In preparation for making use of the generic nmi_cpu_backtrace() to
implement arch_trigger_cpumask_backtrace(), have our implementation of
show_regs() call dump_stack() and drop the explicit dump_stack() call in
arch_dump_stack() which is invoked by arch_trigger_cpumask_backtrace().

This will allow the output we produce to remain the same after a later
patch switches to using nmi_cpu_backtrace(). It may mean that we produce
extra stack output in other uses of show_regs(), but this:

  1) Seems harmless.
  2) Is good for consistency between arch_trigger_cpumask_backtrace()
     and other users of show_regs().
  3) Matches the behaviour of the ARM & PowerPC architectures.

Marked for stable back to v4.9 as a prerequisite of the following patch
"MIPS: Call dump_stack() from show_regs()".

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19596/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
[ Huacai: backported to 4.4: The next patch is also backported to 4.4 ]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/process.c | 4 ++--
 arch/mips/kernel/traps.c   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 1ee603d..f96048a 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -637,8 +637,8 @@ static void arch_dump_stack(void *info)
 
 	if (regs)
 		show_regs(regs);
-
-	dump_stack();
+	else
+		dump_stack();
 }
 
 void arch_trigger_all_cpu_backtrace(bool include_self)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 31ca2ed..1b90121 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -344,6 +344,7 @@ static void __show_regs(const struct pt_regs *regs)
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs((struct pt_regs *)regs);
+	dump_stack();
 }
 
 void show_registers(struct pt_regs *regs)
-- 
2.7.0
