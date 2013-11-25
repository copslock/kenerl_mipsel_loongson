Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2013 00:21:25 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:60809 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831301Ab3KYXVXE1Kz9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Nov 2013 00:21:23 +0100
Received: by mail-pd0-f171.google.com with SMTP id z10so6516577pdj.16
        for <multiple recipients>; Mon, 25 Nov 2013 15:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=KkHBdTzZ94rFQSwLEiksbKhKiqI4SRvY7Q79Vn+SyM4=;
        b=DULFtrhNI1kY+48FV1rVtNcBlvvZskPzwbi6/BCU7enLIG56aOpbHb9Se5uz2iNUuZ
         QgDwmOfBn3MZowP9lsIDEHgpaGs9akhbDYHkvC1HgJiPC9R2mD+Y2PmBwKn0+Zw8LkWJ
         4TOF78aJ4BGCwjrh7M5CvqrPSAUNmb+U2M1JJiLQ/SZiJlEpyQ0ur0Os7uxPO3xsq7Ws
         Nt60pej+Iy0uJpbq9x66dOB7Skcyt1T+GpItFNoYHlhc9Ilyg2STvZsLJU50Uavn/ICJ
         xI7wzoMxCOSaEtG+H3r9dWpcj7NdVqWgUEgZhk3VWSTVZqbqYtER7/JmjbL4NjBUlEOz
         Yepg==
X-Received: by 10.69.19.225 with SMTP id gx1mr20830898pbd.62.1385421676100;
        Mon, 25 Nov 2013 15:21:16 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id oj6sm86001591pab.9.2013.11.25.15.21.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 15:21:15 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mips: Fix build error seen in some configurations
Date:   Mon, 25 Nov 2013 15:21:00 -0800
Message-Id: <1385421660-5608-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.7.9.7
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

The following build error is seen if CONFIG_32BIT is undefined,
CONFIG_64BIT is defined, and CONFIG_MIPS32_O32 is undefined.

asm/syscall.h: In function 'mips_get_syscall_arg':
arch/mips/include/asm/syscall.h:32:16: error: unused variable 'usp' [-Werror=unused-variable]
cc1: all warnings being treated as errors

Fixes: c0ff3c53d4f9 ('MIPS: Enable HAVE_ARCH_TRACEHOOK')
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/include/asm/syscall.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 81c8913..33e8dbf 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -29,7 +29,7 @@ static inline long syscall_get_nr(struct task_struct *task,
 static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
 	struct task_struct *task, struct pt_regs *regs, unsigned int n)
 {
-	unsigned long usp = regs->regs[29];
+	unsigned long usp __maybe_unused = regs->regs[29];
 
 	switch (n) {
 	case 0: case 1: case 2: case 3:
-- 
1.7.9.7
