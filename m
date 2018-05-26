Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2018 19:15:11 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:51487
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994697AbeEZRPFPOguB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 May 2018 19:15:05 +0200
Received: by mail-wm0-x243.google.com with SMTP id j4-v6so21907624wme.1
        for <linux-mips@linux-mips.org>; Sat, 26 May 2018 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tCtQ2UHCisF88/UdZQScfRnVfAxpBHpLOTxzTzqPGNY=;
        b=ZGPo+UreJFwj5FcrD4YHY/qyi04QdOu3ZAXP3IJn1lEwubQejFpuCwXCLimcoIccN8
         p25POHRhhYB3UHkMxnA/DziVWOxnbBDGrhZB3zAoI4hcvYvTgChwQSgCb0MliDVW3csf
         UBa/FqGk8oVUfGzHFpUa9ID1qmXK9SwRuOqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCtQ2UHCisF88/UdZQScfRnVfAxpBHpLOTxzTzqPGNY=;
        b=MwuYOHVJ/YHGw5LpVap1osRIH1x8s7QYHd1slT8T1TFfhDMlHP20txGCcuJ3PBLKBV
         5dGAqrOH2WwnFgnlFbD79Iwu/bkvqZooxcTYzKuRW3IlTSGEz+7oTFW6ERuGhx24SCyq
         5FDMHaiGaUMwArIEUvqqtJ42D81xkujfa0JQuDz6zV206eUNbYfCILxv+Y0jQbJMa+ti
         YpyiV84CwcrN6jT85vcvgaRFK0kDfpHVTwnayyyQR2wVMXidrnw4n9q4NbRWP3ITiwa7
         zW2jZPAnFH+/RL/uuCA7Q1jPhGdCvQCf/um8BMvs3CW5RrgvHxp5zzjXthPR67J+IbeM
         XrhA==
X-Gm-Message-State: ALKqPweD8JScZFS1Zxk1m62FJdA+Miv4/TFTIUSAK5Q+E+F37aS4PbkI
        ovTLDnysfRnSUdBid9qkk+whzw==
X-Google-Smtp-Source: ADUXVKK3vUE0NINdVogsPlRKOBPIcuQlKFdPqsM2EK+P/BqIC4w3BpK3D5O0cAxmy+5Tr+zXkdbTCA==
X-Received: by 2002:a2e:8018:: with SMTP id j24-v6mr4443319ljg.92.1527354899714;
        Sat, 26 May 2018 10:14:59 -0700 (PDT)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id f64-v6sm6077264lfg.63.2018.05.26.10.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 10:14:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH] MIPS: pb44: Fix i2c-gpio GPIO descriptor table
Date:   Sat, 26 May 2018 19:12:51 +0200
Message-Id: <20180526171251.7653-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

I used bad names in my clumsiness when rewriting many board
files to use GPIO descriptors instead of platform data. A few
had the platform_device ID set to -1 which would indeed give
the device name "i2c-gpio".

But several had it set to >=0 which gives the names
"i2c-gpio.0", "i2c-gpio.1" ...

Fix the one affected board in the MIPS tree. Sorry.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Reported-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Ralf can you please apply this for MIPS fixes?
---
 arch/mips/ath79/mach-pb44.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index 6b2c6f3baefa..75fb96ca61db 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -34,7 +34,7 @@
 #define PB44_KEYS_DEBOUNCE_INTERVAL	(3 * PB44_KEYS_POLL_INTERVAL)
 
 static struct gpiod_lookup_table pb44_i2c_gpiod_table = {
-	.dev_id = "i2c-gpio",
+	.dev_id = "i2c-gpio.0",
 	.table = {
 		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SDA,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-- 
2.17.0
