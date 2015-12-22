Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 15:41:54 +0100 (CET)
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33938 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008520AbbLVOlwtMMK9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 15:41:52 +0100
Received: by mail-lf0-f42.google.com with SMTP id y184so130351530lfc.1
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9YCWhaEBz9Ggtr9lm9W5NgV4aciQfnNiNp6VM0b0xCE=;
        b=ccLC0/ZeUTUGzwlVx63yR0hIJx6lqpYo8o8xfEuOdCpUwiG+zQc2qry46WJj+moRsX
         b8vuXwVzQsr65Ns5/KXwe5jfhB4jDf7fsPnbLHdf2NDyQ/dlQu/av8DVKo6zqQOqrNWG
         eG4YDgDcPOTZ5C9aSrZlA2lX65jf97JftvCcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9YCWhaEBz9Ggtr9lm9W5NgV4aciQfnNiNp6VM0b0xCE=;
        b=VrPxC+q2K4bPMduZlDDWu8UvZ1K1t0lFmGsulhnhnqE7e/tGrlUo6zWoTWXAZy8pgY
         gpqbjeKKH1b1+xzME1JxZDlDPEDcCPXH7LByp3Jmjr51ZCsntljXVTjxADwWW3eZhrYl
         JECVrxYQ/Vp2t+j3Zldr0ijldwQha/uG3Nk6Vp0Q1HzktdzhehXFtDoqT6Tmkcy3uZNV
         iMN+bZS9jrbsw44nKppv6/ngPtlJd181WOM5y7yy8LxHZJykF2Y6hLM8eyS3e0WKTnXK
         ZVfMlBAShmgecq45w9pafCaeCRTpHMJjItQ2cosmfyC+tEaAHtH3Ceoyo8GGrcvcAV5V
         lMvw==
X-Gm-Message-State: ALoCoQl1iWo60H90lNOqlz885ulHb8oa21sTGt+uxRe337jMYXLacFdFcQEDYeN9PjeKV858QTYHa/CnecdOy2Y6oj2ZkdJmBQ==
X-Received: by 10.25.154.146 with SMTP id c140mr7792792lfe.24.1450795307459;
        Tue, 22 Dec 2015 06:41:47 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id h8sm5584728lbd.5.2015.12.22.06.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 06:41:46 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 40/54] mips: txx9: iocled: Be sure to clamp return value
Date:   Tue, 22 Dec 2015 15:41:44 +0100
Message-Id: <1450795304-27576-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50736
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

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
MIPS folks: as mentioned in 00/54: either apply this directly
or ACK it and I will take it into the GPIO tree.
---
 arch/mips/txx9/generic/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 9d9962ab7d25..2fd350f31f4b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -689,7 +689,7 @@ static int txx9_iocled_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct txx9_iocled_data *data =
 		container_of(chip, struct txx9_iocled_data, chip);
-	return data->cur_val & (1 << offset);
+	return !!(data->cur_val & (1 << offset));
 }
 
 static void txx9_iocled_set(struct gpio_chip *chip, unsigned int offset,
-- 
2.4.3
