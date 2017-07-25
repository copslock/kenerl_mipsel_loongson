Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:20:42 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993935AbdGYTRfyCrWn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:17:35 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E33D3AA6;
        Tue, 25 Jul 2017 19:17:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 41/60] MIPS: Save static registers before sysmips
Date:   Tue, 25 Jul 2017 12:16:32 -0700
Message-Id: <20170725191619.911812022@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725191614.043749784@linuxfoundation.org>
References: <20170725191614.043749784@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59238
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/scall32-o32.S |    2 +-
 arch/mips/kernel/scall64-64.S  |    2 +-
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 arch/mips/kernel/syscall.c     |    6 ++++++
 5 files changed, 10 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -361,7 +361,7 @@ EXPORT(sys_call_table)
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
@@ -200,6 +200,12 @@ static inline int mips_atomic_set(unsign
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
