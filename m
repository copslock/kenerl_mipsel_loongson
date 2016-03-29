Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 10:50:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60530 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025271AbcCaIuNBOu6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Mar 2016 10:50:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2V8oCm9029862
        for <linux-mips@linux-mips.org>; Thu, 31 Mar 2016 10:50:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2V8oCtT029861
        for linux-mips@linux-mips.org; Thu, 31 Mar 2016 10:50:12 +0200
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 31 Mar 2016 10:50:12 +0200
Resent-Message-ID: <20160331085012.GB5086@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from vger.kernel.org ([209.132.180.67]:51703 "EHLO vger.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025439AbcC2IhMWBVHk (ORCPT <rfc822;ralf@linux-mips.org>);
        Tue, 29 Mar 2016 10:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756378AbcC2IhJ (ORCPT <rfc822;robin@linux-mips.org> + 2 others);
        Tue, 29 Mar 2016 04:37:09 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:20336 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755959AbcC2Ifz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2016 04:35:55 -0400
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id E2A2B2250D34C;
        Tue, 29 Mar 2016 09:35:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:53 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:52 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Will Drewry" <wad@chromium.org>
Subject: [PATCH v2 4/6] seccomp: Get compat syscalls from asm-generic header
Date:   Tue, 29 Mar 2016 09:35:32 +0100
Message-ID: <1459240534-8658-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Move retrieval of compat syscall numbers into inline function defined in
asm-generic header so that arches may override it.

Suggested-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 include/asm-generic/seccomp.h | 14 ++++++++++++++
 kernel/seccomp.c              |  9 +--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
index c9ccafa0d99a..e74072d23e69 100644
--- a/include/asm-generic/seccomp.h
+++ b/include/asm-generic/seccomp.h
@@ -29,4 +29,18 @@
 #define __NR_seccomp_sigreturn		__NR_rt_sigreturn
 #endif
 
+#ifdef CONFIG_COMPAT
+#ifndef get_compat_mode1_syscalls
+static inline const int *get_compat_mode1_syscalls(void)
+{
+	static const int mode1_syscalls_32[] = {
+		__NR_seccomp_read_32, __NR_seccomp_write_32,
+		__NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
+		0, /* null terminated */
+	};
+	return mode1_syscalls_32;
+}
+#endif
+#endif /* CONFIG_COMPAT */
+
 #endif /* _ASM_GENERIC_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 15a1795bbba1..b0082c14764f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -518,19 +518,12 @@ static int mode1_syscalls[] = {
 	0, /* null terminated */
 };
 
-#ifdef CONFIG_COMPAT
-static int mode1_syscalls_32[] = {
-	__NR_seccomp_read_32, __NR_seccomp_write_32, __NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
-	0, /* null terminated */
-};
-#endif
-
 static void __secure_computing_strict(int this_syscall)
 {
 	int *syscall_whitelist = mode1_syscalls;
 #ifdef CONFIG_COMPAT
 	if (is_compat_task())
-		syscall_whitelist = mode1_syscalls_32;
+		syscall_whitelist = get_compat_mode1_syscalls();
 #endif
 	do {
 		if (*syscall_whitelist == this_syscall)
-- 
2.5.0
