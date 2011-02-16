Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2011 15:34:58 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:44002 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab1BPOez (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Feb 2011 15:34:55 +0100
Received: by fxm19 with SMTP id 19so1413561fxm.36
        for <multiple recipients>; Wed, 16 Feb 2011 06:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=afdZGnuovKBtah44yxYrwDykYjHMBanZqAHLayrkMp0=;
        b=h/u3FEvDUpOIfcEE6tSLxEr4FtdYj1i2/f57zhziKBMUMpXMkbb5wJu+EHgvfYVsWq
         iiqWqnOUKLM0Qgld+wUlnntZj/DPZJgUwAJmBTNO73E0/Ur9ua4fhZkGXYDPMeuTbHMw
         eCpbkAmaTZJhsoJrNNkO5FVVp9yHCrC+b3Vx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xx3/G38sV7R2DtvJNgAY/XVMCOfID4akV9KZiGHx9t9D6MGjsVoIueIPboA2XOMn57
         nLjBTeg3BDWM8gMUSdKo2o9RftEPhagnbtbv78yHwBiuMBLWIa+a5zbJ8BmMLZn9UFzw
         z89MlmyNkaZ4s3n1T9JJdH46Hi1zT0BfZJqgI=
Received: by 10.223.54.132 with SMTP id q4mr822580fag.117.1297866889356;
        Wed, 16 Feb 2011 06:34:49 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id 5sm57423fak.23.2011.02.16.06.34.39
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 06:34:42 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH] Include asm/time.h in cevt-r4k.h
Date:   Wed, 16 Feb 2011 20:26:07 +0530
Message-Id: <1297868167-26738-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Following error occurs when compiling files which includes asm/cevt-r4k.h

arch/mips/include/asm/cevt-r4k.h:21:56: error: 'enum clock_event_mode' declared inside parameter list
arch/mips/include/asm/cevt-r4k.h:21:56: error: its scope is only this definition or declaration, which is probably not what you want

This left unnoticed since we will not see this error if we include time.h before cevt-r4k.h .

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/include/asm/cevt-r4k.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cevt-r4k.h b/arch/mips/include/asm/cevt-r4k.h
index fa4328f..ae06b7f 100644
--- a/arch/mips/include/asm/cevt-r4k.h
+++ b/arch/mips/include/asm/cevt-r4k.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_CEVT_R4K_H
 #define __ASM_CEVT_R4K_H
 
+#include <asm/time.h>
+
 DECLARE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 
 void mips_event_handler(struct clock_event_device *dev);
-- 
1.7.0.4
