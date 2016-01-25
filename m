Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:25:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011526AbcAYWYpE00FQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:45 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8921220376;
        Mon, 25 Jan 2016 22:24:43 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A7C20392;
        Mon, 25 Jan 2016 22:24:42 +0000 (UTC)
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
Subject: [PATCH v2 02/16] sparc/compat: Provide an accurate in_compat_syscall implementation
Date:   Mon, 25 Jan 2016 14:24:16 -0800
Message-Id: <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
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
X-archive-position: 51361
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

On sparc64 compat-enabled kernels, any task can make 32-bit and
64-bit syscalls.  is_compat_task returns true in 32-bit tasks, which
does not necessarily imply that the current syscall is 32-bit.

Provide an in_compat_syscall implementation that checks whether the
current syscall is compat.

As far as I know, sparc is the only architecture on which
is_compat_task checks the compat status of the task and on which the
compat status of a syscall can differ from the compat status of the
task.  On x86, is_compat_task checks the syscall type, not the task
type.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/sparc/include/asm/compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 830502fe62b4..5467404857fc 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -307,4 +307,10 @@ static inline int is_compat_task(void)
 	return test_thread_flag(TIF_32BIT);
 }
 
+static inline bool in_compat_syscall(void)
+{
+	return pt_regs_trap_type(current_pt_regs()) == 0x110;
+}
+#define in_compat_syscall in_compat_syscall
+
 #endif /* _ASM_SPARC64_COMPAT_H */
-- 
2.5.0
