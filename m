Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 12:44:40 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:53105 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823049Ab3EWKocg4iDX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 12:44:32 +0200
Received: by mail-we0-f172.google.com with SMTP id w62so2033959wes.17
        for <multiple recipients>; Thu, 23 May 2013 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TqVBKml/Vp8N650Qaent7OA0GsgPu0Gut0K6fZNxbBc=;
        b=WcnZRyW9dvlyCV2G2GCvXfkp4crlaqtqpkyThALZb1hVq6PCv2uagRvArzUrvzhGMW
         12WsRg4X35qqPiGeV4eSmposeSOe1WP6IA5ise2CRqmJpuMKNQ0ikLrHmoF1i9nBjqC4
         bEP3+dlDKQpyjTiGRRCMuV0eIHWFO3amlTtDna5DSwdnN8QjT+iEiOqqPs8EHEAda5Jn
         azzT6ZLPjzPgqV1L93BVJUBrfJmcIafTrt9DMulrcBSAR59hB6YfUaCjug5FWE/uudsT
         OFErleH9L7/bKJuuc7Dx37/V6z80P7fHXDRt33Gf8GdMME+tHBP2c2qiE8TmD0YCQH/K
         UefQ==
X-Received: by 10.180.107.35 with SMTP id gz3mr23669198wib.0.1369305867251;
        Thu, 23 May 2013 03:44:27 -0700 (PDT)
Received: from flagship.roarinelk.net (62-47-62-116.adsl.highway.telekom.at. [62.47.62.116])
        by mx.google.com with ESMTPSA id f2sm34771594wiv.11.2013.05.23.03.44.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 03:44:26 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix wait function
Date:   Thu, 23 May 2013 12:44:16 +0200
Message-Id: <1369305856-21356-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.2.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Only an interrupt can wake the core from 'wait', enable interrupts
locally before executing 'wait'.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Please add to the 3.10 queue, fixes a rather boring hang on boot.

 arch/mips/kernel/idle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 3b09b88..6da2c0f 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -93,12 +93,13 @@ static void rm7k_wait_irqoff(void)
 }
 
 /*
- * The Au1xxx wait is available only if using 32khz counter or
- * external timer source, but specifically not CP0 Counter.
- * alchemy/common/time.c may override cpu_wait!
+ * Au1 'wait' is only useful when the 32kHz counter is used as timer,
+ * since coreclock (and the cp0 counter) stops upon executing it. Only an
+ * interrupt can wake it, so they must be enabled before entering idle modes.
  */
 static void au1k_wait(void)
 {
+	local_irq_enable();
 	__asm__(
 	"	.set	mips3			\n"
 	"	cache	0x14, 0(%0)		\n"
@@ -112,7 +113,6 @@ static void au1k_wait(void)
 	"	nop				\n"
 	"	.set	mips0			\n"
 	: : "r" (au1k_wait));
-	local_irq_enable();
 }
 
 static int __initdata nowait;
-- 
1.8.2.1
