Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:53:53 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52234 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992533AbdJIMx3imQ5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:53:29 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQl-0004v1-V0; Mon, 09 Oct 2017 13:45:12 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQP-0001zj-Lg; Mon, 09 Oct 2017 13:44:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "James Hogan" <james.hogan@imgtec.com>
Date:   Mon, 09 Oct 2017 13:44:24 +0100
Message-ID: <lsq.1507553064.738780694@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 058/192] MIPS: Save static registers before sysmips
In-Reply-To: <lsq.1507553063.449494954@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60337
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

3.16.49-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 49955d84cd9ccdca5a16a495e448e1a06fad9e49 upstream.

The MIPS sysmips system call handler may return directly from the
MIPS_ATOMIC_SET case (mips_atomic_set()) to syscall_exit. This path
restores the static (callee saved) registers, however they won't have
been saved on entry to the system call.

Use the save_static_function() macro to create a __sys_sysmips wrapper
function which saves the static registers before calling sys_sysmips, so
that the correct static register state is restored by syscall_exit.

Fixes: f1e39a4a616c ("MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16149/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/scall32-o32.S | 2 +-
 arch/mips/kernel/scall64-64.S  | 2 +-
 arch/mips/kernel/scall64-n32.S | 2 +-
 arch/mips/kernel/scall64-o32.S | 2 +-
 arch/mips/kernel/syscall.c     | 6 ++++++
 5 files changed, 10 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -363,7 +363,7 @@ EXPORT(sys_call_table)
 	PTR	sys_writev
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	sys_ni_syscall			/* 4150 */
 	PTR	sys_getsid
 	PTR	sys_fdatasync
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -318,7 +318,7 @@ EXPORT(sys_call_table)
 	PTR	sys_sched_getaffinity
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	sys_io_setup			/* 5200 */
 	PTR	sys_io_destroy
 	PTR	sys_io_getevents
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -307,7 +307,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_sched_getaffinity
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	compat_sys_io_setup			/* 6200 */
 	PTR	sys_io_destroy
 	PTR	compat_sys_io_getevents
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -358,7 +358,7 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_writev
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	sys_ni_syscall			/* 4150 */
 	PTR	sys_getsid
 	PTR	sys_fdatasync
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -197,6 +197,12 @@ static inline int mips_atomic_set(unsign
 	unreachable();
 }
 
+/*
+ * mips_atomic_set() normally returns directly via syscall_exit potentially
+ * clobbering static registers, so be sure to preserve them.
+ */
+save_static_function(sys_sysmips);
+
 SYSCALL_DEFINE3(sysmips, long, cmd, long, arg1, long, arg2)
 {
 	switch (cmd) {
