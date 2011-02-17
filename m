Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 09:17:50 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:38808 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1BQIRr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 09:17:47 +0100
Received: by bwz5 with SMTP id 5so2303258bwz.36
        for <multiple recipients>; Thu, 17 Feb 2011 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=JDHCV/N5Y74wXxAkogU9yT1HdzOAnJYvgmg+/Lftrts=;
        b=kKjokFwWh4rpf3lmruS9YKtU6H1fbOeB++iaG6AJo80MqMhxU9Op9triuS1YuUCyfQ
         5maX/Ic6awSF5p9Zjeh+TYLfQnI3gfcgcgS4Y6pRiRNJx3CMRgyacvJkZWawegcJ7DdB
         YKK8DQ5Pa2VFfMtJVCie3UMnqKRCwFROVfmIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pH2pUdL1SbQ0eWwz7EvVTRO7pYe6irvvg2vZo1G+HnYo+vWNOlR/Jk2C1jEmvO2qJH
         z12xp9y1/N6TjdP3tGqMz4rhF2cIOnoraFUDKDmg8Cr9BPPSLIJBm3hvdr7L9bQMIezN
         sdngxJZ9hokOaVZCGKcR8g4D7LXP5FjZRBA/o=
Received: by 10.204.70.134 with SMTP id d6mr1378559bkj.21.1297930661265;
        Thu, 17 Feb 2011 00:17:41 -0800 (PST)
Received: from localhost.localdomain (t35.niisi.ras.ru [193.232.173.35])
        by mx.google.com with ESMTPS id q18sm447859bka.15.2011.02.17.00.17.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 00:17:40 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Antony Pavlov <antony@niisi.msk.ru>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: Loongson: Kconfig: add MACH_LOONGSON dependency
Date:   Thu, 17 Feb 2011 11:26:06 +0300
Message-Id: <1297931166-23957-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
X-list: linux-mips

From: Antony Pavlov <antony@niisi.msk.ru>

The options LOONGSON_SUSPEND, LOONGSON_UART_BASE et al. don't depend
on MACH_LOONGSON option.
So my configuration file (.config) for MIPS Malta board contains

 # CONFIG_MACH_LOONGSON is not set
 CONFIG_MIPS_MALTA=y

 ...

 CONFIG_LOONGSON_UART_BASE=y

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/loongson/Kconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 6e1b77f..4f2cf08 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -61,6 +61,7 @@ endchoice
 
 config CS5536
 	bool
+	depends on MACH_LOONGSON
 
 config CS5536_MFGPT
 	bool "CS5536 MFGPT Timer"
@@ -77,13 +78,14 @@ config CS5536_MFGPT
 config LOONGSON_SUSPEND
 	bool
 	default y
-	depends on CPU_SUPPORTS_CPUFREQ && SUSPEND
+	depends on MACH_LOONGSON && CPU_SUPPORTS_CPUFREQ && SUSPEND
 
 config LOONGSON_UART_BASE
 	bool
 	default y
-	depends on EARLY_PRINTK || SERIAL_8250
+	depends on MACH_LOONGSON && (EARLY_PRINTK || SERIAL_8250)
 
 config LOONGSON_MC146818
 	bool
 	default n
+	depends on MACH_LOONGSON
-- 
1.7.1
