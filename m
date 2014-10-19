Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 04:31:06 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57170 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011052AbaJSCatRF093 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 04:30:49 +0200
Received: by mail-pa0-f44.google.com with SMTP id et14so3026562pad.31
        for <linux-mips@linux-mips.org>; Sat, 18 Oct 2014 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkdWK5cf0Qmc8QMFu3RL9wBkwuqcF1R0AUPzz6ZwQbc=;
        b=lBJFwFVwEsw0wu74EXPuGuBPQHnsa8Z5IhB3+Nwuenjlk+cSvKBsxHb/dy6USJNUFv
         3C43bxUvycIIK7LGLuJd3ocdviSAjaFzfuU5jWnd4DhJ8XJdfZoBaa9y26c9o8Y9vAWc
         LseVTmvo4rM6CWJrUuH6S/W4vwt8RsswqkOgTcujWztI3Bq2FP1ONoIgP1Kzdqoyk8kl
         J8Q7wxZbcubtwRaQZFKxeEbxf63ihf1jAAHbu86HXa8RQFZuQf30bN1UZjGm5aW0hp/A
         32CuoLcWRzNEnXf2N56DDFdT9pdeLK4/kcFJxH8oN27pihpIE2j0s8jjY2me0RTajqSA
         4JRA==
X-Received: by 10.70.88.174 with SMTP id bh14mr8197159pdb.24.1413685842769;
        Sat, 18 Oct 2014 19:30:42 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id gi11sm5298159pbd.48.2014.10.18.19.30.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 18 Oct 2014 19:30:42 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/3] tty: serial: bcm63xx: Update the Kconfig help text
Date:   Sat, 18 Oct 2014 19:30:17 -0700
Message-Id: <1413685818-32265-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43333
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

Remove incorrect "bcm963xx_uart" module name; add a list of known users;
tweak grammar/indentation/capitalization.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4a5c0c8..815b652 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1281,22 +1281,24 @@ config SERIAL_TIMBERDALE
 	Add support for UART controller on timberdale.
 
 config SERIAL_BCM63XX
-	tristate "bcm63xx serial port support"
+	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
 	depends on MIPS || ARM || COMPILE_TEST
 	help
-	  If you have a bcm63xx CPU, you can enable its onboard
-	  serial port by enabling this options.
+	  This enables the driver for the onchip UART core found on
+	  the following chipsets:
 
-          To compile this driver as a module, choose M here: the
-          module will be called bcm963xx_uart.
+	    BCM33xx (cable modem)
+	    BCM63xx/BCM63xxx (DSL)
+	    BCM68xx (PON)
+	    BCM7xxx (STB) - DOCSIS console
 
 config SERIAL_BCM63XX_CONSOLE
-	bool "Console on bcm63xx serial port"
+	bool "Console on BCM63xx serial port"
 	depends on SERIAL_BCM63XX=y
 	select SERIAL_CORE_CONSOLE
 	help
-	  If you have enabled the serial port on the bcm63xx CPU
+	  If you have enabled the serial port on the BCM63xx CPU
 	  you can make it the console by answering Y to this option.
 
 config SERIAL_GRLIB_GAISLER_APBUART
-- 
2.1.1
