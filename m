Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 09:13:38 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992536AbcHSHMAr0ZaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2016 09:12:00 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86AFBABDC;
        Fri, 19 Aug 2016 07:12:00 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-mips@linux-mips.org, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 058/100] KEYS: 64-bit MIPS needs to use compat_sys_keyctl for 32-bit userspace
Date:   Fri, 19 Aug 2016 09:10:57 +0200
Message-Id: <07e92f8086d83a7c4de513a3022185b12d6788ad.1471589700.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <bc76af4e1436406a1f53da243e76bd10327691f2.1471589700.git.jslaby@suse.cz>
References: <bc76af4e1436406a1f53da243e76bd10327691f2.1471589700.git.jslaby@suse.cz>
In-Reply-To: <cover.1471589700.git.jslaby@suse.cz>
References: <cover.1471589700.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 20f06ed9f61a185c6dabd662c310bed6189470df upstream.

MIPS64 needs to use compat_sys_keyctl for 32-bit userspace rather than
calling sys_keyctl.  The latter will work in a lot of cases, thereby hiding
the issue.

Reported-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: keyrings@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13832/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/scall64-n32.S | 2 +-
 arch/mips/kernel/scall64-o32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index cab150789c8d..b657fbefc466 100644
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
index 37605dc8eef7..bf56d7e271dd 100644
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
2.9.3
