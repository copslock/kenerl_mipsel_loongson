Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Aug 2016 22:45:06 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35393 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992509AbcHNUo7AKw9r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Aug 2016 22:44:59 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F30BC78D;
        Sun, 14 Aug 2016 20:44:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
        David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 15/41] KEYS: 64-bit MIPS needs to use compat_sys_keyctl for 32-bit userspace
Date:   Sun, 14 Aug 2016 22:38:41 +0200
Message-Id: <20160814202532.813199627@linuxfoundation.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160814202531.818402015@linuxfoundation.org>
References: <20160814202531.818402015@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.7-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -348,7 +348,7 @@ EXPORT(sysn32_call_table)
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
@@ -504,7 +504,7 @@ EXPORT(sys32_call_table)
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key			/* 4280 */
 	PTR	sys_request_key
-	PTR	sys_keyctl
+	PTR	compat_sys_keyctl
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch		/* 4285 */
