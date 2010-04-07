Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:21:10 +0200 (CEST)
Received: from mail-iw0-f179.google.com ([209.85.223.179]:53313 "EHLO
        mail-iw0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492147Ab0DGNUE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:20:04 +0200
Received: by iwn9 with SMTP id 9so512980iwn.0
        for <multiple recipients>; Wed, 07 Apr 2010 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=VYUmR+Y4s9bws+/rs2pv3MfiLu/dxIYtiWM+i75a2WU=;
        b=Lmci2zfECtcBBvcAzfUXbBGtFoFRIJFmrQAvFUumxjIuDRqmGzIJWtYfy74I7rYiw8
         OFCixeGswaq+VLHsrEb7G/ciyLsOvuPzrydmBD0gPKmlVlfAVHNJ90sYHtUECXEOG4Id
         mpiiermnMqPe/uGzzlcH/CcHywrWwO/61bYWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F24jMXUTBWosYafi6wNfLzOtAMvi1PUOygwIrF3Ngbx45imzue2TBbe05BTn0vcwGB
         18QzbWsoP45sq/eqp6GdplOzNhfzvG+3WT4kzu5LGlETA3CqUqXkZgX1cn3rJtpI7sjl
         uoe9J1ldAu7B67LuY+SHWvjeTbwHnqOdM4xXE=
Received: by 10.142.119.20 with SMTP id r20mr3583447wfc.15.1270646398068;
        Wed, 07 Apr 2010 06:19:58 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm3753168pzk.15.2010.04.07.06.19.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:19:57 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4 4/4] Loongson-2F: Fixup of problems introduced by -mfix-loongson2f-jump
Date:   Wed,  7 Apr 2010 21:11:54 +0800
Message-Id: <6fe942386f96dd1ff085e77494100a38ea02b87c.1270645413.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from old revisions:

  o Incorporated with the feedbacks from Ralf Baechle and used the
  option CONFIG_CPU_JUMP_WORKAROUNDS introduced by "Loongson: Add
  CPU_LOONGSON2F_WORKAROUNDS".

The -mfix-loongson2f-jump option provided by the latest binutils(in the cvs
repository) have fixed the Out-of-order Issue of Loongson-2F described in
Chapter 15 of "Loongson2F User Manual"[1,2], but introduced some problems.

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
 arch/mips/loongson/common/reset.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 4bd9c18..9e10d62 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -16,13 +16,31 @@
 
 #include <loongson.h>
 
+static inline void loongson_reboot(void)
+{
+#ifndef CONFIG_CPU_JUMP_WORKAROUNDS
+	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
+#else
+	void (*func)(void);
+
+	func = (void *)ioremap_nocache(LOONGSON_BOOT_BASE, 4);
+
+	__asm__ __volatile__(
+	"       .set    noat                                            \n"
+	"       jr      %[func]                                         \n"
+	"       .set    at                                              \n"
+	: /* No outputs */
+	: [func] "r" (func));
+#endif
+}
+
 static void loongson_restart(char *command)
 {
 	/* do preparation for reboot */
 	mach_prepare_reboot();
 
 	/* reboot via jumping to boot base address */
-	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
+	loongson_reboot();
 }
 
 static void loongson_poweroff(void)
-- 
1.7.0.1
