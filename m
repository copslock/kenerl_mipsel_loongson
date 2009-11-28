Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 14:32:29 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:38259 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492813AbZK1Nc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 14:32:26 +0100
Received: by pzk35 with SMTP id 35so1642891pzk.22
        for <multiple recipients>; Sat, 28 Nov 2009 05:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HFYSN0IXtJ50L6H3h1pPKd+UhjsWhfx1ZLTJaxlQp1s=;
        b=resFbM0O63/XJroA5GJP1+f62+p/rw2q1o5Kb94a4sNMW1SM7KbNHmkktnhvLMKd0J
         AwdDAjPPOtiaOzOnesh/1SSHYzixPi8WfPT2m0bTUs4QlpMw+0aFs6hZEzb2x4S/1XT1
         rsoRPh8HfeMe5pcqpIUMzulIMkJV7Vbpp63YU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TFm/SW6+KSLurLJxsEyI7ilFAqcr8YPHffry8gCGlA9PNUd9WWoDXaxWXp/OVcJYMU
         QIlTQieE8sS/eFBNnsFJ71HzBNzVnhJo1c15vVWKugu/mAinxLX6uG1SFy9mXD1qJWK5
         /MYlQs7mu1UlSe1hc6Zi9+Hvrb7AaJDGOf0k4=
Received: by 10.115.114.9 with SMTP id r9mr3926138wam.19.1259415139637;
        Sat, 28 Nov 2009 05:32:19 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1962995pzk.12.2009.11.28.05.32.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 05:32:19 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 1/8] Loongson: Lemote-2F: add platform specific submenu
Date:   Sat, 28 Nov 2009 21:31:54 +0800
Message-Id: <3baeafb2eae57ce9bd2a8130c0f5b4899ff37182.1259414649.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 3df1967..a34dfcc 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -83,3 +83,23 @@ config LOONGSON_UART_BASE
 	bool
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
+
+#
+# Loongson Platform Specific Drivers
+#
+
+menuconfig LOONGSON_PLATFORM_DEVICES
+	bool "Loongson Platform Drivers"
+	default y
+	help
+	  Say Y here to get to see options for device drivers of various
+	  loongson platforms, including vendor-specific laptop/pc extension
+	  drivers.  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if LOONGSON_PLATFORM_DEVICES
+# Put platform specific stuff here
+
+
+endif # LOONGSON_PLATFORM_DEVICES
-- 
1.6.2.1
