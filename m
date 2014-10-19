Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 04:30:49 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:43525 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011045AbaJSCarfYmRU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 04:30:47 +0200
Received: by mail-pd0-f175.google.com with SMTP id v10so2894079pde.34
        for <linux-mips@linux-mips.org>; Sat, 18 Oct 2014 19:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AstvNYdX4ulgbMOKBxAf1mlB7nrm+6xhFFjLYtCTnBg=;
        b=gKSZHsqVKuMQ4yszIAXKQfxjY7a4YRfaMZvKY2d44fajfqe1/nWr8TLSHdZE/kILWf
         tRZm9mt+2Scm8zQe/1Eg4aSc9Mb/HWCjt8p/4AUrQWeqK1bmAStD/gpNCK4kqV34S6xp
         NkXO/wIvPaE96sc8H8mqXs2KxqyrAOTG8OyZbPWIUG3s+10voHptp3+0+7jerse/c1RD
         kYzGA0Ei6PnCQJHllnC73YYuiZMzhSlPdExPJ6lYmLjSFK49Nzi8ZNifMqJhpul2QQRA
         Q5fSMBXR0l4MeWJ4ux7fSM01om+rHNwarbyoYzmGaagph6wg/05aXNy5/oiB3EJ/0qOj
         Lt4w==
X-Received: by 10.66.154.10 with SMTP id vk10mr18175918pab.21.1413685840633;
        Sat, 18 Oct 2014 19:30:40 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id gi11sm5298159pbd.48.2014.10.18.19.30.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 18 Oct 2014 19:30:39 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/3] tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other platforms
Date:   Sat, 18 Oct 2014 19:30:16 -0700
Message-Id: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This device was originally supported on bcm63xx only, but it shows up on
a wide variety of MIPS and ARM chipsets spanning multiple product lines.
Now that the driver has eliminated dependencies on bcm63xx-specific
header files, we can build it on any non-bcm63xx kernel.

Compile-tested on x86, both statically and as a module.  Tested for
functionality on bcm3384 (a new MIPS platform under active development).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 649b784..4a5c0c8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1283,7 +1283,7 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "bcm63xx serial port support"
 	select SERIAL_CORE
-	depends on BCM63XX
+	depends on MIPS || ARM || COMPILE_TEST
 	help
 	  If you have a bcm63xx CPU, you can enable its onboard
 	  serial port by enabling this options.
-- 
2.1.1
