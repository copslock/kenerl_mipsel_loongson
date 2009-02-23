Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2009 17:34:33 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:46287 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20808073AbZBWRe3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Feb 2009 17:34:29 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49a2dde00001>; Mon, 23 Feb 2009 12:33:25 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 09:33:17 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 09:33:17 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n1NHXFWq018661;
	Mon, 23 Feb 2009 09:33:15 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n1NHXENh018659;
	Mon, 23 Feb 2009 09:33:14 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Finish fixing CVE-2009-0029.
Date:	Mon, 23 Feb 2009 09:33:14 -0800
Message-Id: <1235410394-18636-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 23 Feb 2009 17:33:17.0229 (UTC) FILETIME=[D007DDD0:01C995DC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The initial patch for CVE-2009-0029 lacked a couple of changes in the
syscall tables.  sys32_sysctl and sys32_ipc were renamed.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index e423ba2..7438e92 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -272,7 +272,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_munlockall
 	PTR	sys_vhangup			/* 6150 */
 	PTR	sys_pivot_root
-	PTR	sys32_sysctl
+	PTR	sys_32_sysctl
 	PTR	sys_prctl
 	PTR	compat_sys_adjtimex
 	PTR	compat_sys_setrlimit		/* 6155 */
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 6ee7997..b0fef4f 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -320,7 +320,7 @@ sys_call_table:
 	PTR	compat_sys_wait4
 	PTR	sys_swapoff			/* 4115 */
 	PTR	compat_sys_sysinfo
-	PTR	sys32_ipc
+	PTR	sys_32_ipc
 	PTR	sys_fsync
 	PTR	sys32_sigreturn
 	PTR	sys32_clone			/* 4120 */
@@ -356,7 +356,7 @@ sys_call_table:
 	PTR	sys_ni_syscall			/* 4150 */
 	PTR	sys_getsid
 	PTR	sys_fdatasync
-	PTR	sys32_sysctl
+	PTR	sys_32_sysctl
 	PTR	sys_mlock
 	PTR	sys_munlock			/* 4155 */
 	PTR	sys_mlockall
-- 
1.5.6.6
