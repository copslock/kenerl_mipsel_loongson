Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 03:54:02 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52348 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842309AbaGVBx7S5O8z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 03:53:59 +0200
Received: by mail-pa0-f47.google.com with SMTP id kx10so10859700pab.6
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 18:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zStVeuj7o/rf0vJ1C6QRL5Y8ra7ACBFZyMyO3pa8i38=;
        b=HwLq+ZuKdgp7/gZZtfY5Pl05msQMS09ytqcp5LmqSC/srzenJnYY0GiN8MUWJv6bE8
         /rngSsz772Sq9vgByrEYMEo/cDe7aP3N79T7grl/VYrKEO/gK/BlfG5H1B5zkiqeEi2K
         irrQ47NO1C1jnOLHZ/gFC4FUqPZoY0uWPaFmppTkhYTwTlF3131mJ3taAU2GQ9Rt2q7x
         PuNqKFAuPcslg6pmpM/ggPUGCSoIB278NWTgTsRQFnj8jfrFidVh+QWEjgvJDOOVXBPs
         IWPCJZ/8loU9TCNKuPi+3pC0UO092NblzIYLhA795ZhTtfprNNGGbMey179eTZv0TFNk
         33DA==
X-Gm-Message-State: ALoCoQnPmHc1cPL47zi/a1wJCaRCoejiqFUYhr2jQ8UkDSuuOZSeV319sWi6D4W0LF2kpA0p1U2V
X-Received: by 10.68.244.40 with SMTP id xd8mr18819808pbc.24.1405994033089;
        Mon, 21 Jul 2014 18:53:53 -0700 (PDT)
Received: from localhost ([2600:1010:b01b:59a8:9138:8dc8:286b:79c0])
        by mx.google.com with ESMTPSA id q1sm6904691pdd.10.2014.07.21.18.53.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2014 18:53:51 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v3 5/8] x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
Date:   Mon, 21 Jul 2014 18:53:40 -0700
Message-Id: <2baeb5fad958c292705885941d61ab31771a75bb.1405992946.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405992946.git.luto@amacapital.net>
References: <cover.1405992946.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

is_compat_task() is the wrong check for audit arch; the check should
be is_ia32_task(): x32 syscalls should be AUDIT_ARCH_X86_64, not
AUDIT_ARCH_I386.

CONFIG_AUDITSYSCALL is currently incompatible with x32, so this has
no visible effect.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/ptrace.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 93c182a..39296d2 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1441,15 +1441,6 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 	force_sig_info(SIGTRAP, &info, tsk);
 }
 
-
-#ifdef CONFIG_X86_32
-# define IS_IA32	1
-#elif defined CONFIG_IA32_EMULATION
-# define IS_IA32	is_compat_task()
-#else
-# define IS_IA32	0
-#endif
-
 /*
  * We must return the syscall number to actually look up in the table.
  * This can be -1L to skip running any syscall at all.
@@ -1487,7 +1478,7 @@ long syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->orig_ax);
 
-	if (IS_IA32)
+	if (is_ia32_task())
 		audit_syscall_entry(AUDIT_ARCH_I386,
 				    regs->orig_ax,
 				    regs->bx, regs->cx,
-- 
1.9.3
