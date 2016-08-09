Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 10:23:42 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34562 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992466AbcHIIXfo5wkf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 10:23:35 +0200
Received: by mail-pa0-f66.google.com with SMTP id hh10so576046pac.1;
        Tue, 09 Aug 2016 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fBTUahwEvS5uC+o5yhnydx8gfE+owyvrcj2ujS8mWoA=;
        b=PQwZSfh1LPTzmF9+S0g71tiJOtPGw2BNURW7KO9X+JNAPyGKcFB5kiw+GYJl70wvQB
         xocZBfJ2PyAjzOliy7siS9tSyEM5My03ZISp+9Zz+KoL2ADNJGTh8zQIMbxG16RcmkOT
         9yIH7CJ8ZLKbXtK8jmdEZ93KZoIG5W+l+ZKSooYrMtg4wpgou9SHqHef0HDb2ilWCDTk
         eK4MjIjciy9D9A8GhZ4vmzRF04XNJNkwvKKEkRpBqf/c7UWqGEvD/AIRIIrSnGVhvNGt
         tTrqlbn/24GkH3DWy82EjFqIvLBmoUuxHKOLKmPgiNfWUtrSFQV3OQhM+1JWgYYrDrVg
         1u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fBTUahwEvS5uC+o5yhnydx8gfE+owyvrcj2ujS8mWoA=;
        b=QWvg0548KHhl+oipAIauSvPwEIru1mZJhpgbEMQIS0+SNBViEURfUx6OYWjD+J64zn
         1O5nsmyXy8aVXAMrcA6uJ5Rdrn/KF/cNnYlF0Nd2Pce24cwnaVM4A4jFfLoQkID1l1JV
         O/SISumXeEojjsvjgr0a3GoHjYGLGdma8d6HsFLOGIITYrQIVBviwm8P7C2JqXPl/f7J
         zFGLlbn78FtDvjI105RV0HEJ3Swk9amXZtIFkBRcxEDQB6rF8TuFuc6gvTXOBMTahr3a
         ZaLkac9Qzd08BOtYO4Qmf7O1LNqfa562E2Zvch+d3FRUxINPu4AS8GP7gfV3E/GwzemF
         pSDw==
X-Gm-Message-State: AEkoousiRDp/jLAI0i9Noz5rxf9SNjwWtQyyboJ0Rh2Dj1ERc1ZVv8G1HdrZVDueOaEXTQ==
X-Received: by 10.66.142.105 with SMTP id rv9mr50927182pab.33.1470731009624;
        Tue, 09 Aug 2016 01:23:29 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id d5sm53688458pfc.4.2016.08.09.01.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Aug 2016 01:23:28 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson1C: Remove ARCH_WANT_OPTIONAL_GPIOLIB
Date:   Tue,  9 Aug 2016 16:23:11 +0800
Message-Id: <1470730991-24498-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch removes ARCH_WANT_OPTIONAL_GPIOLIB due to upstream changes.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 69df280..d0b9ad1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1405,7 +1405,6 @@ config CPU_LOONGSON1C
 	bool "Loongson 1C"
 	depends on SYS_HAS_CPU_LOONGSON1C
 	select CPU_LOONGSON1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1C is a 32-bit SoC, which implements the MIPS32
-- 
1.9.1
