Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:55:38 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59089 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011964AbaJTUzDnswSn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:03 +0200
Received: by mail-pd0-f173.google.com with SMTP id g10so5687548pdj.18
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHd4NhiK1boeJB1KCSuhKZrWD6lRpMfBszgxCSebVjk=;
        b=0D3M85jR3EkwuoUqORkznCi6fnhhzEVJZ7wrbakobxjmcYQ5QIIy25V2xWIcjC6BgP
         EUl8PR7kA5G2t2nAcYG4uUkN9DugdcNB2h2IraYzy2qz9V5Rux6yOhVsZxeI1Ao/j1K9
         nNRoueTuOWxS8NYsKONCfk6cQPNIF9u1C3qy1Wehhekp5zMQP89Ku9LtOEyAvPM9Fv4T
         eZ7eO5Z3dr/sICfrEcv8eoDsNU3JTDAjC16+vPUXco3z9t28Dh7UjMN3rS5taIuYZBkh
         ntt+YbjrFqW15Q6hD3fLOAfrQI5mciwfWRk421S6V6aS+91my4f1DPKH5kMEoRMvxvz0
         ZCSQ==
X-Received: by 10.66.144.106 with SMTP id sl10mr29585713pab.96.1413838497582;
        Mon, 20 Oct 2014 13:54:57 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.54.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:54:56 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 2/9] tty: serial: bcm63xx: Update the Kconfig help text
Date:   Mon, 20 Oct 2014 13:54:01 -0700
Message-Id: <1413838448-29464-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43381
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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
