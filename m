Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2016 20:17:35 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36810 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992622AbcH0SQN3gn6j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Aug 2016 20:16:13 +0200
Received: by mail-pf0-f194.google.com with SMTP id y134so6683447pfg.3;
        Sat, 27 Aug 2016 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+RGOoo4L09/rV0OIJdqhQ7x4FeTSnCk01y7fPzqxju8=;
        b=tpA3v1nHB1Mkgoge2gc2FkkPpGDWulCUA7GVjN7AGmLAZGj7t3m5SdC468p69nTfZ1
         3utorya/XBCRbUhJ41r4eEpqnUut/3nIYmF1CpG6dN3l73QAyd8V3oVn/usVlexqKFvO
         z2TMEoipihxQ+gcJ5OBPsTroYdLpzZkmdM38H77+CV+Th2NQ+ZBdQ0scNXVkpCPKaIKM
         KA26sBGKNRA6cgRK/rj8u1klLyq47dgMg0opb6m3/NqpC5ew2q+8GzKI+ubQEf51KSHl
         uM3LwOHCb78B25MK8jEqOwsZ7WfyG0Sw4hsb5/5WR1ftdAdsh9hlmeGFQw9qdivugfoh
         nKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+RGOoo4L09/rV0OIJdqhQ7x4FeTSnCk01y7fPzqxju8=;
        b=PJrMu8ENLi2WZsDcsIdwootSUXEZ8pc7D2v4qiIWJ+HFagHf+x9jqIxz3b8wE8/BxL
         Cgq2+7KHFl7W21JN/uKnOmaLGRREy52IwTJtmA4u/EX0RstunpFrXCtRuOkeM5uI0IxF
         fJJssdPMPmmHFk8u74hTSz5HC6+akx61oNTYWaHa/ex6Ox1bKWPLEZyXUTqBrEeWq7RI
         JIdh3t5RYhLxsRP946sMfy8m5dkcK4CE4kJfmGehkzZuFWScpSHEfPsmMHAjkQUBxBoP
         +RGELahqDGwS3VbVocvCkrGqzoMNRvBF5iJ2oopxXFls7qjgWYT0CMbzSTRyvBWP8LEU
         JsCg==
X-Gm-Message-State: AE9vXwNaEttEYrGevDP/7IfVBGLViEnVOImPQ2fnfv4Gn/wxYldXmhlpPywI8vaNNlBLPQ==
X-Received: by 10.98.196.138 with SMTP id h10mr17245523pfk.60.1472321767751;
        Sat, 27 Aug 2016 11:16:07 -0700 (PDT)
Received: from localhost.localdomain ([1.22.68.54])
        by smtp.gmail.com with ESMTPSA id y6sm37747529pav.1.2016.08.27.11.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:16:07 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org,
        gregkh@linuxfoundation.org, boris.brezillon@free-electrons.com,
        harvey.hunt@imgtec.com, prarit@redhat.com, f.fainelli@gmail.com,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 4/4] hw_random: jz4780-rng: Enable hardware RNG in CI20 defconfig
Date:   Sat, 27 Aug 2016 23:44:57 +0530
Message-Id: <1472321697-3094-5-git-send-email-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

This patch enables the usage of RNG in MIPS Creator CI20 default config.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/configs/ci20_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index bf164fe..51a47a4 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -88,7 +88,9 @@ CONFIG_SERIAL_8250_NR_UARTS=5
 CONFIG_SERIAL_8250_RUNTIME_UARTS=5
 CONFIG_SERIAL_8250_INGENIC=y
 CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
+CONFIG_HW_RANDOM_JZ4780=y
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_GPIO_SYSFS=y
-- 
2.5.0
