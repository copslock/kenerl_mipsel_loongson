Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 23:20:06 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47227 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861350AbaGRVTKfWwvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 23:19:10 +0200
Received: by mail-pd0-f171.google.com with SMTP id z10so5663075pdj.16
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 14:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zStVeuj7o/rf0vJ1C6QRL5Y8ra7ACBFZyMyO3pa8i38=;
        b=KhKA6HYyXfR/VvxhQs7unJeEyvQhmTyQ5pl6AiP1WCx1g2CgY+nMmVJDO01j7khfvw
         D3ykOx3fudKPxba51jMv1v+5rxSZ3Jc444n7FAk3bkFyZVM1WzlZFfR8MF/xOnb9qX3V
         pIbbvk3nMn0iVirj0k3loeSPw9NVe8WKovDGKGWt5IzZtThLaiHnHP/dR4xspdSvwVJ8
         8myshJxOAbwG9s2Z1DLCeUTedGTzrabMjskhFujwxj17FpUhlEyKgcc4ZFF8XqS7bkzS
         ggrLBAj07L0GYYemArUTZZ7I3ccekMzrTgVxV22LmNeGw8EyRNKnUFTjpCua3cvXew0W
         n5JQ==
X-Gm-Message-State: ALoCoQmFHE7qGAbVBsMcDHhbNC+OzSWVCsMHXBd4qVFMuOG9uJ4WgVYGKVrRjpuZhuH7VYH/LCgd
X-Received: by 10.70.34.73 with SMTP id x9mr8269640pdi.27.1405718344581;
        Fri, 18 Jul 2014 14:19:04 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id mt1sm6523068pbb.31.2014.07.18.14.19.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2014 14:19:03 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 4/7] x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
Date:   Fri, 18 Jul 2014 14:18:12 -0700
Message-Id: <a724eeae03fdec10268cc81da615a36522503458.1405717901.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41337
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
