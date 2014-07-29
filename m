Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 05:59:15 +0200 (CEST)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37688 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861987AbaG2DivOAvvR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 05:38:51 +0200
Received: by mail-pd0-f170.google.com with SMTP id g10so10946773pdj.15
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 20:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zStVeuj7o/rf0vJ1C6QRL5Y8ra7ACBFZyMyO3pa8i38=;
        b=XYxMy9EDylamTiIa3to7exSJBEpkZHDvfWWPjkuIBFhqNvHcYjIySuZEIBLQpK2jsk
         ogb9zDKxmcjOQV3ghodvmwcBfUtZj2TpMihVjqfHi5wEBmE5jopxNV7Vu8KfuxUk1Wbk
         mHEmcpTVL3bDL9wo192ygTRgZJCI7FFY17IzMDyOBAj/zY083JPHdvbxxiIrcVVwpCob
         juOFJv3hT0kCNLJouXe2wCO5l0MrqQzBXT/otPwnwI+7Pzs6O3/duy6JFhkkLmwGVXBT
         GHTvj/u2IvMDvBv363gTl6IZQHMLJtzaA84WGmbtzFXjPqN0O2hT4Sitv7edAPvuefEE
         tTZA==
X-Gm-Message-State: ALoCoQmKAq/wygbicbmyR4Wsemc6s1RnpcgFjQORl+MillxYbKrK+iOubSPBoD414jgbJsQNL/9U
X-Received: by 10.66.191.9 with SMTP id gu9mr42734294pac.27.1406605124976;
        Mon, 28 Jul 2014 20:38:44 -0700 (PDT)
Received: from localhost ([2001:5a8:4:83c0:fd15:6cb4:fa7d:1e89])
        by mx.google.com with ESMTPSA id c17sm26772083pdm.33.2014.07.28.20.38.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 20:38:43 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v4 1/5] x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
Date:   Mon, 28 Jul 2014 20:38:28 -0700
Message-Id: <ed503c590487ac761b9bf39dac4fe26c64022962.1406604806.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41752
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
