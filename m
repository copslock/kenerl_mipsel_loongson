Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 14:01:13 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:47549 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493015AbZLRNA4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 14:00:56 +0100
Received: by mail-yw0-f203.google.com with SMTP id 41so8910964ywh.0
        for <multiple recipients>; Fri, 18 Dec 2009 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ELZP8rpIkL/49NAEKn2TBCb8ahCssVPdtlqXVz4jzog=;
        b=fgLl9bJXIJt2o6SqRDoMgNq0dsTmlhw/fMZlz5jNQwCIxTr1OrF8DtIGds0Z/Emzyd
         GS+keyUMIcKkukfxh/kgklGlPeTLVy+Lq8rfFMHKcitgWeSUQKq9+o04Gat3gv/4JKDo
         JlaKfBSBl99dxHnGmx3L/X9NynoMuT8gvERd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Ydb/4yF+oMGdebkY2L+I5WxkGTmZjGNWQAbieNwAgTV9fm8iJ6xrmZtFYb2ttUOx+W
         4VcKjJuvxX598sea0HGHAOQ63jXxRQZMb5orPqaDRSN2OJmDQDZMrhyk3UAKiXImSgWH
         ijGsfbFYbmX9vgIYgNuuUEMve0y6xQjTTxA5I=
Received: by 10.90.235.6 with SMTP id i6mr601672agh.81.1261141245850;
        Fri, 18 Dec 2009 05:00:45 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm1469182gxk.6.2009.12.18.05.00.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 05:00:45 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:33:46 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 3/5] MIPS: remove powertv mips_machine_halt()
Message-Id: <20091218213346.01f63eac.yuasa@linux-mips.org>
In-Reply-To: <20091218213018.79a9fc11.yuasa@linux-mips.org>
References: <20091218212917.f42e8180.yuasa@linux-mips.org>
        <20091218213018.79a9fc11.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

mips_machine_halt() is same as mips_machine_restart().
In addition, the registration of _machine_halt and pm_power_off are deleted.
because mips_machine_halt() is restart function.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/reset.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
index 494c652..0007652 100644
--- a/arch/mips/powertv/reset.c
+++ b/arch/mips/powertv/reset.c
@@ -28,9 +28,6 @@
 #include <asm/mach-powertv/asic_regs.h>
 #include "reset.h"
 
-static void mips_machine_restart(char *command);
-static void mips_machine_halt(void);
-
 static void mips_machine_restart(char *command)
 {
 #ifdef CONFIG_BOOTLOADER_DRIVER
@@ -44,22 +41,7 @@ static void mips_machine_restart(char *command)
 #endif
 }
 
-static void mips_machine_halt(void)
-{
-#ifdef CONFIG_BOOTLOADER_DRIVER
-	/*
-	 * Call the bootloader's reset function to ensure
-	 * that persistent data is flushed before hard reset
-	 */
-	kbldr_SetCauseAndReset();
-#else
-	writel(0x1, asic_reg_addr(watchdog));
-#endif
-}
-
 void mips_reboot_setup(void)
 {
 	_machine_restart = mips_machine_restart;
-	_machine_halt = mips_machine_halt;
-	pm_power_off = mips_machine_halt;
 }
-- 
1.6.5.7
