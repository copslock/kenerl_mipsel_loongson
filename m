Return-Path: <SRS0=EWWg=Y7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B41C5DF60
	for <linux-mips@archiver.kernel.org>; Thu,  7 Nov 2019 04:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C260F2178F
	for <linux-mips@archiver.kernel.org>; Thu,  7 Nov 2019 04:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rI0u+VLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfKGEBy (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:01:54 -0500
Received: from forward103j.mail.yandex.net ([5.45.198.246]:40733 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbfKGEBy (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Nov 2019 23:01:54 -0500
Received: from mxback27g.mail.yandex.net (mxback27g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:327])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 411D06740311;
        Thu,  7 Nov 2019 07:01:50 +0300 (MSK)
Received: from sas8-93a22d3a76f4.qloud-c.yandex.net (sas8-93a22d3a76f4.qloud-c.yandex.net [2a02:6b8:c1b:2988:0:640:93a2:2d3a])
        by mxback27g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id lTsS6ygbv1-1nDWkCoa;
        Thu, 07 Nov 2019 07:01:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1573099310;
        bh=fu89WWaYiOMgppSvP1h5lqk+OY+A3oYlhfnJ05NZOEE=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=rI0u+VLGQuY0J69Bj+UhX9+/aLeX5CBQj4H3XSm5Ww84c/aZ2GyQX0B4ua2oNQyp6
         bBIgKO0W+isu7Rti7q/RbNVj43/R2wjuUuY9Ld1Hb8hcF9MyjYM9MokkcgmFUOsdE4
         wKHOKH+AnlRh4vrEbLDKLcMnAQisN/2csU4XNZLM=
Authentication-Results: mxback27g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by sas8-93a22d3a76f4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Z8DeRIVREY-1jVmhNeC;
        Thu, 07 Nov 2019 07:01:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     paulburton@kernel.org, chenhe@lemote.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/5] MIPS: Drop pmon.h
Date:   Thu,  7 Nov 2019 12:01:14 +0800
Message-Id: <20191107040118.10685-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107040118.10685-1-jiaxun.yang@flygoat.com>
References: <20191107040118.10685-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

There is no code still using pmon callvectors.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/pmon.h | 46 ------------------------------------
 arch/mips/kernel/smp-bmips.c |  1 -
 2 files changed, 47 deletions(-)
 delete mode 100644 arch/mips/include/asm/pmon.h

diff --git a/arch/mips/include/asm/pmon.h b/arch/mips/include/asm/pmon.h
deleted file mode 100644
index 6ad519189ce2..000000000000
--- a/arch/mips/include/asm/pmon.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004 by Ralf Baechle
- *
- * The cpustart method is a PMC-Sierra's function to start the secondary CPU.
- * Stock PMON 2000 has the smpfork, semlock and semunlock methods instead.
- */
-#ifndef _ASM_PMON_H
-#define _ASM_PMON_H
-
-struct callvectors {
-	int	(*open) (char*, int, int);
-	int	(*close) (int);
-	int	(*read) (int, void*, int);
-	int	(*write) (int, void*, int);
-	off_t	(*lseek) (int, off_t, int);
-	int	(*printf) (const char*, ...);
-	void	(*cacheflush) (void);
-	char*	(*gets) (char*);
-	union {
-		int	(*smpfork) (unsigned long cp, char *sp);
-		int	(*cpustart) (long, void (*)(void), void *, long);
-	} _s;
-	int	(*semlock) (int sem);
-	void	(*semunlock) (int sem);
-};
-
-extern struct callvectors *debug_vectors;
-
-#define pmon_open(name, flags, mode)	debug_vectors->open(name, flage, mode)
-#define pmon_close(fd)			debug_vectors->close(fd)
-#define pmon_read(fd, buf, count)	debug_vectors->read(fd, buf, count)
-#define pmon_write(fd, buf, count)	debug_vectors->write(fd, buf, count)
-#define pmon_lseek(fd, off, whence)	debug_vectors->lseek(fd, off, whence)
-#define pmon_printf(fmt...)		debug_vectors->printf(fmt)
-#define pmon_cacheflush()		debug_vectors->cacheflush()
-#define pmon_gets(s)			debug_vectors->gets(s)
-#define pmon_cpustart(n, f, sp, gp)	debug_vectors->_s.cpustart(n, f, sp, gp)
-#define pmon_smpfork(cp, sp)		debug_vectors->_s.smpfork(cp, sp)
-#define pmon_semlock(sem)		debug_vectors->semlock(sem)
-#define pmon_semunlock(sem)		debug_vectors->semunlock(sem)
-
-#endif /* _ASM_PMON_H */
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 712c15de6ab9..9058e9dcf080 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -31,7 +31,6 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/bootinfo.h>
-#include <asm/pmon.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/mipsregs.h>
-- 
2.20.1

