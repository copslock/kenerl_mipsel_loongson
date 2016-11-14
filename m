Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:05:38 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37789 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992241AbcKNCEUjF-RO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:20 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d7-0005pS-Dg; Mon, 14 Nov 2016 02:04:17 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d7-0000Rj-6W; Mon, 14 Nov 2016 02:04:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Howells" <dhowells@redhat.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Stephan Mueller" <smueller@chronox.de>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.474591754@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 119/346] KEYS: 64-bit MIPS needs to use
 compat_sys_keyctl for 32-bit userspace
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/scall64-n32.S | 2 +-
 arch/mips/kernel/scall64-o32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -353,7 +353,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key
 	PTR	sys_request_key
-	PTR	sys_keyctl			/* 6245 */
+	PTR	compat_sys_keyctl		/* 6245 */
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -491,7 +491,7 @@ EXPORT(sys32_call_table)
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key			/* 4280 */
 	PTR	sys_request_key
-	PTR	sys_keyctl
+	PTR	compat_sys_keyctl
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch		/* 4285 */
