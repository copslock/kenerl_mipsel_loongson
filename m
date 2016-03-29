Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 10:50:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60532 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025299AbcCaIuRFKgMq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Mar 2016 10:50:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2V8oG0x029867
        for <linux-mips@linux-mips.org>; Thu, 31 Mar 2016 10:50:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2V8oGsC029866
        for linux-mips@linux-mips.org; Thu, 31 Mar 2016 10:50:16 +0200
Resent-From: ralf@linux-mips.org
Resent-Date: Thu, 31 Mar 2016 10:50:16 +0200
Resent-Message-ID: <20160331085016.GC5086@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from vger.kernel.org ([209.132.180.67]:49643 "EHLO vger.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025439AbcC2IgKm8Sak (ORCPT <rfc822;ralf@linux-mips.org>);
        Tue, 29 Mar 2016 10:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756310AbcC2If7 (ORCPT <rfc822;robin@linux-mips.org> + 2 others);
        Tue, 29 Mar 2016 04:35:59 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:6190 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756291AbcC2If5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2016 04:35:57 -0400
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id B01035AFAFD85;
        Tue, 29 Mar 2016 09:35:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:55 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:54 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Will Drewry <wad@chromium.org>, <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Kees Cook" <keescook@chromium.org>
Subject: [PATCH v2 6/6] secomp: Constify mode1 syscall whitelist
Date:   Tue, 29 Mar 2016 09:35:34 +0100
Message-ID: <1459240534-8658-7-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 52805
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

These values are constant and should be marked as such.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b0082c14764f..9243d686d11a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -513,14 +513,14 @@ static void seccomp_send_sigsys(int syscall, int reason)
  * To be fully secure this must be combined with rlimit
  * to limit the stack allocations too.
  */
-static int mode1_syscalls[] = {
+static const int mode1_syscalls[] = {
 	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
 	0, /* null terminated */
 };
 
 static void __secure_computing_strict(int this_syscall)
 {
-	int *syscall_whitelist = mode1_syscalls;
+	const int *syscall_whitelist = mode1_syscalls;
 #ifdef CONFIG_COMPAT
 	if (is_compat_task())
 		syscall_whitelist = get_compat_mode1_syscalls();
-- 
2.5.0
