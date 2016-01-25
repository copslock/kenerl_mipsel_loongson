Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:26:05 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37201 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011538AbcAYWYtCC3GI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:49 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id D6FFB20395;
        Mon, 25 Jan 2016 22:24:45 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B37C2039C;
        Mon, 25 Jan 2016 22:24:45 +0000 (UTC)
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v2 04/16] seccomp: Check in_compat_syscall, not is_compat_task, in strict mode
Date:   Mon, 25 Jan 2016 14:24:18 -0800
Message-Id: <9cc3588071d4e31b035e0cf1d09483067df38823.1453759363.git.luto@kernel.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <luto@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@kernel.org
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

Seccomp wants to know the syscall bitness, not the caller task
bitness, when it selects the syscall whitelist.

As far as I know, this makes no difference on any architecture, so
it's not a security problem.  (It generates identical code
everywhere except sparc, and, on sparc, the syscall numbering is the
same for both ABIs.)

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 580ac2d4024f..26858fa43a60 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -395,7 +395,7 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	struct seccomp_filter *filter = ERR_PTR(-EFAULT);
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	if (in_compat_syscall()) {
 		struct compat_sock_fprog fprog32;
 		if (copy_from_user(&fprog32, user_filter, sizeof(fprog32)))
 			goto out;
@@ -529,7 +529,7 @@ static void __secure_computing_strict(int this_syscall)
 {
 	int *syscall_whitelist = mode1_syscalls;
 #ifdef CONFIG_COMPAT
-	if (is_compat_task())
+	if (in_compat_syscall())
 		syscall_whitelist = mode1_syscalls_32;
 #endif
 	do {
-- 
2.5.0
