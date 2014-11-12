Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:48:34 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:61442 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013499AbaKLIrTJYQUW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:19 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so11862652pdj.40
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mfsW2CWCL2B+0pdhxcx3IO89JGcazyL8zIJOIF8hEnQ=;
        b=hEqOFk4peAhBIoALGVi+r8m4RgpVUaYEKGCoNMs7h7Xd0VHzV5ANk2qzyPnil09Hdp
         96k7qSHWpiOXTMEv/eQb+uEzQbK9VKsGDHPWxsm7OULa95G39yO4Wnq6QtVHsT0zJ6Nn
         LasCW3aAIbkpZ4f+/JKJ8oQokwD0G17FMjBaCC98v6ci7K0tQtXmxFKK0KBhOdaH3Jje
         QQZC+KEIU9jJq0GRmX7U67UZUlvFMFbqfzX+dirlb06VHM/Bhf39EuJKaXKGApYqZWal
         kaCq6LztkgdAyCoCjjrousgHmTQ6sACSfm+rEoBg+YidGkBYNRTPrB1tIokW/aCeDqBG
         shxg==
X-Received: by 10.70.36.15 with SMTP id m15mr18183019pdj.132.1415782033326;
        Wed, 12 Nov 2014 00:47:13 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:12 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date:   Wed, 12 Nov 2014 00:46:30 -0800
Message-Id: <1415781993-7755-6-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44033
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

Remove the platform dependency in Kconfig and add an appropriate
compatible string.  Note that BCM7401 has one 16550A-compatible UART
in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
clock domain.  This driver handles the former one.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 drivers/tty/serial/pxa.c   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fdd851e..2015057 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -436,7 +436,7 @@ config SERIAL_MPSC_CONSOLE
 
 config SERIAL_PXA
 	bool "PXA serial port support"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on ARM || MIPS
 	select SERIAL_CORE
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 78ed7ee..f6cc773 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -830,6 +830,7 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 static struct of_device_id serial_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-uart", },
 	{ .compatible = "mrvl,mmp-uart", },
+	{ .compatible = "brcm,bcm7401-upg-uart", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
-- 
2.1.1
