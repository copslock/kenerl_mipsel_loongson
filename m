Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:24:22 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32890 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012079AbaJUWXdmo7la (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:33 +0200
Received: by mail-pd0-f180.google.com with SMTP id fp1so2216576pdb.11
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHd4NhiK1boeJB1KCSuhKZrWD6lRpMfBszgxCSebVjk=;
        b=ZcRRIz0+FTOHtHApRHMMMXSKGgswGbaP9zEuysBacnHU+Jx5wZky3FYgO6p00XDe5a
         qmGZF8Gm+aK1pVPQ0BTBcIh2IlqqNAULelFpaTwynq+cqn/Vd1k/83yMBAnYvdGlEjtq
         wMhnOEFevZMllv3rgGMaQXwuxcPhv0e+/36HWSjdRJCqSN/ZSMkXsAv4BBhi5MWusYLm
         DfHb8H1sbpJFzNKF0ZeXtdMRDtrVqAjZArCeEULSNRQGSZM362XiNWlZzeP5jBRGTM6+
         fckZA4Hdk93pd1J5RtGzMH9W9yOE1ZCU/l73odi821CXe3xqBufL8bhEju/8lBUs6rmQ
         eXzQ==
X-Received: by 10.70.47.42 with SMTP id a10mr37496889pdn.18.1413930207759;
        Tue, 21 Oct 2014 15:23:27 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:27 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 03/10] tty: serial: bcm63xx: Update the Kconfig help text
Date:   Tue, 21 Oct 2014 15:22:59 -0700
Message-Id: <1413930186-23168-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43439
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
