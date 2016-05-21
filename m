Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:05:45 +0200 (CEST)
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33547 "EHLO
        mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032473AbcEUMCDF0y8I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:02:03 +0200
Received: by mail-lb0-f195.google.com with SMTP id u2so694183lbo.0;
        Sat, 21 May 2016 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=h+2exuWhbcEzNc7nuv/GNlkltwbCuZTs/aPVqlSr/3A=;
        b=Dq7wXMQPFPkMPdsSnRIproyRrVm0Ncpfib7tPiQ2ucJESfuJyOy33wWwebwIHgbmG1
         Z1RRcAT3BY8dfNFmNDzKelXi1sgQyam5qUEkNdYB2hLnFQ0+cNnT0XQWUYKFO5BOk6HL
         DMIXfiYYdd9UUl47Djj+AB8fuB0u5rEDCCY/CSYup388LDj4QIvQm/J8Cy7BnV6qSIVv
         +dhrspXaedTf5LYXqSkIEVde1KFxPHMDyTwWy9dgZx4mSPsWm42YVpjpZjsUBDB0Ai8U
         tlu2GNNnOwf0qQydtS/9p0ofenWQFJMqEgpS1Dh5YmeVl5KlgUFHnjgj2h2QhXvqeETa
         WVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=h+2exuWhbcEzNc7nuv/GNlkltwbCuZTs/aPVqlSr/3A=;
        b=Y74T+6j6oOhM9w6ts3Tg0gh2CXT0tEnq2+dVDJc5k7rihSMgnW68phKE/5Kk5DK10R
         URpDfhEJAf419TuHiFdo/eygZejeacHDrmhQyWJp8Z2QXR/AtfH8kNzc+vTHGsM0tyO9
         jdX1WV1oqMjvRMhSbcOq8L9n+qDRSbiCvBrtivquCioOazWuepzG1RanrcGUOCDzQoSq
         5CvOllNKi8SY3kbDhJ0WEJ9y30FpCKbmvyrNDoMfDLP5fIyMBvN1Cr1ZnHkXpfADJN42
         HsufqhCSc/fJWgyQNXiJQLYpljSpJ81o27v+/N4m5nr3E3Unp52jS1lz1Qk7KM0iUkh4
         ffsQ==
X-Gm-Message-State: AOPr4FWJtbVLDD+atexG0Oh2a43zxus/lrZcLpbKSht90zJwXoVkrsaGfNEL1Ss43+MLSQ==
X-Received: by 10.112.154.5 with SMTP id vk5mr2840401lbb.126.1463832115995;
        Sat, 21 May 2016 05:01:55 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id k66sm4245058lfe.32.2016.05.21.05.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:54 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, macro@imgtec.com,
        markos.chandras@imgtec.com, linux-mips@linux-mips.org
Subject: [PATCH 0197/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:51 +0200
Message-Id: <20160521120151.10200-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/dsemul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index d4ceacd..4707488 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -8,7 +8,7 @@
 #include "ieee754.h"
 
 /*
- * Emulate the arbritrary instruction ir at xcp->cp0_epc.  Required when
+ * Emulate the arbitrary instruction ir at xcp->cp0_epc.  Required when
  * we have to emulate the instruction in a COP1 branch delay slot.  Do
  * not change cp0_epc due to the instruction
  *
@@ -88,7 +88,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 	fr = (struct emuframe __user *)
 		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
 
-	/* Verify that the stack pointer is not competely insane */
+	/* Verify that the stack pointer is not completely insane */
 	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
 		return SIGBUS;
 
-- 
2.8.2.534.g1f66975
