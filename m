Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 13:29:40 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35767 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009460AbbJEL3jRY3UV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 13:29:39 +0200
Received: by wicge5 with SMTP id ge5so115846018wic.0;
        Mon, 05 Oct 2015 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XOJG50Y9QlpzBDe6bFPtQtNBGXA7+iTXpPlt1xzkNqI=;
        b=dwNIig4YDkAnu46/vCaC/ibdidEAmwp0kAVWDBak6zxqrV1IMZ436l2nv6djnAAXwE
         kJ4dz6xEJtodLX7GdDVT57GVVdYCx23Dy6mVj6oxRG2J6lvhhJyw76OVzL80akJF15Tx
         zJQy6wdzR15d12lxiXMpvqb5bA7esfthoLMlfLCcadBzo18lRr/q1Wbh/vXzM42JtRQ3
         1j/+VK7tOR3i4FWAMPbNCrjYXHaZewZbLWSEMJ/eq0BPooyZ6HzjrEb5lUQyNFfxg30m
         LPTOr+HJVzhcAC7m08djkD4OKM/ECke/ftYa5WbmxKOJ8die4YJbSjLT1/v85l48dHqa
         RlAQ==
X-Received: by 10.180.101.198 with SMTP id fi6mr11762345wib.25.1444044573006;
        Mon, 05 Oct 2015 04:29:33 -0700 (PDT)
Received: from localhost (port-54044.pppoe.wtnet.de. [46.59.211.200])
        by smtp.gmail.com with ESMTPSA id jd7sm4593563wjb.19.2015.10.05.04.29.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 04:29:32 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] MIPS: jz4740: Add missing gpio.h include
Date:   Mon,  5 Oct 2015 13:29:31 +0200
Message-Id: <1444044571-11304-1-git-send-email-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.5.0
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

Commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h") was
incomplete in that it didn't replace any of the includes for the JZ4740
platform and thus broke the qi_lb60_defconfig build.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/mips/jz4740/board-qi_lb60.c | 1 +
 arch/mips/jz4740/gpio.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 4e62bf85d0b0..f2885adda9d0 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -35,6 +35,7 @@
 
 #include <linux/leds_pwm.h>
 
+#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/platform.h>
 
 #include "clock.h"
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 6cd69fdaa1c5..386626376b18 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -28,6 +28,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/gpio.h>
 
 #define JZ4740_GPIO_BASE_A (32*0)
 #define JZ4740_GPIO_BASE_B (32*1)
-- 
2.5.0
