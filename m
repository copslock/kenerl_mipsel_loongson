Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:26:40 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37263 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011548AbcAYWYt1W40w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:49 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0E1E9200BE;
        Mon, 25 Jan 2016 22:24:48 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9EF20303;
        Mon, 25 Jan 2016 22:24:47 +0000 (UTC)
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
Subject: [PATCH v2 06/16] auditsc: For seccomp events, log syscall compat state using in_compat_syscall
Date:   Mon, 25 Jan 2016 14:24:20 -0800
Message-Id: <2c5ac9f83ad077d1f66c9e6469eb73274703f6d1.1453759363.git.luto@kernel.org>
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
X-archive-position: 51366
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

Except on SPARC, this is what the code always did.  SPARC compat
seccomp was buggy, although the impact of the bug was limited
because SPARC 32-bit and 64-bit syscall numbers are the same.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/auditsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 195ffaee50b9..7d0e3cf8abe1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2412,8 +2412,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
-			 signr, syscall_get_arch(), syscall, is_compat_task(),
-			 KSTK_EIP(current), code);
+			 signr, syscall_get_arch(), syscall,
+			 in_compat_syscall(), KSTK_EIP(current), code);
 	audit_log_end(ab);
 }
 
-- 
2.5.0
