Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 17:20:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24460 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993179AbdEaPUH5iqpT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 17:20:07 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 202B5307301C4;
        Wed, 31 May 2017 16:19:58 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 May 2017 16:20:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/4] MIPS: Save static registers before sysmips
Date:   Wed, 31 May 2017 16:19:48 +0100
Message-ID: <28c2c48b282b4441ba3ec6160bc8c1e48427a6bd.1496240182.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The MIPS sysmips system call handler may return directly from the
MIPS_ATOMIC_SET case (mips_atomic_set()) to syscall_exit. This path
restores the static (callee saved) registers, however they won't have
been saved on entry to the system call.

Use the save_static_function() macro to create a __sys_sysmips wrapper
function which saves the static registers before calling sys_sysmips, so
that the correct static register state is restored by syscall_exit.

Fixes: f1e39a4a616c ("MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/scall32-o32.S | 2 +-
 arch/mips/kernel/scall64-64.S  | 2 +-
 arch/mips/kernel/scall64-n32.S | 2 +-
 arch/mips/kernel/scall64-o32.S | 2 +-
 arch/mips/kernel/syscall.c     | 6 ++++++
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 80ed68b2c95e..27c2f90eeb21 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -371,7 +371,7 @@ EXPORT(sys_call_table)
 	PTR	sys_writev
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	sys_ni_syscall			/* 4150 */
 	PTR	sys_getsid
 	PTR	sys_fdatasync
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 49765b44aa9b..65d5aeeb9bdb 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -311,7 +311,7 @@ EXPORT(sys_call_table)
 	PTR	sys_sched_getaffinity
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	sys_io_setup			/* 5200 */
 	PTR	sys_io_destroy
 	PTR	sys_io_getevents
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 90bad2d1b2d3..cbf190ef9e8a 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -302,7 +302,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_sched_getaffinity
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	compat_sys_io_setup			/* 6200 */
 	PTR	sys_io_destroy
 	PTR	compat_sys_io_getevents
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 2dd70bd104e1..c30bc520885f 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -371,7 +371,7 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_writev
 	PTR	sys_cacheflush
 	PTR	sys_cachectl
-	PTR	sys_sysmips
+	PTR	__sys_sysmips
 	PTR	sys_ni_syscall			/* 4150 */
 	PTR	sys_getsid
 	PTR	sys_fdatasync
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 9dd0788fc56d..3971220ea925 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -192,6 +192,12 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
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
-- 
git-series 0.8.10
