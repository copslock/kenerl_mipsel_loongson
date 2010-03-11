Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:13:30 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:44214 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491149Ab0CKDMN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:12:13 +0100
Received: by mail-bw0-f215.google.com with SMTP id 7so6743579bwz.24
        for <multiple recipients>; Wed, 10 Mar 2010 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=zr893OWQ3vUwhyg6oJp4MD6FThtWm5mK31cbV664TB8=;
        b=GTyKF3r4cyVFaMyu1zZlWDtJqhUyWeaomeTRb/NDCxRXkvYq9tt1ipXQLoTWabVYHi
         wX7hwVrcv9rtczLttDq/a5L90uk/d7JqiXvdVjd40dD+kv7TDNWO1NXqo1wkl6zMjFMp
         VKPRR8RANejuKbPzaMA11XmkBOuPH8pBW8pZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LcFdt2zig7Ql34mhXaSEoL+4ywF09rNKz+/Z4bAlMYO8urO14JmJZLB7qkYWDLfex1
         9UG++uU3FwOViwBf8kFmkGwqTLQ0t3NotjYA1OKTKVbUwoQAAPr0XZe/3CoqNPYybkA6
         J8ZqVNHfUd2aF5eDB2CveEKZLi2fJUpjwHNhU=
Received: by 10.204.21.197 with SMTP id k5mr2957704bkb.28.1268277131942;
        Wed, 10 Mar 2010 19:12:11 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id g18sm30688020bkw.13.2010.03.10.19.12.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:12:10 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Sergei Shtylyov <sshtylyov@mvista.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2 3/3] Loongson-2F: Fixup of problems introduced by -mfix-loongson2f-jump of binutils 2.20.1
Date:   Thu, 11 Mar 2010 11:05:04 +0800
Message-Id: <1bd51326ffa900d034ee81825e803e3bdc46fdaf.1268276417.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268276417.git.wuzhangjin@gmail.com>
References: <cover.1268276417.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268276417.git.wuzhangjin@gmail.com>
References: <cover.1268276417.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The -mfix-loongson2f-jump option provided by the binutils 2.20.1 have fixed the
Out-of-order Issue of Loongson-2F described in Chapter 15 of "Loongson2F User
Manual"[1,2], but introduced some problems.

The option changes all of the jumping target to "addr & 0xcfffffff" through the
at($1) register, but for the REBOOT address of loongson-2F: 0xbfc00000, this is
totally wrong, so, this patch try to avoid the problem via telling the
assembler not to use at($1) register.

[1] Loongson2F User Manual(Chinese Version)
http://www.loongson.cn/uploadfile/file/200808211
[2] English Version of Chapter 15:
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Reported-and-tested-by: Liu Shiwei <liushiwei@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/reset.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 4bd9c18..dc311f2 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -21,8 +21,17 @@ static void loongson_restart(char *command)
 	/* do preparation for reboot */
 	mach_prepare_reboot();
 
-	/* reboot via jumping to boot base address */
+	/* reboot via jumping to boot base address
+	 *
+	 * ".set noat" and ".set at" are used to ensure the address not break
+	 * by the -mfix-loongson2f-jump option provided by binutils 2.20.1 (or
+	 * higher version) which try to change the jumping address to "addr &
+	 * 0xcfffffff" via the at($1) register, this is totally wrong for
+	 * 0xbfc00000 (LOONGSON_BOOT_BASE).
+	 */
+	__asm__ __volatile__(".set noat\n");
 	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
+	__asm__ __volatile__(".set at\n");
 }
 
 static void loongson_poweroff(void)
-- 
1.7.0.1
