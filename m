Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Sep 2014 00:14:48 +0200 (CEST)
Received: from mail-yk0-f181.google.com ([209.85.160.181]:37660 "EHLO
        mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025898AbaIEWOUOkfYm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Sep 2014 00:14:20 +0200
Received: by mail-yk0-f181.google.com with SMTP id 131so7358584ykp.40
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 15:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GtN0w/F4UwQCvEEMReqhKvgZs5d/wpONl4gOxqwrvSs=;
        b=csVJ5UdcOsWqOl12ILxb/1oruka+2GirBVCNuB+t24gx9ZbeMhCNIk2B+ri31fpco3
         TGjE/ABqBDYM68sTjBG+qfc6vD8SaciDBOK1EqXm5zZhIukStMuK41tgymX+4GhvOyAx
         k/xqP2Xm51lLy0gPjBvMf9SWIYesIUoamzQrBmAvnQ0jUtGfRub7vbIGYPVxQxllOWl5
         PTYiRfYz7CQ/IwSj1IVkjTDhFLfK5HQ2GgnWQv1Pdxehh1vgTmltnZpRYBWyn9W6ezoB
         8DxixQQfMKENs95F5n1kw76vYjMiR47XzVh7zVdcTUJ2/rvs6UzVczRHma7V9q4OCuhr
         DOvg==
X-Gm-Message-State: ALoCoQnCE6VRVQH2ISc0X3jGdciGduPwscXP+nnmHuOX8Iubd2rCDdqSWgKD1eioDtjspfnNYrL3
X-Received: by 10.236.26.196 with SMTP id c44mr18200485yha.15.1409955254268;
        Fri, 05 Sep 2014 15:14:14 -0700 (PDT)
Received: from localhost ([2602:301:77d8:1800:bd9e:fe09:e642:968])
        by mx.google.com with ESMTPSA id r77sm1289167yhr.28.2014.09.05.15.14.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 15:14:13 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v5 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Date:   Fri,  5 Sep 2014 15:13:53 -0700
Message-Id: <0b13e0e24ec0307d67ab7a23b58764f6b1270116.1409954077.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42457
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

The RCU context tracking code requires that arch code call
user_exit() on any entry into kernel code if TIF_NOHZ is set.  This
patch adds a check for TIF_NOHZ and a comment to the syscall entry
tracing code.

The main purpose of this patch is to make the code easier to follow:
one can read the body of user_exit and of every function it calls
without finding any explanation of why it's called for traced
syscalls but not for untraced syscalls.  This makes it clear when
user_exit() is necessary.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 39296d25708c..bbf338a04a5d 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1449,7 +1449,12 @@ long syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	user_exit();
+	/*
+	 * If TIF_NOHZ is set, we are required to call user_exit() before
+	 * doing anything that could touch RCU.
+	 */
+	if (test_thread_flag(TIF_NOHZ))
+		user_exit();
 
 	/*
 	 * If we stepped into a sysenter/syscall insn, it trapped in
-- 
1.9.3
