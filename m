Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2016 07:30:43 +0100 (CET)
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33550 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992166AbcL3GaSiiBht (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2016 07:30:18 +0100
Received: by mail-pg0-f67.google.com with SMTP id g1so21144460pgn.0;
        Thu, 29 Dec 2016 22:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MlFhQlxDRbUv17S+mHyI9peld3z36/3UQX4zywFY7w8=;
        b=MLZGz8d6tKjv4XF6F9oN2w6NgF7BBBzMpT9aS2EVmesVIjjSbje64/R7V3z3IzVGRF
         egqdb6r0j5w1f3FsLKyRFmO52XzTOLaX859Y9diko1KkqWiBf9de13B907UcVZ7C6v2b
         cZLnCf1rxSnb8+x590NrNWNyuAFgMsrcrATD2ULH0mbKjRM2mpncgv62jIehfg2Mt4/V
         Yj76rRohZz3tRCqOH9gXb1UruKpLJ0JKh0p0bC/cuZlZNTGCD9pmHYEBdYDo6HmN8jaZ
         BBeXchamm26bemVbS1e6LfDZOCeByyOpnYY1lWgX3bEs1gigk14/42DydZFhaXcp1FV7
         0eWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MlFhQlxDRbUv17S+mHyI9peld3z36/3UQX4zywFY7w8=;
        b=P//svfV3vNZV6lGc5yGRk6OPijUV8XoeKYaBlUmnCl9+RWmT8E+wMHCNArT0PV3NC+
         7Ofc0s/FPWoRaPpz6raGfxb6nX3IPYThIWAvDVGa04wbs31bvnvEG/zwvFFdRW5CtHIa
         6TcQa8IVKc2+KN6etnCKNHSGw/DVcrwhVdJcjAV9EX/WPniixhrg6LGMQZXSgrhydjUN
         n8s2kjJoGQpyUB29m+0Ez9imjI+GbnHLflgIt0l77O/kY6mbDVDyx5V8vGrEJyfmNwww
         TNPKUti7iHrvn9PJhetCPkxUUAaq0bVr6kK2ozpqyAvFpxPuQ+wkEIxxG4AwmafZ5Cij
         VMwQ==
X-Gm-Message-State: AIkVDXLx88XE4+dzKe5qvaaFsV8A2nEWuqxAimcFtJi+p3cPHwH4ESJyLXl6yQaUIw5n+A==
X-Received: by 10.99.124.66 with SMTP id l2mr84108217pgn.116.1483079412951;
        Thu, 29 Dec 2016 22:30:12 -0800 (PST)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id p25sm109237199pfk.20.2016.12.29.22.30.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 22:30:12 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 1/2] spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
Date:   Fri, 30 Dec 2016 15:30:00 +0900
Message-Id: <20161230063001.944-2-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161230063001.944-1-jaedon.shin@gmail.com>
References: <20161230063001.944-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

The Broadcom BCM7XXX ARM and MIPS based SoCs share a similar hardware
block for SPI.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ec4aa252d6e8..c982a01022ba 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -162,7 +162,8 @@ config SPI_BCM63XX_HSSPI
 
 config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
-	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || \
+			BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
-- 
2.11.0
