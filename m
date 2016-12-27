Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2016 03:00:26 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33119 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbcL0B76mict9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2016 02:59:58 +0100
Received: by mail-pf0-f196.google.com with SMTP id 127so7416071pfg.0;
        Mon, 26 Dec 2016 17:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XR3LumDorgC7xuf4JqDHFUCbGTfwF8aO+lcsqZT8kNg=;
        b=uBUbE9NZcZ1vYxct9fdoRIzQtasUu3X2l1b7egQfwWzd0JpDilutjDRx7HePpa4ElZ
         Z0lEoE+wwLgKCah00yyDrt7+CG36WYOJe+Ax3QL482WIbO/r6y7WP1/hgdjitCk5bPKo
         iovTXs6Lw0yqy/mpJbrH0d2xbQCWc7MXG2yAj4iMZr1/SuwrFIEZBn9VT3SKt6QJVEAh
         niOm2vT+sIcnWByQDYwihkokWnU0UzNwrdZY2D3lGpoHVvKboWo3s/kA19NwrnI9ispj
         8C/n7WOwMjpQ1QPxz7hUXomsi9P8JYV+fiedNSRHQhmeb85xHZ104nsmuZPYm2y21TcW
         i7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XR3LumDorgC7xuf4JqDHFUCbGTfwF8aO+lcsqZT8kNg=;
        b=c/cOGQYy3C76fRCPJ9QpUM4a9ws53UDLTILFLcgPKrgeDJ8Q90+l1u1cn4NKuBYCUt
         lq4LPjem4vMN1t60Zj3wJemVJPRKjtCygZ7hTIWcXxkEA8vQjPULRt9gV1kk3qd1DUb+
         VJAH43za2vKoboDU8J6/ycW3CaUJaVClHlRjZH0M5eCFiPyAcoDt9IdaADIVx5nDNqSN
         iX1CsjqC+byUkCGHB7XIVCkk6NGekMxk/lZxrrItve4Oe4/t1MlZE+nzwlHZ+kOsDcKa
         gTjS8MzsCKFAwsEdyH5CUP7+KoM9fNKdKVHl4r2Pkcg7GdyH/6mbx5XyJH1Pa6KpljGH
         KWQQ==
X-Gm-Message-State: AIkVDXLIuj3nWr5CJAZ1dBOm2J0Octw4MbZZ8LDMeSs55KzB57o5OHGNOi4FNZZdW6gU5g==
X-Received: by 10.84.197.1 with SMTP id m1mr62343595pld.157.1482803993007;
        Mon, 26 Dec 2016 17:59:53 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id q5sm9238749pgf.45.2016.12.26.17.59.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 17:59:52 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/2] spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
Date:   Tue, 27 Dec 2016 10:59:22 +0900
Message-Id: <20161227015923.882-2-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161227015923.882-1-jaedon.shin@gmail.com>
References: <20161227015923.882-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56124
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
