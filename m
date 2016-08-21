Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 17:35:46 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55854 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992466AbcHUPfXMAl53 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2016 17:35:23 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u7LFWmpf013413;
        Sun, 21 Aug 2016 17:32:48 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 154/180] KEYS: 64-bit MIPS needs to use compat_sys_keyctl for 32-bit userspace
Date:   Sun, 21 Aug 2016 17:31:24 +0200
Message-Id: <1471793510-13022-155-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1471793510-13022-1-git-send-email-w@1wt.eu>
References: <1471793510-13022-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: David Howells <dhowells@redhat.com>

commit 20f06ed9f61a185c6dabd662c310bed6189470df upstream.

MIPS64 needs to use compat_sys_keyctl for 32-bit userspace rather than
calling sys_keyctl.  The latter will work in a lot of cases, thereby hiding
the issue.

Reported-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: stable@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: keyrings@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13832/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/scall64-n32.S | 2 +-
 arch/mips/kernel/scall64-o32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index cab1507..b657fbe 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -349,7 +349,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key
 	PTR	sys_request_key
-	PTR	sys_keyctl			/* 6245 */
+	PTR	compat_sys_keyctl		/* 6245 */
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 37605dc..bf56d7e 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -474,7 +474,7 @@ sys_call_table:
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key			/* 4280 */
 	PTR	sys_request_key
-	PTR	sys_keyctl
+	PTR	compat_sys_keyctl
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch		/* 4285 */
-- 
2.8.0.rc2.1.gbe9624a
