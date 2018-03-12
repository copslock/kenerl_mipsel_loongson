Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:02:56 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:33181
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990480AbeCLV7yKwfFf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:54 +0100
Received: by mail-qk0-x243.google.com with SMTP id f25so13273012qkm.0
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LT/D0dONcVero6VVTSBj5oWSYcNi9rOpPGBtfXxHhOU=;
        b=fVxa1S64BZHBIWapm5jpsrc1Td7HdsM/bdjttBim5qwKHtMfDruQocKlFxEx0Bq+Ae
         LmgK3WAz6/Bve2Dia4ebaFTCxCaFbmV8AAeze/0gyohqOBR6kJglMWx3ozxBboVwbQmH
         Jg3h3br0Z+1zQObQTVtZVyZ15rATTN2qJFI+sFeSKYsqo790uz+PwNAA5RYmlP0vtKkh
         LHvM/GhNCIhpu6G+lHFs2MZZzInOr7l2drq8JuFkKXvrgSFulgkDYV2hN9WhXSHHttI+
         xPyv16zMOm14MkheJrd6A2E90tHY/a2DysmTeGcO2MLMutnCHWFxw0i1MXCiIdkDWHN+
         NMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LT/D0dONcVero6VVTSBj5oWSYcNi9rOpPGBtfXxHhOU=;
        b=BkkE9t7cdCRHPCd+sl7+yUZJaEvm8vuLZdIm5kTUqplL0gCOvP5f/B6EIzSOSIQPK8
         n8YBWFIHTSbNRPolyz62E7/6qMQjyyukXj2Sp9RA1Q/iaxvciiqo60JzpYyXP7px07IR
         Vla7Me9nT2oIi+a7XmfqLcWUH71kkhpzfQUGy7nSpgFHdytGVvdUiGvyNpd5IfwE1aqh
         /uvYGLSdkkvgljU0JuwcGBpCNUiN1bXntgCrtfX0KzSsCxhzdnxGnx/MjBg8U0AY404k
         zMPSDt4oQ+SmS1I7F7mxlwEUlmEZh/3mn3QEuAMs0gFK8xgKZqVZeGHn4zEV/iQzwch6
         3AKg==
X-Gm-Message-State: AElRT7FU7NmEfZIKJEBHPBWnLq7RXEfSdnYCg920t6eSDmOp4bJ8+NTB
        jfzk5dexNALwIp9eimH+aRx7fw==
X-Google-Smtp-Source: AG47ELuioqbimNYaDAdjHKnsAi7NN65QWu/zWmxaNF2TBg/DUUfaAa0W39O0Ce9Llo/Qjh770i8J/g==
X-Received: by 10.55.194.72 with SMTP id j8mr9389597qkm.247.1520891988454;
        Mon, 12 Mar 2018 14:59:48 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:47 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 14/14] MIPS: configs: ci20: Enable DMA and MMC support
Date:   Mon, 12 Mar 2018 18:55:54 -0300
Message-Id: <20180312215554.20770-15-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62945
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
