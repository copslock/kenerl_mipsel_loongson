Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:29:02 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011572AbcAYWY6MfZwg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:58 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id CC961203C0;
        Mon, 25 Jan 2016 22:24:56 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C857203C2;
        Mon, 25 Jan 2016 22:24:56 +0000 (UTC)
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
Subject: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as in_compat_syscall()
Date:   Mon, 25 Jan 2016 14:24:28 -0800
Message-Id: <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
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
X-archive-position: 51374
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

The input compat code should work like all other compat code: for
32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
64-bit ABI.  We have a helper for that (in_compat_syscall()): just
use it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/input/input-compat.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 148f66fe3205..0f25878d5fa2 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -17,17 +17,7 @@
 
 #ifdef CONFIG_COMPAT
 
-/* Note to the author of this code: did it ever occur to
-   you why the ifdefs are needed? Think about it again. -AK */
-#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
-#  define INPUT_COMPAT_TEST is_compat_task()
-#elif defined(CONFIG_S390)
-#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
-#elif defined(CONFIG_MIPS)
-#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
-#else
-#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
-#endif
+#define INPUT_COMPAT_TEST in_compat_syscall()
 
 struct input_event_compat {
 	struct compat_timeval time;
-- 
2.5.0
