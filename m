Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 05:46:45 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:36803 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491184Ab0CMEq2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 05:46:28 +0100
Received: by pwj2 with SMTP id 2so1146496pwj.36
        for <multiple recipients>; Fri, 12 Mar 2010 20:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=zr893OWQ3vUwhyg6oJp4MD6FThtWm5mK31cbV664TB8=;
        b=x/ePD0JpPJZNB+qSQ7ZvlGKy0liJBS9L+7A2lv43Rg6mW7nSP8+NdwxcCIuglFQQVJ
         rL94QR1y+rfUgQB1xf+6l/QaTMTT1R14V/0wq2QNDVOf16uy6IqV0sVilRp6SHDJHko0
         tAA36xt1OZg6xxtR/h600fU4NAf07vuqTNIhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hpgOHkTAMVe7UWU4ZtP58dZI2aLOAs0TYoHtfqcbhwF85FhXgVNgMXPNeFWHERj8ki
         gsGwhBkRC8bUmdzKRhelKReINo210R126jLfDW9oLZEI/c36fcDe/eAFHBOOSoVsbKYe
         cs6dLzRhQOZL5CjaES+mA4pb4cNTHpD6pVut4=
Received: by 10.114.188.18 with SMTP id l18mr573054waf.32.1268455580133;
        Fri, 12 Mar 2010 20:46:20 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm2172318pzk.0.2010.03.12.20.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:46:19 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v3 3/3] Loongson-2F: Fixup of problems introduced by -mfix-loongson2f-jump of binutils 2.20.1
Date:   Sat, 13 Mar 2010 12:34:17 +0800
Message-Id: <169f2daa3d623fe56c5b0be30feeda10bc79a478.1268453720.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268453720.git.wuzhangjin@gmail.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268453720.git.wuzhangjin@gmail.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26227
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
