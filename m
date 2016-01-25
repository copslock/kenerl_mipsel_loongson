Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:27:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37297 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011552AbcAYWYv2QFIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:51 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 176CF20160;
        Mon, 25 Jan 2016 22:24:50 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D9A220274;
        Mon, 25 Jan 2016 22:24:49 +0000 (UTC)
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
Subject: [PATCH v2 08/16] ext4: In ext4_dir_llseek, check syscall bitness directly
Date:   Mon, 25 Jan 2016 14:24:22 -0800
Message-Id: <8946a5499b6b9f2837fed067885b595ea52aafdf.1453759363.git.luto@kernel.org>
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
X-archive-position: 51368
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

ext4 treats directory offsets differently for 32-bit and 64-bit
callers.  Check the caller type using in_compat_syscall, not
is_compat_task.  This changes behavior on SPARC slightly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/ext4/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 1d1bca74f844..6395456edea6 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -276,7 +276,7 @@ errout:
 static inline int is_32bit_api(void)
 {
 #ifdef CONFIG_COMPAT
-	return is_compat_task();
+	return in_compat_syscall();
 #else
 	return (BITS_PER_LONG == 32);
 #endif
-- 
2.5.0
