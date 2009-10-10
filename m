Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 13:20:15 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:44947 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492657AbZJJLUI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2009 13:20:08 +0200
Received: by pxi17 with SMTP id 17so9321149pxi.21
        for <multiple recipients>; Sat, 10 Oct 2009 04:20:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=glVArUxOWiJHO4CF/8VmhnXzrZWHEaXbgjdoacQmKv8=;
        b=Gwiqx0d6HqLQ1r8j3NiP/xdjY8ifA7iSXD9L8IvdVfLpcc58TktX8WatqObGcfSO6B
         gaL8oZXdRuJKEjvNaRxSXyniXI7w5ueNSoZNABO5vL/zNJNP3Oee/p0O0H+M+TWfvj5i
         +Fd/4mGmx76VJ4uG45HH88Ge850Q5sPSUnXDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rPoTlwKexE1wMk6hChgesP0iUnzhPgt8xkLPt63k++DTWwvsQZk2DmZ0pVoCL0kGlM
         vQwTxis1K7Ub7f/+lcPSak+NOaZ9NVKpW9pzKQC4qq/WarzRGLlenjnh1bovtuVSMq6n
         baQDNQAVHpL5W2B9+8ft+62d42qX+n0xCsv9s=
Received: by 10.115.38.40 with SMTP id q40mr1940830waj.95.1255173599925;
        Sat, 10 Oct 2009 04:19:59 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm254165pzk.10.2009.10.10.04.19.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 04:19:59 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Chen Jie <chenj@lemote.com>, Hu Hongbing <huhb@lemote.com>
Subject: [PATCH] MIPS: Fix the syscall lookup_dcookie in scall64-o32.S
Date:	Sat, 10 Oct 2009 19:19:49 +0800
Message-Id: <1255173589-20394-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

When the kernel is 64bit, the application in O32 ABI will pass 4
arguments to syscall lookup_dcookie, but the implementation can only
handle 3 arguments. This patch will fixes it.

Signed-off-by: Chen Jie <chenj@lemote.com>
Signed-off-by: Hu Hongbing <huhb@lemote.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/linux32.c     |    6 ++++++
 arch/mips/kernel/scall64-o32.S |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 6242bc6..9dc09be 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -428,3 +428,9 @@ _sys32_clone(nabi_no_regargs struct pt_regs regs)
 	return do_fork(clone_flags, newsp, &regs, 0,
 	               parent_tidptr, child_tidptr);
 }
+
+asmlinkage long sys32_lookup_dcookie(u32 dcookie_a0, u32 dcookie_a1,
+		char __user *buf, size_t len)
+{
+       return sys_lookup_dcookie(merge_64(dcookie_a0, dcookie_a1), buf, len);
+}
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 9bbf977..ba0dde6 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -450,7 +450,7 @@ sys_call_table:
 	PTR	sys_io_submit
 	PTR	sys_io_cancel			/* 4245 */
 	PTR	sys_exit_group
-	PTR	sys_lookup_dcookie
+	PTR	sys32_lookup_dcookie
 	PTR	sys_epoll_create
 	PTR	sys_epoll_ctl
 	PTR	sys_epoll_wait			/* 4250 */
-- 
1.6.2.1
