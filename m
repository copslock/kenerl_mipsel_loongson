Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Sep 2014 00:14:28 +0200 (CEST)
Received: from mail-yk0-f175.google.com ([209.85.160.175]:56483 "EHLO
        mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025899AbaIEWOPlV4A3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Sep 2014 00:14:15 +0200
Received: by mail-yk0-f175.google.com with SMTP id 131so7387051ykp.20
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 15:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WMKjs3o0VvrVtW0lSKNsSqgvIyWM27Uam0khU+M4Ds0=;
        b=dALk1uDgzhFQClSO5ScXmuUh0auLoRXObpPW02zoRJ7V3/XpV3cMb7aVpkgERBhIgf
         3wlcS+9GaEBCc0zAPg1veXo1dvEl8PDEY1aRhQagggSUTHZhoUS4Ivlhlg4x5CaG54HL
         wZrMvTRk2f+OVLHJhabD5kn2KZKO6HLR4AJRTNKe9z6DxjVWMj9FSXd97KyyjvM3eLK4
         FoltUR5Olq1m2OyOETyRe2p5FfYliu7AYEcGHSXGc5T/xxJGKNee6nb0Md6baRfGGVDc
         F5Bh2IDh2xW4bWkiERPUaCJhd9KgGmcxT3kgJBBFISNd0vdF7Yxe1iSERBJ+Y0xvhJ6i
         KVDg==
X-Gm-Message-State: ALoCoQkG/MCMxqXb3QOROvVSOsaIKWypqXBBuKRkSL217pfg67ozTDuocEWiNtOFX0XViWfpSknr
X-Received: by 10.236.157.134 with SMTP id o6mr18750173yhk.92.1409955249612;
        Fri, 05 Sep 2014 15:14:09 -0700 (PDT)
Received: from localhost ([2602:301:77d8:1800:bd9e:fe09:e642:968])
        by mx.google.com with ESMTPSA id k67sm1295128yhq.17.2014.09.05.15.14.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 15:14:08 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v5 1/5] x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
Date:   Fri,  5 Sep 2014 15:13:52 -0700
Message-Id: <a0138ed8c709882aec06e4acc30bfa9b623b8717.1409954077.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42456
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
index 93c182a00506..39296d25708c 100644
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
