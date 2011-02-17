Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 10:47:30 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:53170 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab1BQJr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 10:47:26 +0100
Received: by bwz5 with SMTP id 5so2354778bwz.36
        for <multiple recipients>; Thu, 17 Feb 2011 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=D5tgj5KzTIb6DOk3FRF4Cc1IijZ85NxWILc0uwe0LE0=;
        b=i2tFK7gBOl5XRYgMA/Mnbfz5cGgOkKetdQ9xlWzO0049vv9Xx/2XOM5M/RUfHaYahd
         /srh4PQIUXg3Er+2eADT0TYXljUeqaqg6npjC2zNuiNJuGaXuzktqw8kbsNt/uT7UbXW
         I8csqc/m24epYmslhBxo00rAJh6WpuRAtgYTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CaaJet74ZidobqEcIWR7udtcbrbz+hLcnTuqDqbQ/9gKrikGgMQpYgyKgx5yPMP3Pe
         rnlnPziI2pmdv1jZcMLHALii3akwMnJlZDv3iJhez3vClp+KVR7HNUx40Ti/3eHy1wjK
         MtVImI7n3ReOxXYmOKHInPE9wKQoOCb+dEyPE=
Received: by 10.204.101.81 with SMTP id b17mr1447273bko.126.1297936041147;
        Thu, 17 Feb 2011 01:47:21 -0800 (PST)
Received: from localhost.localdomain (t35.niisi.ras.ru [193.232.173.35])
        by mx.google.com with ESMTPS id w3sm509983bkt.5.2011.02.17.01.47.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 01:47:20 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: Loongson: Kconfig: add MACH_LOONGSON dependency
Date:   Thu, 17 Feb 2011 12:55:44 +0300
Message-Id: <1297936544-24369-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
X-list: linux-mips

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
