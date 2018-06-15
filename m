Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 15:24:41 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:34884 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992735AbeFONYev1wgo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 15:24:34 +0200
Received: from ala-blade48.wrs.com (ala-blade48.wrs.com [147.11.105.68])
        by mail.windriver.com (8.15.2/8.15.1) with SMTP id w5FDOOBX021295;
        Fri, 15 Jun 2018 06:24:25 -0700 (PDT)
Received: by ala-blade48.wrs.com (sSMTP sendmail emulation); Fri, 15 Jun 2018 06:24:24 -0700
From:   He Zhe <zhe.he@windriver.com>
To:     ralf@linux-mips.org, jhogan@kernel.org, ebiederm@xmission.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Fix build error by disabling attribute-alias warning
Date:   Fri, 15 Jun 2018 06:24:21 -0700
Message-Id: <20180615132421.2693-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <zhe.he@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhe.he@windriver.com
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

This patch fixes the following error caused by building arch/mips with
GCC 8.1.0.

In file included from arch/mips/kernel/signal32.c:15:
include/linux/syscalls.h:233:18: error: 'sys_32_sigaction' alias between functions of incompatible types 'long int(long int,  const struct compat_sigaction *, struct compat_sigaction *)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/mips/kernel/signal32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c4db910a8794..95cb406e220d 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -35,6 +35,9 @@ asmlinkage int sys32_sigsuspend(compat_sigset_t __user *uset)
 	return compat_sys_rt_sigsuspend(uset, sizeof(compat_sigset_t));
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpragmas"
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *, act,
 	struct compat_sigaction __user *, oact)
 {
@@ -76,3 +79,4 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
 
 	return ret;
 }
+#pragma GCC diagnostic pop
-- 
2.11.0
