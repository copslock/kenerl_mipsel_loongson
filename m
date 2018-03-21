Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:36:33 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:36121
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994703AbeCUT3Vd6CAZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:21 +0100
Received: by mail-qk0-x243.google.com with SMTP id d206so6713452qkb.3
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LT/D0dONcVero6VVTSBj5oWSYcNi9rOpPGBtfXxHhOU=;
        b=uzHVE6hwp4w6VtBCJrlHSQTDyOdj/Lyz3szS0XDWuffTGU+FwduqScEFDlWdT99Wbu
         lvoFaIjXfGYZKOO+QzfqDSLG2WOgtI1GTK9EMD7j1llYl+gmQWS0wi2tWYz8suVjjGSb
         W0ceq5QFMS2RYTxleDWFLR12wnfKvJ+3Yf6A4ZHv8haR9IW3MzlwZcIU/18RV/U6NlVr
         2eS4Xj6m1kL28AyFvtPonTRlnFUheceEWEZtoVSd0g96+Ta4XH4LHyZK6V9iTxKZMnpt
         QHaUxz2V6mfaWxg3DGnYsoM6U/CvwiboJrNAOSB4IrkCuBbaQPciK7nn6+J0n+yeIwfg
         ywaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LT/D0dONcVero6VVTSBj5oWSYcNi9rOpPGBtfXxHhOU=;
        b=BX977uC+tRYq51hnbhfCzSo5/AiOYESTTYMGwiEmrCYSiTwBJF7tw/bl7FcH/bvy42
         1Lm+DGuUKXrWcDbdXoHtgB96f4XsV4QEPEQzhEtHApP05vkYo18L99jBxLyOOUE5JLN4
         zcej8gUjXGVoKNRoLzMfDCJi9JpbnB21keJAeeqCUlAE0F7dJhHjSSN0eAvPaRJvYJy3
         eK2yqTb9tGx0WB7R0lcrEcsrLF+IDgjJFLVIme9AbwUPkOwfNIQQRhuHrNbLFC4lQlxT
         3VZqv8RsxdW4iumSWZsxn+SyE7Ze3S6G9anpOpef8KUN/6wx1tEXpYWeZrr7f7Ou1+1n
         wiEw==
X-Gm-Message-State: AElRT7Gh3eU2r2LCLArI6C4BzISyu2wwvnLoc52YCCdTV+7YWSlqne7/
        sVfbiCkT0skLW2NiRnasLqn5Fg==
X-Google-Smtp-Source: AG47ELtvkAxvd8OCP4vyTccuG6EjxpxRxXDFwfUyLSU02rgzJnNRWtBL+TMcrRaw9xVcgkDDP7Ej4A==
X-Received: by 10.55.31.204 with SMTP id n73mr30799211qkh.38.1521660555838;
        Wed, 21 Mar 2018 12:29:15 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:29:14 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 14/14] MIPS: configs: ci20: Enable DMA and MMC support
Date:   Wed, 21 Mar 2018 16:27:41 -0300
Message-Id: <20180321192741.25872-15-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Enable the SD/MMC support, along with DMA engine
support in the CI20 defconfig.

Acked-by: James Hogan <jhogan@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 arch/mips/configs/ci20_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index b5f4ad8f2c45..f88b05fd3077 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -104,8 +104,11 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
+CONFIG_MMC_JZ4740=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_JZ4740=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_JZ4780=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 # CONFIG_DNOTIFY is not set
-- 
2.16.2
