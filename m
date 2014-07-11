Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 05:08:52 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64978 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838840AbaGKDIs6acMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 05:08:48 +0200
Received: by mail-pa0-f50.google.com with SMTP id bj1so642173pad.9
        for <multiple recipients>; Thu, 10 Jul 2014 20:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rPZowDdWfFq0V7cN9iuJA9/0xjbcCDkrrCUCyEB26r8=;
        b=Nh01QR4urivN0ArhEmExeshlL8vwYxujYEDqpdIx7Uqsl/MFklJkPA4QcgbNU71ags
         +QJNEXrkjNeCWekgk86Ivx1DaXVnyS/ujp7W/1ZgKcxRb056j/J/PIG3MNSQfg2ysbXS
         EWVcb8dkil1CuKJ04NiwdYLUAzbJQwRpsvQ0tnS7UgLNok5ptc4VDY73rypjlMVACYd3
         dVGP988KVxSrV5LTHAqni3Duwk+xLcgbih5FTNDJUzZvHZ0f/VFBmnzOwkaIN4wT00hK
         bu2rTN9bpgUg4Y/1FZ12wuF3CStQT9EcVRQBvk6XklgoxdWE2gUf5Rr6vHgmy6NrIfq0
         6cVQ==
X-Received: by 10.70.14.227 with SMTP id s3mr21169159pdc.88.1405048122360;
        Thu, 10 Jul 2014 20:08:42 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id lq6sm3765289pab.48.2014.07.10.20.08.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jul 2014 20:08:41 -0700 (PDT)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenhc@lemote.com, ralf@linux-mips.org, wangr@lemote.com,
        chenj <chenj@lemote.com>
Subject: [PATCH] Not preempt in CP1 exception handling
Date:   Fri, 11 Jul 2014 11:14:13 +0800
Message-Id: <1405048453-12633-1-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

do_ade may be invoked with preempt enabled. do_cpu will be invoked with
preempt enabled. When it's preempted(in do_ade/do_cpu), TIF_USEDFPU will be
cleared, when it returns to do_ade/do_cpu, the fpu is actually disabled.

e.g.
In do_ade()
  emulate_load_store_insn():
    BUG_ON(!is_fpu_owner()); <-- This assertion may be breaked.

In do_cpu()
  enable_restore_fp_context():
    was_fpu_owner = is_fpu_owner();

This patch simply disables interrupts in related handlers, and
disable preempt/enable interrupts in do_ade/do_cpu.
---
 arch/mips/kernel/genex.S | 4 ++--
 arch/mips/kernel/traps.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ac35e12..a5c6931 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -370,7 +370,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.macro	__build_clear_ade
 	MFC0	t0, CP0_BADVADDR
 	PTR_S	t0, PT_BVADDR(sp)
-	KMODE
+	CLI
 	.endm
 
 	.macro	__BUILD_silent exception
@@ -422,7 +422,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER dbe be cli silent			/* #7  */
 	BUILD_HANDLER bp bp sti silent			/* #9  */
 	BUILD_HANDLER ri ri sti silent			/* #10 */
-	BUILD_HANDLER cpu cpu sti silent		/* #11 */
+	BUILD_HANDLER cpu cpu cli silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
 	BUILD_HANDLER msa_fpe msa_fpe sti silent	/* #14 */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 51706d6..0e0f7de 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1166,6 +1166,9 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	int status, err;
 	unsigned long __maybe_unused flags;
 
+	preempt_disable();
+	local_irq_enable();
+
 	prev_state = exception_enter();
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 
@@ -1258,6 +1261,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 out:
 	exception_exit(prev_state);
+	preempt_enable();
 }
 
 asmlinkage void do_msa_fpe(struct pt_regs *regs)
-- 
1.9.0
